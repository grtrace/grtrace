module math.quaternion;

import config;
import math.util;
import math.matrix;
import math.vector;
import std.math, std.string, std.format, std.algorithm;

class Quaternion
{
	fpnum[4] vals;

	ref @property fpnum val(int i)() @safe
	{
		return vals[i];
	}

	alias w = val!0;
	alias x = val!1;
	alias y = val!2;
	alias z = val!3;

	this(fpnum w=1, fpnum x=0, fpnum y=0, fpnum z=0)
	{
		vals[0] = w;
		vals[1] = x;
		vals[2] = y;
		vals[3] = z;
	}

	this(const Vectorf axis, fpnum alpha)
	{
		fpnum s;
		s = sin(alpha/2);
		vals[0] = cos(alpha/2);
		vals[1] = axis.x * s;
		vals[2] = axis.y * s;
		vals[3] = axis.z * s;
	}

	this(const Quaternion q)
	{
		vals[] = q.vals[];
	}

	@property fpnum sqmag()
	{
		return w*w+x*x+y*y+z*z;
	}

	@property fpnum mag()
	{
		return sqrt(w*w+x*x+y*y+z*z);
	}

	@property Quaternion normalize()
	{
		auto m = this.mag;
		w/=m;
		x/=m;
		y/=m;
		z/=m;
		return this;
	}

	@property Matrix4f matrix()
	{
		return Matrix4f(
			1-2*(y*y-z*z), 2*(x*y-w*z), 2*(x*z+w*y), 0,
			2*(x*y+w*z), 1-2*(x*x-z*z), 2*(y*z+w*x), 0,
			2*(x*z-w*y), 2*(y*z-w*x), 1-2*(x*x-y*y), 0,
			0,0,0,1);
	}

	override string toString()
	{
		return "Q[ %f ; %f ; %f ; %f ]".format(w,x,y,z);
	}

	Quaternion opOpAssign(string op)(const Quaternion rhs) if(op=="*")
	{
		fpnum ww,yy,zz,xx,qq;
		ww = (z + x) * (rhs.x + rhs.y);
		yy = (w - y) * (rhs.w + rhs.z);
		zz = (w + y) * (rhs.w - rhs.z);
		xx = ww + yy + zz;
		qq = 0.5 * (xx + (z - x)*(rhs.x - rhs.y));

		vals[0] = qq - ww + (z - y) * (rhs.y - rhs.z);
		vals[1] = qq - xx + (x + w) * (rhs.x + rhs.w);
		vals[2] = qq - yy + (w - x) * (rhs.y + rhs.z);
		vals[3] = qq - zz + (z + y) * (rhs.w - rhs.x);
	}

	Quaternion opBinary(string op)(const Quaternion rhs)
	{
		return (Quaternion(this).opOpAssign!op(rhs));
	}

	Quaternion opBinary(string op)(Vectorf rhs) if (op=="*")
	{
		return this.matrix*rhs;
	}
}

