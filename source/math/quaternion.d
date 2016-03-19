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

	this(fpnum w = 1, fpnum x = 0, fpnum y = 0, fpnum z = 0)
	{
		vals[0] = w;
		vals[1] = x;
		vals[2] = y;
		vals[3] = z;
	}

	this(const Vectorf axis, fpnum alpha)
	{
		fpnum s;
		s = sin(alpha / 2);
		vals[0] = cos(alpha / 2);
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
		return w * w + x * x + y * y + z * z;
	}

	@property fpnum mag()
	{
		return sqrt(w * w + x * x + y * y + z * z);
	}

	@property Quaternion normalize()
	{
		auto m = this.mag;
		w /= m;
		x /= m;
		y /= m;
		z /= m;
		return this;
	}

	@property Matrix4f matrix()
	{
		Vectorf axi;
		fpnum an;
		toAxisAngle(axi, an);
		fpnum s, c, t, ax, ay, az;
		s = sin(an);
		c = cos(an);
		t = 1.0 - c;
		ax = axi.x;
		ay = axi.y;
		az = axi.z;
		return Matrix4f(c + ax * ax * t, ax * ay * t - az * s,
			ax * az * t + ay * s, 0, ay * ax * t + az * s, c + ay * ay * t,
			ay * az * t - ax * s, 0, az * ax * t - ay * s, az * ay * t + ax * s,
			c + az * az * t, 0, 0, 0, 0, 1);
	}

	override string toString()
	{
		return "Q[ %f ; %f ; %f ; %f ]".format(w, x, y, z);
	}

	Quaternion opOpAssign(string op)(Quaternion rhs) if (op == "*")
	{
		fpnum A, B, C, D;
		A = vals[0] * rhs.vals[0] - vals[1] * rhs.vals[1] - vals[2] * rhs.vals[2] - vals[3] * rhs.vals[
			3];
		B = vals[0] * rhs.vals[1] + vals[1] * rhs.vals[0] + vals[2] * rhs.vals[3] - vals[3] * rhs.vals[
			2];
		C = vals[0] * rhs.vals[2] - vals[1] * rhs.vals[3] + vals[2] * rhs.vals[0] + vals[3] * rhs.vals[
			1];
		D = vals[0] * rhs.vals[3] + vals[1] * rhs.vals[2] - vals[2] * rhs.vals[1] + vals[3] * rhs.vals[
			0];
		this.vals[0] = A;
		this.vals[1] = B;
		this.vals[2] = C;
		this.vals[3] = D;
		return this;
	}

	Quaternion opBinary(string op)(Quaternion rhs)
	{
		return (new Quaternion(this).opOpAssign!op(rhs));
	}

	Vectorf opBinary(string op)(Vectorf rhs) if (op == "*")
	{
		return this.matrix * rhs;
	}

	void toAxisAngle(ref Vectorf axis, ref fpnum angle)
	{
		angle = 2.0 * acos(w);
		fpnum dv = sqrt(1.0 - w * w);
		if (dv == 0)
			axis = vectorf(0, 1, 0);
		else
			axis = vectorf(x / dv, y / dv, z / dv).normalized;
	}

	public static Quaternion lookAt(Vectorf sourcePoint, Vectorf destPoint)
	{
		Vectorf forwardVector = (destPoint - sourcePoint).normalized;
		fpnum dot = vectorf(0, 0, -1) * forwardVector;

		if (fabs(dot - (-1.0)) < 0.000001)
		{
			return new Quaternion(0, -1, 0, 3.1415926535897932f);
		}
		if (fabs(dot - (1.0)) < 0.000001)
		{
			return new Quaternion();
		}

		fpnum rotAngle = cast(fpnum) acos(dot);
		Vectorf rotAxis = (vectorf(0, 0, -1) % forwardVector).normalized;
		return new Quaternion(rotAxis, rotAngle);
	}
}
