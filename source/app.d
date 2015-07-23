module app;

import std.stdio;
import std.getopt;
import scriptconfig;
import config;
import scene.scenemgr;
import math.vector;

enum string HelpStr = `
General Relativity rayTracer usage:
%s [options]
Options:
--verbose|-v  - Outputs additional information
--script|-s   - Script to load the configuration from (default raytrace.tcl)
--help|-h     - Displays this text
--threads|-t  - Thread number to use
`;

void main(string[] args)
{
	string arg0 = args[0].idup;
	InitScripting(arg0);
	bool doHelp;
	getopt(args,
		"verbose|v", &cfgVerbose,
		"script|s", &cfgScript,
		"help|h", &doHelp,
		"threads|t", &cfgThreads
		);
	if(doHelp)
	{
		writef(HelpStr, arg0);
		return;
	}
	DoScript(cfgScript);
	writefln("Rendering to an %dx%d image",cfgResolutionX,cfgResolutionY);
	auto space = CreateSpace(cfgWorldSpace);
	SetupCamera(cfgCameraType, vectorf(cfgCameraX,cfgCameraY,cfgCameraZ), cfgCameraPitch, cfgCameraYaw, cfgCameraRoll, cfgCameraOptions);
	if(true)
	{
		import scene.objects;
		space.AddObject(new Sphere(Vectorf(0,0,10),2.0));
		space.AddObject(new Sphere(Vectorf(4,0,10),3.0));
		space.AddObject(new Sphere(Vectorf(-4,0,10),3.0));
		space.AddObject(new Sphere(Vectorf(0,4,10),3.0));
		space.AddObject(new Sphere(Vectorf(0,-4,10),3.0));
	}
	space.StartTracing(cfgOutputFile);
}
