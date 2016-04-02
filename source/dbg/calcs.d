/// Additional calculations (available with -c and in the interactive visual helper)
module dbg.calcs;

import config;
import dbg.dispatcher;
import scene.objects.interfaces;
import scene.raymgr;
import scene.scenemgr;
import core.stdc.stdio : scanf;
import std.stdio, std.conv, std.string, std.array;
import std.file, std.math;
import math.vector;
import math.matrix;
import math.geometric;

struct AdditionalCalculation
{
	alias calcFunction = void function();
	calcFunction func;
	string description;
}

__gshared AdditionalCalculation[] calculations;

shared static this()
{
	// setup calc functions
	calculations = [
		AdditionalCalculation(&calcSchwarzschildStability, "Schwarzschild photon sphere stability")
	];
}

void askCalculation()
{
	writeln("Choose type of additional calculation to perform:");
	foreach(i,c; calculations)
	{
		writefln("%2d. %s", i+1, c.description);
	}
	int choice;
	try
	{
		choice = readln().strip.to!int;
		choice--;
		if(choice >= calculations.length)
		{
			writeln("Wrong type of calculation, exitting");
			return;
		}
	}
	catch(Exception e)
	{
		writeln("Wrong type of calculation, exitting");
		return;
	}
	calculations[choice].func();
}

private fpnum readFloat(string prompt)
{
	fpnum x = 0.0;
	write(prompt);
	scanf("%lf", &x);
	writeln("V:", x);
	return x;
}

private int readInt(string prompt)
{
	int x = 0;
	write(prompt);
	scanf("%d", &x);
	writeln("V:", x);
	return x;
}

void calcSchwarzschildStability()
{
	import metric.analytic : Analytic;
	import metric.wrapper : WorldSpaceWrapper;
	import metric.initiators.schwarzschild : Schwarzschild;
	fpnum mass, min_timestep, max_timestep, step_timestep;
	int numOfCircles;
	string opath;
	
	WorldSpaceWrapper wsw = cast(WorldSpaceWrapper)Raytracer.space;
	if(wsw is null)
	{
		writeln("World space is not Schwarzschild!");
		return;
	}
	Analytic anl = cast(Analytic)wsw.smetric;
	if(anl is null)
	{
		writeln("World space is not Schwarzschild!");
		return;
	}
	Schwarzschild schw = cast(Schwarzschild)anl.initiator;
	if(schw is null)
	{
		writeln("World space is not Schwarzschild!");
		return;
	}

	do
	{
		write("Enter output file path: ");
		opath = readln().strip;
	}while(opath.length<1);

	mass = readFloat("Enter mass: ");
	min_timestep = readFloat("Enter min timestep: ");
	max_timestep = readFloat("Enter max timestep: ");
	if(max_timestep < min_timestep)
	{
		fpnum t = max_timestep;
		max_timestep = min_timestep;
		min_timestep = t;
	}
	step_timestep = readFloat("Enter timestep step: ");
	numOfCircles = readInt("Enter max num of circles: ");
	if(numOfCircles <= 0) numOfCircles = int.max;
	schw.schwarzschild_radius = 2 * mass;
	schw.mass = mass;
	schw.origin = vectorf(0,0,0);

	static fpnum Rsphere;
	Rsphere = 3*mass;
	Line ray = Line(schw.origin + vectorf(0, Rsphere, 0), vectorf(1,0,1).normalized);
	ray.ray = true;
	File f = File(opath, "a");
	f.writef("Mass \t DT \t Circles \t Dist \n"); // header
	f.flush();
	int stepi = 0;
	int numsteps = cast(int)((max_timestep-min_timestep)/step_timestep);
	DebugDispatcher.saver.enable();
	DebugDispatcher.breakFunction = function(SavedRay sray) {
		fpnum R = *((sray.start+sray.end)/2.0);
		fpnum eps = fabs(R-Rsphere);
		if(eps>0.1) // dtradius > 0.01
		{
			return true;
		}
		return false;
	};
	Rsphere *= Rsphere;
	for(fpnum timestep = min_timestep; timestep <= max_timestep; timestep += step_timestep)
	{
		writef("\r%60c\rProgress: %d/%d", ' ', ++stepi, numsteps);
		stdout.flush();

		anl.paramStep = timestep;
		int maxasteps = cast(int)(6 * PI * mass * numOfCircles / timestep);
		anl.maxNumberOfSteps = maxasteps;
		DebugDispatcher.saver.clear();

		try
		{
			bool dh;
			Vectorf p3;
			Vectorf p4;
			Renderable p5;
			anl.TraceRay(ray, &dh, &p3, &p4, &p5);
		}
		catch(Exception e)
		{
			//
		}
		int stable = 0;
		foreach(ref SavedRay sray; DebugDispatcher.saver.rays)
		{
			
			stable++;
		}

		f.writef("%#.16e \t %#.16e \t %d %#.16e \t %d \n", mass, timestep,
			numOfCircles, stable * timestep, stable);
		f.flush();
	}
	f.close();
	writeln();
	writeln("Finished");
	DebugDispatcher.saver.dirty = true;
	DebugDispatcher.breakFunction = null;
}
