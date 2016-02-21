/// Ray compute dispatch management code
module scene.raymgr;

import config;
import std.container.array;
import std.math, std.string, std.algorithm, std.array, std.range;
import core.thread, core.atomic, core.time;
import math.geometric;
import image.color;
import scene.scenemgr;
import scene.compute;
import dbg.dispatcher;
import std.stdio;

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
		fpnum jmpx = 2.0/cfgResolutionX;
		fpnum jmpy = 2.0/cfgResolutionY;
		foreach(cx; x..x+w)
		{
			foreach(cy; y..y+h)
			{
				foreach(uint smp; 0..cast(uint)cfgSamples)
				{
					double px,py;
					getSample(smp, px, py);
					double X = cx * jmpx - 1.0 + px;
					double Y = cy * jmpy - 1.0 + py;
					if(space.getCamera().fetchRay(X, Y, cray))
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
		stderr.writeln();
	}
	
	private __gshared bool threadRecv;
	private __gshared uint threadId;
	private __gshared uint threadCount;
	private __gshared int[] threadDoneRays;
	private __gshared Thread[] threads;
	
	private static void threadComputer()
	{
		uint tid = threadId;
		threadRecv = true;
		bool done = false;
		int totalRays = cast(int)raybuffer.length;
		int doneRays = 0;
		while(!done)
		{
			done = true;
			doneRays = 0;
			for(int i=tid;i<totalRays;i+=threadCount)
			{
				RayComputation* rc = &raybuffer[i];
				if(rc.state < RayState.Finished)
				{
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
	}
	
	/// Computes all rays in the buffer in multiple threads
	static void computeMultiThread()
	{
		threadCount = cast(int)(cfgThreads);
		writeln("Rendering using ",threadCount," threads");
		bool done = false;
		int totalRays = cast(int)raybuffer.length;
		int doneRays = 0;
		threads = [];
		threads.length = threadCount;
		threadDoneRays.length = threadCount;
		threadDoneRays[] = 0;
		for(int i=0;i<threadCount;i++)
		{
			threadRecv = false;
			threadId = i;
			threads[i] = new Thread(&threadComputer);
			threads[i].start();
			while(!threadRecv){Thread.yield();}
		}
		while(doneRays < totalRays)
		{
			Thread.sleep(dur!("msecs")(150));
			doneRays = 0;
			for(int j=0;j<threadCount;j++)
			{
				doneRays += threadDoneRays[j];
			}
			DebugDispatcher.progress(doneRays, totalRays);
		}
		stderr.writeln();
	}
	
	static void saveImage()
	{
		import image.memory:Image;
		import image.imgio:WriteImage;
		float[] msimage;
		msimage.length = cfgResolutionX*cfgResolutionY*3;
		msimage[] = 0.0f;
		size_t xstride = 3;
		size_t ystride = cfgResolutionX*xstride;
		foreach(ref RayComputation rc; raybuffer[])
		{
			if(rc.state==RayState.Finished)
			{
				msimage[rc.imgX*xstride + rc.imgY*ystride] += rc.color.r;
				msimage[rc.imgX*xstride + rc.imgY*ystride + 1] += rc.color.g;
				msimage[rc.imgX*xstride + rc.imgY*ystride + 2] += rc.color.b;
			}
		}
		if(cfgSamples>1)
			msimage[] /= cast(float)cfgSamples;
		Image im = new Image(cfgResolutionX, cfgResolutionY);
		foreach(y; 0..cfgResolutionY)
		{
			foreach(x; 0..cfgResolutionX)
			{
				size_t i = x*xstride + y*ystride;
				im.Poke(x, y, Color(msimage[i],msimage[i+1],msimage[i+2]));
			}
		}
		WriteImage(im, cfgOutputFile);
		DebugDispatcher.renderResult = im;
	}
	
	static void cleanup()
	{
		import core.memory : GC;
		raybuffer.clear();
		space.freeRayData();
		GC.collect();
	}
}
