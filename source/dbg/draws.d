module dbg.draws;

import math;
import image;

enum DrawType
{
	None,
	AccretionDisc,
	Sphere,
	Plane,
	Triangle
}

struct DebugDraw
{
	DrawType type;
	double radius_one;
	double radius_two;
	Plane* plane;
	Triangle* tri;

	bool isTextured;
	void function(Vectorf point, out float U, out float V) uv_mapper;
	Image tex;

}
