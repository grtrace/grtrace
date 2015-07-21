module math.vector;

import config;
import std.math;
import std.traits;

struct Vector(T)
{
	T x;
	T y;
	T z;
	T w;

	auto ref T opIndex()(int idx) const
	{
		switch(idx)
		{
			case 0:
				return x;
			case 1:
				return y;
			case 2:
				return z;
			case 3:
				return w;
			default:
				assert(0);
		}
	}

	Vector!T opUnary(string op)() const if (op=="-")
	{
		return Vector!T(-x,-y,-z,w);
	}

	/// Length squared operator
	T opUnary(string op)() const if (op=="*")
	{
		return x*x+y*y+z*z;
	}

	/// Length operator
	T opUnary(string op)() const if (op=="~")
	{
		return cast(T)sqrt(cast(real)this.opUnary!"*"());
	}

	@property Vector!T normalized()
	{
		return this/(~this);
	}

	Vector!T opOpAssign(string op)(T rhs) if(op=="*=")
	{
		x*=rhs;
		y*=rhs;
		z*=rhs;
		return this;
	}

	U opCast(U)() const if (is(U==T[3])||is(U==T[]))
	{
		return [x,y,z];
	}

	U opCast(U)() const if (is(U X : Vector!X))
	{
		return Vector!X(cast(X)x,cast(X)y,cast(X)z,cast(X)w);
	}

	Vector!T opBinary(string op)(Vector!T rhs) const if ( (op=="+") || (op=="-") )
	{
		return mixin("Vector!T(x"~op~"rhs.x,y"~op~"rhs.y,z"~op~"rhs.z,w)");
	}

	Vector!T opBinary(string op)(T rhs) const if(op=="*")
	{
		return Vector!T(x*rhs,y*rhs,z*rhs,w);
	}

	Vector!T opBinary(string op)(T rhs) const if(op=="/")
	{
		return Vector!T(x/rhs,y/rhs,z/rhs,w);
	}

	Vector!T opBinaryRight(string op)(T rhs) const if(op=="/")
	{
		return Vector!T(rhs/x,rhs/y,rhs/z,w);
	}

	/// Dot product (*)
	T opBinary(string op)(Vector!T rhs) const if(op=="*")
	{
		return x*rhs.x+y*rhs.y+z*rhs.z;
	}

	/// Cross product (%)
	Vector!T opBinary(string op)(Vector!T rhs) const if(op=="%")
	{
		return Vector!T(y*rhs.z-z*rhs.y, z*rhs.x-x*rhs.z, x*rhs.y-y*rhs.x);
	}

	Vector!T opOpAssign(string op)(Vector!T rhs) if(op=="+=")
	{
		x+=rhs.x;
		y+=rhs.y;
		z+=rhs.z;
		return this;
	}

	Vector!T opOpAssign(string op)(Vector!T rhs) if(op=="-=")
	{
		x-=rhs.x;
		y-=rhs.y;
		z-=rhs.z;
		return this;
	}

	Vector!T opOpAssign(string op)(T rhs) if(op=="*=")
	{
		x*=rhs;
		y*=rhs;
		z*=rhs;
		return this;
	}

	Vector!T opOpAssign(string op)(T rhs) if(op=="/=")
	{
		x/=rhs;
		y/=rhs;
		z/=rhs;
		return this;
	}

	bool opEquals()(auto ref const S s) const
	{
		return (x==s.x)&&(y==s.y)&&(z==s.z)&&(w==s.w);
	}
}

Vector!T vector(T)(T x, T y, T z, T w = 1)
{
	return Vector!T(x,y,z,w);
}

alias vectorf = vector!fpnum;
alias vectori = vector!inum;
alias vectoru = vector!unum;

alias Vectorf = Vector!fpnum;
alias Vectori = Vector!inum;
alias Vectoru = Vector!unum;
