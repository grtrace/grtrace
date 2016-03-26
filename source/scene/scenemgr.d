module scene.scenemgr;

import config;
import core.time;
import std.concurrency;
import std.getopt;
import std.array;
import std.string;
import std.stdio;
import std.math;
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
import scene.materials.material;
import scene.camera;
import scene.compute;
import core.cpuid;
import std.algorithm;
import std.random;
import dbg.debugger;
import dbg.dispatcher;
import scene.raymgr;
import metric;

import scene.noneuclidean;

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
		Light[] lights;
		unum pixelsx, pixelsy;
		Color ambientLight;
	}

	public int allocNewRayData()
	{
		return 0;
	}

	public void freeRayData()
	{
	}

	public size_t getRayDataSize()
	{
		return 0;
	}

	public int getStageCount()
	{
		return 1;
	}

	public ComputeStep[RayState.Finished] getComputeStages()
	{
		static ComputeStep[RayState.Finished] steps;
		return steps;
	}

	public static final ICamera getCamera() nothrow @nogc
	{
		return cast(ICamera) camera;
	}

	//public void DoRay(Tid owner, Line ray, unum x, unum y, int tnum);
	alias RayFunc = Color function(Tid owner, Line ray, unum x, unum y, int tnum);
	public RayFunc GetRayFunc();

	public void AddObject(Renderable obj)
	{
		WorldSpace.objects ~= [cast(shared(Renderable))(obj)];
	}

	public void AddLight(Light obj)
	{
		WorldSpace.lights ~= [cast(shared(Light))(obj)];
	}

	public void StartTracing(string outfile)
	{
		auto cam = cast(ICamera)(camera);
		//DebugDispatcher.space = this;
		ambientLight = cast(shared(Color))(Colors.White);
		pixelsx = cfgResolutionX;
		pixelsy = cfgResolutionY;
		Image im = new Image(pixelsx, pixelsy);
		WorldSpace.fullray = cast(shared(Image))(im);
		__gshared unum todo, done = 0, prostep, dstep = 0;
		enum unum prosteps = 100;
		todo = pixelsx * pixelsy / 100;
		prostep = todo / prosteps;
		writeln("Starting raytrace...");
		writefln(
			"Camera position: %s\nCamera forward: %s\n Camera right: %s\n Camera up: %s",
			cam.origin, cam.lookdir, cam.rightdir, cam.updir);
		auto tdg = function(Tid owner, unum y0, unum y1, int tnum, RayFunc DoRay) {
			try
			{
				Xorshift192 rnd = Xorshift192(1);
				rnd.seed(unpredictableSeed());
				Image im = cast(Image)(WorldSpace.fullray);
				auto cam = cast(ICamera)(camera);
				unum samples = cfgSamples;
				fpnum jmpx = 2.0 / pixelsx;
				fpnum jmpy = 2.0 / pixelsy;
				fpnum smpx = jmpx / cfgSamples;
				fpnum smpy = jmpy / cfgSamples;
				fpnum smpd = cast(fpnum)(samples * samples);
				int cc = 0;
				Line cray;
				double jitx = 0.0, jity = 0.0;
				if (cfgFastApproximation)
				{
					for (unum y = y0; y < y1; y++)
					{
						for (unum x = 0; x < pixelsx; x++)
						{
							if (((x % 5) == 0) && ((y % 5) == 0))
							{
								Color col = Colors.Black;
								if (cam.fetchRay(x * jmpx - 1.0, y * jmpy - 1.0, cray))
								{
									col = DoRay(owner, cray, x, y, tnum);
								}
								im.Poke(x, y, col);
							}
							else
							{
								if ((x % 5) == 0)
								{
									im.Poke(x, y, im.Peek(x, y - 1));
								}
								else
								{
									im.Poke(x, y, im.Peek(x - 1, y));
								}
							}
							cc++;
							if (cc == 100)
							{
								send(owner, Message.Pixel100);
								cc = 0;
							}
						}
					}
				}
				else
				{
					for (unum y = y0; y < y1; y++)
					{
						for (unum x = 0; x < pixelsx; x++)
						{
							Color col = Colors.Black;
							for (unum sy = 0; sy < samples; sy++)
							{
								for (unum sx = 0; sx < samples; sx++)
								{
									if (samples > 1)
									{
										jitx = uniform01!double(rnd) * 2.0 - 1.0;
										jity = uniform01!double(rnd) * 2.0 - 1.0;
									}
									if (cam.fetchRay(x * jmpx - 1.0 + sx * smpx + jitx * smpx,
											y * jmpy - 1.0 + sy * smpy + jity * smpy,
											cray))
									{
										col += DoRay(owner, cray, x, y, tnum);
									}
								}
							}
							col /= smpd;
							im.Poke(x, y, col);
							cc++;
							if (cc == 100)
							{
								send(owner, Message.Pixel100);
								cc = 0;
							}
						}
					}
				}
				send(owner, Message.Finish);
			}
			catch (shared(Exception) e)
			{
				owner.send(e);
			}
		};
		if (!cfgNoImage)
		{
			int threads = cast(int)(cfgThreads);
			writeln("Rendering using ", threads, " CPU threads");
			int perthr = cast(int) pixelsy / threads;
			Tid[] tasks;
			tasks.length = threads;
			int lasty = 0;
			for (int i = 0; i < threads - 1; i++)
			{
				tasks[i] = spawnLinked(tdg, thisTid, cast(unum) lasty,
					cast(unum)(lasty + perthr), i + 1, GetRayFunc());
				lasty += perthr;
			}
			tasks[$ - 1] = spawnLinked(tdg, thisTid, cast(unum) lasty,
				cast(unum) pixelsy, threads, GetRayFunc());
			//tdg(thisTid, cast(unum)lasty, cast(unum)pixelsy, threads, GetRayFunc());
			int running = threads;
			while (running > 0)
			{
				try
				{
					receiveTimeout(dur!"msecs"(10), (Message m) {
						if (m == Message.Pixel100)
						{
							dstep++;
							if (dstep == prostep)
							{
								dstep = 0;
								done++;
								writef("\r                                   \r Done %4d/%4d...",
									done, prosteps);
								stdout.flush();
							}
						}
					}, (shared(Exception) e) {
						writefln("\nThread dead with exception: %s", e.msg);
					});
				}
				catch (LinkTerminated e)
				{
					running--;
				}
				catch (Exception e)
				{
					writeln(e.msg);
					return;
				}
			}
			writeln();
			writeln("Finished!");
			im.WriteImage(outfile);
			DebugDispatcher.renderResult = im;
		}
	}

}

