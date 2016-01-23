module dbg.debugger_new;

import glad.gl.all;
import glad.gl.loader;
import derelict.glfw3.glfw3;
import imgui.api;
import dbg.glhelpers;
import dbg.dispatcher;
import std.stdio, std.string, std.file, std.math, std.exception;

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
    private int winx,winy;
    private int mousex,mousey,mousescroll,keychar;
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
            if(vbo)vbo.bindTo(gBufferTarget.VertexArray);
            if(veo)veo.bindTo(gBufferTarget.ElementArray);
            if(vao)vao.bind();
            if(tex)tex.bind();
        }
    }
    private DrawnObj objRendered;
    private GFXshader shader2D;
    
    private void initVisuals()
    {
        texRendered = new GFXtexture();
        texRendered.recreateTexture(DebugDispatcher.renderResult);
        texRendered.bind();
        texRendered.generateMipmaps();
        shader2D = new GFXshader();
        shader2D.loadVertShader("shaders/twod.vert");
        shader2D.loadFragShader("shaders/twod.frag");
        shader2D.link();
        shader2D.bind();
        shader2D.setUniform1i("doTexture", 1);
        shader2D.setUniformM4("model", gIdentity4());
        shader2D.setUniformM4("view", gIdentity4());
        shader2D.setUniformM4("proj", gIdentity4());
        int sh2Pos = shader2D.getAttribLocation("position");
        int sh2Tex = shader2D.getAttribLocation("texcoord");
        int sh2Color = shader2D.getAttribLocation("color");
        objRendered.tex = texRendered;
        objRendered.data = new GFXdataStruct();
        {
            int vPos, vTex, vColor;
            ubyte[] xdata;
            with(objRendered.data)
            {
                vPos = appendType(gDataType.Avector3); // pos
                vTex = appendType(gDataType.Avector3); // texcoord
                vColor = appendType(gDataType.Avector4); // color
                declarationComplete();
                static struct Vert
                {
                    float x,y,z;
                    float u,v,w;
                    float r,g,b,a;
                }
                Vert[6] dta;
                dta[0] = Vert(-1,-1,0, 0,1,0, 1,1,1,1);
                dta[1] = Vert(-1, 1,0, 0,0,0, 1,1,1,1);
                dta[2] = Vert( 1, 1,0, 1,0,0, 1,1,1,1);
                dta[3] = Vert( 1, 1,0, 1,0,0, 1,1,1,1);
                dta[4] = Vert( 1,-1,0, 1,1,0, 1,1,1,1);
                dta[5] = Vert(-1,-1,0, 0,1,0, 1,1,1,1);
                xdata = cast(ubyte[])(dta);
            }
            objRendered.vbo = new GFXbufferObject(gBufferUsage.StaticPush);
            with(objRendered.vbo)
            {
                bindTo(gBufferTarget.VertexArray);
                updateData(xdata);
            }
            objRendered.vao = new GFXvertexArrayObject();
            with(objRendered.vao)
            {
                bind();
                glEnableVertexAttribArray(sh2Pos);
                configureAttribute(objRendered.data, vPos, sh2Pos, false, false);
                glEnableVertexAttribArray(sh2Tex);
                configureAttribute(objRendered.data, vTex, sh2Tex, false, false);
                glEnableVertexAttribArray(sh2Color);
                configureAttribute(objRendered.data, vColor, sh2Color, false, false);
            }
        }
    }
    
    /// Starts the graphical part of the debugger
    public void runGraphics()
    {
        DerelictGLFW3.load();
        glfwInit();
        setupWindow();
        enforce(imguiInit("firasans-medium.ttf",1024));
        initVisuals();
        int scroll_d = 0;
        while(!glfwWindowShouldClose(rwin))
        {
            resetGl();
            glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
            
            shader2D.bind();
            shader2D.setUniform1i("doTexture", 1);
            shader2D.setUniformM4("model", 
                gMat4Mul(gMatTranslation(gVec3(-winx+60,-winy+60,0)),gMatScaling(gVec3(50,50,1)))
                );
            shader2D.setUniformM4("view", gIdentity4());
            shader2D.setUniformM4("proj", gMatOrthographic(0,winx,0,winy,0,1));
            objRendered.bind();
            glDrawArrays(GL_TRIANGLES, 0, 6);
            gAssertGl();
            imguiBeginFrame(mousex,winy-mousey,mousebtns,mousescroll,cast(dchar)keychar);
            // GUI code
            
            imguiBeginScrollArea("Controls", 10, 10, 100, 100, &scroll_d);
            {
                imguiSlider("BG",&bgIntensity,0.0f,1.0f,0.02f);
            }
            imguiEndScrollArea();
            
            imguiEndFrame();
            mousescroll = 0;
            keychar = 0;
            imguiRender(winx,winy);
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
        int W = cast(int)cfgResolutionX;
        int H = cast(int)cfgResolutionY;
        winx = W;
        winy = H;
        rwin = glfwCreateWindow(W,H,"GrTrace Visual Helper",null,null);
        if(!rwin)
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
        if(button == GLFW_MOUSE_BUTTON_LEFT)
        {
            if(state==GLFW_PRESS)
            {
                mousebtns |= MouseButton.left;
            }
            else if(state==GLFW_RELEASE)
            {
                mousebtns &= ~MouseButton.left;
            }
        }
        else if(button == GLFW_MOUSE_BUTTON_RIGHT)
        {
            if(state==GLFW_PRESS)
            {
                mousebtns |= MouseButton.right;
            }
            else if(state==GLFW_RELEASE)
            {
                mousebtns &= ~MouseButton.right;
            }
        }
    }
    
    /// -
    public void onMouseMove(int x, int y)
    {
        mousex = x;
        mousey = y;
    }
    
    /// -
    public void onScroll(double axis, double dir)
    {
        mousescroll = cast(int)dir;
    }
    
    /// -
    public void onChar(dchar ch)
    {
        keychar = cast(int)ch;
    }
    
    /// -
    public void onKey(int id, int state)
    {
        if(id==GLFW_KEY_ESCAPE && state==GLFW_RELEASE)
        {
            glfwSetWindowShouldClose(rwin,GL_TRUE);
            return;
        }
        if(id==GLFW_KEY_BACKSPACE && state!=GLFW_RELEASE)
        {
            keychar = '\b';
        }
        else if(id==GLFW_KEY_ENTER && state!=GLFW_RELEASE)
        {
            keychar = '\n';
        }
    }
    
    /// -
    public void onResize(int w, int h)
    {
        glViewport(0,0,w,h);
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
		VisualHelper.instance.onMouseButton(btn,type,x,y);
	}
	catch (Throwable o)
	{
	}
}

extern (C) void coreMouseMove(GLFWwindow* w, double x, double y) nothrow
{
	try
	{
		VisualHelper.instance.onMouseMove(cast(int)x,cast(int)y);
	}
	catch (Throwable o)
	{
	}
}

extern (C) void coreScroll(GLFWwindow* w, double axis, double dir) nothrow
{
	try
	{
		VisualHelper.instance.onScroll(axis,dir);
	}
	catch (Throwable o)
	{
	}
}

extern (C) void coreChar(GLFWwindow* w, uint ch) nothrow
{
	try
	{
		VisualHelper.instance.onChar(cast(dchar)ch);
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
		VisualHelper.instance.onResize(w,h);
	}
	catch (Throwable o)
	{
	}
}

