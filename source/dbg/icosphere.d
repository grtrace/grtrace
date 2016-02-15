module dbg.icosphere;

import std.math;
import std.array, std.algorithm;

private struct Vert
{
    double x=0.0,y=0.0,z=0.0;
}

private struct Trgl
{
	short a, b, c;
}

struct Icosphere
{
    @disable this();
    @disable this(this);
	Vert[] vertices;
	Trgl[] triangles;
    /// -
    this(int subdivisions)
    {
        makeBase();
    }
	
	void makeBase()
	{
		enum t = (1.0 + sqrt(5.0)) / 2.0;
		addVert(-1, t, 0);
		addVert( 1, t, 0);
		addVert(-1,-t, 0);
		addVert( 1,-t, 0);
		
		addVert(0, -1, t);
		addVert(0,  1, t);
		addVert(0, -1,-t);
		addVert(0,  1,-t);
		
		addVert( t, 0,-1);
		addVert( t, 0, 1);
		addVert(-t, 0,-1);
		addVert(-t, 0, 1);
		
		triangles ~= Trgl(0, 11, 5);
		triangles ~= Trgl(0, 5, 1);
		triangles ~= Trgl(0, 1, 7);
		triangles ~= Trgl(0, 7, 10);
		triangles ~= Trgl(0, 10, 11);
		triangles ~= Trgl(1, 5, 9);
		triangles ~= Trgl(5, 11, 4);
		triangles ~= Trgl(11, 10, 2);
		triangles ~= Trgl(10, 7, 6);
		triangles ~= Trgl(7, 1, 8);
		triangles ~= Trgl(3, 9, 4);
		triangles ~= Trgl(3, 4, 2);
		triangles ~= Trgl(3, 2, 6);
		triangles ~= Trgl(3, 6, 8);
		triangles ~= Trgl(3, 8, 9);
		triangles ~= Trgl(4, 9, 5);
		triangles ~= Trgl(2, 4, 11);
		triangles ~= Trgl(6, 2, 10);
		triangles ~= Trgl(8, 6, 7);
		triangles ~= Trgl(9, 8, 1);
	}
	
	void addVert(double x, double y, double z)
	{
		double R = sqrt(x*x + y*y + z*z);
		x /= R;
		y /= R;
		z /= R;
		vertices ~= Vert(x,y,z);
	}
}
