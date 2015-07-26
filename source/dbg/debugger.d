module dbg.debugger;

import derelict.glfw3.glfw3;
import glad.gl.all;
import glad.gl.loader;
import config;
import std.stdio, std.math, std.array, std.string, std.format;
import scene.scenemgr;
import scene.camera;
import scene.objects.interfaces;
import math;
import image.color;

// Source: http://www.cburch.com/cs/490/sched/feb8/
private void drawSphereGen(int lats, int longs) {
	int i, j;
	enum double PI2 = 2.0*PI;
	for(i = 0; i <= lats; i++)
	{
		double lat0 = PI * (-0.5 + cast(double) (i - 1) / lats);
		double z0  = sin(lat0);
		double zr0 =  cos(lat0);

		double lat1 = PI * (-0.5 + cast(double) i / lats);
		double z1 = sin(lat1);
		double zr1 = cos(lat1);

		glBegin(GL_QUAD_STRIP);
		for(j = 0; j <= longs; j++)
		{
			double lng = PI2 * cast(double) (j - 1) / longs;
			double x = cos(lng);
			double y = sin(lng);
			glColor3f(.5+x * zr1/2.0, .5+y * zr1/2.0, .5+z1/2.0);
			glNormal3f(x * zr0, y * zr0, z0);
			glVertex3f(x * zr0, y * zr0, z0);
			glNormal3f(x * zr1, y * zr1, z1);
			glVertex3f(x * zr1, y * zr1, z1);
		}
		glEnd();
	}
}

private Color[7] rayColors = [Colors.Red, Colors.Green, Colors.Blue,
							Colors.Magenta, Colors.Yellow, Colors.Cyan, Colors.White];

private struct SavedRay
{
	Vectorf origin;
	Vectorf destination;
	int seq;
	string toString()
	{
		return "#%-2d %s -> %s".format(seq,origin,destination);
	}
}

extern (C) private void coreMouseButton(GLFWwindow* w, int btn, int type, int modkeys) nothrow
{
	try
	{
		double xd, yd;
		glfwGetCursorPos(w, &xd, &yd);
		int x = cast(int) xd, y = cast(int) yd;
		double xR = xd/cfgResolutionX;
		double yR = yd/cfgResolutionY;
		xR*=2.0;
		yR*=2.0;
		xR-=1.0;
		yR-=1.0;
		if (type == GLFW_PRESS)
		{
			Line ray;
			if(VisualDebugger.inst.camera.fetchRay(xR,yR,ray))
			{
				VisualDebugger.inst.rays = [];
				VisualDebugger.inst.space.GetRayFunc()(renderTid,ray,x,y,0);
			}
		}
	}
	catch (Throwable o)
	{
	}
}

private static bool inCamera=false;
private static double lastX=0.0,lastY=0.0;

extern (C) private void coreMouseCamera(GLFWwindow* w, int btn, int type, int modkeys) nothrow
{
	try
	{
		double xd, yd;
		glfwGetCursorPos(w, &xd, &yd);
		int x = cast(int) xd, y = cast(int) yd;
		if(btn==GLFW_MOUSE_BUTTON_1)
		{
			if(type==GLFW_PRESS)
			{
				glfwSetInputMode(w, GLFW_CURSOR, GLFW_CURSOR_DISABLED);
				inCamera = true;
				lastX = double.nan;
				lastY = double.nan;
			}
			else
			{
				glfwSetInputMode(w, GLFW_CURSOR, GLFW_CURSOR_NORMAL);
				inCamera = false;
			}
		}
	}
	catch (Throwable o)
	{
	}
}

extern (C) void coreCameraMove(GLFWwindow* w, double x, double y) nothrow
{
	try
	{
		if(inCamera)
		{
			if(!isNaN(lastX))
			{
				double dx,dy;
				dx = x-lastX;
				dy = y-lastY;
				VisualDebugger.inst.rot.x += dy;
				VisualDebugger.inst.rot.y += dx;
			}
			lastX = x;
			lastY = y;
		}
	}
	catch (Throwable o)
	{
	}
}

extern (C) void coreKey(GLFWwindow* w, int id, int scan, int state, int mods) nothrow
{
	try
	{
		enum double spd = 2.0f;
		enum double rspd = 2.0f;
		VisualDebugger vd = VisualDebugger.inst;
		Vectorf fwd,left,down;
		anglesToAxes(vd.rot, left, fwd);
		down = fwd%left;
		left *= spd;
		fwd *= spd;
		down *= spd;
		if (state == GLFW_PRESS || state==GLFW_REPEAT)
		{
			switch(id)
			{
				case GLFW_KEY_A:
					vd.pos-=left;break;
				case GLFW_KEY_D:
					vd.pos+=left;break;
				case GLFW_KEY_W:
					vd.pos+=fwd;break;
				case GLFW_KEY_S:
					vd.pos-=fwd;break;
				case GLFW_KEY_Q:
					vd.pos-=down;break;
				case GLFW_KEY_E:
					vd.pos+=down;break;
				case GLFW_KEY_1:
					vd.ResetCamera();break;
				default:
					break;
			}
		}
	}
	catch (Throwable o)
	{
	}
}

