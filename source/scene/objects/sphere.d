module scene.objects.sphere;

import scene.objects.interfaces;
import math.geometric;
import math.vector;
import scene.materials.material;
import config;
import std.math;

class Sphere : Renderable
{
	private immutable Material mat;
	private Vectorf center;
	private fpnum radius;

	this(Vectorf cente, fpnum rad)
	{
		center = cente;
		radius = rad;
		mat = Material();
	}

	bool getClosestIntersection(Line ray, out fpnum dist, out Vectorf normal)
	{
		Vectorf o = ray.origin - center;

		double B = 2*(ray.direction*o);
		double C = (o*o) - radius*radius;

		double Det = B*B - 4*C;

		if(Det>=0)
		{
			Det = sqrt(Det);
			double t1 = (-B - Det)/2;
			double t2 = (-B + Det)/2;

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
			point = point*(1/radius);
			
			normal = point; // wektor normalny do punktu przeciecia
			
			return true;
			
		}
		else return false;
	}
	
	@property Material material()
	{
		return mat;
	}
	
	void getUVMapping(Vectorf point, out fpnum U, out fpnum V)
	{
		assert(0, "NIY");
	}

}
