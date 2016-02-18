module dbg.debugger_new;

import glad.gl.all;
import glad.gl.loader;
import derelict.glfw3.glfw3;
import imgui.api;
import dbg.glhelpers;
import dbg.dispatcher;
import dbg.draws;
import std.stdio, std.string, std.file, std.math, std.exception;
import std.string, std.format, std.algorithm, std.array, std.range;
import config, scene.camera, scene.scenemgr, math;

/// -
class TooLowGLVersion : Error
{
    ///-
    this()
    {
        super("You've got too low OpenGL version. 3.3 is required.");
    }
}

struct Vert3D
{
    float x = 0.0, y = 0.0, z = 0.0;
    float tx = 0.0, ty = 0.0, tz = 0.0;
    float r = 0.0, g = 0.0, b = 0.0, a = 0.0;
    float nx = 0.0, ny = 0.0, nz = 0.0;
} // 13 floats = 52 b

private class VisualPrimitives
{
    static int appendSphere(T, U)(ref T Vrng, ref U Erng, int iv0, DebugDraw dd)
    {
        import dbg.icosphere : Icosphere;

        int cnt = 0;
        auto radius = dd.radius_one;
        auto origin = dd.plane.origin;
        auto Verng = appender!(Vert3D[])();
        auto Eerng = appender!(ushort[])();
        Icosphere iso = Icosphere(5);
        foreach (v; iso.vertices[])
        {
            Verng ~= Vert3D(radius * v.x + origin.x, radius * v.y + origin.y,
                radius * v.z + origin.z, 0, 0, 0, 1.0, 1.0, 1.0, 1.0, v.x, v.y, v.z);
        }
        foreach (t; iso.triangles[])
        {
            Eerng ~= [cast(short)(iv0 + t.a), cast(short)(iv0 + t.b), cast(short)(iv0 + t.c)];
            cnt += 3;
        }
        Vrng ~= Verng.data;
        Erng ~= Eerng.data;
        return cnt;
    }

    static int appendAccretionDisc(T, U)(ref T Vrng, ref U Erng, int iv0, DebugDraw dd)
    {
    	double inner_radius = sqrt(dd.radius_two);
    	double outer_radius = sqrt(dd.radius_one);
    	
    	GFXvector3[] points;
    	GFXmatrix3 rot = gMat3RotateVectorOntoVector(
    		gVec3(0, 1, 0),
    		gVec3(dd.plane.normal.x, dd.plane.normal.y, dd.plane.normal.z));
    	
    	int vrt = 0;
    	const int deg_step = 1;
    	const int mod = 2*360/deg_step;
    	for(int i = 0; i<=360; i+=deg_step)
    	{
    		double cosi = cos(cast(double)PI*i/180);
    		double sini = sin(cast(double)PI*i/180);
    		points ~= gMat3MulVec3(rot, GFXvector3(cosi*inner_radius, sini*inner_radius, 0));
    		points ~= gMat3MulVec3(rot, GFXvector3(cosi*outer_radius, sini*outer_radius, 0));
    		
    		Erng ~= [cast(short)((iv0+vrt+0)%mod), cast(short)((iv0+vrt+1)%mod), cast(short)((iv0+vrt+2)%mod)];
    		Erng ~= [cast(short)((iv0+vrt+1)%mod), cast(short)((iv0+vrt+3)%mod), cast(short)((iv0+vrt+2)%mod)];
    		vrt += 2;
    	}
    	
    	for(int i = 0; i<points.length; i++)
    	{
    		auto vec = points[i];
    		//writeln(vec.x, '\t', vec.y);
    		Vrng ~= Vert3D(
    			vec.x + dd.plane.origin.x, vec.y + dd.plane.origin.y, vec.z + dd.plane.origin.z,
    			0, 0, 0,
    			1.0, 1.0, 1.0, 1.0,
    			dd.plane.normal.x, dd.plane.normal.y, dd.plane.normal.z
    		);
    	}
    	
    	return vrt*3;
    }
    
    static int appendPlane(T, U)(ref T Vrng, ref U Erng, int iv0, DebugDraw dd)
    {
        return 0;
    }

