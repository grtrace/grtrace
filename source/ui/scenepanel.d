module ui.scenepanel;

import config;

static if (GRTRACE_HAS_UI)
	 : import derelict.opengl3.gl3;
import dbg.glhelpers;
import dbg.dispatcher;
import dbg.draws;
import std.stdio, std.string, std.file, std.math, std.exception;
import std.string, std.format, std.algorithm, std.array, std.range;
import scene.camera, scene.scenemgr, math;
import std.conv;
import dlangui;
import scene.objects.interfaces;
import metric.interfaces;
import metric.analytic;
import metric.wrapper;
import ui.window : uiMain;

static import image.color;
import image.color;
import image.spectrum;
import scene.creator;

alias Color = image.color.Color;

/// The widget displaying a navigatable grtrace scene.
class GrtraceScenePanel : Widget
{
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

	private DrawnObj objSpatial, objRays, objGrid;

	private static struct TCamera
	{
		float x = 0.0f, y = 0.0f, z = 20.0f;
		float pitch = 0.0f, yaw = 0.0f;
		float near = 0.01f, far = 100.0f;
		float speed = 12.0f;
		float fov = 80.0f;
		GFXvector3 dirFwd, dirRight, dirUp;
		GFXmatrix4 matrix, rmatrix, rinvmatrix;
		void normalize()
		{
			pitch = clamp(pitch, -PI / 2.0, PI / 2.0);
			yaw = fmod(yaw, 2.0 * PI);

			dirFwd = gVecMatTransform(rinvmatrix, gVec4(0, 0, 1, 0)).to3; // gVec3(-sin(yaw),sin(pitch),cos(yaw));
			dirRight = gVecMatTransform(rinvmatrix, gVec4(1, 0, 0, 0)).to3; //dirRight = gVec3(cos(yaw),0,sin(yaw));
			dirUp = gVecMatTransform(rinvmatrix, gVec4(0, 1, 0, 0)).to3;
		}

		void addVec(GFXvector3 V, double scale = 1.0)
		{
			x += V.x * scale;
			y += V.y * scale;
			z += V.z * scale;
		}
	}

	private static struct TSObject
	{
		string id;
		Renderable obj;
		int dataIndex;
		int vertIndex;
		int vertCount;
		bool visible = true;
		bool opanel = true;
	}

	TCamera camera;
	private GFXshader shader3D;
	private GFXmatrix4 matProjection;
	TSObject*[string] sceneObjects;
	TSObject*[] sortedObjects;
	private bool mouseLocked;
	int numverts, numRays, numGridLines;

