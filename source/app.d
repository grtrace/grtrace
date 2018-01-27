module app;

import std.stdio;
import std.getopt;
import std.math;
import scriptconfig;
import config;
import scene.scenemgr;
import math.vector;
import metric;
import std.concurrency;
import core.thread : Thread;
import core.time;
import math;
import gpuacc.gpu;
import dbg.calcs;

enum string HelpStr = `
General Relativity rayTracer usage:
%s [options]
Options:
--verbose|-v     - Outputs additional information
--script|-s      - Script to load the configuration from (default raytrace.tcl)
--help|-h        - Displays this text
--threads|-t     - Thread number to use
--ui|-u          - Launches the graphical user interface
--dpi|-d         - Sets the DPI for the GUI to the specified value
--noimage|-n     - Doesn't run the main rendering loop
--nogpu|-g       - Force-disable GPU acceleration
--addcalc|-c     - Do only additional calculations
--fastapprox|-f  - Calculate 25x less pixels for visual approximation of the result
`;

void RenderSpawner(Tid owner)
{
	while (true)
	{
		if (receiveOnly!bool())
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

static if (!GRTRACE_HAS_UI)
{
	void main(string[] args)
	{
		grtrace_main(args);
	}
}
else
{
	import dlangui;

	mixin APP_ENTRY_POINT;

	extern (C) int UIAppMain(string[] args)
	{
		grtrace_main(args);
		return 0;
	}
}

void grtrace_main(string[] args)
{
	//FloatingPointControl fpc;fpc.enableExceptions(fpc.severeExceptions);
	string arg0 = args[0].idup;
	InitGPU();
	InitScripting(arg0);
	bool doHelp;
	if (args.length == 1)
		cfgDebug = 1;
	// dfmt off
	getopt(args, 
		"verbose|v", &cfgVerbose,
		"script|s", &cfgScript,
		"help|h", &doHelp,
		"threads|t", &cfgThreads,
		"ui|u", &cfgDebug,
		"dpi|d", &cfgUiDpi,
		"noimage|n", &cfgNoImage,
		"nogpu|g", &cfgGpuAcc,
		"addcalc|c", &cfgAdditionalCalc,
		"fastapprox|f", &cfgFastApproximation,
		);
	// dfmt on
	cfgGpuAcc = !cfgGpuAcc;
	if (doHelp)
	{
		writefln(HelpStr, arg0);
		return;
	}
	//VisualHelper.instance.initialize();
	if (cfgDebug)
	{
		static if (GRTRACE_HAS_UI)
		{
			import ui.window;

			runUI();
		}
		else
		{
			writefln("GUI not supported, please run with -h to show available options");
		}
		return;
	}
	MonoTime startTime = MonoTime.currTime;
	renderTid = spawn(&RenderSpawner, thisTid);
	DoScript(cfgScript);
	renderTid.send(false);
	Thread.sleep(dur!"msecs"(50));
	Duration duration = (MonoTime.currTime - startTime);
	writefln("Total rendering time: %s", duration);
	//if (cfgDebug)
	//VisualHelper.instance.runGraphics();
	if (cfgAdditionalCalc && (!cfgDebug))
	{
		askCalculation();
	}
	FinalizeGPU();
}
