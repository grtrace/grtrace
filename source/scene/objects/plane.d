module scene.objects.plane;

import scene.objects.interfaces;
import math.geometric;
import math.vector;
import scene.materials.material;
import config;
import scriptconfig;
import std.string, std.getopt, std.array, std.range, std.math, std.algorithm, std.uni;

class Plane : Renderable
{
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

	void setupFromOptions(string[] a)
	{
		string mat_name;
		dchar mode;

		getopt(a,std.getopt.config.passThrough, std.getopt.config.caseSensitive,
			"construction|c", &mode);

		mode = toLower(mode);

		if(mode == 'a')
		{
			string origStr; fpnum OXZ_deg_angle; fpnum OXY_deg_angle;
			
			getopt(a,std.getopt.config.caseSensitive , std.getopt.config.passThrough,
				"origin|o", &origStr,
				"OXZ_deg_angle|a", &OXZ_deg_angle,
				"OXY_deg_angle|b", &OXY_deg_angle);
			plane = PlaneAngles(OXZ_deg_angle, OXY_deg_angle, vectorString(origStr));
		}
		else if(mode == 'v' || mode =='p')
		{
			string origStr; string vStr1; string vStr2;
			
			getopt(a,std.getopt.config.caseSensitive , std.getopt.config.passThrough,
				"origin|o", &origStr,
				"first|f", &vStr1,
				"second|s", &vStr2);

			if(mode == 'v')
				plane = PlaneVectors(vectorString(origStr), vectorString(vStr1), vectorString(vStr2));
			else //mode p
				plane = PlanePoints(vectorString(origStr), vectorString(vStr1), vectorString(vStr2));
		}
		else
		{
			throw new Exception("Invalid plane construction mode: "~cast(char)mode);
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
		U=V=0;
	}

	DebugDraw getDebugDraw()
	{
		return DebugDraw(DrawType.Plane, 0, &this.plane, null);
	}

	override string toString()
	{
		return format("O:%s N:%s M:%s", plane.origin, plane.normal, mat);
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
	private Vectorf origin;
	private Vectorf A;
	private Vectorf B;

	bool texture_single=false;

	fpnum tex_a_u; fpnum tex_a_v;
	fpnum tex_d_u; fpnum tex_d_v;


	private fpnum len2;

	this()
	{
	}

	this(Material m, math.Plane p, Vectorf a, Vectorf b, fpnum a_u, fpnum a_v, fpnum d_u, fpnum d_v)
	in
	{
		assert(a_u<d_u);
		assert(a_v<d_v);
	}
	body
	{
		super(m, p);

		tex_a_u = a_u;
		tex_a_v = a_v;
		tex_d_u = d_u;
		tex_d_v = d_v;

		setCache(a,b);
	}

	private void setCache(Vectorf a, Vectorf b)
	{
		origin = a;
		A = b-a;
		len2 = (*A);
		B = ((A%plane.normal).normalized)*len2.sqrt();
	}

	override void setupFromOptions(string[] a)
	{
		super.setupFromOptions(a);

		string firstStr; string secondStr;

		getopt(a,std.getopt.config.caseSensitive , std.getopt.config.passThrough,
			"tex_vector_first|F", &firstStr,
			"tex_vector_second|S", &secondStr,

			"tex_crd_first_u|G", &tex_a_u,
			"tex_crd_first_v|H", &tex_a_v,
			"tex_crd_second_u|I", &tex_d_u,
			"tex_crd_second_v|J", &tex_d_v,
			"tex_single|Q", &texture_single);

		setCache(vectorString(firstStr), vectorString(secondStr));
	}
	
	static fpnum fxmod(fpnum A, fpnum M)
	{
		A = fmod(A,M);
		if(A<0.0){A+=M;}
		return A;
	}
	
	override void getUVMapping(Vectorf point, out fpnum u, out fpnum v) const
	{
		Vectorf tmp = point-origin;

		fpnum U,V;

		U = (A*tmp)/(len2);
		U = (texture_single)?clamp(U,0.0,1.0):fxmod(U, 1.0);
		U = U*(tex_d_u-tex_a_u) + tex_a_u;

		V = (B*tmp)/(len2);
		V = (texture_single)?clamp(V,0.0,1.0):fxmod(V, 1.0);
		V = V*(tex_d_v-tex_a_v) + tex_a_v;

		if(U<0)
			U = 1.0+U;
		if(V<0)
			V = 1.0+V;
		u=U;
		v=V;
		//import std.stdio;writeln(U,"\t",V);

	}

	override string toString()
	{
		return super.toString()~format(" TO:%s TA:%s TB:%s TAU: %f TAV %f TBU: %f TBV %f", origin, A, B, tex_a_u,
			tex_a_v, tex_d_u, tex_d_v);
	}
}
