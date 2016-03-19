/// Ray compute dispatch management code
module scene.raymgr;

import config;
import std.container.array;
import std.math, std.string, std.algorithm, std.array, std.range;
import core.thread, core.atomic, core.time, core.bitop;
import math.geometric;
import image.color;
import scene.scenemgr;
import scene.compute;
import dbg.dispatcher;
import std.stdio;
import core.stdc.stdlib;

private void getSample(uint number, out double sx, out double sy)
{
	import std.random : Xorshift192, uniform01, unpredictableSeed;

	static Xorshift192 rnd = Xorshift192();
	static bool seeded = false;
	if (!seeded)
	{
		rnd.seed(unpredictableSeed());
		seeded = true;
	}
	if (number == 0)
	{
		sx = 0.0;
		sy = 0.0;
		return;
	}
	sx = uniform01!double(rnd) * 2.0 - 1.0;
	sy = uniform01!double(rnd) * 2.0 - 1.0;
}

///-
class Raytracer
{
	__gshared
	{
		WorldSpace space;
		RayComputation[raysPerPass] raybuffer;
		size_t rayCount = 0;
		ubyte* computebuffer = null;
		size_t cbuf_l = 0;
	}

	static void ensureBuffer(uint count)
	{
		space.freeRayData();
		if ((cbuf_l < count) || (computebuffer == null))
		{
			free(computebuffer);
			cbuf_l = count;
			computebuffer = cast(ubyte*) malloc(space.getRayDataSize() * (count + 2));
		}
	}

	static void setSpace(WorldSpace sp)
	{
		space = sp;
	}

	static void prepareSingleTrace(uint x, uint y, uint number = 0, double sx = 0.0,
		double sy = 0.0)
	{
		cleanup();
		ensureBuffer(10);
		Line cray;
		if (space.getCamera().fetchRay(x + sx, y + sy, cray))
		{
			raybuffer[0] = RayComputation(cray, RayState.Initialised,
				RayFlags.None, x, y, number, Color(1.0, 1.0, 1.0), 0, space.allocNewRayData());
			rayCount = 1;
		}
		else
		{
			rayCount = 0;
		}
	}

	static void preparePartialTrace(ulong i0, ulong i1)
	{
		ensureBuffer(cast(uint)(i1 - i0 + 1));
		Line cray;
		fpnum jmpx = 2.0 / cfgResolutionX;
		fpnum jmpy = 2.0 / cfgResolutionY;
		rayCount = 0;
		foreach (ulong idx; i0 .. i1)
		{
			uint cx, cy, smp;
			smp = cast(uint)(idx % cfgSamples);
			cx = cast(uint)((idx / cfgSamples) % cfgResolutionY);
			cy = cast(uint)((idx / (cfgSamples * cfgResolutionY)));
			double px, py;
			getSample(smp, px, py);
			double X = cx * jmpx - 1.0 + px;
			double Y = cy * jmpy - 1.0 + py;
			if (space.getCamera().fetchRay(X, Y, cray))
			{
				raybuffer[rayCount++] = RayComputation(cray,
					RayState.Initialised, RayFlags.None, cx, cy, smp,
					Color(1.0, 1.0, 1.0), 0, space.allocNewRayData());
			}
		}
	}

	private __gshared ubyte threadReady;
	private __gshared uint threadCount;
	private __gshared size_t[] threadDoneRays;
	private __gshared Thread[] threads;
	private __gshared int threadMsg = 0;

	private static void threadComputer(bool isMultithreaded)(uint tid)
	{
		threadReady = 1;
		int idx = 0;
		while (true)
		{
			static if (isMultithreaded)
			{
				while (threadMsg != idx)
				{
					if (threadMsg == -1)
					{
						return;
					}
					Thread.sleep(dur!"msecs"(10));
				}
			}
			bool done = false;
			size_t totalRays = rayCount;
			size_t doneRays = 0;
			while (!done)
			{
				done = true;
				doneRays = 0;
				for (int i = tid; i < totalRays; i += threadCount)
				{
					RayComputation* rc = &raybuffer[i];
					if (rc.state < RayState.Finished)
					{
						//stderr.write(tid);
						rc.state = space.getComputeStages()[rc.state].cpuFun(rc);
						done = false;
					}
					else
					{
						doneRays++;
					}
				}
				threadDoneRays[tid] = doneRays;
			}
			idx++;
			static if (!isMultithreaded)
			{
				return;
			}
		}
	}

