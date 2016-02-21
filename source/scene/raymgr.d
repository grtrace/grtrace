/// Ray compute dispatch management code
module scene.raymgr;

import config;
import std.container.array;
import std.math, std.string, std.algorithm, std.array, std.range;
import core.thread, core.atomic;
import scene.scenemgr;
import scene.compute;

private void getSample(uint number, out double sx, out double sy)
{
	import std.random : Xorshift192, uniform01;
	static Xorshift192 rnd = Xorshift192(unpredictableSeed());
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
		int numrays;
		
	}
	
	static void ensureBuffer(uint count)
	{
		raybuffer.reserve(count);
	}
	
	static void prepareSingleTrace(uint x, uint y, uint number = 0, double sx = 0.0, double sy = 0.0)
	{
		raybuffer.clear();
		ensureBuffer(10);
		Line cray;
		if(space.getCamera().fetchRay(x + sx,y + sy,cray))
		{
			raybuffer ~= RayComputation(cray, RayState.Initialised, x + sx, y + sy, number, space.allocNewRayData());
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
				foreach(smp; 0..cfgSamples)
				{
					double px,py;
					getSample(smp, px, py);
					if(space.getCamera().fetchRay(px, py, cray))
					{
						raybuffer ~= RayComputation(cray, RayState.Initialised, px, py, smp, space.allocNewRayData());
					}
				}
			}
		}
	}
	
}
