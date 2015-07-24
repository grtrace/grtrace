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
			Vectorf orig; fpnum OXZ_deg_angle; fpnum OXY_deg_angle;
			
			getopt(a,std.getopt.config.caseSensitive , std.getopt.config.passThrough,
				"origin_x|x", &orig.x,
				"origin_y|y", &orig.y,
				"origin_z|z", &orig.z,
				"OXZ_deg_angle|a", &OXZ_deg_angle,
				"OXY_deg_angle|b", &OXY_deg_angle);
			plane = PlaneAngles(OXZ_deg_angle, OXY_deg_angle, orig);
		}
		else if(mode == 'v' || mode =='p')
		{
			Vectorf orig; Vectorf v1; Vectorf v2;
			
			getopt(a,std.getopt.config.caseSensitive , std.getopt.config.passThrough,
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
			else //mode p
				plane = PlanePoints(orig, v1, v2);
		}
		else
		{
			assert(0, "invalid rivateplane construction mode: "~cast(char)mode);
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
		B = ((A%plane.normal).normalized)*len2;
	}

	override void setupFromOptions(string[] a)
	{
		super.setupFromOptions(a);

		Vectorf first; Vectorf second;

		getopt(a,std.getopt.config.caseSensitive , std.getopt.config.passThrough,
			"tex_vector_first_x|A", &first.x,
			"tex_vector_first_y|B", &first.y,
			"tex_vector_first_z|C", &first.z,
			
			"tex_vector_second_x|D", &second.x,
			"tex_vector_second_y|E", &second.y,
			"tex_vector_second_z|F", &second.z,
			
			"tex_crd_first_u|G", &tex_a_u,
			"tex_crd_first_v|H", &tex_a_v,
			"tex_crd_second_u|I", &tex_d_u,
			"tex_crd_second_v|J", &tex_d_v);

		setCache(first, second);
	}

	override void getUVMapping(Vectorf point, out fpnum u, out fpnum v) const
	{
		Vectorf tmp = point-origin;

		fpnum U,V;

		U = (A*tmp)/(len2);
		U = fmod(U, 1.0);
		U = U*(tex_d_u-tex_a_u) + tex_a_u;

		V = (B*tmp)/(len2);
		V = fmod(V, 1.0);
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
		return super.toString()~format(" TO:%s TA:%s TB:%s TAU:%f TAV%f TBU:%f TBV%f", origin, A, B, tex_a_u,
			tex_a_v, tex_d_u, tex_d_v);
	}
}
