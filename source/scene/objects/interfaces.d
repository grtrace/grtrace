module scene.objects.interfaces;

import math.geometric;
import math.matrix;
import math.vector;
import scene.materials.material;
import config;
import std.math;
import image.color;
import scriptconfig;
public import dbg.draws;
import std.typecons;
import std.variant;

/// Script primitives
public
{
	alias SFloat = Typedef!(fpnum, 0.0, "float");
	alias SWave = Typedef!(fpnum, 0.0, "wave");
	struct SVec2
	{
		fpnum x = 0.0, y = 0.0;
	}

	alias SVec3 = Vectorf;
	alias SMat4 = Matrix4f;
	alias SColor = Color;
	alias SString = string;
	alias STexture = Typedef!(string, "", "texture");
	alias SValue = Algebraic!(SFloat, SWave, SVec2, SVec3, SMat4, SColor, SString,
		STexture);

	Vectorf optVec3(SValue[string] map, string key, lazy Vectorf def = Vectorf(0, 0,
		0))
	{
		if (key in map)
		{
			return cast(Vectorf)((key in map).get!(SVec3));
		}
		else
		{
			return def;
		}
	}

	Matrix4f optMat4(SValue[string] map, string key, lazy Matrix4f def = Matrix4f.Zero())
	{
		if (key in map)
		{
			return cast(Matrix4f)((key in map).get!(SMat4));
		}
		else
		{
			return def;
		}
	}

	fpnum optFloat(SValue[string] map, string key, lazy fpnum def = 0.0)
	{
		if (key in map)
		{
			return cast(fpnum)((key in map).get!(SFloat));
		}
		else
		{
			return def;
		}
	}
}

template RenderableNameHandler()
{
	shared(string) name_;

	string getName() nothrow const
	{
		return cast(string) name_;
	}

	void setName(string nm) nothrow
	{
		name_ = cast(shared(string))(nm.idup);
	}
}

interface Renderable
{
	void setupFromOptions(string[] a);

	string getName() nothrow const;
	void setName(string nm) nothrow;

	bool getClosestIntersection(Line ray, out fpnum dist, out Vectorf normal) const;

	@property ref Material material();

	void getUVMapping(Vectorf point, out fpnum U, out fpnum V) const;

	DebugDraw getDebugDraw();
}

interface Light
{
	void setupFromOptions(string[] a);
	Vectorf getPosition();
	Color getColor();
	Vectorf getPosition() shared;
	Color getColor() shared;
	string getName() nothrow const;
	void setName(string nm) nothrow;
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

	string getName() nothrow const
	{
		return object.getName;
	}

	void setName(string nm) nothrow
	{
		object.setName(nm);
	}

	void setupFromOptions(string[] a)
	{
		object.setupFromOptions(a);
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
		Line local_ray = invTransform * ray;

		bool res = object.getClosestIntersection(local_ray, dist, normal);

		if (!res)
			return false;

		//transform results to globalSpace
		normal = transform * normal;

		Vectorf hitPoint = local_ray.direction * dist + local_ray.origin;

		hitPoint = transform * hitPoint;
		hitPoint = hitPoint - ray.origin;

		dist = ~hitPoint;

		return true;
	}

	@property ref Material material()
	{
		return object.material;
	}

	void getUVMapping(Vectorf point, out fpnum U, out fpnum V) const
	{
		//calculate U,V values in localSpace
		object.getUVMapping(invTransform * point, U, V);
	}

	DebugDraw getDebugDraw()
	{
		return object.getDebugDraw();
	}
}