class VisualDebugger
{
	static VisualDebugger inst;
	__gshared GLFWwindow* rwin;
	__gshared GLFWwindow* dwin;
	GLuint texId;
	GLuint drawBg, drawSphere;
	WorldSpace space;
	ICamera camera;
	static bool glLoaded = false;
	float aspect;
	SavedRay[] rays;
	Vectorf pos,rot;

	static void SaveRay(Line ray, fpnum dist)
	{
		if(inst)
		{
			if(!isFinite(dist))
			{
				dist = 100.0;
			}
			inst.rays ~= SavedRay(ray.origin,ray.origin+ray.direction*dist,cast(int)(inst.rays.length%6));
			writefln("Saved ray %s",inst.rays[$-1]);
		}
	}

	static void FoundLight(Vectorf pos)
	{
		if(inst)
		{
			inst.rays[$-1].destination = pos;
			inst.rays[$-1].seq = 6;
			writefln("Lit ray");
		}
	}

	static void SaveRay(Line ray, Vectorf newp)
	{
		if(inst)
		{
			inst.rays ~= SavedRay(ray.origin,newp,cast(int)inst.rays.length);
		}
	}

	this()
	{
		inst = this;
		DerelictGLFW3.load();
		glfwInit();
		rwin = makeWin("grtrace raytrace");
		dwin = makeWin("grtrace showrays",rwin);
		glfwSetMouseButtonCallback(rwin, &coreMouseButton);
		glfwSetMouseButtonCallback(dwin, &coreMouseCamera);
		glfwSetCursorPosCallback(dwin, &coreCameraMove);
		glfwSetKeyCallback(dwin, &coreKey);
	}

