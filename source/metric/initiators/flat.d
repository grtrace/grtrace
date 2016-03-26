module metric.initiators.flat;

import metric.interfaces;
import metric.coordinates.cartesian;
import metric.coordinates.radial;
import math.metric;
import math.matrix;
import math.vector;
import std.math;
import config;

class FlatCartesian : Initiator
{
	private static const Cartesian cord = new Cartesian();

	this()
	{
	}

	@property Initiator clone() const
	{
		return new FlatCartesian();
	}

	void prepareForRequest(Vectorf point)
	{
		return;
	}

	@property Metric4 getMetricAtPoint() const
	{
		static auto tmp = Metric4(1, 0, 0, 0, -1, 0, 0, -1, 0, -1);
		return tmp;
	}

	@property Metric4 getLocalMetricAtPoint() const
	{
		return getMetricAtPoint;
	}

	@property Metric4[3] getDerivativesAtPoint() const
	{
		static auto tmp = Metric4(0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		return [tmp, tmp, tmp];
	}

	@property Metric4[4] getChristoffelSymbolsAtPoint() const
	{
		static auto tmp = Metric4(0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		return [tmp, tmp, tmp, tmp];
	}

	@property Matrix4f getTetradsElementsAtPoint() const
	{
		static auto tmp = Matrix4f(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1);
		return tmp;
	}

	@property Matrix4f getInverseTetradsElementsAtPoint() const
	{
		static auto tmp = Matrix4f(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1);
		return tmp;
	}
	
	@property Matrix4f[4] getDerivativesOfInverseTetradsElementsAtPoint() const
	{
		auto null_mat = Matrix4f(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0);
		return [null_mat, null_mat, null_mat, null_mat];
	}

	@property CoordinateChanger coordinate_system() const
	{
		return cast(CoordinateChanger) cord;
	}
}

class FlatRadial : Initiator
{
	private static const Radial cord = new Radial;

	//Cached data
	private fpnum r2;
	private fpnum r;
	private fpnum inv_r;
	private fpnum inv_r2;
	private fpnum theta;
	private fpnum sin_theta;

	this()
	{
	}

	this(const FlatRadial o)
	{
		r2 = o.r2;
		r = o.r;
		inv_r = o.inv_r;
		inv_r2 = o.inv_r2;
		theta = o.theta;
		sin_theta = o.sin_theta;
	}

	@property Initiator clone() const
	{
		return new FlatRadial(this);
	}

	void prepareForRequest(Vectorf point)
	{
		r2 = (*point);
		r = sqrt(r2);
		inv_r = 1. / r;
		inv_r2 = 1. / r2;
		theta = acos(point.z / r);
		sin_theta = sin(theta);
	}

	@property Metric4 getMetricAtPoint() const
	{
		return Metric4(-1, 0, 0, 0, 1, 0, 0, r2, 0, r2 * sin_theta * sin_theta);
	}

	@property Metric4 getLocalMetricAtPoint() const
	{
		return getMetricAtPoint;
	}

	@property Metric4[3] getDerivativesAtPoint() const
	{
		assert(0);
	}

	@property Metric4[4] getChristoffelSymbolsAtPoint() const
	{
		static auto a = Metric4(0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

		auto b = Metric4(0, 0, 0, 0, 0, 0, 0, -r, 0, -r * sin_theta * sin_theta);

		auto c = Metric4(0, 0, 0, 0, 0, inv_r, 0, 0, 0, -sin_theta * cos(theta));

		auto d = Metric4(0, 0, 0, 0, 0, 0, inv_r, 0, 1. / tan(theta), 0);

		return [a, b, c, d];
	}

	@property Matrix4f getTetradsElementsAtPoint() const
	{
		auto tmp = Matrix4f(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1);
		return tmp;
	}

	@property Matrix4f getInverseTetradsElementsAtPoint() const
	{
		auto tmp = Matrix4f(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1);
		return tmp;
	}
	
	@property Matrix4f[4] getDerivativesOfInverseTetradsElementsAtPoint() const
	{
		auto null_mat = Matrix4f(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0);
		return [null_mat, null_mat, null_mat, null_mat];
	}

	@property CoordinateChanger coordinate_system() const
	{
		return cast(CoordinateChanger) cord;
	}
}
