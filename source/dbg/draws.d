module dbg.draws;

import math;

enum DrawType
{
	None,
	Sphere,
	Plane,
	Triangle
}

struct DebugDraw
{
	DrawType type;
	double radius;
	Plane *plane;
	Triangle *tri;
}
