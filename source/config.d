module config;

import scene.objects.interfaces;
import scene.materials.material;
import scene.scenemgr, scene.camera;
import image.memory;
import std.concurrency;

alias fpnum = double;
alias inum = long;
alias unum = ulong;
fpnum eps = 1e-9;
alias fpnump = fpnum*;
alias inump = inum*;
alias unump = unum*;

__gshared
{
	bool cfgVerbose = false;
	bool cfgDebug = false;
	bool cfgNoImage = false;
	bool cfgGpuAcc = false;
	string cfgScript = "raytrace.tcl";
	inum cfgResolutionX = 320;
	inum cfgResolutionY = 240;
	inum cfgThreads = 6;
	inum cfgMaxDepth = 5;

	unum cfgSamples = 1;
	string cfgWorldSpace = "euclidean";
	string cfgSpaceConfig = "";
	string cfgCameraType = "orthogonal";
	fpnum cfgCameraX = 0.0;
	fpnum cfgCameraY = 0.0;
	fpnum cfgCameraZ = 0.0;
	fpnum cfgCameraPitch = 0.0;
	fpnum cfgCameraYaw = 0.0;
	fpnum cfgCameraRoll = 0.0;
	string cfgCameraOptions = "";
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
	long cfgTraceStart=0;
	long cfgTraceEnd=0;
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

