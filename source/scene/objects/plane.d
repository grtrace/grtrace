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

		getopt(a,std.getopt.config.passThrough,
			"material|m", &mat_name,
			"construction|c", &mode);

		mat = cfgMaterials[mat_name];
		mode = toLower(mode);

		if(mode == 'a')
		{
			Vectorf orig; fpnum OXZ_deg_angle; fpnum OXY_deg_angle;
			
			getopt(a,
				"origin_x|x", &orig.x,
				"origin_y|y", &orig.y,
				"origin_z|z", &orig.z,
				"OXZ_deg_angle|a", &OXY_deg_angle,
				"OXY_deg_angle|b", &OXY_deg_angle);
			
			plane = PlaneAngles(OXZ_deg_angle, OXY_deg_angle, orig);
		}
		else if(mode == 'v' || mode =='p')
		{
			Vectorf orig; Vectorf v1; Vectorf v2;
			
			getopt(a,
				"first_x|a", &orig.x,
				"first_y|b", &orig.y,
				"first_z|c", &orig.z,
				
				"second_x|d", &v1.x,
				"second_y|e", &v1.y,
				"second_z|f", &v1.z,
				
				"third_x|g", &v2.x,
				"third_y|h", &v2.y,
				"third_z|i", &v2.z);

			if(mode == 'v')
				plane = PlaneVectors(orig, v1, v2);
			else
				plane = PlanePoints(orig, v1, v2);
		}
		else
		{
			assert(0, "invalid plane construction mode: "~cast(char)mode);
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
		assert(0, "NIY");
	}
}
