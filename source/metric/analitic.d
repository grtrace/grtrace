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
	private fpnum param_step;
	private size_t max_number_of_steps;
	private Initiator init = null;

	@property ref fpnum paramStep()
	{
		return param_step;
	}

	@property ref size_t maxNumberOfSteps()
	{
		return max_number_of_steps;
	}

	@property ref Initiator initiator()
	{
		return init;
	}

	fpnum TraceRay(Line ray, bool* didHit, Vectorf* hitpoint=null, Vectorf* hitnormal=null, Renderable* hit=null, int cnt=0)
	{
		//ray.data = 1;
		return Raytrace!(true,true,true)(ray, didHit, hitpoint, hitnormal, hit, cnt);
	}

	private fpnum TraceBetweenPoints(bool doP, bool doN, bool doO)(Vectorf from, Vectorf to, bool* didHit, Vectorf* hitpoint=null, Vectorf* hitnormal=null, Renderable* hit=null)
	{
		static if(doP)
		{
			static assert(doN);
		}

		Line ray;
		ray.origin = from;
		ray.direction = to-from;
		fpnum travel_dist = ~ray.direction;
		ray.direction = ray.direction/travel_dist;
		ray.ray = true;
		
		fpnum dist,mdist;
		mdist = +fpnum.infinity;
		Vectorf normal,mnormal;
		Renderable H = null;
		bool dh=false;
		foreach(shared(Renderable) o; WorldSpace.objects)
		{
			Renderable O = cast(Renderable)(o);
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
		if(dh && mdist<=travel_dist)
		{
			*didHit=true;
			VisualDebugger.SaveRay(ray, *hitpoint);
			return mdist;
		}

		VisualDebugger.SaveRay(ray, to);
		return travel_dist;
	}

	private fpnum Raytrace(bool doP, bool doN, bool doO)(Line ray, bool* didHit, Vectorf* hitpoint=null, Vectorf* hitnormal=null, Renderable* hit=null, int cnt=0)
	{
		if(cnt == max_number_of_steps) return fpnum.infinity;

		//calculate deflected ray
		Line newRay;
		newRay.ray = true;

		//Runge-Kutta 4-th order
		/*
		x1 = x
		v1 = v
		a1 = a(x1, v1, 0)
		
		x2 = x + 0.5*v1*dt
		v2 = v + 0.5*a1*dt
		a2 = a(x2, v2, dt/2.0)
		
		x3 = x + 0.5*v2*dt
		v3 = v + 0.5*a2*dt
		a3 = a(x3, v3, dt/2.0)
		
		x4 = x + v3*dt
		v4 = v + a3*dt
		a4 = a(x4, v4, dt)
		
		xf = x + (dt/6.0)*(v1 + 2*v2 + 2*v3 + v4)
		vf = v + (dt/6.0)*(a1 + 2*a2 + 2*a3 + a4)
		
		return xf, vf*/

		auto x1 = ray.origin;
		auto v1 = ray.direction;
		auto a1 = returnSecondDerivativeOfGeodescis(x1, v1, init);

		auto x2 = ray.origin + (v1*param_step*0.5);
		auto v2 = ray.direction + (a1*param_step*0.5);
		auto a2 = returnSecondDerivativeOfGeodescis(x2, v2, init);

		auto x3 = ray.origin + (v2*param_step*0.5);
		auto v3 = ray.direction + (a2*param_step*0.5);
		auto a3 = returnSecondDerivativeOfGeodescis(x3, v3, init);

		auto x4 = ray.origin + (v3*param_step);
		auto v4 = ray.direction + (a3*param_step);
		auto a4 = returnSecondDerivativeOfGeodescis(x4, v4, init);

		newRay.origin = ray.origin + ((v1 + (v2*2) + (v3*2) + v4)*(param_step/6.));
		newRay.direction = ray.direction + ((a1 + (a2*2) + (a3*2) + a4)*(param_step/6.));


		newRay.direction = newRay.direction.normalized;
		newRay.direction.w = 0; //be sure it's zero

		fpnum m_dist = TraceBetweenPoints!(doP, doN, doO)(ray.origin, newRay.origin, didHit, hitpoint, hitnormal, hit);
		if(*didHit) return m_dist;
		return Raytrace!(doP, doN, doO)(newRay, didHit, hitpoint, hitnormal, hit, cnt+1) + m_dist; 
	}
}
