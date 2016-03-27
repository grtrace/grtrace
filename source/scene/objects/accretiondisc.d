module scene.objects.accretiondisc;

import scene.materials.blackbody;
import scene.objects.interfaces;
import scene.objects.plane;
import math.vector;
import math.geometric;
import scene.materials.material;
import config;
import scriptconfig;
import std.string, std.array, std.range, std.math, std.algorithm,
	std.uni;

class AccretionDisc : Renderable
{
	mixin RenderableNameHandler;
	protected Material accMaterial = null;
	private scene.Plane plane = null;
	private fpnum iRadius2 = 0.0, oRadius2 = 1.0;

	this()
	{
		accMaterial = new BlackBodyEmissionMaterial();
		plane = new scene.Plane();
	}

	void setupFromOptions(SValue[string] a)
	{
		iRadius2 = optFloat(a, "INNER", 0);
		oRadius2 = optFloat(a, "OUTER", 1);

		if (iRadius2 >= oRadius2)
			throw new Exception(
				"The accretion disc's inner radius must be smaller than his outer radius!");
		if (iRadius2 < 0)
			throw new Exception(
				"The accretion disc's inner radius must be greater or equal to zero");
		iRadius2 *= iRadius2;
		oRadius2 *= oRadius2;

		plane.setupFromOptions(a);
	}

	bool getClosestIntersection(Line ray, out fpnum dist, out Vectorf normal) const
	{
		if (plane.getClosestIntersection(ray, dist, normal))
		{
			Vectorf hitPoint = ray.origin + ray.direction * dist;
			fpnum toCenter = *(hitPoint - plane.plane.origin);
			if (toCenter < iRadius2 || toCenter > oRadius2)
			{
				return false;
			}
			else
			{
				return true;
			}
		}
		else
		{
			return false;
		}
	}

	@property ref Material material()
	{
		return accMaterial;
	}

	void getUVMapping(Vectorf point, out fpnum U, out fpnum V) const
	{
		//TODO: Temperature model
	}

	DebugDraw getDebugDraw()
	{
		return DebugDraw(DrawType.AccretionDisc, oRadius2, iRadius2, &plane.plane,
			null);
	}
}

class TexturedAccretionDisc : AccretionDisc
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
		super();
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

	private void setCache(Vectorf a, Vectorf b)
	{
		origin = a;
		A = b - a;
		len2 = (*A);
		B = ((A % plane.plane.normal).normalized) * len2.sqrt();
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
}
