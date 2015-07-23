module scene.scenemgr;

import config;
import core.time;
import std.concurrency;
import std.stdio;
import std.functional;
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
import core.cpuid;

abstract class WorldSpace
{
	enum Message
	{
		Pixel100,
		Finish
	}
	public static shared
	{
		Image fullray;
		ICamera camera;
		Renderable[] objects;
		unum pixelsx,pixelsy;
		Color ambientLight;
	}
	
	//public void DoRay(Tid owner, Line ray, unum x, unum y, int tnum);
	alias RayFunc = void function(Tid owner, Line ray, unum x, unum y, int tnum);
	protected RayFunc GetRayFunc();

	public void AddObject(Renderable obj)
	{
		WorldSpace.objects ~= [cast(shared(Renderable))(obj)];
	}

	public void StartTracing(string outfile)
	{
		auto cam = cast(ICamera)(camera);
		ambientLight = cast(shared(Color))(Colors.White);
		pixelsx = cfgResolutionX*cfgSamples;
		pixelsy = cfgResolutionY*cfgSamples;
		Image im = new Image(pixelsx,pixelsy);
		WorldSpace.fullray = cast(shared(Image))(im);
		__gshared unum todo,done=0,prostep,dstep=0;
		enum unum prosteps = 100;
		todo = pixelsx*pixelsy/100;
		prostep = todo/prosteps;
		writefln("Starting raytrace [Realres: %dx%dx3=%d]...",pixelsx,pixelsy,fullray.data.length);
		writefln("Camera position: %s\nCamera forward: %s\n Camera right: %s", cam.origin, cam.lookdir, cam.rightdir);
		auto tdg = function(Tid owner, unum y0, unum y1, int tnum, RayFunc DoRay)
		{
			auto cam = cast(ICamera)(camera);
			fpnum jmpx = 2.0/pixelsx;
			fpnum jmpy = 2.0/pixelsy;
			int cc=0;
			Line cray;
			for(unum y=y0;y<y1;y++)
			{
				for(unum x=0;x<pixelsx;x++)
				{
					if(cam.fetchRay(x*jmpx - 1.0,y*jmpy - 1.0,cray))
					{
						DoRay(owner, cray, x, y, tnum);
					}
					cc++;
					if(cc==100)
					{
						send(owner,Message.Pixel100);
						cc=0;
					}
				}
			}
			send(owner,Message.Finish);
		};
		int threads = cast(int)(cfgThreads);
		writeln("Rendering using ",threads," CPU threads");
		int perthr = cast(int)pixelsy/threads;
		Tid[] tasks;
		tasks.length = threads;
		int lasty = 0;
		for(int i=0;i<threads-1;i++)
		{
			tasks[i] = spawn(tdg, thisTid, cast(unum)lasty, cast(unum)(lasty+perthr), i+1, GetRayFunc());
			lasty+=perthr;
		}
		tasks[$-1] = spawn(tdg, thisTid, cast(unum)lasty, cast(unum)pixelsy, threads, GetRayFunc());
		int running = threads;
		while(running>0)
		{
			try
			{
				receiveTimeout(dur!"msecs"(10), (Message m){
						if(m==Message.Pixel100)
						{
							dstep++;
							if(dstep==prostep)
							{
								dstep = 0;done++;
								writef("\r                                   \r Done %4d/%4d...",done,prosteps);
								stdout.flush();
							}
						}
						else if(m==Message.Finish)
						{
							running--;
						}
					});
			}
			finally{}
		}
		writeln();writeln("Finished!");
		if(cfgSamples==1)
		{
			im.WriteImage(outfile);
		}
		else
		{
			int sm = cast(int)cfgSamples;
			int smq = sm*sm;
			int stride = cast(int)cfgResolutionX*3;
			int bstride = stride * sm;
			Image im2 = new Image(cfgResolutionX, cfgResolutionY);
			foreach(int y; 0..cast(int)(cfgResolutionY))
			{
				foreach(int x; 0..cast(int)(cfgResolutionX))
				{
					int R=0,G=0,B=0;
					foreach(int sy; 0..cast(int)(sm))
					{
						foreach(int sx; 0..cast(int)(sm))
						{
							int pos = (sm*y+sy)*bstride + x*sm*3 + sx*3;
							R += im.data[pos];
							G += im.data[pos+1];
							B += im.data[pos+2];
						}
					}
					int opos = y*stride + x*3;
					im2.data[opos] = cast(ubyte)(R/smq);
					im2.data[opos+1] = cast(ubyte)(G/smq);
					im2.data[opos+2] = cast(ubyte)(B/smq);
				}
			}
			im2.WriteImage(outfile);
		}
	}

}

class EuclideanSpace : WorldSpace
{
	override protected RayFunc GetRayFunc()
	{
		return &DoRay;
	}

	private static Color NormalToColor(Vectorf N)
	{
		return Color( (N.x+1.0f)/2.0f, (N.y+1.0f)/2.0f, (N.z+1.0f)/2.0f );
	}

	public static void DoRay(Tid owner, Line ray, unum x, unum y, int tnum)
	{
		fpnum dist;
		Vectorf normal;
		fpnum mindist=1e99;
		Color outc = Colors.Black;
		foreach(shared(Renderable) o; WorldSpace.objects)
		{
			Renderable O = cast(Renderable)(o);
			if(O.getClosestIntersection(ray,dist,normal))
			{
				if(dist<mindist)
				{
					outc = NormalToColor(normal);
					mindist = dist;
				}
			}
		}
		WorldSpace.fullray.Poke(x,y,outc);
	}
}

WorldSpace CreateSpace(string name)
{
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
	else if(name=="linear")
	{
		cam = new LinearPerspectiveCamera();
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
