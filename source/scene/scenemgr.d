module scene.scenemgr;

import config;
import std.concurrency;
import std.stdio;
import math.vector;
import math.geometric;
import math.matrix;
import image.memory;
import image.imgio;
import image.color;
import scene.camera;
import scene.objects.interfaces;
import scene.objects.sphere;
import scene.camera;

abstract class WorldSpace
{
	public static shared
	{
		Image fullray;
		ICamera camera;
		Renderable[] objects;
		ushort sampleLineCount=1;
	}
	public static Sphere sph;
	//public void DoRay(Tid owner, Line ray, unum x, unum y);
	alias RayFunc = void function(Tid owner, Line ray, unum x, unum y);
	protected RayFunc GetRayFunc();

	public void AddObject(Renderable obj)
	{
		WorldSpace.objects ~= [cast(shared(Renderable))(obj)];
	}

	public void StartTracing(string outfile)
	{
		auto cam = cast(ICamera)(camera);
		unum pixelsx = cfgResolutionX*sampleLineCount;
		unum pixelsy = cfgResolutionY*sampleLineCount;
		fpnum jmpx = 2.0/pixelsx;
		fpnum jmpy = 2.0/pixelsy;
		auto DoRay = GetRayFunc();
		WorldSpace.fullray = cast(shared(Image))(new Image(pixelsx,pixelsy));
		Line cray;
		unum todo,done=0,prostep,dstep=0;
		enum unum prosteps = 1000;
		todo = pixelsx*pixelsy;
		prostep = todo/prosteps;
		writeln("Starting raytrace...");
		writefln("Camera position: %s\nCamera forward: %s\n Camera right: %s", cam.origin, cam.lookdir, cam.rightdir);
		sph = new Sphere(Vectorf(0,0,10.0),1.0);
		for(unum y=0;y<pixelsy;y++)
		{
			for(unum x=0;x<pixelsx;x++)
			{
				if(cam.fetchRay(x*jmpx - 1.0,y*jmpy - 1.0,cray))
				{
					DoRay(thisTid, cray, x, y);
				}
				dstep++;
				if(dstep==prostep)
				{
					dstep = 0;done++;
					writef("\r                                   \r Done %4d/%4d...",done,prosteps);
					stdout.flush();
				}
			}
		}
		writeln();writeln("Finished!");
		Image im = cast(Image)(fullray);
		im.WriteImage(outfile);
	}

}

class EuclideanSpace : WorldSpace
{
	override protected RayFunc GetRayFunc()
	{
		return &DoRay;
	}

	public static void DoRay(Tid owner, Line ray, unum x, unum y)
	{
		fpnum dist;
		Vectorf normal;
		if(WorldSpace.sph.getClosestIntersection(ray,dist,normal))
			WorldSpace.fullray.Poke(x,y,Colors.Green);
		else
			WorldSpace.fullray.Poke(x,y,Colors.Black);
	}
}

WorldSpace CreateSpace(string name, unum samples)
{
	WorldSpace.sampleLineCount = cast(ushort)samples;
	WorldSpace R;
	if(name=="euclidean")
	{
		R = new EuclideanSpace();
	}
	else
	{
		assert(0,"Space "~name~" doesn't exist");
	}
	return R;
}

void SetupCamera(string name, Vectorf origin, fpnum pitch, fpnum yaw, fpnum roll, string options="")
{
	ICamera cam;
	if(name=="orthogonal")
	{
		cam = new OrthogonalCamera();
	}
	else
	{
		assert(0,"Camera "~name~" doesn't exist");
	}
	cam.origin = origin;
	SetCameraAngles(cam, pitch, yaw, roll);
	cam.yxratio = cast(fpnum)(cfgResolutionY)/cast(fpnum)(cfgResolutionX);
	cam.options = options;
	WorldSpace.camera = cast(shared(ICamera))(cam);
}
