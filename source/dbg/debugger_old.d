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
import image.spectrum;
import metric;

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

	/*	glBegin(GL_QUAD_STRIP);
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
		glEnd();*/
	}
}

public Color[7] rayColors = [Colors.Red, Colors.Green, Colors.Blue,
							Colors.Magenta, Colors.Yellow, Colors.Cyan, Colors.White];

private struct SavedRay
{
	Vectorf origin;
	Vectorf destination;
	Vectorf direction;
	fpnum distance;
	Color col;
	string toString()
	{
		return "#%-2d %s -> %s".format(col,origin,destination);
	}
}

bool rayMode=false;

extern (C) private void corexMouseButton(GLFWwindow* w, int btn, int type, int modkeys) nothrow
{
	try
	{
		if(btn==GLFW_MOUSE_BUTTON_1)
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
				rayMode = true;
				Line ray;
				if(VisualDebugger_Old.inst.camera.fetchRay(xR,yR,ray))
				{
					//FloatingPointControl fpc;fpc.enableExceptions(fpc.severeExceptions);
					VisualDebugger_Old.inst.rays = [];
					VisualDebugger_Old.DebugRayA = &VisualDebugger_Old.SaveRay;
					VisualDebugger_Old.DebugRayB = &VisualDebugger_Old.SaveRay;
					VisualDebugger_Old.inst.DebugRayA = &VisualDebugger_Old.SaveRay;
					VisualDebugger_Old.inst.DebugRayB = &VisualDebugger_Old.SaveRay;
					VisualDebugger_Old.inst.start_col = Colors.Red;
					//TODO:remove
					//ray = Line(vectorf(cfgCameraX, cfgCameraY, cfgCameraZ), vectorf(1,0.01,0).normalized);
					//writeln(ray);
					//double h = 0;
					/*for(double h = -1; h<=1; h+=0.1)
					{
						ray = Line(vectorf(cfgCameraX, cfgCameraY, cfgCameraZ), vectorf(h,0,1).normalized);
						//writeln(h);
						VisualDebugger_Old.inst.space.GetRayFunc()(renderTid,ray,x,y,0);
					}*/
					
					//ray = Line(vectorf(cfgCameraX, cfgCameraY, cfgCameraZ), vectorf(3,h,1).normalized);
					Color outcol = VisualDebugger_Old.inst.space.GetRayFunc()(renderTid,ray,x,y,0);
					if( (x>=0) && (y>=0) && (x<cfgResolutionX) && (y<cfgResolutionY))
					{
						ubyte[] pixel = [outcol.ru,outcol.gu,outcol.bu];
						glfwMakeContextCurrent(VisualDebugger_Old.inst.rwin);
						glBindTexture(GL_TEXTURE_2D, VisualDebugger_Old.inst.texId);
						glTexSubImage2D(GL_TEXTURE_2D,0,x,y,1,1,GL_RGB,GL_UNSIGNED_BYTE,pixel.ptr);
					}
					
					if(isFinite(VisualDebugger_Old.inst.cur_src_lambda)) VisualizeRedshift(VisualDebugger_Old.inst.cur_src_lambda);

					VisualDebugger_Old vd = VisualDebugger_Old.inst;
					/*for(int i=1;i<vd.rays.length;i++)
					{
						SavedRay r0,r1;
						r0 = vd.rays[i-1];
						r1 = vd.rays[i];
						Vectorf d1,d2;
						d1 = (r0.destination - r0.origin).normalized;
						d2 = (r1.destination - r1.origin).normalized;
						//writeln(r0);
						auto dot = d1*d2;
						if((-1<=dot)&&(dot<=1)) //TODO:COMMENTED
						{
							writefln("Angle #%d->#%d: %s",i,i+1,acos(dot)*180.0/PI);
						}
						else
						{
							writefln("Xxxxx #%d->#%d: %s",i,i+1,dot);
						}
					}*/
				}
			}
			else if(type==GLFW_RELEASE)
			{
				rayMode = false;
			}
		}
	}
	catch (Throwable o)
	{
	}
}

extern (C) void corexRayMove(GLFWwindow* w, double x, double y) nothrow
{
	try
	{
		if(rayMode)
		{
			corexMouseButton(w,GLFW_MOUSE_BUTTON_1,GLFW_PRESS,0);
		}
	}
	catch (Throwable o)
	{
	}
}

private static bool inCamera=false;
private static double lastX=0.0,lastY=0.0;

extern (C) private void corexMouseCamera(GLFWwindow* w, int btn, int type, int modkeys) nothrow
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

