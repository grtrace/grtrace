module dbg.dispatcher;

import config;
import std.stdio, std.math, std.array, std.string, std.format;
import scene.scenemgr;
import scene.camera;
import scene.objects.interfaces;
import math;
public import image.color : Colors;
import image.color;
import image.memory;
import metric;
import scene.raymgr;

/// -
enum RayDebugType
{
	Default,
	CustomColor
}

struct SavedRay
{
	Vectorf start;
	Vectorf end;
	Vectorf dir;
	RayDebugType type;
	int index;
	Color color;
}

/// -
struct RaySaver
{
	static __gshared Color[7] rayColors = [Colors.Red, Colors.Green, Colors.Blue,
							Colors.Magenta, Colors.Yellow, Colors.Cyan, Colors.White];
    bool enabled = false;
	SavedRay[] rays;
	bool dirty = false;
	
	void enable()
	{
		enabled = true;
	}
	void disable()
	{
		enabled = false;
	}
	void clear()
	{
		rays = [];
		dirty = true;
	}
	void append(SavedRay sr)
	{
		if(!enabled)return;
		if(sr.type==RayDebugType.Default)
		{
			sr.color = rayColors[sr.index % rayColors.length];
		}
		rays ~= sr;
		dirty = true;
	}
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
		/// Ray saver
		RaySaver saver;
    }
    static:
    void progress(int done, int total)
	{
		stderr.writef("\r%30c\rProgress: %d/%d",' ',done,total);
	}
	
	void saveRay(Line ray, fpnum dist, RayDebugType rdt, Color customColor=Colors.White)
	{
		if(!saver.enabled)return;
		saveRay(ray, ray.origin + ray.direction * dist, rdt, customColor);
	}
	
	void saveRay(Line ray, Vectorf end, RayDebugType rdt, Color customColor=Colors.White)
	{
		if(!saver.enabled)return;
		saver.append(SavedRay(ray.origin, end, ray.direction, rdt, cast(int)saver.rays.length, customColor));
	}
}
