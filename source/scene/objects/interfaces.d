module scene.objects.interfaces;

public import math.geometric;
public import math.vector;
public import scene.materials.material;
public import config;

interface Renderable
{
public:

	bool getIntersection(Line ray, out fpnum dist, out Vectorf normal);

	@property Material material();

	void getUVMapping(Vectorf point, out fpnum U, out fpnum V);
}
