module scene.objects.plane;

import scene.objects.interfaces;

class Plane : Renderable
{
private:
	immutable Material mat;
	math.Plane plane;
public:

	this(Material m, math.Plane p)
	{
		mat = m;
		plane = p;
	}

	bool getIntersection(Line ray, out fpnum dist, out Vectorf normal)
	{
		fpnum B = plane.normal*ray.direction;
		if(B == 0) return false;
		
		double t1 = (plane.normal*(plane.origin-ray.origin))/B;
		
		if(t1 > eps)
		{
			dist = t1;
			if(B<0.0) normal = plane.normal;
			else normal = -plane.normal;
			
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
		assert(0);
	}
}
