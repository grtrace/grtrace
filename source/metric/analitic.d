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
		//ray.data = 1;
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
			//calculate deflected ray
			Line newRay;
			newRay.origin = ray.origin + ray.direction*travel_dist;
			newRay.ray = true;

			//get metric at point
			Metric4 metric = initiator.getMetricAt(newRay.origin);

			//get christoffels symbols at point
			Metric4[4] christoffel_symbols;

			if(initiator.hasFunction("christoffels"))
			{
				christoffel_symbols = initiator.getChristoffelSymbolsAt(newRay.origin);
			}
			else
			{
				christoffel_symbols = returnChristoffelsSymbols(
					metric, 
					initiator.getDerivativesAt(newRay.origin));
			}

			auto second = returnSecondDerivativeOfGeodescis(newRay.origin, ray.direction, initiator.coordinate_system, metric, christoffel_symbols);

			newRay.direction = ((ray.direction)+second*param_step).normalized;
			//newRay.data = (~newRay.direction);
			//newRay.direction = newRay.direction / newRay.data;

			newRay.direction.w = 0; //be sure it's zero
			newRay.origin = ray.origin + ray.direction*(travel_dist+param_step);

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
