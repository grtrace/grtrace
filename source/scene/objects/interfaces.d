module scene.objects.interfaces;

import math.geometric;
import math.matrix;
import math.vector;
import scene.materials.material;
import config;
import std.math;

interface Renderable
{
public:

	void setupFromOptions(string[] a);

	bool getClosestIntersection(Line ray, out fpnum dist, out Vectorf normal) const
	in
	{
		assert(fabs(*ray.direction)<eps);
	}

	@property Material material();

	void getUVMapping(Vectorf point, out fpnum U, out fpnum V) const;
}


class Transformed : Renderable
{
	protected Renderable object;
	private Matrix4f transform;
	private Matrix4f invTransform;

	this(Renderable obj, Matrix4f tr = Matrix4f.Identity)
	{
		object = obj;
		transform = tr;
		invTransform = tr.inverse;
	}

	void setupFromOptions(string[] a)
	{

	}

	Matrix4f getTransform()
	{
		return transform;
	}

	void setTransform(Matrix4f tr)
	{
		transform = tr;
		invTransform = tr.inverse;
	}

	bool getClosestIntersection(Line ray, out fpnum dist, out Vectorf normal) const
	{
		//transform ray to localSpace
		Line local_ray = invTransform*ray;

		bool res = object.getClosestIntersection(local_ray, dist, normal);

		if(!res) return false;

		//transform results to globalSpace
		normal = transform*normal;

		Vectorf hitPoint = local_ray.direction*dist + local_ray.origin;

		hitPoint = transform*hitPoint;
		hitPoint = hitPoint - ray.origin;

		dist = ~hitPoint;

		return true;
	}
	
	@property Material material()
	{
		return object.material;
	}

	void getUVMapping(Vectorf point, out fpnum U, out fpnum V) const
	{
		//calculate U,V values in localSpace
		object.getUVMapping(invTransform*point, U, V);
	}
}
