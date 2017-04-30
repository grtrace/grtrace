module metric.analytic;

import metric.interfaces;
import metric.util;
import math;
import config;
import image;
import scene;
import std.concurrency;
import std.math;
import dbg.dispatcher;
import scene.compute, scene.raymgr;
import metric.integrators;

import core.atomic;

class Analytic : AnalyticMetricContainer
{
	private static __gshared fpnum param_step;
	private static __gshared size_t max_number_of_steps;
	private static shared Initiator init = null;

	static struct RayData
	{
		size_t geodesic_iteration;
	}

	ComputeStep[RayState.Finished] steps;

	this()
	{
		steps[RayState.Initialised] = ComputeStep(RayState.Initialised,
				RayState.Finished, &computeRay1, false, "");
	}

	size_t getRayDataSize()
	{
		return RayData.sizeof + (cast(Initiator) init).getCacheSize();
	}

	int getStageCount()
	{
		return 1;
	}

	ComputeStep[RayState.Finished] getComputeStages()
	{
		return steps;
	}

	private static RayState computeRay1(RayComputation* rc)
	{
		Vectorf rayhit;
		Vectorf normal;
		Renderable closest;
		bool hit = false;
		Vectorf origin = rc.curRay.origin;
		ubyte* initiatorCache = (Raytracer.computebuffer + rc.dataIdx + RayData.sizeof);
		RayData* rayD = cast(RayData*)(Raytracer.computebuffer + rc.dataIdx);
		RaytraceIRayMgr!(true, true, true)(rc.curRay, &hit, &rayhit,
				&normal, &closest, 0, initiatorCache, rayD);
		rayD.geodesic_iteration = 0;
		if (!hit)
		{
			rc.color = Colors.Black;
			return RayState.Finished;
		}
		if (!closest.material)
		{
			rc.color = Colors.Magenta;
			return RayState.Finished;
		}
		rc.curRay.origin = rayhit + normal * 0.01;
		fpnum u, v;
		closest.getUVMapping(rayhit, u, v);

		Color tmpc = closest.material.emission_color;
		Color textureColor = Colors.White;

		if (closest.material.hasTexture())
		{
			fpnum U, V;
			closest.getUVMapping(rayhit, U, V);
			textureColor = closest.material.peekUV(U, V);
		}

		tmpc *= textureColor;

		if (isFinite(closest.material.emission_wave_length))
		{
			auto init = (cast(Initiator)(this.init)).cloneParams();
			init.setCacheBuffer(initiatorCache);

			fpnum est_lamda_src = closest.material.emission_wave_length;

			init.prepareForRequest(rayhit);
			fpnum src_met = init.getMetricAtPoint()[0, 0];

			init.prepareForRequest(origin);
			fpnum rec_met = init.getMetricAtPoint()[0, 0];

			fpnum red_shift_plus_one = sqrt(rec_met / src_met);

			fpnum l_obs = est_lamda_src * red_shift_plus_one;

			tmpc = GetSpectrumColor(l_obs);
		}

		rc.color = tmpc;
		return RayState.Finished;
	}

	private static fpnum RaytraceIRayMgr(bool doP, bool doN, bool doO)(Line ray, bool* didHit,
			Vectorf* hitpoint = null, Vectorf* hitnormal = null, Renderable* hit = null,
			int cnt = 0, ubyte* initiatorCache = null, RayData* rayDat = null)
	{
		auto init = (cast(Initiator)(this.init)).cloneParams();
		init.setCacheBuffer(initiatorCache);
		fpnum totalDist = 0;

		for (; rayDat.geodesic_iteration < max_number_of_steps; rayDat.geodesic_iteration++) //TODO: ray hit not correct
		{
			//calculate deflected ray
			Line newRay = integrateStep(cfgIntegrator, ray, param_step, init);

			fpnum m_dist = TraceBetweenPoints!(doP, doN, doO)(ray.origin,
					newRay.origin, didHit, hitpoint, hitnormal, hit);

			totalDist += m_dist;

			if (*didHit)
				return totalDist;

			ray = newRay;
		}
		return fpnum.infinity;
	}

	@property ref fpnum paramStep()
	{
		return param_step;
	}

	@property ref size_t maxNumberOfSteps()
	{
		return max_number_of_steps;
	}

	@property Initiator initiator()
	{
		return cast(Initiator) init;
	}

	@property void initiator(Initiator inx)
	{
		init = cast(shared Initiator) inx;
	}

	fpnum TraceRay(Line ray, bool* didHit, Vectorf* hitpoint = null,
			Vectorf* hitnormal = null, Renderable* hit = null, int cnt = 0)
	{
		//ray.data = 1;
		return RaytraceI!(true, true, true)(ray, didHit, hitpoint, hitnormal, hit, cnt);
	}

