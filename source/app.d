module app;

import std.stdio;
import std.getopt;
import scriptconfig;
import config;
import scene.scenemgr;
import math.vector;
import std.concurrency;
import core.thread : Thread;
import core.time : dur;

enum string HelpStr = `
General Relativity rayTracer usage:
%s [options]
Options:
--verbose|-v  - Outputs additional information
--script|-s   - Script to load the configuration from (default raytrace.tcl)
--help|-h     - Displays this text
--threads|-t  - Thread number to use
--debug|-d    - Launches the visual debugger
--noimage|-n  - Doesn't run the main rendering loop
`;

void RenderSpawner(Tid owner)
{
	while(true)
	{
		if(receiveOnly!bool())
		{
			WorldSpace sp = cast(WorldSpace)(cfgSpace);
			sp.StartTracing(cfgOutputFile);
			cfgTraceEnd = cfgTraceStart;
		}
		else
		{
			return;
		}
	}
}

void main(string[] args)
{
	string arg0 = args[0].idup;
	InitScripting(arg0);
	bool doHelp;
	getopt(args,
		"verbose|v", &cfgVerbose,
		"script|s", &cfgScript,
		"help|h", &doHelp,
		"threads|t", &cfgThreads,
		"debug|d", &cfgDebug,
		"noimage|n", &cfgNoImage
		);
	if(doHelp)
	{
		writef(HelpStr, arg0);
		return;
	}
	renderTid = spawn(&RenderSpawner, thisTid);
	DoScript(cfgScript);
	renderTid.send(false);
	Thread.sleep(dur!"msecs"(50));
	if(cfgDebug)
	{
		import dbg.debugger;
		VisualDebugger vdbg = new VisualDebugger();
		vdbg.Run();
	}
}
