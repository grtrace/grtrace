module scene.scenemgr;

import grtrace;
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
	alias RayFunc = Color function(GRTrace* grt, Tid owner, Line ray, unum x, unum y, int tnum);
	public RayFunc GetRayFunc();

	public void AddObject(Renderable obj)
	{
		WorldSpace.objects ~= [cast(shared(Renderable))(obj)];
	}

	public void AddLight(Light obj)
	{
		WorldSpace.lights ~= [cast(shared(Light))(obj)];
	}

	public void StartTracing(GRTrace* grt, string outfile)
	{
		auto cam = cast(ICamera)(camera);
		//DebugDispatcher.space = this;
		ambientLight = cast(shared(Color))(Colors.White);
		pixelsx = grt.config.resolutionX;
		pixelsy = grt.config.resolutionY;
		Image im = new Image(pixelsx, pixelsy);
		WorldSpace.fullray = cast(shared(Image))(im);
		__gshared unum todo, done = 0, prostep, dstep = 0;
		done = 0;
		dstep = 0;
		enum unum prosteps = 100;
		todo = pixelsx * pixelsy / 100;
		prostep = todo / prosteps;
		writeln("Starting raytrace...");
		writefln("Camera position: %s\nCamera forward: %s\n Camera right: %s\n Camera up: %s",
				cam.origin, cam.lookdir, cam.rightdir, cam.updir);
		auto tdg = function(shared(GRTrace)* grt_shared, Tid owner, unum y0,
				unum y1, int tnum, RayFunc DoRay) {
			try
			{
				GRTrace* grt = cast(GRTrace*) grt_shared;
				Xorshift192 rnd = Xorshift192(1);
				rnd.seed(unpredictableSeed());
				Image im = cast(Image)(WorldSpace.fullray);
				auto cam = cast(ICamera)(camera);
				unum samples = grt.config.samples;
				fpnum jmpx = 2.0 / pixelsx;
				fpnum jmpy = 2.0 / pixelsy;
				fpnum smpx = jmpx / grt.config.samples;
				fpnum smpy = jmpy / grt.config.samples;
				fpnum smpd = cast(fpnum)(samples * samples);
				int cc = 0;
				Line cray;
				double jitx = 0.0, jity = 0.0;
				if (grt.config.fastApproximation)
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
									col = DoRay(grt, owner, cray, x, y, tnum);
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
											y * jmpy - 1.0 + sy * smpy + jity * smpy, cray))
									{
										col += DoRay(grt, owner, cray, x, y, tnum);
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
		if (!grt.config.noImage)
		{
			int threads = cast(int)(grt.config.threads);
			writeln("Rendering using ", threads, " CPU threads");
			int perthr = cast(int) pixelsy / threads;
			Tid[] tasks;
			tasks.length = threads;
			int lasty = 0;
			for (int i = 0; i < threads - 1; i++)
			{
				tasks[i] = spawnLinked(tdg, cast(shared) grt, thisTid,
						cast(unum) lasty, cast(unum)(lasty + perthr), i + 1, GetRayFunc());
				lasty += perthr;
			}
			tasks[$ - 1] = spawnLinked(tdg, cast(shared) grt, thisTid,
					cast(unum) lasty, cast(unum) pixelsy, threads, GetRayFunc());
			//tdg(thisTid, cast(unum)lasty, cast(unum)pixelsy, threads, GetRayFunc());
			int running = threads;
			done = 0;
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

	public DebugDraw[string] returnDebugRenderObjects() const
	{
		return null;
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
		steps[RayState.InComputation1] = ComputeStep(RayState.InComputation1,
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

	private static RayState computeRay1(GRTrace* grt, RayComputation* rc)
	{
		Vectorf rayhit;
		Vectorf normal;
		Renderable closest;
		bool hit = false;
		Raytrace!(true, true, true)(grt, rc.curRay, &hit, &rayhit, &normal, &closest);
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

	private static RayState computeRayLight(GRTrace* grt, RayComputation* rc)
	{
		RayData* rd = cast(RayData*)(Raytracer.computebuffer + rc.dataIdx);
		if (rd.slights < WorldSpace.lights.length)
		{
			Light L = cast(Light) WorldSpace.lights[rd.slights];
			Line hitRay = LinePoints(rc.curRay.origin, L.getPosition());
			hitRay.ray = true;
			bool unlit = false;
			fpnum dst = Raytrace!(false, false, false)(grt, hitRay, &unlit);
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

	protected static fpnum Raytrace(bool doP, bool doN, bool doO)(GRTrace* grt, Line ray, bool* didHit,
			Vectorf* hitpoint = null, Vectorf* hitnormal = null, Renderable* hit = null)
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

	protected static Color Rayer(GRTrace* grt, Line ray, int recnum, Color lastcol)
	{
		if (recnum > grt.config.maxDepth)
		{
			return lastcol;
		}
		Color tmpc = lastcol;
		Vectorf rayhit;
		Vectorf normal;
		Renderable closest;
		bool hit = false;
		Raytrace!(true, true, true)(grt, ray, &hit, &rayhit, &normal, &closest);
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
						fpnum dst = Raytrace!(false, false, false)(grt, hitRay, &unlit);
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

	public static Color DoRay(GRTrace* grt, Tid owner, Line ray, unum x, unum y, int tnum)
	{
		Color outc = Rayer(grt, ray, 0, Colors.Black);
		float mx = max(outc.r, outc.g, outc.b);
		if (mx > 1.0f)
		{
			outc = outc / mx;
		}
		return outc;
	}
}