class EuclideanSpace : WorldSpace
{
	static struct RayData
	{
		fpnum u, v;
		Vectorf normal;
		int nlights;
		int slights;
		Material material;
		Material.LightHit[32] lights;
	}

	static shared(uint) rdata = 0;
	ComputeStep[RayState.Finished] steps;

	this()
	{
		steps[RayState.Initialised] = ComputeStep(RayState.Initialised,
			RayState.InComputation1, &computeRay1, false, "");
		steps[RayState.InComputation1] = ComputeStep(RayState.Initialised,
			RayState.Finished, &computeRayLight, false, "");
	}

	override public size_t getRayDataSize()
	{
		return RayData.sizeof;
	}

	override public int allocNewRayData()
	{
		import core.atomic : atomicOp;

		uint idx = atomicOp!"+="(rdata, RayData.sizeof);
		idx -= RayData.sizeof;
		return idx;
	}

	override public void freeRayData()
	{
		rdata = 0;
	}

	override public int getStageCount()
	{
		return 1;
	}

	override public ComputeStep[RayState.Finished] getComputeStages()
	{
		return steps;
	}

	private static RayState computeRay1(RayComputation* rc)
	{
		Vectorf rayhit;
		Vectorf normal;
		Renderable closest;
		bool hit = false;
		Raytrace!(true, true, true)(rc.curRay, &hit, &rayhit, &normal, &closest);
		if (!hit)
		{
			rc.color = Colors.Black;
			return RayState.Finished;
		}
		if (!closest.material)
		{
			rc.color = Colors.Magenta;
			return RayState.Finished;
		}
		rc.curRay.origin = rayhit + normal * 0.01;
		fpnum u, v;
		closest.getUVMapping(rayhit, u, v);
		RayData* rd = cast(RayData*)(Raytracer.computebuffer + rc.dataIdx);
		rd.u = u;
		rd.v = v;
		rd.normal = normal;
		rd.material = closest.material;
		return RayState.InComputation1;
	}