    static int appendTriangle(T, U)(ref T Vrng, ref U Erng, int iv0, DebugDraw dd)
    {
        Vectorf a = dd.tri.plane.origin;
        Vectorf[3] tab = [a, a + dd.tri.b, a + dd.tri.c];
        Vectorf normal = dd.tri.plane.normal;

        foreach (Vectorf vert; tab)
        {
            Vrng ~= Vert3D(vert.x, vert.y, vert.z, 0, 0, 0, 1.0, 1.0, 1.0, 1.0,
                normal.x, normal.y, normal.z);
        }

        Erng ~= [cast(short)(iv0), cast(short)(iv0 + 1), cast(short)(iv0 + 2)];

        return 3;
    }
}

/// Class responsible for visual debugging
class VisualHelper
{
    private __gshared VisualHelper _inst;
    shared static this()
    {
        _inst = new VisualHelper();
    }

    private this()
    {
    }
    /// -
    public static @property VisualHelper instance()
    {
        return _inst;
    }
    /// -
    public void initialize()
    {

    }

    private GLFWwindow* rwin;
    private int winx, winy;
    private int mousex, mousey, mousescroll, keychar;
    private ubyte mousebtns;
    private float bgIntensity = 0.25f;
    private GFXtexture texRendered;
    private static struct DrawnObj
    {
        GFXdataStruct data;
        GFXbufferObject vbo, veo;
        GFXvertexArrayObject vao;
        GFXtexture tex;
        void bind()
        {
            if (vao)
                vao.bind();
            if (vbo)
                vbo.bindTo(gBufferTarget.VertexArray);
            if (veo)
                veo.bindTo(gBufferTarget.ElementArray);
            if (tex)
                tex.bind();
        }
    }

    private DrawnObj objSpatial;

    private static struct TCamera
    {
        float x = 0.0f, y = 0.0f, z = 5.0f;
        float pitch = 0.0f, yaw = 0.0f;
        float near = 0.01f, far = 100.0f;
        float fov = 80.0f;
		GFXvector3 dirFwd, dirRight, dirUp;
		GFXmatrix4 matrix, rmatrix;
        void normalize()
        {
            pitch = fmod(pitch, PI);
            yaw = fmod(yaw, 2.0*PI);
			dirFwd = gVecMatTransform(rmatrix, gVec4(0,0,1,0)).to3;// gVec3(-sin(yaw),sin(pitch),cos(yaw));
			dirRight = gVecMatTransform(rmatrix, gVec4(1,0,0,0)).to3; //dirRight = gVec3(cos(yaw),0,sin(yaw));
			dirUp = gVecMatTransform(rmatrix, gVec4(0,1,0,0)).to3;
        }
		void addVec(GFXvector3 V, double scale = 1.0)
		{
			x += V.x * scale;
			y += V.y * scale;
			z += V.z * scale;
		}
    }

