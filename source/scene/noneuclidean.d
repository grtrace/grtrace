module scene.noneuclidean;

import config;
import core.time;
import std.concurrency;
import std.stdio, std.math;
import std.functional;
import math.vector;
import math.geometric;
import scene.objects.plane;
import math.matrix;
import image.memory;
import image.imgio;
import image.color;
import scene.camera;
import scene.objects.interfaces;
import scene.objects.sphere;
import scene.camera;
import core.cpuid;
import std.algorithm, std.array, std.string;
import std.random, std.getopt;
import scene.scenemgr;
import dbg.debugger;
private alias RPlane = scene.objects.plane.Plane;

class PlaneDeflectSpace : WorldSpace
{
	static shared(RPlane) pln;

	this()
	{
		string[] args = ["0"]~cfgSpaceConfig.split();
		getopt(args, std.getopt.config.passThrough);
		pln = cast(shared(RPlane))(new RPlane(null,math.Plane(vectorf(0,0,0),vectorf(0,0,-1))));
	}

	override protected RayFunc GetRayFunc()
	{
		return &DoRay;
	}
	
	private static Color NormalToColor(Vectorf N)
	{
		return Color( (N.x+1.0f)/2.0f, (N.y+1.0f)/2.0f, (N.z+1.0f)/2.0f );
	}
	
	protected static fpnum Raytrace(bool doP, bool doN, bool doO, bool doD)(Line ray, bool* didHit, Vectorf* hitpoint=null, Vectorf* hitnormal=null, Renderable* hit=null,int cnt=0)
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
		static if(doD)
		{
			RPlane def = cast(RPlane)(pln);
			if(def.getClosestIntersection(ray,dist,normal))
			{
				mdist = dist;
				static Vectorf newPos;
				static fpnum R;
				static fpnum Phi;
				static Vectorf axis;
				static Vectorf newDir;
				static math.Plane rpl;
				
				//calculate rotation plane
				rpl = PlanePoints(def.plane.origin, ray.origin, ray.origin+(ray.direction*100));
				
				//newPos contains the position of the ray intersection with the deflection plane
				newPos = ray.origin + ray.direction*mdist;

				//the distance from the point of closest aproach and the center of the black hole
				R = sqrt((*(ray.origin-def.plane.origin))*(*(newPos-def.plane.origin))/(*(ray.origin-newPos)));
				
				enum Mass = 1;

				//check if we had hit the event horizont
				if(R<=2*Mass)
				{
					VisualDebugger.SaveRay(ray, newPos);
					*didHit=false;
					return float.infinity;
				}
				
				//calculate the deflection angle
				Phi = 4.0*Mass/R;
				Phi = fmod(Phi,2*PI);
				axis = rpl.normal;
				axis.w = 0.0;
				newDir = Matrix4f.RotateV(axis.normalized,Phi,ray.direction).normalized;
				
				//check if we had rotated the ray.direction in the right way 
				fpnum tmp = 100;
				Vectorf a = ray.direction*tmp;
				Vectorf b = (a%(def.plane.origin-newPos)).normalized;
				Vectorf c = (a%(newDir*tmp)).normalized;
				
				bool inline = (1.0-(b*c))<eps;
				
				//if not rotate the ray,direction in the corect way
				if(!inline)
					newDir = Matrix4f.RotateV(axis.normalized,-Phi,ray.direction).normalized;
				
				//calculate new position
				//TODO: WTF

				Vectorf orthogonal = (newDir%rpl.normal);
				newPos = def.plane.origin - orthogonal*R;

				a = def.plane.origin-ray.origin;
				b = (a%(ray.direction*mdist)).normalized;
				c = (a%(newPos-ray.origin)).normalized;
				
				inline = (1.0-(b*c))<eps;

				if(!inline)
				{
					orthogonal = -(newDir%rpl.normal); 
					newPos = def.plane.origin - orthogonal*R;
				}

				//cast deflected ray
				VisualDebugger.SaveRay(ray, mdist);
				VisualDebugger.SaveRay(Line(ray.origin+ray.direction*mdist, (newPos-ray.origin-ray.direction*mdist).normalized, true), newPos);
				return Raytrace!(doP,doN,doO,false)(Line(newPos,newDir,true),didHit,hitpoint,hitnormal,hit,cnt+1);
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
	
	protected static Color Rayer(Line ray, int recnum, Color lastcol)
	{
		if(recnum>cfgMaxDepth)
		{
			return lastcol;
		}
		Color tmpc = lastcol;
		Vectorf rayhit;
		Vectorf normal;
		Renderable closest;
		bool hit=false;
		Raytrace!(true,true,true,true)(ray, &hit, &rayhit, &normal, &closest);
		if(hit)
		{
			tmpc = closest.material.emission_color;
			
			Color textureColor = Colors.White;
			
			if(closest.material.hasTexture())
			{
				fpnum U,V;
				closest.getUVMapping(rayhit, U, V);
				textureColor = closest.material.peekUV(U,V);
			}
			
			if(closest.material.is_diffuse)
			{
				Color diffuseColor = closest.material.diffuse_color;
				
				foreach(shared(Light) l;lights)
				{
					Line hitRay = LinePoints(rayhit,l.getPosition());
					hitRay.ray = true;
					bool unlit=false;
					fpnum dst = Raytrace!(false,false,false,false)(hitRay,&unlit);
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
			}
			tmpc *= textureColor;
		}
		return tmpc;
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
}