extern (C) void corexCameraMove(GLFWwindow* w, double x, double y) nothrow
{
	try
	{
		if(inCamera)
		{
			if(!isNaN(lastX))
			{
				double dx,dy;
				enum double sens = 0.01;
				dx = (x-lastX)*sens;
				dy = (y-lastY)*sens;
				Vectorf right = vectorf(-1,0,0);
				right = (VisualDebugger_Old.inst.rot * right);
				VisualDebugger_Old.inst.rot = new Quaternion(right,dy)*VisualDebugger_Old.inst.rot;
				VisualDebugger_Old.inst.rot = new Quaternion(vectorf(0,-1,0),dx)*VisualDebugger_Old.inst.rot;
				VisualDebugger_Old.inst.rot.normalize;
			}
			lastX = x;
			lastY = y;
		}
	}
	catch (Throwable o)
	{
	}
}

Vectorf vel = Vectorf(0,0,0,1);

extern (C) void corexKey(GLFWwindow* w, int id, int scan, int state, int mods) nothrow
{
	try
	{
		double spd = 0.2;
		VisualDebugger_Old vd = VisualDebugger_Old.inst;
		Vectorf fwd = vectorf(0,0,-1),right = vectorf(1,0,0),up = vectorf(0,-1,0);
		if(mods & GLFW_MOD_SHIFT)
		{
			spd /= 3.0;
		}
		if(mods & GLFW_MOD_CONTROL)
		{
			spd /= 9.0;
		}
		if(mods & GLFW_MOD_ALT)
		{
			spd /= 6.0;
		}
		fwd *= spd;
		right *= spd;
		up *= spd;
		vel = vectorf(0,0,0,1);
		if(glfwGetKey(w,GLFW_KEY_W))
		{
			vel += fwd*spd;
		}
		if(glfwGetKey(w,GLFW_KEY_S))
		{
			vel -= fwd*spd;
		}
		if(glfwGetKey(w,GLFW_KEY_A))
		{
			vel -= right*spd;
		}
		if(glfwGetKey(w,GLFW_KEY_D))
		{
			vel += right*spd;
		}
		if(glfwGetKey(w,GLFW_KEY_Q))
		{
			vel += up*spd;
		}
		if(glfwGetKey(w,GLFW_KEY_E))
		{
			vel -= up*spd;
		}
		if((state==GLFW_PRESS)&&(id==GLFW_KEY_F1))
		{
			vd.SaveCurRayToFile();
		}
		if((state==GLFW_PRESS)&&(id==GLFW_KEY_F2))
		{
			StartTest();
		}
		if((state==GLFW_PRESS)&&(id==GLFW_KEY_F3))
		{
			VisualizeRedshift();
		}
		if((state==GLFW_PRESS)&&(id==GLFW_KEY_F4))
		{
			changeDefaultLambda();
		}
		if(id==GLFW_KEY_ESCAPE)
		{
			glfwSetWindowShouldClose(w, GL_TRUE);
		}
	}
	catch (Throwable o)
	{
	}
}

void StartTest()
{
	writef("Are you sure to start a calculation? (y/n): ");
	char ans;
	readf(" %c", &ans);
	if(ans=='y')
	{
		writef("Chose Calculation to Perform: \n");
		writef("1) Schwarzschild photon sphere stability\n");
		
		int inp;
		readf(" %d", &inp);
		
		if(inp == 1)
		{
			//BH_mass Timestep numOfCircles
			double mass=0.0, min_timestep=0.0, max_timestep=0.0, step_timestep=0.0;
			int numOfCircles;
			string path;
			do
			{
				writefln("Enter: mass min_timestep max_timestep step_timestep maxNumOfCircles:");
				scanf(" %lf %lf %lf %lf %d", &mass, &min_timestep, &max_timestep, &step_timestep, &numOfCircles);
			}while(((
						mass<=0. || min_timestep<=0. || 
						max_timestep<=0. || min_timestep>=max_timestep || 
						step_timestep<=0. || numOfCircles<0)?(writefln("Try Again"),1):0)); //RIP syntax
			//writef(" %f %f %f %f %d", mass, min_timestep, max_timestep, step_timestep, numOfCircles);
			writefln("Enter file path to save results at:");

			do
			{
				path = stdin.readln().strip();
			}while(path.length < 1);
			writeln(path);
			PhotonSphereStability(mass, min_timestep, max_timestep, step_timestep, numOfCircles, path);
		}
	}
}

void VisualizeRedshift()
{
	writef("Are you sure to visualize redshift? (y/n): ");
	char ans;
	readf(" %c", &ans);
	if(ans=='y')
	{
		double lambda;
		do
		{
			writefln("Enter desired source wavelenght in nanometers: ");
			scanf("%lf", &lambda);
		}while((lambda<=0?(writefln("Try Again"),1):0));
		VisualizeRedshift(cast(fpnum)lambda);
	}
}

