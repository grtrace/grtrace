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
`;

void main(string[] args)
{
	string arg0 = args[0].idup;
	InitScripting(arg0);
	bool doHelp;
	getopt(args,
		"verbose|v", &cfgVerbose,
		"script|s", &cfgScript,
		"help|h", &doHelp
		);
	if(doHelp)
	{
		writef(HelpStr, arg0);
		return;
	}
	DoScript(cfgScript);
	writefln("Rendering to an %dx%d image",cfgResolutionX,cfgResolutionY);
	auto space = CreateSpace(cfgWorldSpace, cfgSamples);
	SetupCamera(cfgCameraType, vectorf(cfgCameraX,cfgCameraY,cfgCameraZ), cfgCameraPitch, cfgCameraYaw, cfgCameraRoll, cfgCameraOptions);
	space.StartTracing(cfgOutputFile);
}
