module scene.objects.triangle;

import scene.objects.interfaces;
import math.geometric;
import math.vector;
import scene.materials.material;
import config;
import scriptconfig;
import std.math;
static import scene.objects.plane;
import std.string, std.getopt, std.array, std.range, std.math, std.algorithm;

class Triangle : Renderable
{
	mixin RenderableNameHandler;
	private Material mat;
	private math.Triangle triangle;

	this()
	{
	}

	this(Material m, math.Triangle tr)
	{
		mat = m;
		triangle = tr;
	}

	void setupFromOptions(string[] a)
	{
		string A; string B; string C;

		getopt(a, 
			std.getopt.config.passThrough,
			std.getopt.config.caseSensitive,

			"first|a", &A,
			"second|b", &B,
			"third|c", &C);

		triangle = TrianglePoints(vectorString(A), vectorString(B), vectorString(C));
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
			fpnum d1, d2, d3, d4, d5, u, v;
			d1 = triangle.c*triangle.c;
			d2 = triangle.c*triangle.b;
			d3 = triangle.c*InsertPoint;
			d4 = triangle.b*triangle.b;
			d5 = triangle.b*InsertPoint;

			//calculation of barycentric cordinates for InsertPoint
			fpnum invD = 1 / ((d1 * d4) - (d2 * d2));
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

	@property ref Material material()
	{
		return mat;
	}
	
	void getUVMapping(Vectorf point, out fpnum U, out fpnum V) const
	{
		// Compute barycentric coordinates (u, v, w) for
		// point p with respect to triangle (a, b, c)

		Vectorf v0 = triangle.b - triangle.plane.origin;
		Vectorf v1 = triangle.c - triangle.plane.origin;
		Vectorf v2 = point - triangle.plane.origin;
		fpnum d00 = v0*v0;
		fpnum d01 = v0*v1;
		fpnum d11 = v1*v1;
		fpnum d20 = v2*v0;
		fpnum d21 = v2*v1;
		fpnum denom = 1/ (d00 * d11 - d01 * d01);
		fpnum v = (d11 * d20 - d01 * d21) * denom;
		fpnum w = (d00 * d21 - d01 * d20) * denom;
		fpnum u = 1.0f - v - w;

		//(U,V)
		//a=(0,0), b=(1,0), c=(0,1)
		U = v;
		V = w;
	}

	override string toString() 
	{
		return format("A:%s B:%s C:%s N:%s M:%s", 
			triangle.plane.origin, triangle.b, triangle.c,
			triangle.plane.normal, mat);
	}

	DebugDraw getDebugDraw()
	{
		return DebugDraw(DrawType.Triangle, 0, 0, null, &this.triangle);
	}
}

class TexturableTriangle : Triangle
{
	private fpnum tex_u_a; private fpnum tex_v_a;
	private fpnum tex_u_b; private fpnum tex_v_b;
	private fpnum tex_u_c; private fpnum tex_v_c;

	struct Cached
	{
		fpnum d00;
		fpnum d01;
		fpnum d11;
		fpnum denom;
	}

	Cached cached;

	this()
	{
	}

	this(Material m, math.Triangle tr, fpnum U_a, fpnum V_a, fpnum U_b, fpnum V_b, fpnum U_c, fpnum V_c)
	{
		super(m, tr);

		tex_u_a = U_a; tex_v_a = V_a;
		tex_u_b = U_b; tex_v_b = V_b;
		tex_u_c = U_c; tex_v_c = V_c;

		setCache();
	}

	private void setCache()
	{
		Vectorf v0 = triangle.b - triangle.plane.origin;
		Vectorf v1 = triangle.c - triangle.plane.origin;
		
		cached = Cached(
			v0*v0,
			v0*v1,
			v1*v1,
			1/ ((v0*v0) * (v1*v1) - (v0*v1) * (v0*v1)));
	}

	override void setupFromOptions(string[] a)
	{
		super.setupFromOptions(a);
		getopt(a, std.getopt.config.caseSensitive,
			"texture_a_u|a", &tex_u_a,
			"texture_a_v|A", &tex_v_a,

			"texture_b_u|b", &tex_u_b,
			"texture_b_v|B", &tex_v_b,

			"texture_c_u|c", &tex_u_c,
			"texture_c_v|C", &tex_v_c);

		setCache();
	}

	override void getUVMapping(Vectorf point, out fpnum U, out fpnum V) const
	{
		// Compute barycentric coordinates (u, v, w) for
		// point p with respect to triangle (a, b, c)
		Vectorf v0 = triangle.b - triangle.plane.origin;
		Vectorf v1 = triangle.c - triangle.plane.origin;
		Vectorf v2 = point - triangle.plane.origin;

		fpnum d20 = v2*v0;
		fpnum d21 = v2*v1;

		fpnum v = (cached.d11 * d20 - cached.d01 * d21) * cached.denom;
		fpnum w = (cached.d00 * d21 - cached.d01 * d20) * cached.denom;
		fpnum u = 1.0f - v - w;
		
		U = tex_u_a*u + tex_u_b*v + tex_u_c*w;
		V = tex_v_a*u + tex_v_b*v + tex_v_c*w;
		
	}

	override string toString()
	{
		return super.toString()~format("TAU: %f TAV: %f TBU: %f TBV: %f TCU: %f TCV: %f", 
			tex_u_a, tex_v_a, 
			tex_u_b, tex_v_b, 
			tex_u_c, tex_v_c);
	}
}
