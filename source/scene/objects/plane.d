module scene.objects.plane;

import scene.objects.interfaces;
import math.geometric;
import math.vector;
import scene.materials.material;
import config;
import std.string, std.getopt, std.array, std.range, std.math, std.algorithm, std.uni;

class Plane : Renderable
{
	private Material mat;
	private math.Plane plane;

	this()
	{
	}

	this(Material m, math.Plane p)
	{
		mat = m;
		plane = p;
	}

	void setupFromOptions(string[] a)
	{
		string mat_name;
		dchar mode;

		getopt(
			a,std.getopt.config.passThrough,
			"material|m", &mat_name,
			"construction|c", &mode);

		//FIXME:mat = cfgMaterials[mat_name];
		mode = toLower(mode);

		switch(mode)
		{
			case 'a':
				Vectorf orig;

				getopt(a,
					"origin_x|x", &orig.x,
					"origin_y|y", &orig.y,
					"origin_z|z", &orig.z);
				break;
			case 'v':
				break;
			case 'p':
				break;
			default: 
				assert(0);
		}
	}

	bool getClosestIntersection(Line ray, out fpnum dist, out Vectorf normal) const
	{
		return .getClosestIntersection(plane, ray, dist, normal);
	}
	
	@property Material material()
	{
		return mat;
	}
	
	void getUVMapping(Vectorf point, out fpnum U, out fpnum V) const
	{
		assert(0, "For texturable plane use TexturablePlane");
	}
}

bool getClosestIntersection(math.Plane plane, Line ray, out fpnum dist, out Vectorf normal)
{
	fpnum B = plane.normal*ray.direction;
	if(B == 0) return false;
	
	double t1 = (plane.normal*(plane.origin-ray.origin))/B;
	
	if(!ray.ray || t1 > eps)
	{
		dist = t1;
		if(B<0.0) normal = plane.normal;
		else normal = -plane.normal;
		
		return true;
	}
	else return false;
}

class TexturablePlane : Plane
{
	this()
	{
	}

	this(Material m, math.Plane p)
	{
		super(m, p);
	}

	override void setupFromOptions(string[] a)
	{
		assert(0);
	}
}