    private TCamera camera;
    private DrawnObj objRendered;
    private GFXshader shader2D, shader3D;
    private GFXmatrix4 matProjection;
    private bool mouseInGui, mouseLocked;
    int numverts;
    private void initVisuals()
    {
        texRendered = new GFXtexture();
        if (DebugDispatcher.renderResult is null)
        {
            import image.memory : Image;

            DebugDispatcher.renderResult = new Image(8, 8);
        }
        texRendered.recreateTexture(DebugDispatcher.renderResult);
        texRendered.bind();
        texRendered.generateMipmaps();
        shader2D = new GFXshader();
        shader2D.loadVertShader("shaders/twod.vert");
        shader2D.loadFragShader("shaders/twod.frag");
        int sh2Pos = shader2D.bindAttribLocation(1, "position");
        int sh2Tex = shader2D.bindAttribLocation(2, "texcoord");
        int sh2Color = shader2D.bindAttribLocation(3, "color");
        shader2D.link();
        shader2D.bind();
        shader2D.setUniform1i("doTexture", 1);
        shader2D.setUniformM4("model", gIdentity4());
        shader2D.setUniformM4("view", gIdentity4());
        shader2D.setUniformM4("proj", gIdentity4());
        shader3D = new GFXshader();
        shader3D.loadVertShader("shaders/space.vert");
        shader3D.loadFragShader("shaders/space.frag");
        int sh3Pos = shader3D.bindAttribLocation(1, "position");
        int sh3Tex = shader3D.bindAttribLocation(2, "texcoord");
        int sh3Color = shader3D.bindAttribLocation(3, "color");
        int sh3Normal = shader3D.bindAttribLocation(4, "normal");
        shader3D.link();
        shader3D.bind();
        shader3D.setUniform1i("doTexture", 1);
        shader3D.setUniformM4("model", gIdentity4());
        shader3D.setUniformM4("view", gIdentity4());
        shader3D.setUniformM4("proj", gIdentity4());
        shader2D.bind();
        objRendered.tex = texRendered;
        objRendered.data = new GFXdataStruct();
        {
            int vPos, vTex, vColor;
            ubyte[] xdata;
            with (objRendered.data)
            {
                vPos = appendType(gDataType.Avector3); // pos
                vTex = appendType(gDataType.Avector3); // texcoord
                vColor = appendType(gDataType.Avector4); // color
                declarationComplete();
                static struct Vert
                {
                    float x, y, z;
                    float u, v, w;
                    float r, g, b, a;
                }

                Vert[6] dta;
                dta[0] = Vert(-1, -1, 0, 0, 1, 0, 1, 1, 1, 1);
                dta[1] = Vert(-1, 1, 0, 0, 0, 0, 1, 1, 1, 1);
                dta[2] = Vert(1, 1, 0, 1, 0, 0, 1, 1, 1, 1);
                dta[3] = Vert(1, 1, 0, 1, 0, 0, 1, 1, 1, 1);
                dta[4] = Vert(1, -1, 0, 1, 1, 0, 1, 1, 1, 1);
                dta[5] = Vert(-1, -1, 0, 0, 1, 0, 1, 1, 1, 1);
                xdata = cast(ubyte[])(dta);
            }
            objRendered.data.setLength(6);
            objRendered.data.data = xdata.dup;
            objRendered.vbo = new GFXbufferObject(gBufferUsage.StaticPush);
            with (objRendered.vbo)
            {
                bindTo(gBufferTarget.VertexArray);
                updateData(xdata);
            }
            objRendered.vao = new GFXvertexArrayObject();
            with (objRendered.vao)
            {
                bind();
                configureAttribute(objRendered.data, vPos, sh2Pos, false, false);
                configureAttribute(objRendered.data, vTex, sh2Tex, false, false);
                configureAttribute(objRendered.data, vColor, sh2Color, false, false);
            }
        }
        shader3D.bind();
        objSpatial.data = new GFXdataStruct();
        int sPos = objSpatial.data.appendType(gDataType.Avector3);
        int sTex = objSpatial.data.appendType(gDataType.Avector3);
        int sCol = objSpatial.data.appendType(gDataType.Avector4);
        int sNorm = objSpatial.data.appendType(gDataType.Avector3);
        objSpatial.data.declarationComplete();
        objSpatial.data.setLength(3);

        Vert3D[] v3d = [];
        ushort[] e3d = [];

        import scene.objects.interfaces;

        numverts = 0;
        foreach (shared Renderable obj; DebugDispatcher.space.objects)
        {
            auto OBJ = cast(Renderable) obj;
            DebugDraw deb = OBJ.getDebugDraw();

            switch (deb.type)
            {
            case DrawType.None:
                continue;

            case DrawType.Sphere:
                numverts += VisualPrimitives.appendSphere(v3d, e3d, cast(int)v3d.length, deb);
                continue;

            case DrawType.Triangle:
                numverts += VisualPrimitives.appendTriangle(v3d, e3d, cast(int)v3d.length, deb);
                continue;

            case DrawType.Plane:
                numverts += VisualPrimitives.appendPlane(v3d, e3d, cast(int)v3d.length, deb);
                continue;

            case DrawType.AccretionDisc:
                numverts += VisualPrimitives.appendAccretionDisc(v3d, e3d, cast(int)v3d.length, deb);
                continue;

            default:
                continue;
            }
        }

        objSpatial.data.data = cast(ubyte[])(v3d);
        objSpatial.vbo = new GFXbufferObject(gBufferUsage.StaticPush);
        objSpatial.vbo.bindTo(gBufferTarget.VertexArray);
        objSpatial.vbo.updateData(objSpatial.data);
        objSpatial.veo = new GFXbufferObject(gBufferUsage.StaticPush);
        objSpatial.veo.bindTo(gBufferTarget.ElementArray);
        objSpatial.veo.updateData(cast(ubyte[]) e3d);
        objSpatial.vao = new GFXvertexArrayObject();
        objSpatial.vao.bind();
        objRendered.vao.disableAttribs();
        objSpatial.vao.configureAttribute(objSpatial.data, sPos, sh3Pos, false, false);
        objSpatial.vao.configureAttribute(objSpatial.data, sTex, sh3Tex, false, false);
        objSpatial.vao.configureAttribute(objSpatial.data, sCol, sh3Color, false, false);
        objSpatial.vao.configureAttribute(objSpatial.data, sNorm, sh3Normal, false,
            false);
        objSpatial.vao.disableAttribs();
        objSpatial.vbo.unbindFrom(gBufferTarget.VertexArray);
        objSpatial.veo.unbindFrom(gBufferTarget.ElementArray);
    }
	
