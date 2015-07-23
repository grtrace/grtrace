module image.color;

import std.math;
import config;

struct Color
{
public:
	fpnum r;
	fpnum g;
	fpnum b;

	this(fpnum R, fpnum G, fpnum B)
	{
		r = R;
		g = G;
		b = B;
	}

	Color opUnary(string op)() const
	{
		return mixin( "Color("~op~"r,"~op~"g,"~op~"b)" );
	}

	Color opBinary(string op)(Color rhs) const
	{
		return mixin( "Color(r"~op~"rhs.r, g"~op~"rhs.g, b"~op~"rhs.b)" );
	}

	Color opOpAssign(string op)(Color rhs)
	{
		mixin("r "~op~"= rhs.r;");
		mixin("g "~op~"= rhs.g;");
		mixin("b "~op~"= rhs.b;");
		return this;
	}

	Color opBinary(string op)(fpnum rhs) const
	{
		return mixin( "Color(r"~op~"rhs, g"~op~"rhs, b"~op~"rhs)" );
	}

	Color opOpAssign(string op)(fpnum rhs)
	{
		mixin("r "~op~"= rhs;");
		mixin("g "~op~"= rhs;");
		mixin("b "~op~"= rhs;");
		return this;
	}

	bool opEquals()(auto ref const Color s) const
	{
		return (r==s.r)&&(g==s.g)&&(b==s.b);
	}

	void opAssign(fpnum v)
	{
		r=g=b=v;
	}

	fpnum opIndex(size_t i) const
	{
		if(i == 0) return r;
		else if(i==1) return g;
		else if(i==2) return b;
		else assert(0);
	}

	void opIndexAssign(size_t i, fpnum v)
	{
		if(i == 0) r=v;
		else if(i==1) g=v;
		else if(i==2) b=v;
		else assert(0);
	}

	@property ubyte ru() const
	{
		return cast(ubyte)(round(r*255.0));
	}

	@property ubyte gu() const
	{
		return cast(ubyte)(round(g*255.0));
	}

	@property ubyte bu() const
	{
		return cast(ubyte)(round(b*255.0));
	}

}

enum Colors : Color
{
	Black = Color(0,0,0),
	White = Color(1,1,1),
	Red = Color(1,0,0),
	Green = Color(0,1,0),
	Blue = Color(0,0,1),
	Yellow = Red+Green,
	Cyan = Green+Blue,
	Magneta = Red+Blue
}