	private void initVisuals()
	{
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
		shader3D.bind();
		objSpatial.data = new GFXdataStruct();
		int sPos = objSpatial.data.appendType(gDataType.Avector3);
		int sTex = objSpatial.data.appendType(gDataType.Avector3);
		int sCol = objSpatial.data.appendType(gDataType.Avector4);
		int sNorm = objSpatial.data.appendType(gDataType.Avector3);
		objSpatial.data.declarationComplete();
		objSpatial.data.setLength(3);

		Vert3D[] v3d = [];
		uint[] e3d = [];
		numverts = 0;
		{
			ICamera cam = DebugDispatcher.space.getCamera();
			TSObject* tso = new TSObject();
			tso.id = "@camera";
			tso.obj = null;
			tso.vertIndex = 0;
			tso.dataIndex = 0;
			tso.vertCount = 18;
			tso.visible = true;
			float csz = 1.0f;
			float cyx = cam.yxratio;
			float ax, ay, ah;
			float cx = cam.origin.x;
			float cy = cam.origin.y;
			float cz = cam.origin.z;
			float cux = csz * cam.updir.x * cyx;
			float cuy = csz * cam.updir.y * cyx;
			float cuz = csz * cam.updir.z * cyx;
			float crx = csz * cam.rightdir.x;
			float cry = csz * cam.rightdir.y;
			float crz = csz * cam.rightdir.z;
			float cfx = csz * cam.lookdir.x;
			float cfy = csz * cam.lookdir.y;
			float cfz = csz * cam.lookdir.z;
			float nm = 1.0f / (csz * csz * csz * 3.0f);
			enum float CamR = 1.0f, CamG = 0.8f, CamB = 0.1f;
			enum float CamXR = 0.7f, CamXG = 0.7f, CamXB = 0.7f;
			v3d ~= Vert3D(cx - 4 * cfx, cy - 4 * cfy, cz - 4 * cfz, 0, 0, 0, CamR,
					CamG, CamB, 1.0, -cam.lookdir.x, -cam.lookdir.y, -cam.lookdir.z); // 0 - top
			v3d ~= Vert3D(cx + cux + crx, cy + cuy + cry, cz + cuz + crz, 0, 0, 0,
					CamXR, CamXG, CamXB, 1.0, nm * (cux + crx + cfx),
					nm * (cuy + cry + cfy), nm * (cuz + crz + cfz)); // 1 - ^>
			v3d ~= Vert3D(cx - cux + crx, cy - cuy + cry, cz - cuz + crz, 0, 0, 0,
					CamXR, CamXG, CamXB, 1.0, nm * (-cux + crx + cfx),
					nm * (-cuy + cry + cfy), nm * (-cuz + crz + cfz)); // 2 - V>
			v3d ~= Vert3D(cx - cux - crx, cy - cuy - cry, cz - cuz - crz, 0, 0, 0,
					CamXR, CamXG, CamXB, 1.0, nm * (-cux - crx + cfx),
					nm * (-cuy - cry + cfy), nm * (-cuz - crz + cfz)); // 3 - <V
			v3d ~= Vert3D(cx + cux - crx, cy + cuy - cry, cz + cuz - crz, 0, 0, 0,
					CamXR, CamXG, CamXB, 1.0, nm * (cux - crx + cfx),
					nm * (cuy - cry + cfy), nm * (cuz - crz + cfz)); // 4 - <^
			e3d ~= [0, 1, 2, 0, 2, 3, 0, 3, 4, 0, 4, 1, 1, 2, 3, 3, 4, 1];
			numverts += 18;
			sceneObjects[tso.id] = tso;
		}
		{
			DebugDraw[string] space_info = DebugDispatcher.space.returnDebugRenderObjects();

			foreach (string obj_name, DebugDraw obj; space_info)
			{
				TSObject* tso = new TSObject();
				tso.id = obj_name;
				tso.obj = null;
				tso.vertIndex = cast(int) e3d.length;
				tso.dataIndex = cast(int) v3d.length;
				switch (obj.type)
				{
				case DrawType.None:
					continue;

				case DrawType.Sphere:
					tso.vertCount = VisualPrimitives.appendSphere(v3d,
							e3d, cast(int) v3d.length, obj);
					numverts += tso.vertCount;
					sceneObjects[tso.id] = tso;
					continue;

				case DrawType.Triangle:
					tso.vertCount = VisualPrimitives.appendTriangle(v3d,
							e3d, cast(int) v3d.length, obj);
					numverts += tso.vertCount;
					sceneObjects[tso.id] = tso;
					continue;

				case DrawType.Plane:
					tso.vertCount = VisualPrimitives.appendPlane(v3d,
							e3d, cast(int) v3d.length, obj);
					numverts += tso.vertCount;
					sceneObjects[tso.id] = tso;
					continue;

				case DrawType.AccretionDisc:
					tso.vertCount = VisualPrimitives.appendAccretionDisc(v3d,
							e3d, cast(int) v3d.length, obj);
					numverts += tso.vertCount;
					sceneObjects[tso.id] = tso;
					continue;

				default:
					continue;
				}
			}
		}
		foreach (shared Renderable obj; DebugDispatcher.space.objects)
		{
			auto OBJ = cast(Renderable) obj;
			if (OBJ is null)
			{
				writeln("[dbg] renderable is null");
				continue;
			}
			if (OBJ.material is null)
			{
				writeln("[dbg] material is null");
			}
			else if (OBJ.material.emission_color.isBlack)
			{
				oColor = OBJ.material.diffuse_color;
			}
			else
			{
				oColor = OBJ.material.emission_color;
			}
			TSObject* tso = new TSObject();
			tso.id = OBJ.getName();
			tso.obj = OBJ;
			tso.vertIndex = cast(int) e3d.length;
			tso.dataIndex = cast(int) v3d.length;
			DebugDraw deb = OBJ.getDebugDraw();

			switch (deb.type)
			{
			case DrawType.None:
				continue;

			case DrawType.Sphere:
				tso.vertCount = VisualPrimitives.appendSphere(v3d,
						e3d, cast(int) v3d.length, deb);
				numverts += tso.vertCount;
				sceneObjects[tso.id] = tso;
				continue;

			case DrawType.Triangle:
				tso.vertCount = VisualPrimitives.appendTriangle(v3d,
						e3d, cast(int) v3d.length, deb);
				numverts += tso.vertCount;
				sceneObjects[tso.id] = tso;
				continue;

			case DrawType.Plane:
				tso.vertCount = VisualPrimitives.appendPlane(v3d,
						e3d, cast(int) v3d.length, deb);
				numverts += tso.vertCount;
				sceneObjects[tso.id] = tso;
				continue;

			case DrawType.AccretionDisc:
				tso.vertCount = VisualPrimitives.appendAccretionDisc(v3d,
						e3d, cast(int) v3d.length, deb);
				numverts += tso.vertCount;
				sceneObjects[tso.id] = tso;
				continue;

			default:
				continue;
			}
		}
		foreach (ref Vert3D v; v3d)
		{
			v.z = -v.z;
		}
		sortedObjects.length = sceneObjects.keys.length;
		int sobji = 0;
		foreach (string k, TSObject* v; sceneObjects)
		{
			sortedObjects[sobji] = v;
			sobji++;
		}
		sort!("a.id < b.id")(sortedObjects);
		if (cfgVerbose)
		{
			writeln("[VDBG] Number of evertices registered: ", numverts);
			writeln("[VDBG] Number of elements total: ", e3d.length);
			writeln("[VDBG] Number of vertices total: ", v3d.length);
			writeln("[VDBG] Scene objects: ");
			foreach (string id, TSObject* obj; sceneObjects)
			{
				writefln("\t%s [Vi:%d,Vn:%d,Ve:%d]", id, obj.vertIndex,
						obj.vertCount, obj.vertIndex + obj.vertCount - 1);
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
		objSpatial.vao.configureAttribute(objSpatial.data, sPos, sh3Pos, false, false);
		objSpatial.vao.configureAttribute(objSpatial.data, sTex, sh3Tex, false, false);
		objSpatial.vao.configureAttribute(objSpatial.data, sCol, sh3Color, false, false);
		objSpatial.vao.configureAttribute(objSpatial.data, sNorm, sh3Normal, false, false);
		objSpatial.vao.disableAttribs();

		Vert3D[] dummy;
		dummy.length = 3;
		objRays.vbo = new GFXbufferObject(gBufferUsage.DynamicPush);
		objRays.vbo.bindTo(gBufferTarget.VertexArray);
		objRays.vbo.updateData(cast(ubyte[]) dummy);
		objRays.vao = new GFXvertexArrayObject();
		objRays.vao.bind();
		objSpatial.vao.disableAttribs();
		objRays.vao.configureAttribute(objSpatial.data, sPos, sh3Pos, false, false);
		objRays.vao.configureAttribute(objSpatial.data, sTex, sh3Tex, false, false);
		objRays.vao.configureAttribute(objSpatial.data, sCol, sh3Color, false, false);
		objRays.vao.configureAttribute(objSpatial.data, sNorm, sh3Normal, false, false);
		objRays.vao.enableAttribs();

		objGrid.vbo = new GFXbufferObject(gBufferUsage.DynamicPush);
		objGrid.vbo.bindTo(gBufferTarget.VertexArray);
		objGrid.vbo.updateData(cast(ubyte[]) dummy);
		objGrid.vao = new GFXvertexArrayObject();
		objGrid.vao.bind();
		objRays.vao.disableAttribs();
		objGrid.vao.configureAttribute(objSpatial.data, sPos, sh3Pos, false, false);
		objGrid.vao.configureAttribute(objSpatial.data, sTex, sh3Tex, false, false);
		objGrid.vao.configureAttribute(objSpatial.data, sCol, sh3Color, false, false);
		objGrid.vao.configureAttribute(objSpatial.data, sNorm, sh3Normal, false, false);
		objGrid.vao.enableAttribs();
	}

	private void rebuildRays()
	{
		Vert3D[] v3d = [];
		foreach (SavedRay ray; DebugDispatcher.saver.rays)
		{
			v3d ~= Vert3D(ray.start.x, ray.start.y, -ray.start.z, 0.0f, 0.0f,
					0.0f, ray.color.r, ray.color.g, ray.color.b, 1.0f, 0.0f, 1.0f, 0.0f);
			if (*(ray.end - ray.start) > 10_000_000.0f)
			{
				ray.end = ray.start + ray.dir * 100.0f;
			}
			v3d ~= Vert3D(ray.end.x, ray.end.y, -ray.end.z, 0.0f, 0.0f, 0.0f,
					ray.color.r, ray.color.g, ray.color.b, 1.0f, 0.0f, 1.0f, 0.0f);
		}
		numRays = cast(int) v3d.length;
		if (numRays > 0)
			objRays.vbo.updateData(cast(ubyte[]) v3d);
		DebugDispatcher.saver.dirty = false;
	}

	private double dt = 0.01;

	this()
	{
		super("scenePanel");
		layoutWidth = FILL_PARENT;
		layoutHeight = FILL_PARENT;
		alignment = Align.Center;
		focusable(true);
		this.backgroundDrawable = DrawableRef(new OpenGLDrawable(&this.render));
		initVisuals();
		DebugDispatcher.saver.enable();
		DebugDispatcher.saver.clear();
		vbegins.length = sceneObjects.keys.length;
		vends.length = vbegins.length;
		rebuildGrid();
		camera.normalize();
	}

	private
	{
		size_t[] vbegins;
		GLsizei[] vends;
		GLsizei numvs;
	}

	@property override bool animating()
	{
		return true;
	}

	double totalDt = 0.0;
	private GFXvector3 realvel;
	override void animate(long interval_hnsecs)
	{
		camera.normalize();
		dt = interval_hnsecs * 1.0e-7;
		totalDt += dt;
		{
			float sref = max(abs(mdpitch), abs(mdyaw));
			float smoother = max(0.01f, min(sref / 1.5f, 1.0f));
			float dpitch = mdpitch * smoother;
			if (abs(dpitch) < 0.001f)
				mdpitch = 0.0f;
			camera.pitch += dpitch;
			mdpitch -= dpitch;
			float dyaw = mdyaw * smoother;
			if (abs(dyaw) < 0.001f)
				mdyaw = 0.0f;
			camera.yaw += dyaw;
			mdyaw -= dyaw;
		}
		{
			GFXvector3 camvel = GFXvector3();
			camvel = camvel + camera.dirFwd * GFXnum(camf);
			camvel = camvel + camera.dirRight * GFXnum(camr);
			camvel = camvel + camera.dirUp * GFXnum(camu);
			float adiv = abs(camf) + abs(camr) + abs(camu);
			if (adiv > 0)
				camvel = camvel / sqrt(adiv);
			realvel = (realvel + camvel) / 2.0f;
			camera.addVec(realvel, cast(float)(camera.speed * dt));
		}
	}

	public void requestFocus()
	{
		uiMain.window.setFocus(this, FocusReason.Unspecified);
	}

	private int oldmx, oldmy;
	private float mdpitch = 0.0f, mdyaw = 0.0f;
	protected override bool onMouseEvent(MouseEvent me)
	{
		int dx = me.x - oldmx;
		int dy = me.y - oldmy;
		oldmx = me.x;
		oldmy = me.y;

		if (me.lbutton.isDown)
		{
			requestFocus();
		}

		if (!mouseLocked && me.lbutton.isDown)
			mouseLocked = true;
		if (mouseLocked && !me.lbutton.isDown)
			mouseLocked = false;
		if (mouseLocked)
		{
			double dYaw = dx * M_2_PI / 150.0;
			double dPitch = dy * PI / 200.0;
			mdyaw -= dYaw;
			mdpitch += dPitch;
		}
		return true;
	}

	private int camf = 0, camr = 0, camu = 0;
	protected override bool onKeyEvent(KeyEvent ke)
	{
		if (ke.action == KeyAction.KeyUp || ke.action == KeyAction.KeyDown)
		{
			switch (ke.keyCode) with (KeyCode)
			{
			case KEY_W:
				camf = -int(ke.action != KeyAction.KeyUp);
				break;
			case KEY_S:
				camf = +int(ke.action != KeyAction.KeyUp);
				break;
			case KEY_A:
				camr = -int(ke.action != KeyAction.KeyUp);
				break;
			case KEY_D:
				camr = +int(ke.action != KeyAction.KeyUp);
				break;
			case KEY_Q:
				camu = -int(ke.action != KeyAction.KeyUp);
				break;
			case KEY_E:
				camu = +int(ke.action != KeyAction.KeyUp);
				break;
			default:
				return false;
			}
			return true;
		}
		return false;
	}

	private void render(Rect windowRect, Rect rc)
	{
		glScissor(rc.left, windowRect.height - rc.bottom, rc.width, rc.height);
		glEnable(GL_SCISSOR_TEST);
		camera.normalize();
		camera.rmatrix = gMat4Mul(gMatRotX(camera.pitch), gMatRotY(camera.yaw));
		camera.rinvmatrix = gMat4Inverse(camera.rmatrix);
		camera.matrix = gMat4Mul(camera.rmatrix,
				gMatTranslation(gVec3(-camera.x, -camera.y, -camera.z)));
		//camMover();
		matProjection = gMatProjection(camera.fov * PI / 180.0,
				rc.height / cast(double) rc.width, camera.near, camera.far);
		matProjection = gMat4Mul(matProjection, gMatTranslation(GFXvector3(
				rc.left / cast(float)-windowRect.width,
				(windowRect.height - rc.bottom) / cast(float)-windowRect.height)));
		resetGl(rc);
		glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
		glEnable(GL_DEPTH_TEST);
		//glEnable(GL_CULL_FACE);
		shader3D.bind();
		shader3D.setUniform1i("doTexture", 0);
		shader3D.setUniformM4("model", gIdentity4());
		shader3D.setUniformM4("view", camera.matrix);
		shader3D.setUniformM4("proj", matProjection);
		objSpatial.bind();
		objSpatial.vao.enableAttribs();
		numvs = 0;
		foreach (string id, TSObject* tso; sceneObjects)
		{
			if ((tso.visible) && (tso.vertCount > 0))
			{
				vbegins[numvs] = tso.vertIndex * uint.sizeof;
				vends[numvs] = tso.vertCount;
				numvs++;
			}
		}
		glMultiDrawElements(GL_TRIANGLES, cast(const(int)*)(vends.ptr),
				GL_UNSIGNED_INT, cast(const(void*)*)(vbegins.ptr), cast(GLsizei) numvs);

		objRays.bind();
		objRays.vao.enableAttribs();
		if (DebugDispatcher.saver.dirty)
			rebuildRays();
		glDrawArrays(GL_LINES, 0, numRays);

		objGrid.bind();
		objGrid.vao.enableAttribs();
		glDrawArrays(GL_LINES, 0, numGridLines);

		glDisable(GL_DEPTH_TEST);
		glDisable(GL_CULL_FACE);
		glDisable(GL_SCISSOR_TEST);
	}

	private void resetGl(Rect rc)
	{
		glBindTexture(GL_TEXTURE_2D, 0);
		glClearColor(0.3f, 0.3f, 0.3f, 1.0f);
		//glViewport(0, 0, rc.width, rc.height);
		glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
		glEnable(GL_BLEND);
		glEnable(GL_LINE_SMOOTH);
	}

	struct TraceHistoryEntry
	{
		Vectorf origin;
		Vectorf direction;
		bool doRedshift;
	}

	__gshared Color lastRayColor;
	__gshared bool doRedshift = false;
	__gshared bool persistentTracing = false;
	__gshared TraceHistoryEntry[] TraceHistory = [];
	__gshared float wavelength = 650.0;

	private void traceSingleRay(bool history = true)(Vectorf origin, Vectorf direction)
	{
		import std.concurrency : thisTid;

		static if (history)
		{
			if (!persistentTracing)
			{
				ClearTraceHistory();
			}
			TraceHistory ~= TraceHistoryEntry(origin, direction, doRedshift);
		}

		WorldSpace.RayFunc rf = DebugDispatcher.space.GetRayFunc();
		lastRayColor = rf(thisTid, Line(origin, direction, true), 0, 0, 0);

		if (doRedshift)
		{
			WorldSpaceWrapper wsw = cast(WorldSpaceWrapper)(DebugDispatcher.space);
			auto mc = cast(AnalyticMetricContainer)(wsw.smetric);
			auto met = mc.initiator.clone;
			auto first = DebugDispatcher.saver.rays[0];
			met.prepareForRequest(first.start);
			auto met_src = met.getMetricAtPoint()[0, 0];
			foreach (ref ray; DebugDispatcher.saver.rays)
			{
				met.prepareForRequest(ray.end);
				auto met_rec = met.getMetricAtPoint()[0, 0];
				ray.color = GetSpectrumColor(wavelength * sqrt(met_rec / met_src));
			}
		}

	}

	private void RetraceTraceHistory()
	{
		bool saved_doRedshift = doRedshift;
		DebugDispatcher.saver.clear();

		foreach (TraceHistoryEntry ent; TraceHistory)
		{
			doRedshift = ent.doRedshift;
			traceSingleRay!(false)(ent.origin, ent.direction);
		}

		doRedshift = saved_doRedshift;
	}

	private void ClearTraceHistory()
	{
		DebugDispatcher.saver.clear();
		TraceHistory = [];
	}

	struct CurrentRaySettings
	{
		float X = 0.0, Y = 0.0;
	}

	private CurrentRaySettings nextRayConf;

	struct GridStateData
	{
		bool xyShow = false, xzShow = false, yzShow = false;
		float zPos = 0, yPos = 0, xPos = 0;
		float xyGSize = 1, xySize = 10;
		float xzGSize = 1, xzSize = 10;
		float yzGSize = 1, yzSize = 10;
	}

	private GridStateData gridState;

	private void rebuildGrid()
	{
		Vert3D[] v3d = [];

		with (gridState)
		{
			if (xyShow)
			{
				int lineCount = cast(int) ceil(xySize / xyGSize);
				float dim = (lineCount * xyGSize) / 2;
				dim -= fmod(dim, xyGSize);
				if (dim < lineCount / 2 * xyGSize)
					dim += xyGSize;
				for (int i = -lineCount / 2; i <= lineCount / 2; i++)
				{
					v3d ~= Vert3D(xPos + i * xyGSize, yPos - dim, zPos, 0, 0,
							0, 1, 1, 1, 1, 0, 0, 1);
					v3d ~= Vert3D(xPos + i * xyGSize, yPos + dim, zPos, 0, 0,
							0, 1, 1, 1, 1, 0, 0, 1);
					v3d ~= Vert3D(xPos - dim, yPos + i * xyGSize, zPos, 0, 0,
							0, 1, 1, 1, 1, 0, 0, 1);
					v3d ~= Vert3D(xPos + dim, yPos + i * xyGSize, zPos, 0, 0,
							0, 1, 1, 1, 1, 0, 0, 1);
				}
			}

			if (xzShow)
			{
				int lineCount = cast(int) ceil(xzSize / xzGSize);
				float dim = (lineCount * xzGSize) / 2;
				dim -= fmod(dim, xzGSize);
				if (dim < lineCount / 2 * xzGSize)
					dim += xzGSize;
				for (int i = -lineCount / 2; i <= lineCount / 2; i++)
				{
					v3d ~= Vert3D(xPos + i * xzGSize, yPos, zPos - dim, 0, 0,
							0, 1, 1, 1, 1, 0, 0, 1);
					v3d ~= Vert3D(xPos + i * xzGSize, yPos, zPos + dim, 0, 0,
							0, 1, 1, 1, 1, 0, 0, 1);
					v3d ~= Vert3D(xPos - dim, yPos, zPos + i * xzGSize, 0, 0,
							0, 1, 1, 1, 1, 0, 0, 1);
					v3d ~= Vert3D(xPos + dim, yPos, zPos + i * xzGSize, 0, 0,
							0, 1, 1, 1, 1, 0, 0, 1);
				}
			}

			if (yzShow)
			{
				int lineCount = cast(int) ceil(yzSize / yzGSize);
				float dim = (lineCount * yzGSize) / 2;
				dim -= fmod(dim, yzGSize);
				if (dim < lineCount / 2 * yzGSize)
					dim += yzGSize;
				for (int i = -lineCount / 2; i <= lineCount / 2; i++)
				{
					v3d ~= Vert3D(xPos, yPos - dim, zPos + i * yzGSize, 0, 0,
							0, 1, 1, 1, 1, 0, 0, 1);
					v3d ~= Vert3D(xPos, yPos + dim, zPos + i * yzGSize, 0, 0,
							0, 1, 1, 1, 1, 0, 0, 1);
					v3d ~= Vert3D(xPos, yPos + i * yzGSize, zPos - dim, 0, 0,
							0, 1, 1, 1, 1, 0, 0, 1);
					v3d ~= Vert3D(xPos, yPos + i * yzGSize, zPos + dim, 0, 0,
							0, 1, 1, 1, 1, 0, 0, 1);
				}
			}
		}

		numGridLines = cast(int) v3d.length;
		if (numGridLines > 0)
		{
			objGrid.bind();
			objGrid.vbo.updateData(cast(ubyte[]) v3d);
		}
	}
}

struct Vert3D
{
	float x = 0.0, y = 0.0, z = 0.0;
	float tx = 0.0, ty = 0.0, tz = 0.0;
	float r = 0.0, g = 0.0, b = 0.0, a = 0.0;
	float nx = 0.0, ny = 0.0, nz = 0.0;
} // 13 floats = 52 b

private __gshared Color oColor;

private class VisualPrimitives
{
	static int appendSphere(T, U)(ref T Vrng, ref U Erng, int iv0, DebugDraw dd)
	{
		import dbg.icosphere : Icosphere;

		int cnt = 0;
		auto radius = dd.radius_one;
		auto origin = dd.plane.origin;
		auto Verng = appender!(Vert3D[])();
		auto Eerng = appender!(uint[])();
		Icosphere iso = Icosphere(4);
		foreach (v; iso.vertices[])
		{
			Verng ~= Vert3D(radius * v.x + origin.x, radius * v.y + origin.y,
					radius * v.z + origin.z, 0, 0, 0, oColor.r, oColor.g,
					oColor.b, 1.0, v.x, v.y, v.z);
		}
		foreach (t; iso.triangles[])
		{
			Eerng ~= [cast(uint)(iv0 + t.a), cast(uint)(iv0 + t.b), cast(uint)(iv0 + t.c)];
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

		Vectorf qvec;
		qvec = (vectorf(1.0f, 0.75f, -0.8f) % dd.plane.normal).normalized;
		Vectorf pvec = (qvec % dd.plane.normal).normalized;
		Vectorf vec, nvec;
		//GFXmatrix3 rot = gMat3RotateVectorOntoVector(gVec3(0, 1, 0),
		//    gVec3(rvec.x, rvec.y, rvec.z));

		int vrt = 0;
		const int deg_step = 1;
		const int mod = 2 * 361 / deg_step;
		for (int i = 0; i <= 360; i += deg_step)
		{
			double cosi = cos(cast(double) PI * i / 180);
			double sini = sin(cast(double) PI * i / 180);
			vec = (qvec * cosi + pvec * sini) * inner_radius;
			nvec = vectorf(dd.plane.normal.x - vec.x, dd.plane.normal.y - vec.y,
					dd.plane.normal.z - vec.z).normalized;
			Vrng ~= Vert3D(vec.x + dd.plane.origin.x, vec.y + dd.plane.origin.y,
					vec.z + dd.plane.origin.z, 0, 0, 0, oColor.r, oColor.g,
					oColor.b, 1.0, nvec.x, nvec.y, nvec.z);
			vec = vec * (outer_radius / inner_radius);
			nvec = vectorf(dd.plane.normal.x + vec.x, dd.plane.normal.y + vec.y,
					dd.plane.normal.z + vec.z).normalized;
			Vrng ~= Vert3D(vec.x + dd.plane.origin.x, vec.y + dd.plane.origin.y,
					vec.z + dd.plane.origin.z, 0, 0, 0, oColor.r, oColor.g,
					oColor.b, 1.0, nvec.x, nvec.y, nvec.z);

			Erng ~= [cast(uint)(iv0 + ((vrt + 0) % mod)),
				cast(uint)(iv0 + ((vrt + 1) % mod)), cast(uint)(iv0 + ((vrt + 2) % mod))];
			Erng ~= [cast(uint)(iv0 + ((vrt + 1) % mod)),
				cast(uint)(iv0 + ((vrt + 3) % mod)), cast(uint)(iv0 + ((vrt + 2) % mod))];
			vrt += 6;
		}

		return vrt;
	}

	static int appendPlane(T, U)(ref T Vrng, ref U Erng, int iv0, DebugDraw dd)
	{
		double inner_radius = 0.001;
		double outer_radius = 1000;

		Vectorf qvec;
		qvec = (vectorf(1.0f, 0.75f, -0.8f) % dd.plane.normal).normalized;
		Vectorf pvec = (qvec % dd.plane.normal).normalized;
		Vectorf vec, nvec;
		//GFXmatrix3 rot = gMat3RotateVectorOntoVector(gVec3(0, 1, 0),
		//    gVec3(rvec.x, rvec.y, rvec.z));

		int vrt = 0;
		const int deg_step = 1;
		const int mod = 2 * 361 / deg_step;
		for (int i = 0; i <= 360; i += deg_step)
		{
			double cosi = cos(cast(double) PI * i / 180);
			double sini = sin(cast(double) PI * i / 180);
			vec = (qvec * cosi + pvec * sini) * inner_radius;
			nvec = vectorf(dd.plane.normal.x - vec.x, dd.plane.normal.y - vec.y,
					dd.plane.normal.z - vec.z).normalized;
			Vrng ~= Vert3D(vec.x + dd.plane.origin.x, vec.y + dd.plane.origin.y,
					vec.z + dd.plane.origin.z, 0, 0, 0, oColor.r, oColor.g,
					oColor.b, 1.0, nvec.x, nvec.y, nvec.z);
			vec = vec * (outer_radius / inner_radius);
			nvec = vectorf(dd.plane.normal.x + vec.x, dd.plane.normal.y + vec.y,
					dd.plane.normal.z + vec.z).normalized;
			Vrng ~= Vert3D(vec.x + dd.plane.origin.x, vec.y + dd.plane.origin.y,
					vec.z + dd.plane.origin.z, 0, 0, 0, oColor.r, oColor.g,
					oColor.b, 1.0, nvec.x, nvec.y, nvec.z);

			Erng ~= [cast(uint)(iv0 + ((vrt + 0) % mod)),
				cast(uint)(iv0 + ((vrt + 1) % mod)), cast(uint)(iv0 + ((vrt + 2) % mod))];
			Erng ~= [cast(uint)(iv0 + ((vrt + 1) % mod)),
				cast(uint)(iv0 + ((vrt + 3) % mod)), cast(uint)(iv0 + ((vrt + 2) % mod))];
			vrt += 6;
		}

		return vrt;
	}

	static int appendTriangle(T, U)(ref T Vrng, ref U Erng, int iv0, DebugDraw dd)
	{
		Vectorf a = dd.tri.plane.origin;
		Vectorf[3] tab = [a, a + dd.tri.b, a + dd.tri.c];
		Vectorf normal = dd.tri.plane.normal;

		foreach (Vectorf vert; tab)
		{
			Vrng ~= Vert3D(vert.x, vert.y, vert.z, 0, 0, 0, oColor.r, oColor.g,
					oColor.b, 1.0, normal.x, normal.y, normal.z);
		}

		Erng ~= [cast(uint)(iv0), cast(uint)(iv0 + 1), cast(uint)(iv0 + 2)];

		return 3;
	}
}