	private static RayState computeRayLight(RayComputation* rc)
	{
		RayData* rd = cast(RayData*)(Raytracer.computebuffer + rc.dataIdx);
		if (rd.slights < WorldSpace.lights.length)
		{
			Light L = cast(Light) WorldSpace.lights[rd.slights];
			Line hitRay = LinePoints(rc.curRay.origin, L.getPosition());
			hitRay.ray = true;
			bool unlit = false;
			fpnum dst = Raytrace!(false, false, false)(hitRay, &unlit);
			if (unlit)
			{
				fpnum dLO = *(L.getPosition() - rc.curRay.origin);
				if (dLO < (dst ^^ 2))
				{
					unlit = false;
				}
			}
			if (!unlit)
			{
				rd.lights[rd.nlights] = Material.LightHit(L.getPosition(),
					hitRay.direction, L.getColor());
				rd.nlights++;
			}
			rd.slights++;
		}
		else
		{
			rc.color = rd.material.calculateColor(rd.u, rd.v, rd.normal,
				rd.lights[0 .. rd.nlights]);
			return RayState.Finished;
		}
		return RayState.InComputation1;
	}

	override protected RayFunc GetRayFunc()
	{
		return &DoRay;
	}

	private static Color NormalToColor(Vectorf N)
	{
		return Color((N.x + 1.0f) / 2.0f, (N.y + 1.0f) / 2.0f, (N.z + 1.0f) / 2.0f);
	}

	protected static fpnum Raytrace(bool doP, bool doN, bool doO)(Line ray,
		bool* didHit, Vectorf* hitpoint = null, Vectorf* hitnormal = null, Renderable* hit = null)
	{
		static if (doP)
		{
			static assert(doN);
		}
		fpnum dist, mdist;
		mdist = +fpnum.infinity;
		Vectorf normal, mnormal;
		Renderable H = null;
		bool dh = false;
		foreach (shared Renderable o; WorldSpace.objects)
		{
			Renderable O = cast(Renderable)(o);
			import std.math;

			if (O.getClosestIntersection(ray, dist, normal))
			{
				if (mdist > dist)
				{
					dh = true;
					mdist = dist;
					static if (doN)
					{
						mnormal = normal;
					}
					static if (doO)
					{
						H = O;
					}
				}
			}
		}
		DebugDispatcher.saveRay(ray, mdist, RayDebugType.Default);
		if (dh)
		{
			*didHit = true;
		}
		static if (doO)
		{
			*hit = H;
		}
		static if (doN)
		{
			*hitnormal = mnormal;
		}
		static if (doP)
		{
			Vectorf P = ray.origin + ray.direction * mdist;
			*hitpoint = P;
		}
		return mdist;
	}

	protected static Color Rayer(Line ray, int recnum, Color lastcol)
	{
		if (recnum > cfgMaxDepth)
		{
			return lastcol;
		}
		Color tmpc = lastcol;
		Vectorf rayhit;
		Vectorf normal;
		Renderable closest;
		bool hit = false;
		Raytrace!(true, true, true)(ray, &hit, &rayhit, &normal, &closest);
		if (hit)
		{
			if (closest.material)
			{
				tmpc = closest.material.emission_color;

				Color textureColor = Colors.White;

				if (closest.material.hasTexture())
				{
					fpnum U, V;
					closest.getUVMapping(rayhit, U, V);
					textureColor = closest.material.peekUV(U, V);
				}

				if (closest.material.is_diffuse)
				{
					Color diffuseColor = closest.material.diffuse_color;

					foreach (shared Light l; lights)
					{
						Line hitRay = LinePoints(rayhit, l.getPosition());
						hitRay.ray = true;
						bool unlit = false;
						fpnum dst = Raytrace!(false, false, false)(hitRay, &unlit);
						if (unlit)
						{
							fpnum dLO = *(l.getPosition() - rayhit);
							if (dLO < (dst * dst))
							{
								unlit = false;
							}
						}
						if (unlit == false) // lit
						{
							//VisualDebugger.FoundLight(l.getPosition());
							fpnum DP = normal * (hitRay.direction);
							if (DP > 0)
								tmpc = tmpc + diffuseColor * l.getColor() * (DP);
						}
					}
				}
				tmpc *= textureColor;
			}
			else
			{
				tmpc = Colors.Magenta;
			}
		}
		return tmpc;
	}

	public static Color DoRay(Tid owner, Line ray, unum x, unum y, int tnum)
	{
		Color outc = Rayer(ray, 0, Colors.Black);
		float mx = max(outc.r, outc.g, outc.b);
		if (mx > 1.0f)
		{
			outc = outc / mx;
		}
		return outc;
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
		
		getopt(args, "mass|m", &mass, "x", &x, "y",
			&y, "z", &z, "angularmomentum|L", &L, "paramstep|d", &pStep, "nsteps|n",
			&nSteps);
		
		//not safe workarround
		string initType;
		if(args[0] == "-t") initType=args[1];	
		
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
