module scene.objects.plane;

import scene.objects.interfaces;
import math.geometric;
import math.vector;
import scene.materials.material;
import grtrace;
import scriptconfig;
import std.string, std.array, std.range, std.math, std.algorithm, std.uni;

class Plane : Renderable
{
	mixin RenderableNameHandler;
	private Material mat;
	public math.Plane plane;

	this()
	{
	}

	this(Material m, math.Plane p)
	{
		mat = m;
		plane = p;
	}

	void setupFromOptions(SValue[string] a)
	{
		bool done = false;
		if ("OXZDEGREES" in a)
		{
			done = true;

			Vectorf origin = optVec3(a, "ORIGIN");
			fpnum OXZ_deg_angle = optFloat(a, "OXZDEGREES");
			fpnum OXY_deg_angle = optFloat(a, "OXYDEGREES");
			plane = PlaneAngles(OXZ_deg_angle, OXY_deg_angle, origin);
		}
		if ("POINT1" in a)
		{
			if (done)
				throw new Exception("Multiple plane construction modes used!");
			done = true;
			Vectorf p1, p2, p3;
			p1 = optVec3(a, "POINT1");
			p2 = optVec3(a, "POINT2");
			p3 = optVec3(a, "POINT3");
			plane = PlanePoints(p1, p2, p3);
		}
		if ("DIR1" in a)
		{
			if (done)
				throw new Exception("Multiple plane construction modes used!");
			done = true;
			Vectorf origin, d1, d2;
			origin = optVec3(a, "ORIGIN");
			d1 = optVec3(a, "DIR1");
			d2 = optVec3(a, "DIR2");
			plane = PlaneVectors(origin, d1, d2);
		}
		if (!done)
		{
			throw new Exception("Plane not constructed!");
		}
	}

	bool getClosestIntersection(Line ray, out fpnum dist, out Vectorf normal) const
	{
		return .getClosestIntersection(plane, ray, dist, normal);
	}

	@property ref Material material()
	{
		return mat;
	}

	void getUVMapping(Vectorf point, out fpnum U, out fpnum V) const
	{
		//assert(0, "For texturable plane use TexturablePlane");
		U = V = 0;
	}

	DebugDraw getDebugDraw()
	{
		return DebugDraw(DrawType.Plane, 0, 0, &this.plane, null);
	}

	override string toString()
	{
		return format("O:%s N:%s M:%s", plane.origin, plane.normal, mat);
	}
}

bool getClosestIntersection(math.Plane plane, Line ray, out fpnum dist, out Vectorf normal)
{
	fpnum B = plane.normal * ray.direction;
	if (B == 0)
		return false;

	double t1 = (plane.normal * (plane.origin - ray.origin)) / B;

	if (!ray.ray || t1 > eps)
	{
		dist = t1;
		if (B < 0.0)
			normal = plane.normal;
		else
			normal = -plane.normal;

		return true;
	}
	else
		return false;
}

class TexturablePlane : Plane
{
	private Vectorf origin;
	private Vectorf A;
	private Vectorf B;

	bool texture_single = false;

	fpnum tex_a_u;
	fpnum tex_a_v;
	fpnum tex_d_u;
	fpnum tex_d_v;

	private fpnum len2;

	this()
	{
	}

	this(Material m, math.Plane p, Vectorf a, Vectorf b, fpnum a_u, fpnum a_v, fpnum d_u, fpnum d_v)
	in
	{
		assert(a_u < d_u);
		assert(a_v < d_v);
	}
	do
	{
		super(m, p);

		tex_a_u = a_u;
		tex_a_v = a_v;
		tex_d_u = d_u;
		tex_d_v = d_v;

		setCache(a, b);
	}

	private void setCache(Vectorf a, Vectorf b)
	{
		origin = a;
		A = b - a;
		len2 = (*A);
		B = ((A % plane.normal).normalized) * len2.sqrt();
	}

	override void setupFromOptions(SValue[string] a)
	{
		super.setupFromOptions(a);
		Vectorf udir, vdir;
		SVec2 uv1, uv2;
		fpnum repeatMode;

		udir = optVec3(a, "UDIR");
		vdir = optVec3(a, "VDIR");
		uv1 = optVec2(a, "UV1");
		uv2 = optVec2(a, "UV2");
		repeatMode = optFloat(a, "UVREPEAT", 1);
		texture_single = (repeatMode <= 0);
		tex_a_u = uv1.x;
		tex_d_u = uv2.x;
		tex_a_v = uv1.y;
		tex_d_v = uv2.y;
		setCache(udir, vdir);
	}

	static fpnum fxmod(fpnum A, fpnum M)
	{
		A = fmod(A, M);
		if (A < 0.0)
		{
			A += M;
		}
		return A;
	}

	override void getUVMapping(Vectorf point, out fpnum u, out fpnum v) const
	{
		Vectorf tmp = point - origin;

		fpnum U, V;

		U = (A * tmp) / (len2);
		U = (texture_single) ? clamp(U, 0.0, 1.0) : fxmod(U, 1.0);
		U = U * (tex_d_u - tex_a_u) + tex_a_u;

		V = (B * tmp) / (len2);
		V = (texture_single) ? clamp(V, 0.0, 1.0) : fxmod(V, 1.0);
		V = V * (tex_d_v - tex_a_v) + tex_a_v;

		if (U < 0)
			U = 1.0 + U;
		if (V < 0)
			V = 1.0 + V;
		u = U;
		v = V;
		//import std.stdio;writeln(U,"\t",V);

	}

	override string toString()
	{
		return super.toString() ~ format(" TO:%s TA:%s TB:%s TAU: %f TAV %f TBU: %f TBV %f",
				origin, A, B, tex_a_u, tex_a_v, tex_d_u, tex_d_v);
	}
}