	GLFWwindow* makeWin(string title, GLFWwindow* share=null)
	{
		GLFWwindow* w;
		glfwWindowHint(GLFW_CLIENT_API, GLFW_OPENGL_API);
		glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 2);
		glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 0);
		glfwWindowHint(GLFW_FOCUSED, GL_TRUE);
		glfwWindowHint(GLFW_DOUBLEBUFFER, GL_TRUE);
		glfwWindowHint(GLFW_RESIZABLE, GL_FALSE);
		glfwWindowHint(GLFW_VISIBLE, GL_TRUE);
		w = glfwCreateWindow(cast(int)cfgResolutionX, cast(int)cfgResolutionY, title.toStringz(), null, share);
		aspect = cast(float)(cfgResolutionX)/cast(float)(cfgResolutionY);
		if(w is null)
		{
			throw new Exception("Couldn't create glfw3 window");
		}
		glfwMakeContextCurrent(w);
		glfwSwapInterval(1);
		if(!glLoaded)
		{
			glLoaded=true;
			if(!gladLoadGL())
			{
				throw new Exception("Couldn't load OpenGL functions");
			}
			writeln("Loaded OpenGL ",GLVersion.major,".",GLVersion.minor);
		}
		glfwSwapBuffers(w);
		glfwPollEvents();
		glClearColor(0, 0, 0, 1);
		glViewport(0, 0, cast(int)cfgResolutionX, cast(int)cfgResolutionY);
		glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
		glEnable(GL_BLEND);
		glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
		glLineWidth(2.0f);
		glPointSize(2.0f);
		glEnable(GL_LINE_SMOOTH);
		glHint( GL_LINE_SMOOTH_HINT, GL_NICEST );
		glfwSwapBuffers(w);
		return w;
	}

	~this()
	{
		if(rwin)
		{
			glDeleteTextures(1,&texId);
			glfwDestroyWindow(rwin);
			rwin = null;
		}
	}

	void ResetCamera()
	{
		pos = -camera.origin;
		rot = vectorf(cfgCameraPitch, cfgCameraYaw+180.0, cfgCameraRoll, 0);
	}

	void LoadTex()
	{
		glEnable(GL_TEXTURE_2D);
		glGenTextures(1,&texId);
		glBindTexture(GL_TEXTURE_2D, texId);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB8, 
			cast(int)cfgResolutionX, cast(int)cfgResolutionY, 0, 
			GL_RGB, GL_UNSIGNED_BYTE, cast(ubyte*)(space.fullray.data.ptr));
		glDisable(GL_TEXTURE_2D);

		drawBg = glGenLists(1);
		glNewList(drawBg, GL_COMPILE);
		glColor3f(1.0f,1.0f,1.0f);
		glEnable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D, texId);
		glBegin(GL_QUADS);

		glTexCoord2f(0.0,1.0);
		glVertex2f(-1.0,-1.0);

		glTexCoord2f(0.0,0.0);
		glVertex2f(-1.0,1.0);
		
		glTexCoord2f(1.0,0.0);
		glVertex2f(1.0,1.0);
		
		glTexCoord2f(1.0,1.0);
		glVertex2f(1.0,-1.0);
		
		glEnd();
		glDisable(GL_TEXTURE_2D);
		glEndList();

		glfwMakeContextCurrent(dwin);
		drawSphere = glGenLists(1);
		glNewList(drawSphere,GL_COMPILE);
		drawSphereGen(32,32);
		glEndList();
	}

	void makeFrustum(double fovY, double aspectRatio, double front, double back)
	{
		enum double DEG2RAD = 3.14159265 / 180.0;
		
		double tangent = tan(fovY/2 * DEG2RAD);   // tangent of half fovY
		double height = front * tangent;          // half height of near plane
		double width = height * aspectRatio;      // half width of near plane
		
		// params: left, right, bottom, top, near, far
		glFrustum(-width, width, -height, height, front, back);
	}

	void Run()
	{
		glfwMakeContextCurrent(rwin);
		space = cast(WorldSpace)(cfgSpace);
		camera = cast(ICamera)(cfgSpace.camera);
		ResetCamera();
		Vectorf camo = camera.origin;
		LoadTex();
		while(!(glfwWindowShouldClose(rwin)||glfwWindowShouldClose(dwin)))
		{
			// rwin
			glfwMakeContextCurrent(rwin);
			glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
			glMatrixMode(GL_PROJECTION);
			glLoadIdentity();
			glMatrixMode(GL_MODELVIEW);
			glLoadIdentity();

			glCallList(drawBg);

			glfwSwapBuffers(rwin);
			// dwin
			glfwMakeContextCurrent(dwin);
			glEnable(GL_DEPTH_TEST);
			glDepthFunc(GL_LEQUAL);
			glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
			glMatrixMode(GL_PROJECTION);
			glLoadIdentity();
			makeFrustum(60.0,aspect,1.0,2000.0);

			Vectorf fwd,left,down,right,up;
			anglesToAxes(rot, left, fwd);
			down = fwd%left;
			up = -down.normalized;
			right = -left;
			Matrix4f rotm = Matrix4f(
				right.x,up.x,fwd.x,0,
				right.y,up.y,fwd.y,0,
				right.z,up.z,fwd.z,0,
				0,0,0,1
				);
			glMultMatrixd(rotm.transposed.vals.ptr);
			glTranslated(pos.x,pos.y,pos.z);

			glMatrixMode(GL_MODELVIEW);
			glLoadIdentity();

			glColor3f(1.0f,1.0f,1.0f);
			foreach(obji; space.objects)
			{
				Renderable obj = cast(Renderable)(obji);
				DebugDraw dd = obj.getDebugDraw();
				switch(dd.type)
				{
					case DrawType.None:
						break;
					case DrawType.Sphere:
						Vectorf o = dd.plane.origin;
						glPushMatrix();
						glTranslated(o.x,o.y,o.z);
						glScaled(dd.radius,dd.radius,dd.radius);
						glCallList(drawSphere);
						glPopMatrix();
						break;
					case DrawType.Triangle:
						Triangle tr = *(dd.tri);
						glBegin(GL_TRIANGLES);
						glColor3f(1.0f,1.0f,0.0f);
						glVertex3d(tr.plane.origin.x,tr.plane.origin.y,tr.plane.origin.z);
						glColor3f(1.0f,0.0f,1.0f);
						glVertex3d(tr.b.x,tr.b.y,tr.b.z);
						glColor3f(0.0f,1.0f,1.0f);
						glVertex3d(tr.c.x,tr.c.y,tr.c.z);
						glEnd();
						break;
					default:
						break;
				}
			}
			glLoadIdentity();
			glDisable(GL_DEPTH_TEST);
			glBegin(GL_LINES);
			foreach(SavedRay ray;rays)
			{
				Color c = rayColors[ray.seq%cast(int)(rayColors.length)];
				glColor3f(c.r,c.g,c.b);
				glVertex3d(ray.origin.x, ray.origin.y, ray.origin.z);
				glVertex3d(ray.destination.x, ray.destination.y, ray.destination.z);
			}
			glEnd();
			glColor3f(0.1f,0.1f,1.0f);
			enum double BScale=15.0;
			glScaled(1.0/BScale,1.0/BScale,1.0/BScale);
			foreach(SavedRay ray;rays)
			{
				glPushMatrix();
				glTranslated(ray.origin.x*BScale, ray.origin.y*BScale, ray.origin.z*BScale);
				glCallList(drawSphere);
				glPopMatrix();
				glPushMatrix();
				glTranslated(ray.destination.x*BScale, ray.destination.y*BScale, ray.destination.z*BScale);
				glCallList(drawSphere);
				glPopMatrix();
			}
			glColor3f(1.0f,0.0f,0.0f);
			glBegin(GL_POINTS);
			glVertex3d(camera.origin.x,camera.origin.y,camera.origin.z);
			glEnd();

			glfwSwapBuffers(dwin);
			glfwPollEvents();
		}
	}
}

