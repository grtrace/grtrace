/// The grtrace main interface object.
module grtrace;

import scene.objects.interfaces;
import scene.materials.material;
import scene.scenemgr, scene.camera;
import image.memory;
import std.math, std.functional;
import std.array;
import std.concurrency;
public import metric.integrators : Integrator;
import math;
import image.color;

alias fpnum = double;
alias inum = long;
alias unum = ulong;
fpnum eps = 1e-9;

alias fast_atan2 = atan2;

export struct GRTraceConfig
{
	bool verbose = false;
	bool debugMode = false;
	bool additionalCalc = false;
	bool noImage = false;
	bool gpuAcc = false;
	bool fastApproximation = false;
	string script = "raytrace.tcl";
	inum resolutionX = 320;
	inum resolutionY = 240;
	inum threads = 6;
	inum maxDepth = 5;
	Integrator integrator = Integrator.RK4;

	unum samples = 1;
	string outputFile = "raytrace.png";

	Renderable[string] objects;
	string[Renderable] objectsMaterialNames;

	Light[string] lights;
	Image[string] textures;

	Material[string] materials;
	string[Material] materialsTextureNames;

	WorldSpace space;
	ICamera camera;
	long traceStart = 0;
	long traceEnd = 0;
}

private immutable Color[7] savedRayColors = [
	Colors.Red, Colors.Green, Colors.Blue, Colors.Magenta, Colors.Yellow,
	Colors.Cyan, Colors.White
];

export struct SavedRay
{
	Vectorf start;
	Vectorf end;
	Vectorf dir;
	int index;
	Color color;
}

/// Contains the state of the entire raytracer.
export struct GRTrace
{
	@disable this(this);

	GRTraceConfig config;

	Tid renderTid;

	Image targetImage;

	bool shouldSaveRays;
	Appender!(SavedRay[]) savedRays;
	bool savedRaysDirty;
	void* cancelRayCallbackUdata;
	bool function(void* udata, SavedRay* ray) cancelRayCallback;

	void* progressCallbackUdata;
	void function(void* udata, ulong progress, ulong maxProgress) progressCallback;
	ulong progress, maxProgress;

	void setProgress(ulong prog, ulong maxProg)
	{
		progress = prog;
		maxProgress = maxProg;
		if (progressCallback)
		{
			progressCallback(progressCallbackUdata, prog, maxProg);
		}
	}

	/// Save a ray if saving is enabled, and return if computation should be terminated as signified by a custom callback.
	bool saveRay(Line ray, Vectorf end)
	{
		return saveRay(ray, end, savedRayColors[savedRays.data.length % savedRayColors.length]);
	}

	/// Ditto
	bool saveRay(Line ray, Vectorf end, Color customColor)
	{
		if (shouldSaveRays)
		{
			savedRays ~= SavedRay(ray.origin, end, ray.direction,
					cast(int) savedRays.data.length, customColor);
			savedRaysDirty = true;
		}
		return cancelRayCallback ? cancelRayCallback(cancelRayCallbackUdata, &savedRays.data.back)
			: false;
	}

	/// Ditto
	bool saveRay(Line ray, fpnum dist, Color customColor)
	{
		return saveRay(ray, ray.origin + ray.direction * dist, customColor);
	}

	/// Ditto
	bool saveRay(Line ray, fpnum dist)
	{
		return saveRay(ray, ray.origin + ray.direction * dist);
	}
}

extern (C)
{
	import core.runtime : Runtime;
	import core.memory : GC;

export:

	void grtInitialize()
	{
		Runtime.initialize();
	}

	void grtTerminate()
	{
		Runtime.terminate();
	}

	GRTrace* grtNewGRTrace()
	{
		GRTrace* inst = new GRTrace();
		GC.addRoot(inst);
		return inst;
	}

	void grtDeleteGRTrace(GRTrace* grt)
	{
		GC.removeRoot(grt);
		grt = null;
		GC.collect();
	}

	void grtSetRaySavingEnabled(GRTrace* grt, bool enabled)
	{
		grt.shouldSaveRays = enabled;
	}

	void grtClearSavedRays(GRTrace* grt)
	{
		grt.savedRays.clear();
		grt.savedRaysDirty = true;
	}

}

//debug info
enum WorldType : string
{
	Unknown = "Unknown",
	Flat = "Clasical",
	Deflect = "Deflection",
	Analytic = "Analytical",
	AnalyticSkyBox = "Analytical Sky Box"
}

enum MetricType : string
{
	Unknown = "Unknown",
	FlatCartesian = "Flat Cartesian",
	FlatRadial = "Flat Radial",
	Schwarzchild = "Schwarzschild",
	Reisnerr = "Reisnerr Nordstrom",
	Kerr = "Kerr"
}

public shared
{
	string dbgWorldType = WorldType.Unknown;
	string dbgMetricType = MetricType.Unknown;
}

// physical constants
enum P : fpnum
{
	c = 1.0,
	G = 1.0,
	hd = 2.612e-70, // m^2
	MS = 1477, // m
	MZ = 0.004435, // m
	LS = 1.08e-26
}
