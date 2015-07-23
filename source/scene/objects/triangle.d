module scene.objects.triangle;

import scene.objects.interfaces;
import math.geometric;
import math.vector;
import scene.materials.material;
import config;
import std.math;
static import scene.objects.plane;

class Triangle : Renderable
{
	private immutable Material mat;
	private math.Triangle triangle;

	this(Material m, math.Triangle tr)
	{
		mat = m;
		triangle = tr;
	}

	bool getClosestIntersection(Line ray, out fpnum dist, out Vectorf normal) const
	{
		if (scene.objects.plane.getClosestIntersection(triangle.plane, ray, dist, normal))
		{
			Vectorf InsertPoint = ray.direction*dist + ray.origin;
			
			InsertPoint = InsertPoint - triangle.plane.origin;
			
			//in this moment InsertPoint, triangle.b, triangle.c are
			//translated to a cordinate system with origin at triangle.plane.origin
			
			//this is the data needed for finding barycentric cordinates for InsertPoint
			double d1, d2, d3, d4, d5, u, v;
			d1 = triangle.c*triangle.c;
			d2 = triangle.c*triangle.b;
			d3 = triangle.c*InsertPoint;
			d4 = triangle.b*triangle.b;
			d5 = triangle.b*InsertPoint;
			
			//calculation of barycentric cordinates for InsertPoint
			double invD = 1 / ((d1 * d4) - (d2 * d2));
			u = ((d4 * d3) - (d2 * d5)) * invD;
			v = ((d1 * d5) - (d2 * d3)) * invD;
			
			//checking whether InsertPoint is inside this triangle or not
			if ((u >= 0) && (v >= 0) && ((u + v) <= 1))
				return true;
			else 
				return  false;
		}
		else 
			return false;
	}

	@property Material material() const
	{
		return mat;
	}
	
	void getUVMapping(Vectorf point, out fpnum U, out fpnum V) const
	{
		assert(0);
	}
}
