module config;

import scene.objects.interfaces;
import scene.materials.material;
import scene.scenemgr, scene.camera;
import image.memory;
import std.math, std.functional;
import std.concurrency;

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
	string cfgScript = "raytrace.tcl";
	inum cfgResolutionX = 320;
	inum cfgResolutionY = 240;
	inum cfgThreads = 6;
	inum cfgMaxDepth = 5;

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
