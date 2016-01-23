module scene.objects.accretiondisc;

import scene.materials.blackbody;
import scene.objects.interfaces;
import math.geometric;
import math.vector;
import scene.materials.material;
import config;
import scriptconfig;
import std.string, std.getopt, std.array, std.range, std.math, std.algorithm, std.uni;

class AccretionDisc : Renderable
{
	Material accMaterial;
	Vectorf centerPoint = vectorf(0,0,0);
	fpnum iRadius = 0.0, oRadius = 1.0;
	Vectorf normal = vectorf(0,1,0);
	
	void setupFromOptions(string[] a)
	{
		accMaterial = new BlackBodyEmissionMaterial();
		fpnum cpx = 0.0, cpy = 0.0, cpz = 0.0;
		fpnum nx = 0.0, ny = 0.0, nz = 0.0;
		getopt(a, 
			"x", &cpx,
			"y", &cpy,
			"z", &cpz,
			"n", &nx,
			"o", &ny,
			"p", &nz,
			"ir", &iRadius,
			"or", &oRadius);
		centerPoint = vectorf(cpx,cpy,cpz);
		normal = vectorf(nx,ny,nz).normalized();
	}

	bool getClosestIntersection(Line ray, out fpnum dist, out Vectorf normal) const
	{
		return false;
	}

	@property ref Material material()
	{
		return accMaterial;
	}

	void getUVMapping(Vectorf point, out fpnum U, out fpnum V) const
	{
		
	}

	DebugDraw getDebugDraw()
	{
		return DebugDraw(DrawType.None);
	}
}
