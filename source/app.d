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
	int cntO=0, cntL=0;
	foreach(name,object;cfgObjects)
	{
		space.AddObject(object);
		cntO++;
		if(cfgVerbose)
			writeln("Added "~name~" ",object);
	}
	foreach(name,object;cfgLights)
	{
		space.AddLight(object);
		cntL++;
		if(cfgVerbose)
			writeln("Added "~name);
	}
	if(!cfgVerbose)
		writefln("Added %d objects and %d lights.",cntO,cntL);
	space.StartTracing(cfgOutputFile);
}