	private double dt;
	
    /// Starts the graphical part of the debugger
    public void runGraphics()
    {
        double Taccum = 0.0;
        DerelictGLFW3.load();
        glfwInit();
        setupWindow();
        initVisuals();
        enforce(imguiInit("firasans-medium.ttf", 1024));
        int scroll_d = 0;
        glfwSetTime(0.0);
        while (!glfwWindowShouldClose(rwin))
        {
            dt = glfwGetTime();
            Taccum += dt;
            glfwSetTime(0.0);
            mouseInGui = false;
			camera.normalize();
			camera.rmatrix = gMat4Mul(gMatRotX(camera.pitch),gMatRotY(camera.yaw));
			camera.matrix = gMat4Mul(camera.rmatrix,gMatTranslation(gVec3(-camera.x,
                -camera.y, -camera.z)));
			camMover();
			matProjection = gMatProjection(camera.fov * PI / 180.0,
                winy / cast(double) winx, camera.near, camera.far);
            resetGl();
            glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
            glEnable(GL_DEPTH_TEST);
            //glEnable(GL_CULL_FACE);
            shader3D.bind();
            shader3D.setUniform1i("doTexture", 0);
            shader3D.setUniformM4("model", gIdentity4());
            shader3D.setUniformM4("view", camera.matrix);
            shader3D.setUniformM4("proj", matProjection);
            objSpatial.bind();
            objRendered.vao.disableAttribs();
            objSpatial.vao.enableAttribs();
            glDrawElements(GL_TRIANGLES, numverts, GL_UNSIGNED_SHORT, null);

            glDisable(GL_DEPTH_TEST);
            glDisable(GL_CULL_FACE);
            shader2D.bind();
            shader2D.setUniform1i("doTexture", 1);
            shader2D.setUniformM4("model",
                gMat4Mul(gMatTranslation(gVec3(-winx + 60, -winy + 60, 0)),
                gMatScaling(gVec3(50, 50, 1))));
            shader2D.setUniformM4("view", gIdentity4());
            shader2D.setUniformM4("proj", gMatOrthographic(0, winx, 0, winy, 0, 1));
            objRendered.vao.enableAttribs();
            objSpatial.vao.disableAttribs();
            objRendered.bind();
            glDrawArrays(GL_TRIANGLES, 0, 6);

            gAssertGl();
            glClear(GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
            imguiBeginFrame(mousex, winy - mousey, mouseLocked ? 0 : mousebtns,
                mouseLocked ? 0 : mousescroll, cast(dchar) keychar);
            // GUI code

            mouseInGui |= imguiBeginScrollArea("Controls", 10, winy - 510, 190, 500,
                &scroll_d);
            {
                imguiSlider("BG", &bgIntensity, 0.0f, 1.0f, 0.02f);
                static bool expView = false;
                imguiCollapse("View controls", "", &expView);
                if (expView)
                {
                    imguiIndent();
                    imguiLabel("x y z:");
                    imguiLabel("%.1f %.1f %.1f".format(camera.x, camera.y, camera.z));
                    imguiLabel("Pitch: %.1f".format(camera.pitch));
                    imguiLabel("Yaw: %.1f".format(camera.yaw));
                    imguiSlider("FOV", &camera.fov, 20.0f, 150.0f, 1.0f);
                    imguiSlider("Near", &camera.near, 0.0001f, 1.0f, 0.0001f);
                    imguiSlider("Far", &camera.far, camera.near, 10_000.0f, 10.0f);
                    imguiUnindent();
                }
            }
            imguiEndScrollArea();

            imguiEndFrame();
            mousescroll = 0;
            keychar = 0;
            imguiRender(winx, winy);
            glfwSwapBuffers(rwin);
            glfwPollEvents();
        }
        imguiDestroy();
        glfwTerminate();
    }

    private void resetGl()
    {
        glBindTexture(GL_TEXTURE_2D, 0);
        glClearColor(bgIntensity, bgIntensity, bgIntensity, 1.0f);
        glViewport(0, 0, winx, winy);
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        glEnable(GL_BLEND);
    }

    private void setupWindow()
    {
        glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
        glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
        glfwWindowHint(GLFW_FOCUSED, GL_TRUE);
        glfwWindowHint(GLFW_SRGB_CAPABLE, GL_TRUE);
        glfwWindowHint(GLFW_DOUBLEBUFFER, GL_TRUE);
        glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
        glfwWindowHint(GLFW_CONTEXT_RELEASE_BEHAVIOR, GLFW_RELEASE_BEHAVIOR_NONE);
        glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
        glfwWindowHint(GLFW_RESIZABLE, GL_TRUE);
        glfwWindowHint(GLFW_VISIBLE, GL_TRUE);
        int W = cast(int) cfgResolutionX;
        int H = cast(int) cfgResolutionY;
        winx = W;
        winy = H;
        rwin = glfwCreateWindow(W, H, "GrTrace Visual Helper", null, null);
        if (!rwin)
        {
            throw new TooLowGLVersion();
        }
        glfwMakeContextCurrent(rwin);
        glfwSwapInterval(1);
        if (!gladLoadGL())
        {
            throw new TooLowGLVersion();
        }
        if (GLVersion.major < 3)
        {
            throw new TooLowGLVersion();
        }
        if ((GLVersion.major == 3) && (GLVersion.minor < 3))
        {
            throw new TooLowGLVersion();
        }
        glfwSwapBuffers(rwin);
        glfwSetMouseButtonCallback(rwin, &coreMouseButton);
        glfwSetScrollCallback(rwin, &coreScroll);
        glfwSetCursorPosCallback(rwin, &coreMouseMove);
        glfwSetCharCallback(rwin, &coreChar);
        glfwSetKeyCallback(rwin, &coreKey);
        glfwSetFramebufferSizeCallback(rwin, &coreSize);
    }

    ///-
    public bool modLShift = false;
    ///-
    public bool modRShift = false;
    ///-
    public bool modLAlt = false;
    ///-
    public bool modRAlt = false;
    ///-
    public bool modLCtrl = false;
    ///-
    public bool modRCtrl = false;

    // Updates the modifier key variables.
    private void updateMods()
    {
        int t;
        t = glfwGetKey(rwin, GLFW_KEY_LEFT_SHIFT);
        modLShift = (t == GLFW_PRESS);
        t = glfwGetKey(rwin, GLFW_KEY_RIGHT_SHIFT);
        modRShift = (t == GLFW_PRESS);
        t = glfwGetKey(rwin, GLFW_KEY_LEFT_ALT);
        modLAlt = (t == GLFW_PRESS);
        t = glfwGetKey(rwin, GLFW_KEY_RIGHT_ALT);
        modRAlt = (t == GLFW_PRESS);
        t = glfwGetKey(rwin, GLFW_KEY_LEFT_CONTROL);
        modLCtrl = (t == GLFW_PRESS);
        t = glfwGetKey(rwin, GLFW_KEY_RIGHT_CONTROL);
        modRCtrl = (t == GLFW_PRESS);
    }

    /// -
    public void onMouseButton(int button, int state, int x, int y)
    {
		if(mouseLocked)
		{
			if(button == GLFW_MOUSE_BUTTON_LEFT)
			{
				if(state==GLFW_RELEASE)
				{
					mouseLocked = false;
					glfwSetInputMode(rwin, GLFW_CURSOR, GLFW_CURSOR_NORMAL);
					double xd, yd;
        			glfwGetCursorPos(rwin, &xd, &yd);
        			mousex = cast(int) xd;
					mousey = cast(int) yd;
				}
			}
		}
		else if(!mouseInGui)
		{
			if(button == GLFW_MOUSE_BUTTON_LEFT)
			{
				if(state==GLFW_PRESS)
				{
					mouseLocked = true;
					glfwSetInputMode(rwin, GLFW_CURSOR, GLFW_CURSOR_DISABLED);
				}
			}
		}
        if (button == GLFW_MOUSE_BUTTON_LEFT)
        {
            if (state == GLFW_PRESS)
            {
                mousebtns |= MouseButton.left;
            }
            else if (state == GLFW_RELEASE)
            {
                mousebtns &= ~MouseButton.left;
            }
        }
        else if (button == GLFW_MOUSE_BUTTON_RIGHT)
        {
            if (state == GLFW_PRESS)
            {
                mousebtns |= MouseButton.right;
            }
            else if (state == GLFW_RELEASE)
            {
                mousebtns &= ~MouseButton.right;
            }
        }
    }

    /// -
    public void onMouseMove(int x, int y)
    {
		if(mouseLocked)
		{
			int dx = x-mousex;
			int dy = y-mousey;
			double dYaw = dx * M_2_PI / 100.0;
			double dPitch = dy * PI / 100.0;
			camera.yaw -= dYaw;
			camera.pitch = clamp(camera.pitch + dPitch, -PI + 0.001, PI - 0.001);
		}
		mousex = x;
		mousey = y;
    }

    /// -
    public void onScroll(double axis, double dir)
    {
        mousescroll = cast(int) dir;
    }

    /// -
    public void onChar(dchar ch)
    {
        keychar = cast(int) ch;
    }

    /// -
    public void onKey(int id, int state)
    {
        if (id == GLFW_KEY_ESCAPE && state == GLFW_RELEASE)
        {
            glfwSetWindowShouldClose(rwin, GL_TRUE);
            return;
        }
        if (id == GLFW_KEY_BACKSPACE && state != GLFW_RELEASE)
        {
            keychar = '\b';
        }
        else if (id == GLFW_KEY_ENTER && state != GLFW_RELEASE)
        {
            keychar = '\n';
        }
    }
	
	void camMover()
	{
		double CamSpeed = 15.0*dt;
		if(glfwGetKey(rwin, GLFW_KEY_W) != GLFW_RELEASE)
		{
			camera.addVec(camera.dirFwd,-CamSpeed);
		}
		if(glfwGetKey(rwin, GLFW_KEY_S) != GLFW_RELEASE)
		{
			camera.addVec(camera.dirFwd,CamSpeed);
		}
		if(glfwGetKey(rwin, GLFW_KEY_A) != GLFW_RELEASE)
		{
			camera.addVec(camera.dirRight,-CamSpeed);
		}
		if(glfwGetKey(rwin, GLFW_KEY_D) != GLFW_RELEASE)
		{
			camera.addVec(camera.dirRight,CamSpeed);
		}
		if(glfwGetKey(rwin, GLFW_KEY_E) != GLFW_RELEASE)
		{
			camera.addVec(camera.dirUp,CamSpeed);
		}
		if(glfwGetKey(rwin, GLFW_KEY_Q) != GLFW_RELEASE)
		{
			camera.addVec(camera.dirUp,-CamSpeed);
		}
	}

    /// -
    public void onResize(int w, int h)
    {
        glViewport(0, 0, w, h);
        winx = w;
        winy = h;
    }
}

extern (C) void coreMouseButton(GLFWwindow* w, int btn, int type, int modkeys) nothrow
{
    try
    {
        double xd, yd;
        glfwGetCursorPos(w, &xd, &yd);
        int x = cast(int) xd, y = cast(int) yd;
        VisualHelper.instance.onMouseButton(btn, type, x, y);
    }
    catch (Throwable o)
    {
    }
}

extern (C) void coreMouseMove(GLFWwindow* w, double x, double y) nothrow
{
    try
    {
        VisualHelper.instance.onMouseMove(cast(int) x, cast(int) y);
    }
    catch (Throwable o)
    {
    }
}

extern (C) void coreScroll(GLFWwindow* w, double axis, double dir) nothrow
{
    try
    {
        VisualHelper.instance.onScroll(axis, dir);
    }
    catch (Throwable o)
    {
    }
}

extern (C) void coreChar(GLFWwindow* w, uint ch) nothrow
{
    try
    {
        VisualHelper.instance.onChar(cast(dchar) ch);
    }
    catch (Throwable o)
    {
    }
}

extern (C) void coreKey(GLFWwindow* w, int id, int scan, int state, int mods) nothrow
{
    try
    {
        VisualHelper.instance.onKey(id, state);
    }
    catch (Throwable o)
    {
    }
}

extern (C) void coreSize(GLFWwindow* win, int w, int h) nothrow
{
    if ((w == 0) || (h == 0))
        return;
    try
    {
        VisualHelper.instance.onResize(w, h);
    }
    catch (Throwable o)
    {
    }
}
