module metric.analitic;

import metric.interfaces;
import math;
import config;
import image;
import scene;
import std.concurrency;
import dbg.debugger;

class Analitic : AnaliticMetricContainer
{
	private fpnum param_step;
	private size_t max_number_of_steps;
	private Initiator initiator = null;

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
		if(mdist>param_step)
		{
			//calculate deflected ray
			Line newRay;
			newRay.origin = ray.origin + ray.direction*param_step;
			newRay.ray = true;

			fpnum[4] dr = [
				0, //dt/ds
				ray.direction.x/param_step, //dx/ds
				ray.direction.y/param_step, //dy/ds
				ray.direction.z/param_step]; //dz/ds
				
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

			//calculate the second derivatives
			for(byte i = 0; i<3; i++)
			{
				fpnum d2i = 0;

				for(byte a = 0; a<4; a++)
				{
					for(byte b = 0; b<4; b++)
					{
						d2i += christoffel_symbols[i][a,b]*dr[a]*dr[b];
					}
				}

				d2i = -d2i;
				newRay.direction[i] = dr[i+1] + d2i*param_step; //update direction
			}

			newRay.direction.w = 0; //be sure it's zero
			newRay.direction = newRay.direction.normalized; //normalize direction

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
