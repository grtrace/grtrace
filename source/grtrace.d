/// The grtrace main interface object.
module grtrace;

import scene.objects.interfaces;
import scene.materials.material;
import scene.scenemgr, scene.camera;
import image.memory;
import std.math, std.functional;
import std.concurrency;
public import metric.integrators : Integrator;

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

/// Contains the state of the entire raytracer.
export struct GRTrace
{
	@disable this(this);

	GRTraceConfig config;

	Tid renderTid;
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