void VisualizeRedshift(fpnum lambda)
{
	if(VisualDebugger_Old.inst.rays.length == 0) writefln("Trace rays first");
	
	VisualDebugger_Old.inst.start_col = GetSpectrumColor(lambda);
	
	auto s = cast(WorldSpaceWrapper) VisualDebugger_Old.inst.space;
	if(s is null)
	{
		foreach(ref SavedRay ray; VisualDebugger_Old.inst.rays)
		{
			ray.col = VisualDebugger_Old.inst.start_col;
		}
	}
	auto k = cast(AnalyticMetricContainer)(s.smetric);
	if(k is null) return;
	auto met = k.initiator;
	
	auto first = VisualDebugger_Old.inst.rays[0];
	met.prepareForRequest(first.origin);
	auto met_src = met.getMetricAtPoint()[0,0];
	
	foreach(ref SavedRay ray; VisualDebugger_Old.inst.rays)
	{
		met.prepareForRequest(ray.destination);
		auto met_rec = met.getMetricAtPoint()[0,0];
		ray.col = GetSpectrumColor(lambda*sqrt(met_rec/met_src));
	}
}

void changeDefaultLambda()
{
	fpnum* lambda = &VisualDebugger_Old.inst.cur_src_lambda;
	writeln("Current wavelenght of light source is: ", *lambda);
	writeln("Enter new wavelenght: ");
	scanf("%lf", lambda);
	if(!isFinite(*lambda) || (*lambda) <= 0) *lambda = fpnum.nan;
}

void PhotonSphereStability(fpnum mass, fpnum min_timestep, fpnum max_timestep, fpnum step_timestep, int numOfCircles, string fpath)
{
	WorldSpaceWrapper s = cast(WorldSpaceWrapper) VisualDebugger_Old.inst.space;
	if(s is null)
	{
		printf("Change Space to Schwarzschild!\n");
		return;
	}
	
	Analytic k = cast(Analytic) cast(AnalyticMetricContainer) s.smetric;
	if(k is null)
	{
		printf("Change Space to Schwarzschild\n");
		return;
	}
	
	Schwarzschild v = cast(Schwarzschild) k.initiator();
	if(v is null)
	{
		printf("Change Space to Schwarzschild\n");
		return;
	}
	
	//prepare simulation
	v.origin = Vectorf(0,0,0);
	v.cord = new Radial(Vectorf(0,0,0));
	v.schwarzschild_radius = 2*mass;
	v.mass = mass;
	
	VisualDebugger_Old.inst.rays = [];
	VisualDebugger_Old.inst.rayProcesorData_f = [9*mass*mass, 0.0, 0.0, 0.0];
	VisualDebugger_Old.DebugRayA = &VisualDebugger_Old.PhotonSphereStabilityRayProcesor;
	VisualDebugger_Old.DebugRayB = &VisualDebugger_Old.PhotonSphereStabilityRayProcesor;
	
	Line ray = Line(vectorf(0, 3*mass, 0), vectorf(1,0,1).normalized);
	
	File f = File(fpath,"a");
	f.writef("Mass \t DT \t Circles \t Dist \n"); // header
	f.flush();
	int i = 0;
	fpnum timestep = min_timestep;
	long numsteps = cast(long)((max_timestep-min_timestep)/step_timestep);
	long step = 0;
	for(; timestep<max_timestep;step++)
	{
		timestep = min_timestep + step*step_timestep;
		writef("\r%60c\rProgress: %d/%d",' ',step,numsteps);
		stdout.flush();
		VisualDebugger_Old.inst.rayProcesorData_i = [cast(size_t)0];
		
		//ray trace
		k.paramStep = timestep;
		k.maxNumberOfSteps = cast(int)(6*PI*mass*numOfCircles/timestep);
		
		try
		{
			VisualDebugger_Old.inst.space.GetRayFunc()(renderTid,ray,0,0,0);
		}
		catch(Throwable a)
		{
		}
		
		//write result
		f.writef("%#.16e \t %#.16e \t %d %#.16e \n", mass, timestep, numOfCircles, VisualDebugger_Old.inst.rayProcesorData_i[0]*timestep);
		f.flush();
	}
	writeln();
	VisualDebugger_Old.DebugRayA = &VisualDebugger_Old.SaveRay;
	VisualDebugger_Old.DebugRayB = &VisualDebugger_Old.SaveRay;
	writeln("Finished\n");
}

