module metric.analitic;

import metric.interfaces;
import math;

class Analitic : AnaliticMetricContainer
{
	Initiator!Matrix4f initiator = null;

	@property Initiator!Matrix4f getInitiator()
	{
		return initiator;
	}
	
	@property void setInitiator(Initiator!Matrix4f init)
	{
		initiator = init;
	}

	fpnum Raytrace(bool doP, bool doN, bool doO)(Line ray, bool* didHit, Vectorf* hitpoint=null, Vectorf* hitnormal=null, Renderable* hit=null)
	{
		static if(doP)
		{
			static assert(doN);
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
