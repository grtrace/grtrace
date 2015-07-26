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

void Test()
{
	import math;
	import std.random;

	while(true)
	{
		Vectorf a = vectorf(uniform(0.,100.), uniform(0.,100.), uniform(0.,100.));
		Vectorf b = vectorf(uniform(0.,100.), uniform(0.,100.), uniform(0.,100.));

		assert(a%b == (-(b%a)));
	}
	/*
	import math;
	import std.random;
	import std.math;
	import std.conv;

	fpnum eps2 = 0.0001;

	try
	{
		while(true)
		{
			Vectorf axis;
			do
			{
				axis = vectorf(uniform(0.,1.),uniform(0.,1.),uniform(0.,1.));
			}
			while((*axis)>1);
			axis = axis.normalized;

			Vectorf point = axis*uniform(0.,100.);

			for(fpnum i = 1; i<20; i+=0.1)
			{
				Vectorf tmp = Matrix4f.RotateV(axis,i,point);
				if(fabs(tmp.x-point.x)>eps2) throw new Exception(axis.toString()~" "~point.toString()~" "~to!string(i)~" "~tmp.toString());
				if(fabs(tmp.y-point.y)>eps2) throw new Exception(axis.toString()~" "~point.toString()~" "~to!string(i)~" "~tmp.toString());
				if(fabs(tmp.z-point.z)>eps2) throw new Exception(axis.toString()~" "~point.toString()~" "~to!string(i)~" "~tmp.toString());
			}
		}
	}
	catch(Exception ex)
	{
		writeln(ex.msg);
	}
	*/
}

enum DoTests = false;

void main(string[] args)
{
	static if(DoTests)
	{
		Test();
	}
	else
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
		renderTid = spawn(&RenderSpawner, thisTid);
		DoScript(cfgScript);
		renderTid.send(false);
		Thread.sleep(dur!"msecs"(50));
	}
}
