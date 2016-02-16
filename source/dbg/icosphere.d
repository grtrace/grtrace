module dbg.icosphere;

import std.math;
import std.array, std.algorithm;

private struct Vert
{
    double x=0.0,y=0.0,z=0.0;
}

private struct Trgl
{
	uint a, b, c;
}

struct Icosphere
{
    @disable this();
    @disable this(this);
	Vert[] vertices;
	uint[ulong] vert_map;
	Trgl[] triangles;
    /// -
    this(int subdivisions)
    {
    	if(subdivisions<0) throw new Error("Cannot create a icosphere with a negative recursion level");
        makeBase();
        while(subdivisions--)
        {
        	Trgl[] triangles2;
        	
        	foreach(Trgl trg; triangles)
        	{
        		int a = getMidlePoint(trg.a, trg.b);
        		int b = getMidlePoint(trg.a, trg.c);
        		int c = getMidlePoint(trg.b, trg.c);
        		
        		triangles2 ~= Trgl(trg.a, a, b);
        		triangles2 ~= Trgl(trg.b, c, a);
        		triangles2 ~= Trgl(trg.c, b, c);
        		triangles2 ~= Trgl(a, b, c);
        	}
        	
        	triangles = triangles2;        	
        }
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
		double invR = 1./sqrt(x*x + y*y + z*z);
		x *= invR;
		y *= invR;
		z *= invR;
		vertices ~= Vert(x,y,z);
	}
	
	uint getMidlePoint(uint a, uint b)
	{
		if(a>b) swap(a, b);
		ulong key = ((cast(ulong)a)<<32)+b;
		
		if(key in vert_map)
			return vert_map[key];
		
		Vert v1 = vertices[a];
		Vert v2 = vertices[b];
		
		addVert((v1.x+v2.x)/2, (v1.y+v2.y)/2, (v1.z+v2.z)/2);
		
		uint res = cast(uint)vertices.length-1;
		vert_map[key] = res;
		return res;
	}
}
