module scene.objects.interfaces;

import math.geometric;
import math.vector;
import scene.materials.material;
import config;
import std.math;

interface Renderable
{
public:

	bool getClosestIntersection(Line ray, out fpnum dist, out Vectorf normal)
	in
	{
		assert(fabs(*ray.direction)<eps);
	}

	@property Material material();

	void getUVMapping(Vectorf point, out fpnum U, out fpnum V);
}
