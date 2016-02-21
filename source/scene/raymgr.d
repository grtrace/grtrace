/// Ray compute dispatch management code
module scene.raymgr;

import config;
import std.container.array;
import std.math, std.string, std.algorithm, std.array, std.range;
import core.thread, core.atomic;
import math.geometric;
import image.color;
import scene.scenemgr;
import scene.compute;
import dbg.dispatcher;

private void getSample(uint number, out double sx, out double sy)
{
	import std.random : Xorshift192, uniform01, unpredictableSeed;
	static Xorshift192 rnd = Xorshift192();
	static bool seeded = false;
	if(!seeded)
	{
		rnd.seed(unpredictableSeed());
		seeded = true;
	}
	if(number==0)
	{
		sx = 0.0;
		sy = 0.0;
		return;
	}
	sx = uniform01!double(rnd)*2.0-1.0;
	sy = uniform01!double(rnd)*2.0-1.0;
}

///-
class Raytracer
{
	__gshared
	{
		WorldSpace space;
		Array!RayComputation raybuffer;
	}
	
	static void ensureBuffer(uint count)
	{
		raybuffer.reserve(count);
	}
	
	static void setSpace(WorldSpace sp)
	{
		space = sp;
	}
	
	static void prepareSingleTrace(uint x, uint y, uint number = 0, double sx = 0.0, double sy = 0.0)
	{
		raybuffer.clear();
		ensureBuffer(10);
		Line cray;
		if(space.getCamera().fetchRay(x + sx,y + sy,cray))
		{
			raybuffer ~= RayComputation(cray, RayState.Initialised, RayFlags.None, x, y, number, Color(1.0,1.0,1.0), 0, space.allocNewRayData());
		}
	}
	
	static void prepareSubimageTrace(uint x, uint y, uint w, uint h)
	{
		raybuffer.clear();
		ensureBuffer(cast(uint)(w*h*(space.lights.length+1)));
		Line cray;
		foreach(cx; x..x+w)
		{
			foreach(cy; y..y+h)
			{
				foreach(uint smp; 0..cast(uint)cfgSamples)
				{
					double px,py;
					getSample(smp, px, py);
					if(space.getCamera().fetchRay(px, py, cray))
					{
						raybuffer ~= RayComputation(cray, RayState.Initialised, RayFlags.None, cx, cy, smp, Color(1.0,1.0,1.0), 0, space.allocNewRayData());
					}
				}
			}
		}
	}
	
	/// Computes all rays in the buffer in a single thread
	static void computeSingleThread()
	{
		bool done = false;
		int totalRays = cast(int)raybuffer.length;
		int doneRays = 0;
		while(!done)
		{
			done = true;
			doneRays = 0;
			foreach(ref RayComputation rc; raybuffer[])
			{
				if(rc.state < RayState.Finished)
				{
					rc.state = space.getComputeStages()[rc.state].cpuFun(&rc);
					done = false;
				}
				else
				{
					doneRays++;
				}
			}
			DebugDispatcher.progress(doneRays, totalRays);
		}
	}
}
