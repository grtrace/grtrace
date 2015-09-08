module math.vector;

import config;
import std.math;
import std.traits;
import std.format, std.string;
import std.algorithm;
import math.metric;

struct Vector(T)
{
	T x;
	T y;
	T z;
	T w;

	auto ref T opIndex()(int idx)
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

	Vector!T opOpAssign(string op)(T rhs) if(op=="*")
	{
		x*=rhs;
		y*=rhs;
		z*=rhs;
		return this;
	}

	Vector!T opOpAssign(string op)(Vector!T rhs) if(op=="+")
	{
		x+=rhs.x;
		y+=rhs.y;
		z+=rhs.z;
		return this;
	}

	Vector!T opOpAssign(string op)(Vector!T rhs) if(op=="-")
	{
		x-=rhs.x;
		y-=rhs.y;
		z-=rhs.z;
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
		return mixin("Vector!T(x"~op~"rhs.x,y"~op~"rhs.y,z"~op~"rhs.z,max(w,rhs.w))");
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
		return Vector!T(y*rhs.z-z*rhs.y, z*rhs.x-x*rhs.z, x*rhs.y-y*rhs.x, max(w,rhs.w));
	}

	Vector!T opOpAssign(string op)(Vector!T rhs) if(op=="+=")
	{
		x+=rhs.x;
		y+=rhs.y;
		z+=rhs.z;
		w=max(w,rhs.w);
		return this;
	}

	Vector!T opOpAssign(string op)(Vector!T rhs) if(op=="-=")
	{
		x-=rhs.x;
		y-=rhs.y;
		z-=rhs.z;
		w=max(w,rhs.w);
		return this;
	}

	Vector!T opOpAssign(string op)(T rhs) if(op=="*=")
	{
		x*=rhs;
		y*=rhs;
		z*=rhs;
		w=max(w,rhs.w);
		return this;
	}

	Vector!T opOpAssign(string op)(T rhs) if(op=="/=")
	{
		x/=rhs;
		y/=rhs;
		z/=rhs;
		w=max(w,rhs.w);
		return this;
	}

	bool opEquals()(auto ref const Vector!T s) const
	{
		return (x==s.x)&&(y==s.y)&&(z==s.z)&&(w==s.w);
	}

	string toString()
	{
		return format("( %.4f ; %.4f ; %.4f ; %.0f )",x,y,z,w);
	}
	static if(is(T==fpnum))
	{
		fpnum mDot(Metric4 m, Vectorf o)
		{
			return
				this.x*o.x*m[1,1] + 
				this.x*o.y*m[1,2] + 
				this.x*o.z*m[1,3] + 
				this.y*o.x*m[2,1] + 
				this.y*o.y*m[2,2] + 
				this.y*o.z*m[2,3] + 
				this.z*o.x*m[3,1] + 
				this.z*o.y*m[3,2] + 
				this.z*o.z*m[3,3];
		}

		fpnum mLenSq(Metric4 m)
		{
			return mDot(m,this).fabs();
		}

		fpnum mLen(Metric4 m)
		{
			return sqrt(mLenSq(m));
		}

		fpnum mCrossLenSq(Metric4 m, Vectorf o)
		{
			return this.mLenSq(m)*o.mLenSq(m) - this.mDot(m,o)^^2;
		}

		fpnum mCosV(Metric4 m, Vectorf v)
		{
			return this.mDot(m,v)/( mLen(m)*v.mLen(m) );
		}
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
