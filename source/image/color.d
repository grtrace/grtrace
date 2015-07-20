module image.color;

struct Color
{
public:
	ubyte r;
	ubyte g;
	ubyte b;

	this(int R, int G, int B)
	{
		r = cast(ubyte)R;
		g = cast(ubyte)G;
		b = cast(ubyte)B;
	}

	Color opUnary(string op)()
	{
		return mixin( "Color("~op~"r,"~op~"g,"~op~"b)" );
	}

	Color opBinary(string op)(Color rhs)
	{
		return mixin( "Color(r"~op~"rhs.r, g"~op~"rhs.g, b"~op~"rhs.b)" );
	}

	bool opEquals()(auto ref const Color s) const
	{
		return (r==s.r)&&(g==s.g)&&(b==s.b);
	}

	int opCmp(ref const Color s) const
	{
		assert(0);
	}

	void opAssign(Color o)
	{
		r=o.r;
		g=o.g;
		b=o.b;
	}

	void opAssign(ubyte v)
	{
		r=g=b=v;
	}

	ubyte opIndex(size_t i)
	{
		if(i == 0) return r;
		else if(i==1) return g;
		else if(i==2) return b;
		else assert(0);
	}

};

enum Colors : Color
{
	Black = Color(0,0,0),
	White = Color(255,255,255),
	Red = Color(255,0,0),
	Green = Color(0,255,0),
	Blue = Color(0,0,255),
	Yellow = Red+Green,
	Cyan = Green+Blue,
	Magneta = Red+Blue
}
