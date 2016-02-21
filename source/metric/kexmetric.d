module metric.kexmetric;

import config;
import core.time;
import std.concurrency;
import std.stdio, std.math;
import std.functional;
import math;
import scene.objects.plane;
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
import dbg.dispatcher;
private alias RPlane = scene.objects.plane.Plane;

class KexMetric : WorldSpace
{
	static shared(RPlane) pln;

	enum fpnum Mass = 1;
	enum fpnum Rad = 2*Mass;

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

	static Metric4 getMetFromPoint(Vectorf p)
	{
		/*fpnum R = ~p;
		fpnum STh = sqrt(1.0-((p.z / R)^^2));
		fpnum rsr = Rad/R;
		return Metric4(Matrix4f(
				-1.0-rsr,0,0,0,
				0,-1.0/(1-rsr),0,0,
				0,0,-R*R,0,
				0,0,0,-R*R*STh*STh
				));*/
		return Metric4(Matrix4f(
				1,0,0,0,
				0,-1,0,0,
				0,0,-1,0,
				0,0,0,-1
				));
	}

	static Vectorf metCartToLocal(Vectorf v)
	{
		//fpnum R = ~v;
		//return vectorf(R, acos(v.z/R), atan2(v.y,v.x));
		return v;
	}

	static Vectorf metLocalToCart(Vectorf v)
	{
		//fpnum r = v.x;
		//return vectorf(r*sin(v.y)*cos(v.z),r*sin(v.y)*sin(v.z),r*cos(v.y));
		return v;
	}

	protected static fpnum Raytrace(bool doP, bool doN, bool doO, bool doD)(Line ray, bool* didHit, Vectorf* hitpoint=null, Vectorf* hitnormal=null, Renderable* hit=null,int cnt=0)
	{
		static if(doP)
		{
			static assert(doN);
		}
		if(cnt==1000)
		{
			*didHit = false;
			return fpnum.infinity;
		}
		if(~(ray.origin)<Rad)
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
		if(mdist>5.0)
		{
			/*FloatingPointControl fpc;
			fpc.enableExceptions(fpc.severeExceptions);*/
			Line newRay;
			newRay.origin= ray.origin + ray.direction*5.0;
			Metric4 M = getMetFromPoint(newRay.origin);
			Vectorf A,B;
			fpnum R = ~newRay.origin;
			auto bhrp = PlanePoints(vectorf(0,0,0), ray.origin, newRay.origin);
			A = metCartToLocal(ray.direction);
			B = metCartToLocal(ray.direction*5.0);
			fpnum da = A.mCosV(M,B);
			da *= DEG2RAD;
			writeln(da);
			newRay.direction = Matrix4f.RotateV(bhrp.normal,(-da),ray.direction);
			newRay.ray = true;
			DebugDispatcher.saveRay(ray, newRay.origin, RayDebugType.Default);
			return Raytrace!(doP,doN,doO,doD)(newRay,didHit,hitpoint, hitnormal,hit,cnt+1);
		}
		DebugDispatcher.saveRay(ray, mdist, RayDebugType.Default);
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
						//VisualDebugger.FoundLight(l.getPosition());
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
