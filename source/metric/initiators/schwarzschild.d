module metric.initiators.schwarzschild;

import metric.interfaces;
import metric.coordinates.radial;
import math;
import config;
import std.math;

class Schwarzschild : Initiator
{
	public Vectorf origin;
	public fpnum schwarzschild_radius;
	public fpnum mass;
	public Radial cord;

	//Cache
	private fpnum r2;
	private fpnum r;
	private fpnum inv_r;
	private fpnum inv_r2;
	private fpnum theta;
	private fpnum sin_theta;
	private fpnum tmp;
	private fpnum inv_tmp;

	this(fpnum m, Vectorf orig)
	{
		origin = orig;
		cord = new Radial(orig);
		schwarzschild_radius = 2 * m;
		mass = m;
	}

	this(const Schwarzschild o)
	{
		origin = o.origin;
		schwarzschild_radius = o.schwarzschild_radius;
		mass = o.mass;
		cord = new Radial(o.cord);
		r2 = o.r2;
		inv_r = o.inv_r;
		inv_r2 = o.inv_r2;
		theta = o.theta;
		sin_theta = o.sin_theta;
		tmp = o.tmp;
		inv_tmp = o.inv_tmp;
	}

	@property Initiator clone() const
	{
		return new Schwarzschild(this);
	}

	void prepareForRequest(Vectorf point)
	{
		Vectorf v = point - origin;

		r2 = (*v);
		r = sqrt(r2);
		inv_r = 1. / r;
		inv_r2 = 1. / r2;

		theta = acos(v.z / r);
		sin_theta = sin(theta);

		tmp = (1. - schwarzschild_radius * inv_r);
		inv_tmp = 1. / tmp;
	}

	@property Metric4 getMetricAtPoint() const
	{
		return Metric4(-tmp, 0, 0, 0, inv_tmp, 0, 0, r2, 0, r2 * sin_theta * sin_theta);
	}

	@property Metric4 getLocalMetricAtPoint() const
	{
		return Metric4(-1, 0, 0, 0, 1, 0, 0, r2, 0, r2 * sin_theta * sin_theta);
	}

	@property Metric4[3] getDerivativesAtPoint() const
	{
		assert(0);
	}

	@property Metric4[4] getChristoffelSymbolsAtPoint() const
	{
		auto a = Metric4(0, mass * inv_tmp * inv_r2, 0, 0, 0, 0, 0, 0, 0, 0);

		auto b = Metric4(mass * tmp * inv_r2, 0, 0, 0, -mass * inv_tmp * inv_r2,
			0, 0, -r * tmp, 0, -r * sin_theta * sin_theta * tmp);

		auto c = Metric4(0, 0, 0, 0, 0, inv_r, 0, 0, 0, -sin_theta * cos(theta));

		auto d = Metric4(0, 0, 0, 0, 0, 0, inv_r, 0, 1. / tan(theta), 0);

		return [a, b, c, d];
	}

	@property Matrix4f getTetradsElementsAtPoint() const
	{
		auto res = Matrix4f(sqrt(inv_tmp), 0, 0, 0, 0, sqrt(tmp), 0, 0, 0, 0, 1, 0,
			0, 0, 0, 1);
		return res;
	}

	@property Matrix4f getInverseTetradsElementsAtPoint() const
	{
		auto res = Matrix4f(sqrt(tmp), 0, 0, 0, 0, sqrt(inv_tmp), 0, 0, 0, 0, 1, 0,
			0, 0, 0, 1);
		return res;
	}

	@property CoordinateChanger coordinate_system() const
	{
		return cast(CoordinateChanger) cord;
	}
}
