module metric.analitic;

import metric.interfaces;
import metric.util;
import math;
import config;
import image;
import scene;
import std.concurrency;
import std.math;
import dbg.debugger;

class Analitic : AnaliticMetricContainer
{
	private fpnum travel_dist;
	private fpnum param_step;
	private size_t max_number_of_steps;
	private Initiator initiator = null;

	@property ref fpnum travelDist()
	{
		return travel_dist;
	}

	@property ref fpnum paramStep()
	{
		return param_step;
	}

	@property ref size_t maxNumberOfSteps()
	{
		return max_number_of_steps;
	}

	@property Initiator getInitiator()
	{
		return initiator;
	}
	
	@property void setInitiator(Initiator init)
	{
		initiator = init;
	}

	fpnum TraceRay(Line ray, bool* didHit, Vectorf* hitpoint=null, Vectorf* hitnormal=null, Renderable* hit=null, int cnt=0)
	{
		ray.data = 1;
		return Raytrace!(true,true,true)(ray, didHit, hitpoint, hitnormal, hit, cnt);
	}

	private fpnum Raytrace(bool doP, bool doN, bool doO)(Line ray, bool* didHit, Vectorf* hitpoint=null, Vectorf* hitnormal=null, Renderable* hit=null, int cnt=0)
	{
		static if(doP)
		{
			static assert(doN);
		}
		if(cnt==max_number_of_steps)
		{
			*didHit = false;
			return fpnum.infinity;
		}

		fpnum dist,mdist;
		mdist = +fpnum.infinity;
		Vectorf normal,mnormal;
		Renderable H = null;
		bool dh=false;
		foreach(shared(Renderable) o; WorldSpace.objects)
		{
			Renderable O = cast(Renderable)(o);
			import std.math;
			if(O.getClosestIntersection(ray,dist,normal))
			{
				if(mdist>dist)
				{
					dh=true;
					mdist=dist;
					static if(doN)
					{
						mnormal = normal;
					}
					static if(doO)
					{
						H = O;
					}
				}
			}
		}
		if(mdist>(travelDist+param_step))
		{
			import std.stdio;
			//calculate deflected ray
			Line newRay;
			newRay.origin = ray.origin + ray.direction*travel_dist;
			newRay.ray = true;

			//writeln(initiator.coordinate_system);

			fpnum[4] dr = initiator.coordinate_system.transformForwardSpacialFirstDerivatives(newRay.origin, ray.direction*ray.data);

			dr[0] = returnTimeDerivativeFromSpacialDerivatives(initiator.getMetricAt(newRay.origin), dr);

			/*Metric4 tmp = initiator.getMetricAt(newRay.origin);
			writeln(tmp[0,0]*dr[0]*dr[0] + tmp[1,1]*dr[1]*dr[1] + tmp[2,2]*dr[2]*dr[2] + tmp[3,3]*dr[3]*dr[3]);*/

			if(cfgVerbose)
			{
				writeln("BEGIN DEBUG ENTRY");
				writeln(__LINE__,":","ray.direction->dr: ", ray.direction, " -> " ,dr);
			}
			//get christoffels symbols
			Metric4[4] christoffel_symbols;

			if(initiator.hasFunction("christoffels"))
			{
				christoffel_symbols = initiator.getChristoffelSymbolsAt(newRay.origin);
			}
			else
			{
				christoffel_symbols = returnChristoffelsSymbols(
					initiator.getMetricAt(newRay.origin), 
					initiator.getDerivativesAt(newRay.origin));
			}

			fpnum[4] d2r = [0,0,0,0];

			//calculate the second derivatives
			for(byte i = 0; i<4; i++)
			{
				for(byte a = 0; a<4; a++)
				{
					for(byte b = 0; b<4; b++)
					{
						d2r[i] += christoffel_symbols[i][a,b]*dr[a]*dr[b];
					}
				}

				d2r[i] = -d2r[i];
			}

			if(cfgVerbose)writeln(__LINE__,":", "d2r: ",d2r);

			//dr[] = (dr[] + d2r[]*param_step);

			Vectorf second = initiator.coordinate_system.transformBackSpacialSecondDerivatives(initiator.coordinate_system.transformForwardPosition(newRay.origin), dr, d2r);

			writeln(second);

			newRay.direction = (ray.direction*ray.data)+second*param_step;
			newRay.data = (~newRay.direction);
			newRay.direction = newRay.direction / newRay.data;

			newRay.direction.w = 0; //be sure it's zero
			newRay.origin = ray.origin + ray.direction*(travel_dist+param_step);

			if(cfgVerbose)writeln(__LINE__,":","ray.direction->newRay.direction: ",ray.direction,"->",newRay.direction);

			if(cfgVerbose)writeln("END DEBUG ENTRY\n");

			VisualDebugger.SaveRay(ray, newRay.origin);
			return Raytrace!(doP,doN,doO)(newRay,didHit,hitpoint, hitnormal,hit,cnt+1);
		}

		VisualDebugger.SaveRay(ray, mdist);
		if(dh){*didHit=true;}
		static if(doO)
		{
			*hit = H;
		}
		static if(doN)
		{
			*hitnormal = mnormal;
		}
		static if(doP)
		{
			Vectorf P = ray.origin + ray.direction*mdist;
			*hitpoint = P;
		}
		return mdist;
	}
}