	private enum uint raysPerPass = 4096;
	private __gshared float[] msimage;

	/// Computes the whole image in multiple passes in multiple threads
	static void computeMultiThread()
	{
		msimage.length = cfgResolutionX * cfgResolutionY * 3;
		msimage[] = 0.0f;
		threadCount = cast(int)(cfgThreads);
		writeln("Rendering using ", threadCount, " threads");
		bool done = false;
		size_t totalRays = cast(size_t)(cfgResolutionX * cfgResolutionY * cfgSamples);
		size_t doneRays = 0, lastRays = 0;
		size_t totalDoneRays = 0;
		size_t pass0 = 0, passN = min(raysPerPass, totalRays);

		threads = [];
		threads.length = threadCount;
		if (threadCount > 1)
		{
			threadMsg = -2; // Wait for all threads to spawn

			for (int i = 0; i < threadCount; i++)
			{
				threadReady = 0;
				threads[i] = new Thread(() { threadComputer!true(i); });
				threads[i].start();
				while (!volatileLoad(&threadReady))
				{
				}
			}
		}
		threadDoneRays.length = threadCount;

		int passno = -1;
		while ((totalDoneRays < totalRays) && (passN > 0))
		{
			passno++;
			preparePartialTrace(pass0, pass0 + passN);
			threadDoneRays[] = 0;
			doneRays = 0;
			lastRays = 0;
			if (threadCount > 1)
			{
				threadMsg = passno;
				while (doneRays < passN)
				{
					doneRays = 0;
					for (int j = 0; j < threadCount; j++)
					{
						doneRays += threadDoneRays[j];
					}
					if(doneRays>lastRays+512)
					{
						lastRays = doneRays;
						DebugDispatcher.progress(totalDoneRays + doneRays, totalRays);
					}
				}
			}
			else
			{
				threadComputer!false(0);
				doneRays = threadDoneRays[0];
				DebugDispatcher.progress(totalDoneRays + doneRays, totalRays);
			}
			totalDoneRays += doneRays;
			size_t xstride = 3;
			size_t ystride = cfgResolutionX * xstride;
			for (int i = 0; i < rayCount; i++)
			{
				RayComputation* rc = &raybuffer[i];
				if (rc.state == RayState.Finished)
				{
					msimage[rc.imgX * xstride + rc.imgY * ystride] += rc.color.r;
					msimage[rc.imgX * xstride + rc.imgY * ystride + 1] += rc.color.g;
					msimage[rc.imgX * xstride + rc.imgY * ystride + 2] += rc.color.b;
				}
			}
			pass0 += raysPerPass;
			if ((pass0 + passN) > totalRays)
			{
				passN = totalRays - pass0;
			}
		}
		threadMsg = -1;
		if (threadCount > 1)
		{
			for (int j = 0; j < threadCount; j++)
			{
				threads[j].join();
			}
		}
		stderr.writeln();
	}

	static void saveImage()
	{
		import image.memory : Image;
		import image.imgio : WriteImage;

		size_t xstride = 3;
		size_t ystride = cfgResolutionX * xstride;
		if (cfgSamples > 1)
			msimage[] /= cast(float) cfgSamples;
		Image im = new Image(cfgResolutionX, cfgResolutionY);
		foreach (y; 0 .. cfgResolutionY)
		{
			foreach (x; 0 .. cfgResolutionX)
			{
				size_t i = x * xstride + y * ystride;
				im.Poke(x, y, Color(msimage[i], msimage[i + 1], msimage[i + 2]));
			}
		}
		WriteImage(im, cfgOutputFile);
		DebugDispatcher.renderResult = im;
	}

	static void cleanup()
	{
		import core.memory : GC;

		rayCount = 0;
		free(computebuffer);
		computebuffer = null;
		cbuf_l = 0;
		space.freeRayData();
		GC.collect();
	}
}
