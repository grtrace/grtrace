﻿module math.geometric;

import config;
import math.util;
import math.vector;
import math.matrix;
import std.math;
import std.algorithm;

enum IntersectionCount
{
	Zero,
	One,
	Two,
	Three,
	Four,
	Infinity
}

alias Point = Vectorf;

/// Line of form `Ax + By + Cz = D`
struct Line
{
	Point origin;
	Vectorf direction;
	// true if is a ray (half-line)
	bool ray=false;
}

Line LinePoints(Point A, Point B)
{
	Vectorf Dir = (A-B).normalized;
	return Line(A, Dir);
}

struct Plane
{
	Point origin;
	Vectorf normal;
}

Plane PlaneVectors(Point origin, Vectorf v1, Vectorf v2)
{
	return Plane(origin, (v1%v2).normalized);
}

Plane PlanePoints(Point p1, Point p2, Point p3)
{
	return PlaneVectors(p1, p2-p1, p3-p1);
}

Plane InversePlane(Plane p)
{
	return Plane(p.origin,-p.normal);
}

struct AABB
{
	Point min, max;
}

bool PointInBox(AABB box, Point p)
{
	return InRange(p.x, box.min.x, box.max.x) && InRange(p.y, box.min.y, box.max.y) && InRange(p.z, box.min.z, box.max.z);
}

bool LineIntersectsBox(AABB box, Line l)
{
	Vectorf dirfrac;
	dirfrac.x = 1.0 / l.direction.x;
	dirfrac.y = 1.0 / l.direction.y;
	dirfrac.z = 1.0 / l.direction.z;
	Vectorf lb = box.min;
	Vectorf rt = box.max;
	fpnum t1 = (lb.x - l.origin.x)*dirfrac.x;
	fpnum t2 = (rt.x - l.origin.x)*dirfrac.x;
	fpnum t3 = (lb.y - l.origin.y)*dirfrac.y;
	fpnum t4 = (rt.y - l.origin.y)*dirfrac.y;
	fpnum t5 = (lb.z - l.origin.z)*dirfrac.z;
	fpnum t6 = (rt.z - l.origin.z)*dirfrac.z;
	
	fpnum tmin = max(max(min(t1, t2), min(t3, t4)), min(t5, t6));
	fpnum tmax = min(min(max(t1, t2), max(t3, t4)), max(t5, t6));

	if (tmax < 0)
	{
		return !l.ray;
	}
	if (tmin > tmax)
	{
		return false;
	}
	return true;
}