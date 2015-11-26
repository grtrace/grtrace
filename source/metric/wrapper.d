module metric.wrapper;

import metric.interfaces;
import scene;
import math;
import std.concurrency;
import config;
import image;
import std.algorithm;
import dbg.debugger;

class WorldSpaceWrapper : WorldSpace
{
	static shared MetricContainer smetric;

	this(MetricContainer met)
	{
		smetric = cast(shared(MetricContainer))met;
	}

	override protected RayFunc GetRayFunc()
	{
		return &DoRay;
	}

	public static Color DoRay(Tid owner, Line ray, unum x, unum y, int tnum)
	{
		Color outc = Rayer(ray, 0, Colors.Black);
		float mx = max(outc.r, outc.g, outc.b);
		if(mx>1.0f)
		{
			outc = outc / mx;
		}
		return outc;
	}

	protected static Color Rayer(Line ray, int recnum, Color lastcol)
	{
		if(recnum>cfgMaxDepth)
		{
			return lastcol;
		}
		auto metric = cast(MetricContainer)(smetric);
		Color tmpc = lastcol;
		Vectorf rayhit;
		Vectorf normal;
		Renderable closest;
		bool hit=false;

		metric.TraceRay(ray, &hit, &rayhit, &normal, &closest, 0);

		if(hit)
		{
			if(closest.material)
			{
				tmpc = closest.material.emission_color;
				
				Color textureColor = Colors.White;
				
				if(closest.material.hasTexture())
				{
					fpnum U,V;
					closest.getUVMapping(rayhit, U, V);
					textureColor = closest.material.peekUV(U,V);
				}

				//TODO:lightning not supported yet
				/*if(closest.material.is_diffuse)
				{
					Color diffuseColor = closest.material.diffuse_color;
					
					foreach(shared(Light) l;lights)
					{
						Line hitRay = LinePoints(rayhit,l.getPosition());
						hitRay.ray = true;
						bool unlit=false;
						//fpnum dst = Raytrace!(false,false,false)(hitRay,&unlit);
						if(unlit)
						{
							fpnum dLO = *(l.getPosition()-rayhit);
							if(dLO<(dst*dst))
							{
								unlit = false;
							}
						}
						if(unlit==false) // lit
						{
							VisualDebugger.FoundLight(l.getPosition());
							fpnum DP = normal*(hitRay.direction);
							if(DP>0)
								tmpc = tmpc + diffuseColor*l.getColor()*(DP);
						}
					}
				}*/
				tmpc *= textureColor;
			}
			else
			{
				tmpc = Colors.Magenta;
			}
		}
		if(hit)tmpc=Colors.Green;
		else tmpc=Colors.Red;
		return tmpc;
	}
}
