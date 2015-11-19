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
--nogpu|-g    - Force-disable GPU acceleration
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
	/*auto A = new Radial();

	writeln(A.transformForwardSpacialFirstDerivatives(vectorf(1,0,0), vectorf(0,1,0)));

	auto D2 = [0,1,0,0];
	auto D = A.transformForwardSpacialFirstDerivatives(vectorf(1,0,0), vectorf(0,1,0));
	//0,1,0,0
	D[] = (D[]+D2[]*0.01)*0.01 + A.transformForwardPosition(vectorf(1,0,0))[];

	writeln(A.transformBackSpacialFirstDerivatives(D, [0,0.01,0,1]));
	writeln(A.transformBackSpacialSecondDerivatives(A.transformForwardPosition(vectorf(1,0,0)),[0,0,0,1],[0,1,0,0]));

	return;*/

	/*auto B = A.getCoordinatesFromCartesian(vectorf(-100,200,300));

	auto C = A.getSpacialDerivativesFromCartesianVector(vectorf(-100,200,300), vectorf(1,-2,-3));

	auto D = A.getSpacialCartesianVectorFromDerivatives(B, C);

	writeln("POS-RADIAL:",B,"DIR-RADIAL",C,"DIR-CARTESIAN",D);*/

	//FloatingPointControl fpc;fpc.enableExceptions(fpc.severeExceptions);
	string arg0 = args[0].idup;//asds
	InitGPU();
	InitScripting(arg0);
	bool doHelp;
	getopt(args,
		"verbose|v", &cfgVerbose,
		"script|s", &cfgScript,
		"help|h", &doHelp,
		"threads|t", &cfgThreads,
		"debug|d", &cfgDebug,
		"noimage|n", &cfgNoImage,
		"nogpu|g", &cfgGpuAcc
		);
	cfgGpuAcc = !cfgGpuAcc;
	if(doHelp)
	{
		writef(HelpStr, arg0);
		return;
	}
	MonoTime startTime = MonoTime.currTime;
	renderTid = spawn(&RenderSpawner, thisTid);
	DoScript(cfgScript);
	renderTid.send(false);
	Thread.sleep(dur!"msecs"(50));
	Duration duration = (MonoTime.currTime - startTime);
	writefln("Total rendering time: %s",duration);
	if(cfgDebug)
	{
		import dbg.debugger;
		VisualDebugger vdbg = new VisualDebugger();
		vdbg.Run();
	}
	FinalizeGPU();
}
