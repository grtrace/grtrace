module app;

import std.stdio;
import std.getopt;
import std.math;
import scriptconfig;
import grtrace;
import scene.scenemgr;
import scene.raymgr : Raytracer;
import math.vector;
import metric;
import std.concurrency;
import core.thread : Thread;
import core.time;
import math;
import gpuacc.gpu;
import dbg.debugger : VisualHelper;
import dbg.calcs;

enum string HelpStr = `
General Relativity rayTracer usage:
%s [options]
Options:
--verbose|-v     - Outputs additional information
--script|-s      - Script to load the configuration from (default raytrace.tcl)
--help|-h        - Displays this text
--threads|-t     - Thread number to use
--debug|-d       - Launches the visual debugger
--noimage|-n     - Doesn't run the main rendering loop
--nogpu|-g       - Force-disable GPU acceleration
--addcalc|-c     - Do only additional calculations
--fastapprox|-f  - Calculate 25x less pixels for visual approximation of the result
`;

void RenderSpawner(Tid owner, shared(GRTrace)* grtShared)
{
	GRTrace* grt = cast(GRTrace*) grtShared;
	while (true)
	{
		if (receiveOnly!bool())
		{
			WorldSpace sp = cast(WorldSpace)(grt.config.space);
			sp.StartTracing(grt, grt.config.outputFile);
			grt.config.traceEnd = grt.config.traceStart;
		}
		else
		{
			return;
		}
	}
}

void main(string[] args)
{
	//FloatingPointControl fpc;fpc.enableExceptions(fpc.severeExceptions);
	string arg0 = args[0].idup; //asds
	GRTrace* grt = new GRTrace();
	Raytracer.grt = grt;
	InitGPU(grt);
	InitScripting(grt, arg0);
	bool doHelp;
	getopt(args, "verbose|v", &grt.config.verbose, "script|s",
			&grt.config.script, "help|h", &doHelp, "threads|t", &grt.config.threads,
			"debug|d", &grt.config.debugMode, "noimage|n", &grt.config.noImage,
			"nogpu|g", &grt.config.gpuAcc, "addcalc|c", &grt.config.additionalCalc,
			"fastapprox|f", &grt.config.fastApproximation);
	grt.config.gpuAcc = !grt.config.gpuAcc;
	if (doHelp)
	{
		writefln(HelpStr, arg0);
		return;
	}
	VisualHelper.instance.initialize();
	MonoTime startTime = MonoTime.currTime;
	grt.renderTid = spawn(&RenderSpawner, thisTid, cast(shared) grt);
	DoScript(grt.config.script);
	grt.renderTid.send(false);
	Thread.sleep(dur!"msecs"(50));
	Duration duration = (MonoTime.currTime - startTime);
	writefln("Total rendering time: %s", duration);
	VisualHelper.instance.grt = grt;
	if (grt.config.debugMode)
		VisualHelper.instance.runGraphics();
	if (grt.config.additionalCalc && (!grt.config.debugMode))
	{
		askCalculation(grt);
	}

	FinalizeGPU();
}