	private static fpnum TraceBetweenPoints(bool doP, bool doN, bool doO)(Vectorf from, Vectorf to, bool* didHit,
			Vectorf* hitpoint = null, Vectorf* hitnormal = null, Renderable* hit = null)
	{
		static if (doP)
		{
			static assert(doN);
		}

		Line ray;
		ray.origin = from;
		ray.direction = to - from;
		fpnum travel_dist = ~ray.direction;
		ray.direction = ray.direction / travel_dist;
		ray.ray = true;

		fpnum dist, mdist;
		mdist = +fpnum.infinity;
		Vectorf normal, mnormal;
		Renderable H = null;
		bool dh = false;
		foreach (shared Renderable o; WorldSpace.objects)
		{
			Renderable O = cast(Renderable)(o);
			if (O.getClosestIntersection(ray, dist, normal))
			{
				if (mdist > dist)
				{
					dh = true;
					mdist = dist;
					static if (doN)
					{
						mnormal = normal;
					}
					static if (doO)
					{
						H = O;
					}
				}
			}
		}

		static if (doO)
		{
			*hit = H;
		}
		static if (doN)
		{
			*hitnormal = mnormal;
		}
		static if (doP)
		{
			Vectorf P = ray.origin + ray.direction * mdist;
			*hitpoint = P;
		}
		if (dh && mdist <= travel_dist)
		{
			*didHit = true;
			DebugDispatcher.saveRay(ray, *hitpoint, RayDebugType.Default);
			return mdist;
		}
		if (DebugDispatcher.saveRay(ray, to, RayDebugType.Default))
		{
			*didHit = true;
			return travel_dist;
		}
		return travel_dist;
	}

	//Recursive version
	private fpnum RaytraceR(bool doP, bool doN, bool doO)(Line ray, bool* didHit,
			Vectorf* hitpoint = null, Vectorf* hitnormal = null, Renderable* hit = null, int cnt = 0)
	{
		if (cnt == max_number_of_steps)
			return fpnum.infinity;

		//calculate deflected ray
		Line newRay = integrateStep(cfgIntegrator, ray, param_step, initiator);

		fpnum m_dist = TraceBetweenPoints!(doP, doN, doO)(ray.origin,
				newRay.origin, didHit, hitpoint, hitnormal, hit);
		if (*didHit)
			return m_dist;
		return RaytraceR!(doP, doN, doO)(newRay, didHit, hitpoint, hitnormal, hit, cnt + 1) + m_dist;
	}

	//Iterative version
	private fpnum RaytraceI(bool doP, bool doN, bool doO)(Line ray, bool* didHit,
			Vectorf* hitpoint = null, Vectorf* hitnormal = null, Renderable* hit = null, int cnt = 0)
	{
		auto init = (cast(Initiator)(this.init)).clone();
		fpnum totalDist = 0;

		for (size_t i = 0; i < max_number_of_steps; i++) //TODO: ray hit not correct
		{
			//calculate deflected ray
			Line newRay = integrateStep(cfgIntegrator, ray, param_step, init);

			fpnum m_dist = TraceBetweenPoints!(doP, doN, doO)(ray.origin,
					newRay.origin, didHit, hitpoint, hitnormal, hit);

			totalDist += m_dist;

			if (*didHit)
				return totalDist;

			ray = newRay;
		}
		return fpnum.infinity;
	}

	DebugDraw[string] returnDebugRenderObjects()
	{
		return (cast(Initiator) init).returnDebugRenderObjects();
	}

}

class AnalyticSkyBox : Analytic
{
	override fpnum TraceRay(Line ray, bool* didHit, Vectorf* hitpoint = null,
			Vectorf* hitnormal = null, Renderable* hit = null, int cnt = 0)
	{
		//ray.data = 1;
		return RaytraceI!(true, true, true)(ray, didHit, hitpoint, hitnormal, hit, cnt);
	}

	fpnum RaytraceI(bool doP, bool doN, bool doO)(Line ray, bool* didHit,
			Vectorf* hitpoint = null, Vectorf* hitnormal = null, Renderable* hit = null, int cnt = 0)
	{
		auto init = (cast(Initiator)(this.init)).clone();
		fpnum totalDist = 0;

		for (size_t i = 0; i < max_number_of_steps; i++) //TODO: ray hit not correct
		{
			//calculate deflected ray
			Line newRay = integrateStep(cfgIntegrator, ray, param_step, init);

			fpnum m_dist = super.TraceBetweenPoints!(doP, doN, doO)(ray.origin,
					newRay.origin, didHit, hitpoint, hitnormal, hit);

			totalDist += m_dist;

			if (*didHit)
				return totalDist;

			ray = newRay;
		}
		//max iterations exceded - time to shot the skybox :)
		fpnum m_dist = super.TraceBetweenPoints!(doP, doN, doO)(ray.origin,
				ray.origin + ray.direction * 1e9, didHit, hitpoint, hitnormal, hit);

		return m_dist;
	}
}
