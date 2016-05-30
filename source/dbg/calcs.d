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
		AdditionalCalculation(&calcSchwarzschildStability, "Schwarzschild photon sphere stability"),
		AdditionalCalculation(&calcTotalDistantRayDeflection, "Calculate total ray deflection")
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

 fpnum readFloat(string prompt)
{
	fpnum x = 0.0;
	write(prompt);
	scanf("%lf", &x);
	writeln("V:", x);
	return x;
}

 int readInt(string prompt)
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

fpnum ReadBoundedFloat(const string boundaries)(string name)
{
	fpnum x;
	do{
		x = readFloat(name);
	}while(!mixin(boundaries));
	return x;
}

void calcTotalDistantRayDeflection()
{
	import metric.analytic : Analytic;
	import metric.wrapper : WorldSpaceWrapper;
	import metric.initiators;
	import metric.interfaces;
	import metric.coordinates;
	
	WorldSpaceWrapper wsw = cast(WorldSpaceWrapper)Raytracer.space;
	if(wsw is null)
	{
		writeln("World space is not Analitic!");
		return;
	}
	Analytic anl = cast(Analytic)wsw.smetric;
	if(anl is null)
	{
		writeln("World space is not Analitic!");
		return;
	}
	Initiator init = anl.initiator;//.clone();
	if(init is null)
	{
		writeln("Invalid metric type!");
		return;
	}
	
	string metric_info;
	
	if(cast(Schwarzschild)init !is null)
	{
		auto schw = cast(Schwarzschild)init;
		
		fpnum mass = ReadBoundedFloat!"x>=0"("Enter mass: ");
		
		schw.schwarzschild_radius = 2 * mass;
		schw.mass = mass;
		schw.origin = vectorf(0,0,0);
		
		if(cfgVerbose) writeln("Detected Schwarzschild metric");
		
		metric_info = format("Metric: Analitic-Schwarzschild\n
		Mass: %#.16e\n", mass);
	}
	/*else if(cast(Kerr)init !is null)
	{
		auto kerr = cast(Kerr)init;
		
		fpnum mass = readFloat("Enter mass: ");
		fpnum angMomentum = readFloat("Enter angular momentum: ");
		
		kerr.m = mass;
		kerr.Rs = 2 * mass;
		kerr.origin = vectorf(0,0,0);
		kerr.j = angMomentum;
		if (mass == 0)
			kerr.a = 0;
		else
			kerr.a = angMomentum / mass;
		kerr.a2 = kerr.a * kerr.a;
		kerr.coord = new BoyerLinguist(kerr.origin, kerr.a);
		
		kerr.r_plus = kerr.Rs/2 + sqrt((kerr.Rs*kerr.Rs)/4 - kerr.a2);
		
		if(cfgVerbose) writeln("Detected Kerr metric");
	}*/
	else if(cast(Reissner)init !is null)
	{
		auto reiss = cast(Reissner)init;
		
		fpnum mass = ReadBoundedFloat!"x>=0"("Enter mass: ");
		fpnum charge = ReadBoundedFloat!"x>=0"("Enter charge: ");
		
		reiss.origin = vectorf(0,0,0);
		reiss.cord = new Radial(reiss.origin);
		reiss.M = mass;
		reiss.Rs = 2 * mass;
		reiss.Q = charge;
		reiss.Q2 = charge*charge;
		
		reiss.det = (reiss.Rs/2) * sqrt(1-(4*reiss.Q2)/(reiss.Rs*reiss.Rs));
		reiss.r_ext = (reiss.Rs/2) + reiss.det;
		reiss.r_cauchy = (reiss.Rs/2) - reiss.det;
		
		if(cfgVerbose) writeln("Detected Reissner-Nordstrom metric");
		
		metric_info = format("Metric: Analitic-Reissner\n
		Mass: %#.16e\tCharge: %#.16e\n", mass, charge);
	}
	else if(cast(FlatCartesian)init !is null || cast(FlatRadial)init !is null)
	{
		if(cfgVerbose) writeln("Detected flat Minkowski metric");
		metric_info = "Metric: Analitic-Flat\n";
	}
	else
	{
		writeln("Unsuported metric type!");
		return;
	}
	
	string opath;
	fpnum timestep, distFromHole;
	int minDeflectionMag;
	size_t max_num_of_steps;
	fpnum castingDistFromHole, castingDistFromHoleStep;
	
	do
	{
		write("Enter output file path: ");
		opath = readln().strip;
	}while(opath.length<1);
	
	timestep = ReadBoundedFloat!"x>0"("Enter integration step: ");
	
	fpnum rayTracingDistance = readFloat("Enter maximum ray tracing distance(negative for inf): ");
	if(rayTracingDistance <= 0) max_num_of_steps = size_t.max;
	else max_num_of_steps = cast(int)(rayTracingDistance / timestep);
	
	distFromHole = ReadBoundedFloat!"x>0"("Enter starting dist from hole: ");
	
	castingDistFromHole = ReadBoundedFloat!"x>0"("Enter ray casting dist: "); //TODO: better name
	castingDistFromHoleStep = ReadBoundedFloat!"x>0"("Enter ray casting dist step: "); //TODO: better name
	
	bool display = cast(bool)cast(int)readFloat("Do you wanna a visualisation of the rays(0/1): ");
	
	File f = File(opath, "a");
	f.writef(metric_info);	//metric info
	//f.writef(format("\n")); //simulation info
	f.writef("Closest Dist \t Total Deflection Angle\n"); //header
	f.flush();
	
	static fpnum minDistToHole2 = fpnum.infinity;
	
	DebugDispatcher.saver.enable();
	DebugDispatcher.breakFunction = function(SavedRay sray) {
		fpnum curDist2 = *sray.start;
		if(curDist2<=(minDistToHole2+eps))
		{
			minDistToHole2 = fmin(minDistToHole2, curDist2);
			return false;
		}
		else return true;
	};
	
	int stepi = 0;
	int numsteps = cast(int)(castingDistFromHole/castingDistFromHoleStep);
	
	anl.paramStep = timestep;
	anl.maxNumberOfSteps = max_num_of_steps;
	
	DebugDispatcher.saver.clear();
	
	for(fpnum curCastingDist = castingDistFromHole; curCastingDist > 0; curCastingDist -= castingDistFromHoleStep)
	{
		size_t first_id = DebugDispatcher.saver.rays.length;
		
		writef("\r%60c\rProgress: %d/%d", ' ', ++stepi, numsteps);
		stdout.flush();
		
		minDistToHole2 = fpnum.infinity;

		Line ray = Line(vectorf(0, distFromHole, 0), vectorf(curCastingDist,-distFromHole,0).normalized);
		ray.ray = true;
		
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
		fpnum totalDeflection = 2*acos(
			DebugDispatcher.saver.rays[$-1].dir.normalized *
			DebugDispatcher.saver.rays[first_id].dir.normalized);
		fpnum minDistToHole = sqrt(minDistToHole2);
		
		
		f.writef("%#.16e \t %#.16e \n", minDistToHole, totalDeflection);
		f.flush();
		
		
		if(!display) DebugDispatcher.saver.clear();
	}
	
	f.close();
	writeln();
	writeln("Finished");
	DebugDispatcher.saver.dirty = true;
	DebugDispatcher.breakFunction = null;
}