class VisualDebugger_Old
{
	static VisualDebugger_Old inst;
	__gshared GLFWwindow* rwin;
	__gshared GLFWwindow* dwin;
	GLuint texId;
	GLuint drawBg, drawSphere;
	WorldSpace space;
	ICamera camera;
	static bool glLoaded = false;
	float aspect;
	SavedRay[] rays;
	Color start_col = Colors.Red;
	fpnum cur_src_lambda = fpnum.nan;
	
	fpnum[] rayProcesorData_f;
	size_t[] rayProcesorData_i;
	
	Vectorf pos;
	Quaternion rot;

	static public void function(Line, fpnum, Color*) DebugRayA = &ign;
	static public void function(Line, Vectorf, Color*) DebugRayB = &ign;

	static public void ign(Line, fpnum, Color*)
	{ 
		return;
	}
	static public void ign(Line, Vectorf, Color*)
	{ 
		return;
	}

	static void FoundLight(Vectorf pos)
	{
		if(inst)
		{
			inst.rays[$-1].destination = pos;
			inst.rays[$-1].col = rayColors[6];
		}
	}

	static public void SaveRay(Line ray, Vectorf newp, Color* col = null)
	{
		if(inst)
		{
			Vectorf dif = newp - ray.origin;
			if(col == null) col = &rayColors[cast(int)inst.rays.length%6];
			inst.rays ~= SavedRay(ray.origin,newp,ray.direction,~dif,*col);
		}
	}
	
	static public void SaveRay(Line ray, fpnum dist, Color* col = null)
	{
		if(inst)
		{
			if(!isFinite(dist))
			{
				dist = 100.0;
			}
			if(col == null) col = &rayColors[cast(int)inst.rays.length%6];
			inst.rays ~= SavedRay(ray.origin,ray.origin+ray.direction*dist,ray.direction,dist,*col);
		}
	}
	
	static public void PhotonSphereStabilityRayProcesor(Line ray, Vectorf newp, Color* col = null)
	{
		Vectorf half = (ray.origin+newp)/2;
		fpnum a = half.x-inst.rayProcesorData_f[1];
		fpnum b = half.y-inst.rayProcesorData_f[2];
		fpnum c = half.z-inst.rayProcesorData_f[3];
		fpnum rad = a*a+b*b+c*c;
		fpnum eps = sqrt(rad/inst.rayProcesorData_f[0]);
		
		//the ray has escaped
		if(fabs(eps-1) > 0.01) throw new Exception("");
		
		inst.rayProcesorData_i[0]++;
		
		if(inst.rayProcesorData_i[0]%(cast(size_t)1e7)==0) writeln(inst.rayProcesorData_i[0]);
	}
	
	static public void PhotonSphereStabilityRayProcesor(Line ray, fpnum dist, Color* col = null)
	{
		if(isFinite(dist))
		PhotonSphereStabilityRayProcesor(ray, ray.origin+ray.direction*dist, col);
	}
	
	void SaveCurRayToFile(string path="aray.txt")
	{
		File fp = File(path,"w");
		fp.write("x y z dx dy dz len\n");
		auto app = appender!string();
		foreach(const ref SavedRay s; rays)
		{
			formattedWrite(app, "%#.16e\t%#.16e\t%#.16e\t%#.16e\t%#.16e\t%#.16e\t%#.16e\n",
				s.origin.x, s.origin.y, s.origin.z,
				s.direction.x, s.direction.y, s.direction.z,
				s.distance
				);
		}
		fp.write(app.data);
		fp.flush();
		fp.close();
	}
	
	this()
	{
		inst = this;
		if(cfgDebug)
			{
			DebugRayA = &SaveRay;
			DebugRayB = &SaveRay;
			VisualDebugger_Old.DebugRayA = &SaveRay;
			VisualDebugger_Old.DebugRayB = &SaveRay;
			DerelictGLFW3.load();
			glfwInit();
			rwin = makeWin("grtrace raytrace");
			dwin = makeWin("grtrace showrays",rwin);
			glfwSetMouseButtonCallback(rwin, &corexMouseButton);
			glfwSetMouseButtonCallback(dwin, &corexMouseCamera);
			glfwSetCursorPosCallback(rwin, &corexRayMove);
			glfwSetCursorPosCallback(dwin, &corexCameraMove);
			glfwSetKeyCallback(dwin, &corexKey);
		}
		else
		{
			DebugRayA = &ign;
			DebugRayB = &ign;
			VisualDebugger_Old.DebugRayA = &ign;
			VisualDebugger_Old.DebugRayB = &ign;
		}
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
		glPointSize(3.5f);
		glEnable(GL_LINE_SMOOTH);
	//	glEnable(GL_POINT_SMOOTH);
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
		pos = camera.origin;
		rot = new Quaternion();//Quaternion.lookAt(pos, vectorf(0,0,0));
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

	/*	drawBg = glGenLists(1);
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
		glEndList();*/
	}

