module dbg.debugger;

import grtrace;
import glad.gl.all;
import glad.gl.loader;
import bindbc.glfw;
import imgui.api;
import dbg.glhelpers;
import dbg.dispatcher;
import dbg.draws;
import std.stdio, std.string, std.file, std.math, std.exception;
import std.string, std.format, std.algorithm, std.array, std.range;
import scene.camera, scene.scenemgr, math;
import scene.objects.interfaces;
import metric.interfaces;
import metric.analytic;
import metric.wrapper;
import image.color;
import image.spectrum;
import scene.creator;
import std.conv;

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

private __gshared Color oColor;

private float tryParseVal(char[] v, float ifnot)
{
	if (v.length < 1)
	{
		return ifnot;
	}
	try
	{
		float V = to!float(v);
		return V;
	}
	catch (Exception e)
	{
		return ifnot;
	}
}

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
			Eerng ~= [
				cast(uint)(iv0 + t.a), cast(uint)(iv0 + t.b), cast(uint)(iv0 + t.c)
			];
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

			Erng ~= [
				cast(uint)(iv0 + ((vrt + 0) % mod)),
				cast(uint)(iv0 + ((vrt + 1) % mod)),
				cast(uint)(iv0 + ((vrt + 2) % mod))
			];
			Erng ~= [
				cast(uint)(iv0 + ((vrt + 1) % mod)),
				cast(uint)(iv0 + ((vrt + 3) % mod)),
				cast(uint)(iv0 + ((vrt + 2) % mod))
			];
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

			Erng ~= [
				cast(uint)(iv0 + ((vrt + 0) % mod)),
				cast(uint)(iv0 + ((vrt + 1) % mod)),
				cast(uint)(iv0 + ((vrt + 2) % mod))
			];
			Erng ~= [
				cast(uint)(iv0 + ((vrt + 1) % mod)),
				cast(uint)(iv0 + ((vrt + 3) % mod)),
				cast(uint)(iv0 + ((vrt + 2) % mod))
			];
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

/// Class responsible for visual debugging
class VisualHelper
{
	private __gshared VisualHelper _inst;

	private this()
	{
	}
	/// -
	public static @property VisualHelper instance()
	{
		if (_inst is null)
		{
			_inst = new VisualHelper();
		}
		return _inst;
	}
	/// -
	public void initialize()
	{

	}

	public GRTrace* grt;
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

	private DrawnObj objSpatial, objRays, objGrid;

	private static struct TCamera
	{
		float x = 0.0f, y = 0.0f, z = 0.0f;
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

	private static struct MCamera
	{
		double focus_x = 0.5f, focus_y = 0.5f;
		float zoom = 1.0f;
		float zoom_max = 6.0f;
		float zoom_min = 1.0f;
		float zoom_speed = 0.1f;

		GFXmatrix4 matrix;

		///Normalizes parameters
		private void normalize()
		{
			zoom = clamp(zoom, zoom_min, zoom_max);
			focus_x = clamp(focus_x, 0.0f, 1.0f);
			focus_y = clamp(focus_y, 0.0f, 1.0f);
		}

		///Transforms miniature ray cordinates (-1,1) to texture ray cordinates
		void getNormalizedRayCoordinates(float x, float y, ref double ray_x, ref double ray_y)
		{
			getNormalizedTexCoordinates(x, y, ray_x, ray_y);
			ray_x = (ray_x - 0.5f) * 2;
			ray_y = (ray_y - 0.5f) * 2;
		}

		///Transforms miniature ray cordinates (-1,1) to texture cordinates
		void getNormalizedTexCoordinates(float x, float y, ref double tex_x, ref double tex_y)
		{
			auto res = gVecMatTransform(matrix, GFXvector4((x / 2) + 0.5f,
					(y / 2) + 0.5f, 0.0f, 1.0f));
			tex_x = res.x;
			tex_y = res.y;
		}

