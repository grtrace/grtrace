module config;

import scene.objects.interfaces;
import scene.materials.material;
import scene.scenemgr, scene.camera;
import image.memory;
import std.math, std.functional;
import std.concurrency;
public import metric.integrators : Integrator;

version(GRTrace_NoUI)
	enum bool GRTRACE_HAS_UI = false;
else
	enum bool GRTRACE_HAS_UI = true;

alias fpnum = double;
alias inum = long;
alias unum = ulong;
fpnum eps = 1e-9;
alias fpnump = fpnum*;
alias inump = inum*;
alias unump = unum*;

/*fpnum fast_atan2(fpnum y, fpnum x)
{
	
}*/
alias fast_atan2 = atan2;

__gshared
{

	bool cfgVerbose = false;
	bool cfgDebug = false;
	bool cfgAdditionalCalc = false;
	bool cfgNoImage = false;
	bool cfgGpuAcc = false;
	bool cfgFastApproximation = false;
	inum cfgUiDpi = 96;
	string cfgScript = "raytrace.tcl";
	inum cfgResolutionX = 320;
	inum cfgResolutionY = 240;
	inum cfgThreads = 6;
	inum cfgMaxDepth = 5;
	Integrator cfgIntegrator = Integrator.RK4;

	unum cfgSamples = 1;
	string cfgOutputFile = "raytrace.png";

	Renderable[string] cfgObjects;
	string[Renderable] cfgObjectsMaterialNames;

	Light[string] cfgLights;
	Image[string] cfgTextures;

	Material[string] cfgMaterials;
	string[Material] cfgMaterialsTextureNames;

	Tid renderTid;
}

public shared
{
	WorldSpace cfgSpace;
	ICamera cfgCamera;
	long cfgTraceStart = 0;
	long cfgTraceEnd = 0;
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
