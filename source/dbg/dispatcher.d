module dbg.dispatcher;

import config;
import std.stdio, std.math, std.array, std.string, std.format;
import scene.scenemgr;
import scene.camera;
import scene.objects.interfaces;
import math;
import image.color;
import image.memory;
import metric;
import scene.raymgr;

/// -
struct RaySaver
{
    
}

/// Debug routines dispatcher and state storage
struct DebugDispatcher
{
    @disable this();
    @disable this(this);
	static WorldSpace space() nothrow @nogc
	{
		return Raytracer.space;
	}
    __gshared
    {
        /// Rendering result
        Image renderResult;
    }
    static:
    void progress(int done, int total)
	{
		//
	}
}