		///Rebuilds texture view matrix
		void rebuildView()
		{
			normalize();

			matrix = gMat4Mul(gMatTranslation(GFXvector3(focus_x, focus_y, 0.0f)),
				gMat4Mul(gMatScaling(GFXvector3(1.0f / zoom, 1.0f / zoom, 1.0f)),
					gMatTranslation(GFXvector3(-focus_x, -focus_y, 0.0f))));
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

	private TCamera camera;
	private MCamera miniatureCamera;
	private DrawnObj objRendered;
	private GFXshader shader2D, shader3D;
	private GFXmatrix4 matProjection;
	private TSObject*[string] sceneObjects;
	private TSObject*[] sortedObjects;
	private bool mouseInGui, mouseLocked, mouseInMiniature, miniatureMove, pMouseInGui;
	int numverts, numRays, numGridLines;
	private void initVisuals()
	{
		texRendered = new GFXtexture();
		import std.file : exists;

		if (DebugDispatcher.renderResult is null)
		{
			import image.memory : Image;

			DebugDispatcher.renderResult = new Image(8, 8);
		}
		if (grt.config.noImage && exists(grt.config.outputFile))
		{
			import image.imgio : ReadImage;

			texRendered.recreateTexture(ReadImage(grt.config.outputFile));
		}
		else
		{
			texRendered.recreateTexture(DebugDispatcher.renderResult);
		}
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
		shader2D.setUniformM4("texModel", gIdentity4());
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
		if (grt.config.verbose)
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
		objRendered.vao.disableAttribs();
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

		miniatureCamera.rebuildView();

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

	private double dt;
	enum DWindow
	{
		None,
		Raytrace,
		Coordinates
	}

	private DWindow window;

	/// Starts the graphical part of the debugger
	public void runGraphics()
	{
		double Taccum = 0.0;
		GLFWSupport ret = loadGLFW();
		if(ret != glfwSupport) {
			static import bindbc.loader.sharedlib;
			foreach(info; bindbc.loader.sharedlib.errors) {
				writeln(info.error, info.message);
			}

			string msg;
			if(ret == GLFWSupport.noLibrary) {
				msg = "This application requires the GLFW library.";
			} else {
				msg = "The version of the GLFW library on your system is too low. Please upgrade.";
			}
			throw new Error(msg);
    	}

		glfwInit();
		setupWindow();
		initVisuals();
		DebugDispatcher.saver.enable();
		DebugDispatcher.saver.clear();
		enforce(imguiInit("firasans-medium.ttf", 1024));
		int scroll_d = 0;
		glfwSetTime(0.0);
		size_t[] vbegins;
		GLsizei[] vends;
		GLsizei numvs;
		vbegins.length = sceneObjects.keys.length;
		vends.length = vbegins.length;
		rebuildGrid();
		while (!glfwWindowShouldClose(rwin))
		{
			dt = glfwGetTime();
			Taccum += dt;
			glfwSetTime(0.0);
			pMouseInGui = mouseInGui;
			mouseInGui = false;
			camera.normalize();
			camera.rmatrix = gMat4Mul(gMatRotX(camera.pitch), gMatRotY(camera.yaw));
			camera.rinvmatrix = gMat4Inverse(camera.rmatrix);
			camera.matrix = gMat4Mul(camera.rmatrix,
				gMatTranslation(gVec3(-camera.x, -camera.y, -camera.z)));
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
			shader2D.bind();
			shader2D.setUniform1i("doTexture", 1);
			if (glfwGetKey(rwin, GLFW_KEY_F) == GLFW_RELEASE)
			{
				shader2D.setUniformM4("model", gMat4Mul(gMatTranslation(gVec3(-winx + 60,
						-winy + 60, 0)), gMatScaling(gVec3(50, 50, 1))));

				shader2D.setUniformM4("texModel", miniatureCamera.matrix);
			}
			else if (!pMouseInGui)
			{
				glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
				auto tex_aspect = cast(double) texRendered.getWidth() / texRendered.getHeight();
				auto min_res = min(winx, winy);

				shader2D.setUniformM4("model", gMat4Mul(gMatTranslation(gVec3(-winx / 2,
						-winy / 2, 0)), gMatScaling(gVec3(min_res * tex_aspect / 2.0,
						min_res / 2.0, 1))));
				shader2D.setUniformM4("texModel", gIdentity4());
			}
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

			mouseInGui |= imguiBeginScrollArea("Controls", 10, 270, 240, winy - 280, &scroll_d);
			{
				imguiLabel("FPS: %.1f".format(1.0 / dt));
				imguiSlider("BG", &bgIntensity, 0.0f, 1.0f, 0.02f);
				static bool expView = true;
				imguiCollapse("View controls", "", &expView);
				if (expView)
				{
					imguiIndent();
					imguiLabel("x y z:");
					imguiLabel("%.1f %.1f %.1f".format(camera.x, camera.y, camera.z));
					imguiLabel("Pitch: %.1f".format(camera.pitch));
					imguiLabel("Yaw: %.1f".format(camera.yaw));
					imguiSlider("Cam Speed", &camera.speed, 1.0f, 80.0f, 0.5f);
					imguiSlider("FOV", &camera.fov, 20.0f, 150.0f, 1.0f);
					imguiSlider("Near", &camera.near, 0.0001f, 1.0f, 0.0001f);
					imguiSlider("Far", &camera.far, 2.0f, 10_000.0f, 10.0f);
					imguiUnindent();
				}
				imguiCheck("Persistent Ray Saver", &persistentTracing);
				if (imguiButton("Clear Ray History"))
				{
					ClearTraceHistory();
				}
				if (imguiButton("Calculations"))
				{
					import dbg.calcs : askCalculation;

					askCalculation(grt);
				}
				if (imguiButton("Single trace"))
				{
					window = DWindow.Raytrace;
				}
				if (imguiButton("Grid settings"))
				{
					window = DWindow.Coordinates;
				}
				static bool checkState = true;
				imguiCollapse("Simulation Details", "", &checkState);
				if (checkState)
				{
					imguiIndent();
					imguiLabel("World: %s".format(dbgWorldType));
					fpnum param_step;
					size_t max_number_of_steps;
					bool dirty_history = false;
					MetricContainer wrp = cast(MetricContainer)(
						cast(WorldSpaceWrapper) grt.config.space).smetric;

					final switch (dbgWorldType) with (WorldType)
					{
					case Unknown:
						{
							throw new Exception("[DBG] Unknown WorldType");
						}
					case Flat:
						{
							break;
						}
					case Analytic:
						param_step = (cast(metric.analytic.Analytic) wrp).paramStep;
						max_number_of_steps = (cast(metric.analytic.Analytic) wrp).maxNumberOfSteps;
						goto case AnalyticSkyBox;
					case AnalyticSkyBox:
						{
							if (dbgWorldType == WorldType.AnalyticSkyBox)
							{
								param_step = (cast(metric.analytic.AnalyticSkyBox) wrp).paramStep;
								max_number_of_steps = (cast(metric.analytic.AnalyticSkyBox) wrp)
									.maxNumberOfSteps;
							}
							param_step = abs(param_step);
							imguiLabel("Metric: %s".format(dbgMetricType));
							Initiator ini = (cast(AnalyticMetricContainer) wrp).initiator;

							float gui_param_step = cast(float) param_step;
							float gui_max_number_of_steps = cast(float) max_number_of_steps;
							imguiLabel("Param Step: %f".format(param_step));
							imguiSlider("", &gui_param_step, 0.001f, 1.0f, 0.001f);
							imguiLabel("Max Number of Steps: %d".format(max_number_of_steps));
							imguiSlider("", &gui_max_number_of_steps, 1, 10000, 1);

							if (gui_max_number_of_steps != max_number_of_steps
								|| gui_param_step != param_step)
							{
								dirty_history = true;

								if (dbgWorldType == WorldType.AnalyticSkyBox)
								{
									(cast(metric.analytic.AnalyticSkyBox) wrp).paramStep
										= -gui_param_step;
									(cast(metric.analytic.AnalyticSkyBox) wrp).maxNumberOfSteps = cast(
										size_t) gui_max_number_of_steps;
								}
								else
								{
									(cast(metric.analytic.Analytic) wrp).paramStep
										= -gui_param_step;
									(cast(metric.analytic.Analytic) wrp).maxNumberOfSteps = cast(
										size_t) gui_max_number_of_steps;
								}
							}

							final switch (dbgMetricType) with (MetricType)
							{
							case MetricType.Unknown:
								{
									throw new Exception("[DBG] Unknown MetricType");
								}
							case FlatCartesian:
							case FlatRadial:
								break;
							case MetricType.Schwarzchild:
								{
									import metric.initiators.schwarzschild;

									auto met = cast(Schwarzschild) ini;
									float mass = met.mass;
									imguiLabel("Mass: %f".format(mass));
									imguiSlider("", &mass, 0.0f, 10.0f, 0.1f);

									if (mass != cast(float) met.mass)
									{
										dirty_history = true;
										met.mass = mass;
										met.schwarzschild_radius = 2 * met.mass;

										Vert3D[] v3d = [];
										uint[] e3d = [];

										auto deb = met.returnDebugRenderObjects()["@event_horizon"];
										TSObject* tso = sceneObjects["@event_horizon"];

										VisualPrimitives.appendSphere(v3d, e3d, tso.dataIndex, deb);

										(cast(Vert3D[]) objSpatial.data.data)[(
												tso.dataIndex) .. (tso.dataIndex + v3d.length)] = v3d[0
											.. $];

										objSpatial.bind();
										//TODO: update only the changed slice
										//TODO: append a modelview matrix to every object
										objSpatial.vbo.updateData(objSpatial.data.data);

									}
									break;
								}
							case MetricType.Reisnerr:
								{
									import metric.initiators.reissner;

									auto met = cast(Reissner) ini;
									float mass = met.M;
									float charge = met.Q;
									imguiLabel("Mass: %f".format(mass));
									imguiSlider("", &mass, 0.0f, 10.0f, 0.1f);
									imguiLabel("Charge: %f".format(charge));
									imguiSlider("", &charge, 0.0f, 10.0f, 0.1f);
									if (mass != cast(float) met.M || charge != cast(float) met.Q)
									{
										dirty_history = true;
										with (met)
										{
											M = mass;
											Q = charge;
											Rs = 2 * M;
											Q2 = Q * Q;

											if (1 - (4 * Q2) / (Rs * Rs) >= 0)
											{
												det = (Rs / 2) * sqrt(1 - (4 * Q2) / (Rs * Rs));
												r_ext = (Rs / 2) + det;
												r_cauchy = (Rs / 2) - det;
											}
											else
												r_ext = r_cauchy = 0;

											Vert3D[] v3d = [];
											uint[] e3d = [];

											auto deb = returnDebugRenderObjects()[
												"@ext_event_horizon"
											];
											TSObject* tso = sceneObjects["@ext_event_horizon"];

											VisualPrimitives.appendSphere(v3d,
												e3d, tso.dataIndex, deb);

											(cast(Vert3D[]) objSpatial.data.data)[(
													tso.dataIndex) .. (tso.dataIndex + v3d.length)] = v3d[0
												.. $];

											objSpatial.bind();
											//TODO: update only the changed slice
											//TODO: append a modelview matrix to every object
											objSpatial.vbo.updateData(objSpatial.data.data);
										}
									}

									break;
								}
							case MetricType.Kerr:
								{
									import metric.initiators.kerr;

									auto met = cast(metric.initiators.kerr.Kerr) ini;
									float mass = met.m;
									float angular_momentum = met.j;
									imguiLabel("Mass: %f".format(mass));
									imguiSlider("", &mass, 0.0f, 10.0f, 0.1f);
									imguiLabel("Momentum: %f".format(angular_momentum));
									imguiSlider("", &angular_momentum, 0.0f, 10.0f, 0.1f);
									if (mass != cast(float) met.m
										|| angular_momentum != cast(float) met.j)
									{
										dirty_history = true;
										with (met)
										{
											m = mass;
											Rs = 2 * m;
											j = angular_momentum;
											if (mass == 0)
												a = 0;
											else
												a = angular_momentum / m;
											a2 = a * a;
											r_plus = Rs / 2 + sqrt((Rs * Rs) / 4 - a2);
										}
									}
									break;
								}
							}
							break;
						}
					}

					if (dirty_history)
					{
						RetraceTraceHistory();
					}

					imguiUnindent();
				}
			}
			imguiEndScrollArea();
			if ((!pMouseInGui) && glfwGetKey(rwin, GLFW_KEY_F1) == GLFW_PRESS)
			{
				static int scroll_cs;
				mouseInGui |= imguiBeginScrollArea("Help", winx / 2 - 150,
					winy / 2 - 250, 300, 500, &scroll_cs);
				imguiLabel("Keys:");
				imguiLabel("F1 - this help");
				imguiLabel("W,A,S,D,Q,E - Camera movement");
				imguiLabel("Tab - Object list");
				imguiLabel("R - Reset camera to raytrace settings");
				imguiLabel("G - Position list");
				imguiLabel("Shift+R - Reset camera to 0,0,0");
				imguiLabel("F - Show fullscreen image");
				imguiLabel("F+Left Click - Raytrace from image");
				imguiLabel("1 - Do a raytrace");
				imguiLabel("2 - Coordinate grid settings");
				//imguiLabel("");
				imguiEndScrollArea();
			}
			if (glfwGetKey(rwin, GLFW_KEY_TAB) == GLFW_PRESS)
			{
				static int scroll_ol;
				mouseInGui |= imguiBeginScrollArea("Objects", winx / 2 - 150,
					winy / 2 - 250, 300, 500, &scroll_ol);
				foreach (TSObject* obj; sortedObjects)
				{
					imguiCollapse(obj.id, "", &obj.opanel);
					if (obj.opanel)
					{
						imguiIndent();
						imguiCheck("Visible", &obj.visible);
						imguiUnindent();
					}
				}
				imguiEndScrollArea();
			}
			if ((!pMouseInGui) && glfwGetKey(rwin, GLFW_KEY_G) == GLFW_PRESS)
			{
				SVec3 sv3;
				if (showVectors(sv3))
				{
					camera.x = sv3.x;
					camera.y = sv3.y;
					camera.z = sv3.z;
				}
			}
			mouseInGui |= windowRaytrace();
			mouseInGui |= windowCoordinates();

			imguiEndFrame();
			mousescroll = 0;
			keychar = 0;
			imguiRender(winx, winy);
			glfwSwapBuffers(rwin);
			updateMods();
			glfwPollEvents();
		}
		imguiDestroy();
		glfwTerminate();
	}

	private bool showVectors(ref SVec3 vec)
	{
		static int scroll_pos;
		mouseInGui |= imguiBeginScrollArea("Positions", winx / 2 - 200,
			winy / 2 - 275, 400, 550, &scroll_pos);
		bool flag = false;
		foreach (string key, SValue sv; SceneDescription.defines)
		{
			if ((sv.peek!SVec3) is null)
			{
				continue;
			}
			if (imguiButton(key))
			{
				vec = sv.get!SVec3;
				flag = true;
			}
		}
		imguiEndScrollArea();
		return flag;
	}

	private void resetGl()
	{
		glBindTexture(GL_TEXTURE_2D, 0);
		glClearColor(bgIntensity, bgIntensity, bgIntensity, 1.0f);
		glViewport(0, 0, winx, winy);
		glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
		glEnable(GL_BLEND);
		glEnable(GL_LINE_SMOOTH);
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
		int W = cast(int) grt.config.resolutionX;
		int H = cast(int) grt.config.resolutionY;
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
		lastRayColor = rf(grt, thisTid, Line(origin, direction, true), 0, 0, 0);

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

	private void TextFloatInput(const(char)[] label, char[] buffer, ref char[] slice)
	{
		imguiTextInput(label, buffer, slice);
		while (slice.length > 0 && !((slice[$ - 1] >= '0' && slice[$ - 1] <= '9')
				|| slice[$ - 1] == '.' || slice[$ - 1] == '-'))
		{
			slice = slice[0 .. $ - 1];
		}
	}

	private bool windowRaytrace()
	{
		if (window != DWindow.Raytrace)
			return false;
		static int scroll;
		bool mig = imguiBeginScrollArea("Raytrace", winx - 350, winy / 2 - 250, 340, 500, &scroll);
		static bool fromImage = false;
		static bool predef = false, predefD = false;
		static SVec3 predefV;
		if (WorldSpaceWrapper wsw = cast(WorldSpaceWrapper)(DebugDispatcher.space))
		{
			imguiCheck("Visualise redshift", &doRedshift);
			if (doRedshift)
			{
				imguiSlider("Wavelength", &wavelength, 300.0, 1000.0, 10.0f);
			}
			bool integr;
			imguiLabel("Integrator: ");
			imguiIndent();
			foreach (i, memb; __traits(allMembers, Integrator))
			{
				static if (memb[0] >= 'A' && memb[0] <= 'Z')
				{
					enum val = mixin("Integrator." ~ memb);
					integr = (grt.config.integrator == val);
					if (imguiCheck(memb, &integr))
					{
						grt.config.integrator = val;
					}
				}
			}
			imguiUnindent();
		}
		imguiCheck("Use image coordinates", &fromImage);
		if (fromImage)
		{
			static bool Cont = false;
			bool mod = false;
			if (glfwGetKey(rwin, GLFW_KEY_KP_4) == GLFW_PRESS)
			{
				nextRayConf.X -= 0.1;
				mod = true;
			}
			if (glfwGetKey(rwin, GLFW_KEY_KP_6) == GLFW_PRESS)
			{
				nextRayConf.X += 0.1;
				mod = true;
			}
			if (glfwGetKey(rwin, GLFW_KEY_KP_8) == GLFW_PRESS)
			{
				nextRayConf.Y -= 0.1;
				mod = true;
			}
			if (glfwGetKey(rwin, GLFW_KEY_KP_2) == GLFW_PRESS)
			{
				nextRayConf.Y += 0.1;
				mod = true;
			}
			if ((imguiSlider("X", &nextRayConf.X, 0.0, grt.config.resolutionX, 1.0f) && Cont) || mod)
			{
				float cx = (nextRayConf.X / grt.config.resolutionX) * 2.0 - 1.0;
				float cy = (nextRayConf.Y / grt.config.resolutionY) * 2.0 - 1.0;
				Line ray;
				DebugDispatcher.space.getCamera.fetchRay(cx, cy, ray);
				traceSingleRay(ray.origin, ray.direction);
			}
			if ((imguiSlider("Y", &nextRayConf.Y, 0.0, grt.config.resolutionY, 1.0f) && Cont) || mod)
			{
				float cx = (nextRayConf.X / grt.config.resolutionX) * 2.0 - 1.0;
				float cy = (nextRayConf.Y / grt.config.resolutionY) * 2.0 - 1.0;
				Line ray;
				DebugDispatcher.space.getCamera.fetchRay(cx, cy, ray);
				traceSingleRay(ray.origin, ray.direction);
			}
			imguiCheck("Continuous", &Cont);
			if (imguiButton("Trace"))
			{
				float cx = (nextRayConf.X / grt.config.resolutionX) * 2.0 - 1.0;
				float cy = (nextRayConf.Y / grt.config.resolutionY) * 2.0 - 1.0;
				Line ray;
				DebugDispatcher.space.getCamera.fetchRay(cx, cy, ray);
				traceSingleRay(ray.origin, ray.direction);
			}
		}
		else
		{
			static Point p = Point(0.0, 0.0, 0.0);
			static Vectorf d = Vectorf(0.0, 0.0, 0.0);
			static char[64] b1, b2, b3, b4, b5, b6;
			static char[] tx1, tx2, tx3, tx4, tx5, tx6;
			if (tx1.ptr != b1.ptr)
			{
				tx1 = b1[0 .. 0];
				tx2 = b2[0 .. 0];
				tx3 = b3[0 .. 0];
				tx4 = b4[0 .. 0];
				tx5 = b5[0 .. 0];
				tx6 = b6[0 .. 0];
			}
			imguiLabel("Position:");
			imguiCheck("Use predefined", &predef);
			if (predefD)
			{
				tx1 = sformat(b1, "%.3f", predefV.x);
				tx2 = sformat(b2, "%.3f", predefV.y);
				tx3 = sformat(b3, "%.3f", predefV.z);
				predefD = false;
			}

			TextFloatInput("X", b1, tx1);
			TextFloatInput("Y", b2, tx2);
			TextFloatInput("Z", b3, tx3);
			imguiLabel("Direction:");
			TextFloatInput("X", b4, tx4);
			TextFloatInput("Y", b5, tx5);
			TextFloatInput("Z", b6, tx6);
			p.x = tryParseVal(tx1, p.x);
			p.y = tryParseVal(tx2, p.y);
			p.z = -tryParseVal(tx3, p.z);
			d.x = tryParseVal(tx4, d.x);
			d.y = tryParseVal(tx5, d.y);
			d.z = -tryParseVal(tx6, d.z);
			if (imguiButton("Trace"))
			{
				traceSingleRay(p, -d.normalized);
			}
		}
		if (imguiButton("Close"))
		{
			window = DWindow.None;
		}

		imguiEndScrollArea();
		if (predef)
		{
			if (showVectors(predefV))
			{
				predef = false;
				predefD = true;
			}
		}

		return mig;
	}

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

	private bool windowCoordinates()
	{
		if (window != DWindow.Coordinates)
			return false;

		static int scroll;
		bool mig = imguiBeginScrollArea("Grid Settings", winx - 200,
			winy / 2 - 250, 190, 500, &scroll);

		static bool xyExp, xzExp, yzExp;

		static GridStateData curGridState;

		imguiSlider("X Pos", &curGridState.xPos, -15f, 15f, 1f);
		imguiSlider("Y Pos", &curGridState.yPos, -15f, 15f, 1f);
		imguiSlider("Z Pos", &curGridState.zPos, -15f, 15f, 1f);

		imguiCollapse("XY Grid Settings", " ", &xyExp);
		if (xyExp)
		{
			imguiIndent();
			imguiCheck("Show", &curGridState.xyShow);
			imguiSlider("Grid Size", &curGridState.xyGSize, 0.5f, 5f, 0.5f);
			imguiSlider("Size", &curGridState.xySize, 5f, 200f, 1f);
			imguiUnindent();
		}

		imguiCollapse("XZ Grid Settings", " ", &xzExp);
		if (xzExp)
		{
			imguiIndent();
			imguiCheck("Show", &curGridState.xzShow);
			imguiSlider("Grid Size", &curGridState.xzGSize, 0.5f, 5f, 0.5f);
			imguiSlider("Size", &curGridState.xzSize, 5f, 200f, 1f);
			imguiUnindent();
		}

		imguiCollapse("YZ Grid Settings", " ", &yzExp);
		if (yzExp)
		{
			imguiIndent();
			imguiCheck("Show", &curGridState.yzShow);
			imguiSlider("Grid Size", &curGridState.yzGSize, 0.5f, 5f, 0.5f);
			imguiSlider("Size", &curGridState.yzSize, 5f, 200f, 1f);
			imguiUnindent();
		}

		if (curGridState != gridState)
		{
			gridState = curGridState;
			rebuildGrid();
		}

		if (imguiButton("Close"))
		{
			window = DWindow.None;
		}

		imguiEndScrollArea();
		return mig;
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
		if (glfwGetKey(rwin, GLFW_KEY_F) == GLFW_PRESS)
		{
			if (button == GLFW_MOUSE_BUTTON_LEFT)
			{
				if (state != GLFW_RELEASE)
				{
					double xd, yd;
					glfwGetCursorPos(rwin, &xd, &yd);
					auto tex_aspect = cast(double) texRendered.getWidth() / texRendered.getHeight();
					auto min_res = min(winx, winy);
					xd = (cast(double)(x - winx / 2) / (min_res / 2.0));
					yd = (cast(double)(y - winy / 2) / ((min_res * tex_aspect) / 2.0));
					nextRayConf.X = ((xd + 1.0) / 2.0) * grt.config.resolutionX;
					nextRayConf.Y = ((yd + 1.0) / 2.0) * grt.config.resolutionY;
					Line ray;
					DebugDispatcher.space.getCamera.fetchRay(xd, yd, ray);
					traceSingleRay(ray.origin, ray.direction);
				}
			}

			return;
		}

		if ((x >= 10) && (y >= winy - 110) && (x <= 110) && (y <= winy - 10))
		{
			if (button == GLFW_MOUSE_BUTTON_LEFT)
			{
				if (state != GLFW_RELEASE)
				{
					mouseInMiniature = true;
					miniatureMove = false;
				}
				else
				{
					double xd = clamp(mousex, 10, 110) - 10.0f;
					double yd = clamp(mousey, winy - 110, winy - 10) - (winy - 110.0f);
					xd = (xd / 50.0) - 1.0;
					yd = (yd / 50.0) - 1.0;
					miniatureCamera.getNormalizedRayCoordinates(xd, yd, xd, yd);
					nextRayConf.X = ((xd + 1.0) / 2.0) * grt.config.resolutionX;
					nextRayConf.Y = ((yd + 1.0) / 2.0) * grt.config.resolutionY;
					Line ray;
					DebugDispatcher.space.getCamera.fetchRay(xd, yd, ray);
					traceSingleRay(ray.origin, ray.direction);
					mouseInMiniature = false;
				}
			}
			if (button == GLFW_MOUSE_BUTTON_RIGHT)
			{
				if (state != GLFW_RELEASE)
				{
					miniatureMove = true;
				}
				else
				{
					miniatureMove = false;
				}
			}
			return;
		}
		else
		{
			mouseInMiniature = false;
			miniatureMove = false;
		}

		if (mouseLocked)
		{
			if (button == GLFW_MOUSE_BUTTON_LEFT)
			{
				if (state == GLFW_RELEASE)
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
		else if (!mouseInGui)
		{
			if (button == GLFW_MOUSE_BUTTON_LEFT)
			{
				if (state == GLFW_PRESS)
				{
					double xd, yd;
					glfwGetCursorPos(rwin, &xd, &yd);
					mousex = cast(int) xd;
					mousey = cast(int) yd;
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
				mousebtns &= ~cast(int)(MouseButton.left);
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
				mousebtns &= ~cast(int)(MouseButton.right);
			}
		}
	}

	/// -
	public void onMouseMove(int x, int y)
	{
		if (mouseLocked)
		{
			int dx = x - mousex;
			int dy = y - mousey;
			double dYaw = dx * M_2_PI / 150.0;
			double dPitch = dy * PI / 200.0;
			camera.yaw -= dYaw;
			camera.pitch = clamp(camera.pitch + dPitch, -PI + 0.001, PI - 0.001);
		}
		else if (mouseInMiniature)
		{
			double xd = clamp(mousex, 10, 110) - 10.0f;
			double yd = clamp(mousey, winy - 110, winy - 10) - (winy - 110.0f);
			xd = (xd / 50.0) - 1.0;
			yd = (yd / 50.0) - 1.0;
			miniatureCamera.getNormalizedRayCoordinates(xd, yd, xd, yd);
			nextRayConf.X = ((xd + 1.0) / 2.0) * grt.config.resolutionX;
			nextRayConf.Y = ((yd + 1.0) / 2.0) * grt.config.resolutionY;
			Line ray;
			DebugDispatcher.space.getCamera.fetchRay(xd, yd, ray);
			traceSingleRay(ray.origin, ray.direction);
		}
		else if (miniatureMove)
		{
			if (clamp(mousex, 10, 110) != mousex || clamp(mousey, winy - 110, winy - 10) != mousey)
			{
				miniatureMove = false;
			}
			else
			{
				with (miniatureCamera)
				{
					double dx = (x - mousex) / (100.0 * zoom);
					double dy = (y - mousey) / (100.0 * zoom);

					focus_x += dx;
					focus_y += dy;

					normalize();
					rebuildView();
				}
			}

		}
		mousex = x;
		mousey = y;
	}

	/// -
	public void onScroll(double axis, double dir)
	{
		mousescroll = cast(int) dir;

		if ((mousex >= 10) && (mousey >= winy - 110) && (mousex <= 110) && (mousey <= winy - 10))
		{
			double xd = clamp(mousex, 10, 110) - 10.0f;
			double yd = clamp(mousey, winy - 110, winy - 10) - (winy - 110.0f);
			xd = (xd / 50.0f) - 1.0f;
			yd = (yd / 50.0f) - 1.0f;

			with (miniatureCamera)
			{
				//getNormalizedTexCoordinates(xd, yd, focus_x, focus_y);
				zoom += zoom * zoom_speed * mousescroll;
				rebuildView();
			}
		}

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
			if (window == DWindow.None)
			{
				glfwSetWindowShouldClose(rwin, GL_TRUE);
				return;
			}
			else if ((!pMouseInGui)) //hacked :)
			{
				window = DWindow.None;
			}
		}
		if (id == GLFW_KEY_BACKSPACE && state != GLFW_RELEASE)
		{
			keychar = '\b';
		}
		else if (id == GLFW_KEY_ENTER && state != GLFW_RELEASE)
		{
			keychar = '\n';
		}

		//hacked :)
		if ((!pMouseInGui))
		{
			if (window == DWindow.None)
			{
				if (id == GLFW_KEY_R && state == GLFW_PRESS)
				{
					if (modLShift || modRShift) // reset to 0,0,0
					{
						camera.x = 0.0;
						camera.y = 0.0;
						camera.z = 0.0;
						camera.pitch = 0.0;
						camera.yaw = 0.0;
						sceneObjects["@camera"].visible = true;
					}
					else
					{
						auto rcam = DebugDispatcher.space.getCamera();
						camera.x = rcam.origin.x;
						camera.y = rcam.origin.y;
						camera.z = -rcam.origin.z;
						camera.pitch = acos(rcam.lookdir.z);
						camera.yaw = atan2(rcam.lookdir.y, rcam.lookdir.x);
						sceneObjects["@camera"].visible = false;
					}
				}
			}

			if (id == GLFW_KEY_1 && state == GLFW_PRESS)
			{
				if (window == DWindow.Raytrace)
				{
					window = DWindow.None;
				}
				else
				{
					window = DWindow.Raytrace;

				}
			}
			else if (id == GLFW_KEY_2 && state == GLFW_PRESS)
			{
				if (window == DWindow.Coordinates)
				{
					window = DWindow.None;
				}
				else
				{
					window = DWindow.Coordinates;
				}
			}
		}
	}

	void camMover()
	{
		//hacked :)
		if ((!pMouseInGui))
		{
			double CamSpeed = camera.speed * dt;
			if (glfwGetKey(rwin, GLFW_KEY_W) != GLFW_RELEASE)
			{
				camera.addVec(camera.dirFwd, -CamSpeed);
			}
			if (glfwGetKey(rwin, GLFW_KEY_S) != GLFW_RELEASE)
			{
				camera.addVec(camera.dirFwd, CamSpeed);
			}
			if (glfwGetKey(rwin, GLFW_KEY_A) != GLFW_RELEASE)
			{
				camera.addVec(camera.dirRight, -CamSpeed);
			}
			if (glfwGetKey(rwin, GLFW_KEY_D) != GLFW_RELEASE)
			{
				camera.addVec(camera.dirRight, CamSpeed);
			}
			if (glfwGetKey(rwin, GLFW_KEY_E) != GLFW_RELEASE)
			{
				camera.addVec(camera.dirUp, CamSpeed);
			}
			if (glfwGetKey(rwin, GLFW_KEY_Q) != GLFW_RELEASE)
			{
				camera.addVec(camera.dirUp, -CamSpeed);
			}
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
