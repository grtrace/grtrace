module metric.grid;

import math;
import metric.interfaces;
import config;
import scene;

class Grid : DiscreteMetricContainer
{
	private Initiator init = null;
	//probingParam tells us that we will be getting probingParam^3 samples inside the given box;
	private AABB box; //TODO: for now we assume that box is a cube, better change that
	private size_t probingParam;

	private Metric4[] storage;

	void setProbingParam(size_t pP)
	{
		probingParam = pP;
		storage.length = (pP + 1) * (pP + 1) * (pP + 1);
	}

	void InitializeMetric()
	{
		for (size_t x = 0; x <= probingParam; x++)
			for (size_t y = 0; y <= probingParam; y++)
				for (size_t z = 0; z <= probingParam; z++)
				{
					Vectorf pos = vectorf(
						(cast(fpnum) x / cast(fpnum) probingParam) * (box.max.x - box.max.x) + box.min.x,
						(cast(fpnum) y / cast(fpnum) probingParam) * (box.max.y - box.max.y) + box.min.y,
						(cast(fpnum) z / cast(fpnum) probingParam) * (box.max.z - box.max.z) + box.min.z);

					init.prepareForRequest(pos);
					storage[x + y * probingParam + z * probingParam * probingParam] = init.getMetricAtPoint;

				}
	}

	@property ref Initiator initiator()
	{
		return init;
	}

	fpnum TraceRay(Line ray, bool* didHit, Vectorf* hitpoint = null,
		Vectorf* hitnormal = null, Renderable* hit = null, int cnt = 0)
	{
		assert(0);
	}

	fpnum Raytrace(bool doP, bool doN, bool doO, bool doD)(Line ray,
		bool* didHit, Vectorf* hitpoint = null, Vectorf* hitnormal = null,
		Renderable* hit = null, int cnt = 0)
	{
		//TODO:DO NOT USE
		//find the cube in with the ray origin is contained
		Vectorf tmp = ray.origin - box.min;

		//TODO:Dont forget to add the needed changes to the code below
		static if (doP)
		{
			static assert(doN);
		}
		fpnum dist, mdist;
		mdist = +fpnum.infinity;
		Vectorf normal, mnormal;
		Renderable H = null;
		bool dh = false;
		foreach (shared(Renderable) o; WorldSpace.objects)
		{
			Renderable O = cast(Renderable)(o);
			import std.math;

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
		VisualDebugger.SaveRay(ray, mdist);
		if (dh)
		{
			*didHit = true;
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
		return mdist;
	}
	
	DebugDraw[string] returnDebugRenderObjects() const
	{
		return null;
	}

}
