module image.color;

struct Color
{
public:
	float r;
	float g;
	float b;

	this(float R, float G, float B)
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

	Color opBinary(string op)(float rhs) const
	{
		return mixin( "Color(r"~op~"rhs, g"~op~"rhs, b"~op~"rhs)" );
	}

	bool opEquals()(auto ref const Color s) const
	{
		return (r==s.r)&&(g==s.g)&&(b==s.b);
	}

	void opAssign(float v)
	{
		r=g=b=v;
	}

	float opIndex(size_t i) const
	{
		if(i == 0) return r;
		else if(i==1) return g;
		else if(i==2) return b;
		else assert(0);
	}

	void opIndexAssign(size_t i, float v)
	{
		if(i == 0) r=v;
		else if(i==1) g=v;
		else if(i==2) b=v;
		else assert(0);
	}

	@property ubyte ru() const
	{
		return cast(ubyte)(r*255.0f);
	}

	@property ubyte gu() const
	{
		return cast(ubyte)(g*255.0f);
	}

	@property ubyte bu() const
	{
		return cast(ubyte)(b*255.0f);
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
