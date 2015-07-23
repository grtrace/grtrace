module scene.objects.plane;

import scene.objects.interfaces;
import math.geometric;
import math.vector;
import scene.materials.material;
import config;

class Plane : Renderable
{
	private immutable Material mat;
	private math.Plane plane;

	this(Material m, math.Plane p)
	{
		mat = m;
		plane = p;
	}

	bool getClosestIntersection(Line ray, out fpnum dist, out Vectorf normal) const
	{
		return .getClosestIntersection(plane, ray, dist, normal);
	}
	
	@property Material material() const
	{
		return mat;
	}
	
	void getUVMapping(Vectorf point, out fpnum U, out fpnum V) const
	{
		assert(0, "NIY");
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