	void makeFrustum(double fovY, double aspectRatio, double front, double back)
	{
		
		double tangent = tan(fovY/2 * DEG2RAD);   // tangent of half fovY
		double height = front * tangent;          // half height of near plane
		double width = height * aspectRatio;      // half width of near plane
		
		// params: left, right, bottom, top, near, far
		//glFrustum(-width, width, -height, height, front, back);
	}

	void Run()
	{
		space = cast(WorldSpace)(cfgSpace);
		camera = cast(ICamera)(cfgSpace.camera);
		if(!cfgDebug)return;
		glfwMakeContextCurrent(rwin);
		ResetCamera();
		Vectorf camo = camera.origin;
		LoadTex();
		double dt = glfwGetTime();
		glfwSetTime(0.0);
		while(!(glfwWindowShouldClose(rwin)||glfwWindowShouldClose(dwin)))
		{
			// rwin
			/*glfwMakeContextCurrent(rwin);
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
			//makeFrustum(60.0,aspect,1.0,2000.0);
			makeFrustum(60.0,aspect,0.00003,2000.0);

			Vectorf camAx;fpnum camAn;
			rot.toAxisAngle(camAx,camAn);
			camAn /= -DEG2RAD;
			glRotated(camAn,camAx.x,camAx.y,camAx.z);
			glTranslated(-pos.x,-pos.y,-pos.z);

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
						glVertex3d(tr.b.x+tr.plane.origin.x,tr.b.y+tr.plane.origin.y,tr.b.z+tr.plane.origin.z);
						glColor3f(0.0f,1.0f,1.0f);
						glVertex3d(tr.c.x+tr.plane.origin.x,tr.c.y+tr.plane.origin.y,tr.c.z+tr.plane.origin.z);
						glEnd();
						break;
					case DrawType.Plane:
						Plane pl = *(dd.plane);
						glBegin(GL_QUADS);
						glColor3f(1.0f,1.0f,0.0f);
						glVertex3d(pl.origin.x, pl.origin.y, pl.origin.z);
						glColor3f(1.0f,0.0f,1.0f);
						glVertex3d(pl.origin.x, pl.origin.y, pl.origin.z);
						glColor3f(0.0f,1.0f,1.0f);
						glVertex3d(pl.origin.x, pl.origin.y, pl.origin.z);
						glColor3f(0.0f,1.0f,0.0f);
						glVertex3d(pl.origin.x, pl.origin.y, pl.origin.z);
						glEnd();
						break;
					default:
						break;
				}
			}
			glLoadIdentity();
			//glDisable(GL_DEPTH_TEST);
			glBegin(GL_LINES);
			glColor3f(start_col.r, start_col.g, start_col.b);
			foreach(SavedRay ray;rays)
			{
				glVertex3d(ray.origin.x, ray.origin.y, ray.origin.z);
				glColor3f(ray.col.r,ray.col.g,ray.col.b);
				glVertex3d(ray.destination.x, ray.destination.y, ray.destination.z);
			}
			glEnd();
			glColor3f(0.1f,0.1f,1.0f);
			/*enum double BScale=1.0;
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
			}*/
			/*glColor3f(1.0f,0.0f,0.0f);
			glLoadIdentity();
			glBegin(GL_POINTS);
			glVertex3d(camera.origin.x,camera.origin.y,camera.origin.z);
			glEnd();

			glMatrixMode(GL_PROJECTION);
			glLoadIdentity();
			glMatrixMode(GL_MODELVIEW);
			glLoadIdentity();
			glTranslated(-0.75,-0.75,0);
			glScaled(0.1,0.1*aspect,0.1);
			glMatrixMode(GL_PROJECTION);
			glLoadIdentity();
			glRotated(camAn,camAx.x,camAx.y,camAx.z);
			Matrix4f tmat;
			glGetDoublev(GL_TRANSPOSE_PROJECTION_MATRIX, tmat.vals.ptr);
			glMatrixMode(GL_MODELVIEW);

			glfwSwapBuffers(dwin);
			glfwPollEvents();

			pos += ((tmat.inverse)*vel)*dt*1000.0;

			dt = glfwGetTime();
			glfwSetTime(0.0);
			if(dt>0)
			{
				string T = "grtrace showrays %.1f FPS".format(1/dt);
				//glfwSetWindowTitle(dwin,T.toStringz());
			}*/
		}
	}
}

