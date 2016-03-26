/// Scene creation&loading functions
module scene.creator;

import config;
import scene.scenemgr;
import std.typecons;
import std.variant;
import math.vector;
import image.color;
import scene.objects.interfaces;
import scene.materials;

class SceneException : Exception
{
	@nogc @safe pure nothrow this(string msg, string file = __FILE__,
		size_t line = __LINE__, Throwable next = null)
	{
		super(msg, file, line, next);
	}

	@nogc @safe pure nothrow this(string msg, Throwable next,
		string file = __FILE__, size_t line = __LINE__)
	{
		super(msg, file, line, next);
	}
}

struct SceneDescription
{
	enum scriptHeader = "GRTRACE SCENE DESCRIPTION VERSION 1";
	alias ObjectConstructor = Renderable function(SValue[string]);
	__gshared static ObjectConstructor[string] objTypes;

	Renderable makeObject(string type, SValue[string] args)
	{
		ObjectConstructor* oc = type in objTypes;
		if (oc is null)
		{
			throw new SceneException("Invalid object type: " ~ type);
		}
		ObjectConstructor occ = *oc;
		return occ(args);
	}

	/**
	Populate the space with objects loaded from a script.
	Format: [types: FLOAT, VEC2, VEC3, COLOR, WAVE, implicit strings]
	---
	GRTRACE SCENE DESCRIPTION VERSION 1
	# comment
	DEFINE r1 FLOAT 2.5 ;
	DEFINE r2 FLOAT 5 ;
	# VEC3 X Y Z
	DEFINE v1 VEC3 1 2 3 ;
	DEFINE v2 VEC3 2 3 4 ;
	DEFINE v3 VEC3 3 4 5 ;
	#
	DEFINE cblack COLOR 000000 ;
	DEFINE cmagenta COLOR FF00FF ;
	DEFINE wgreen WAVE 500.0 ;
	# TEXTURE loads&defines a texture
	TEXTURE check textures/checkerBoard.png ;
	MATERIAL m1 DIFFUSE cmagenta ;
	MATERIAL m2 EMIT wgreen ;
	MATERIAL m3 EMIT COLOR EEAA11 ;
	MATERIAL m4 DIFFUSE check FILTER NEAREST ;
	# FILTER NEAREST/LINEAR
	# Objects start with "="
	=SPHERE MATERIAL m2 CENTER v1 RADIUS r1 ;
	=SPHERE MATERIAL m4 CENTER VEC3 2 2 2 RADIUS FLOAT 1 ;
	=TEX.PLANE MATERIAL m4 ORIGIN v1 PITCH 0 ROLL 0 
	UDIR VEC3 1 0 0 VDIR VEC3 0 1 0 UVMIN VEC2 0 0 UVMAX VEC2 1 1 ;
	# Lights defined with "!"
	!POINT CENTER v3 EMIT cmagenta
	---
	**/
	void loadFromScript(string script)
	{
		if (script.length <= scriptHeader.length)
		{
			throw new SceneException("Script too short");
		}
		if (script[0 .. scriptHeader.length] != scriptHeader)
		{
			throw new SceneException("Script has invalid header");
		}
	}
}

WorldSpace CreateSpace(string name)
{
	WorldSpace R;
	if (name == "euclidean")
	{
		R = new EuclideanSpace();
	}
	else if (name == "deflect")
	{
		R = new PlaneDeflectSpace();
	}
	else if (name == "test" || name == "analytic")
	{
		auto A = new Analytic;
		fpnum mass = 1.5;
		fpnum x = 0.0, y = 0.0, z = 0.0;
		fpnum L = 0.0;
		fpnum pStep = 0.08;
		int nSteps = 250;
		string[] args = split(cfgMetricOptions);

		getopt(args, "mass|m", &mass, "x", &x, "y", &y, "z", &z,
			"angularmomentum|L", &L, "paramstep|d", &pStep, "nsteps|n", &nSteps);

		//not safe workarround
		string initType;
		if (args[0] == "-t")
			initType = args[1];

		switch (initType)
		{
		case "schwarzschild":
			A.initiator = new Schwarzschild(mass, vectorf(x, y, z));
			break;
		case "flatcartesian":
			A.initiator = new FlatCartesian();
			break;
		case "flatradial":
			A.initiator = new FlatRadial();
			break;
		case "kerr":
			A.initiator = new Kerr(mass, L, vectorf(x, y, z));
			break;
		default:
			stderr.writeln("Error: wrong type of analytic metric: " ~ initType);
			assert(0);
		}
		A.paramStep = pStep;
		A.maxNumberOfSteps = nSteps;
		R = new WorldSpaceWrapper(A);
	}
	else
	{
		assert(0, "Space " ~ name ~ " doesn't exist");
	}
	return R;
}

void SetupCamera(string name, Vectorf origin, fpnum pitch, fpnum yaw, fpnum roll, string options = "")
{
	ICamera cam;
	if (name == "orthogonal")
	{
		cam = new OrthogonalCamera();
	}
	else if (name == "linear")
	{
		cam = new LinearPerspectiveCamera();
	}
	else
	{
		assert(0, "Camera " ~ name ~ " doesn't exist");
	}
	cam.origin = origin;
	SetCameraAngles(cam, pitch, yaw, roll);
	cam.yxratio = cast(fpnum)(cfgResolutionY) / cast(fpnum)(cfgResolutionX);
	cam.options = options;
	WorldSpace.camera = cast(shared(ICamera))(cam);
	cfgCamera = cast(shared(ICamera)) cam;
}
