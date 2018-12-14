module dbg.dispatcher;

import grtrace;
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
	static __gshared Color[7] rayColors = [
		Colors.Red, Colors.Green, Colors.Blue, Colors.Magenta, Colors.Yellow,
		Colors.Cyan, Colors.White
	];
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
		if (!enabled)
			return;
		if (sr.type == RayDebugType.Default)
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
		/// Breaking function (true=stop rendering)
		bool function(SavedRay) breakFunction;
	}
static:
	void progress(size_t done, size_t total)
	{
		stderr.writef("\r%30c\rProgress: %d/%d", ' ', done, total);
	}

	bool saveRay(Line ray, fpnum dist, RayDebugType rdt, Color customColor = Colors.White)
	{
		if (!saver.enabled)
			return false;
		return saveRay(ray, ray.origin + ray.direction * dist, rdt, customColor);
	}

	bool saveRay(Line ray, Vectorf end, RayDebugType rdt, Color customColor = Colors.White)
	{
		if (!saver.enabled)
			return false;
		auto sray = SavedRay(ray.origin, end, ray.direction, rdt,
				cast(int) saver.rays.length, customColor);
		saver.append(sray);
		return breakFunction ? breakFunction(sray) : false;
	}
}
