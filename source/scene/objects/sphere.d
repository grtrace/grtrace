module scene.objects.sphere;

import scene.objects.interfaces;
import math.geometric;
import math.vector;
import scene.materials.material;
import config;
import std.math;
import std.getopt, std.string;

class Sphere : Renderable
{
	private Material mat;
	private Vectorf center;
	private fpnum radius;

	this()
	{
	}

	this(Vectorf cente, fpnum rad)
	{
		center = cente;
		radius = rad;
	}

	void setupFromOptions(string[] a)
	{
		fpnum x,y,z;
		getopt(a,std.getopt.config.caseSensitive,
			"x",&x,
			"y",&y,
			"z",&z,
			"radius|r",&radius);
		center = vectorf(x,y,z);
	}

	bool getClosestIntersection(Line ray, out fpnum dist, out Vectorf normal) const
	{
		Vectorf o = ray.origin - center;
		
		fpnum B = 2.0*(ray.direction*o);
		fpnum C = (*o) - radius*radius;
		
		fpnum Det = B*B - 4*C;
		
		if(Det>=0)
		{
			Det = sqrt(Det);
			fpnum t1 = (-B - Det)/2;
			fpnum t2 = (-B + Det)/2;
			
			if(ray.ray)
			{
				if(t2<eps) return false;
				else if(t1<eps)
				{
					t1 = t2;
				}
			}
			else
			{
				if(fabs(t1) > fabs(t2)) t1 = t2;
			}
			
			dist = t1;
			Vectorf point = ray.direction*t1 + o;
			point = point*(1.0/radius);
			
			normal = point;
			
			return true;
			
		}
		else return false;
	}
	
	@property ref Material material()
	{
		return mat;
	}
	
	void getUVMapping(Vectorf point, out fpnum U, out fpnum V) const
	{
		Vectorf d = (center - point).normalized;
		U = 0.5 + atan2(d.z, d.x)/2*PI;
		V = 0.5 - asin(d.y)/PI;
	}

	override string toString() 
	{
		return format("C:%s R:%f M:%s", center, radius, mat);
	}

}
