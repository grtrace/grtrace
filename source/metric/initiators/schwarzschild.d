module metric.initiators.schwarzschild;

import metric.interfaces;
import metric.coordinates.radial;
import math;
import grtrace;
import std.math;
import dbg.draws;

class Schwarzschild : Initiator
{
	public Vectorf origin;
	public fpnum schwarzschild_radius;
	public fpnum mass;
	public Radial cord;

	struct CachedData
	{
		fpnum r2;
		fpnum r;
		fpnum inv_r;
		fpnum inv_r2;
		fpnum theta;
		fpnum sin_theta;
		fpnum tmp;
		fpnum inv_tmp;
	}

	private CachedData* cache = null;

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
	}

	@property Initiator clone() const
	{
		auto cloned = new Schwarzschild(this);
		cloned.cache = new CachedData;
		return cloned;
	}

	@property Initiator cloneParams() const
	{
		return new Schwarzschild(this);
	}

	@nogc nothrow size_t getCacheSize() const
	{
		return CachedData.sizeof;
	}

	@nogc nothrow void setCacheBuffer(ubyte* prt)
	{
		cache = cast(CachedData*) prt;
	}

	void prepareForRequest(Vectorf point)
	{
		with (cache)
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
	}

	@property Metric4 getMetricAtPoint() const
	{
		with (cache)
		{
			return Metric4(-tmp, 0, 0, 0, inv_tmp, 0, 0, r2, 0, r2 * sin_theta * sin_theta);

		}
	}

	@property Metric4 getLocalMetricAtPoint() const
	{
		with (cache)
		{
			return Metric4(-1, 0, 0, 0, 1, 0, 0, r2, 0, r2 * sin_theta * sin_theta);
		}
	}

	@property Metric4[3] getDerivativesAtPoint() const
	{
		assert(0);
	}

	@property Metric4[4] getChristoffelSymbolsAtPoint() const
	{
		with (cache)
		{
			auto a = Metric4(0, mass * inv_tmp * inv_r2, 0, 0, 0, 0, 0, 0, 0, 0);

			auto b = Metric4(mass * tmp * inv_r2, 0, 0, 0,
					-mass * inv_tmp * inv_r2, 0, 0, -r * tmp, 0, -r * sin_theta * sin_theta * tmp);

			auto c = Metric4(0, 0, 0, 0, 0, inv_r, 0, 0, 0, -sin_theta * cos(theta));

			auto d = Metric4(0, 0, 0, 0, 0, 0, inv_r, 0, 1. / tan(theta), 0);

			return [a, b, c, d];
		}
	}

	@property Matrix4f getTetradsElementsAtPoint() const
	{
		with (cache)
		{
			auto res = Matrix4f(sqrt(inv_tmp), 0, 0, 0, 0, sqrt(tmp), 0, 0,
					0, 0, 1, 0, 0, 0, 0, 1);
			return res;
		}
	}

	@property Matrix4f getInverseTetradsElementsAtPoint() const
	{
		with (cache)
		{
			auto res = Matrix4f(sqrt(tmp), 0, 0, 0, 0, sqrt(inv_tmp), 0, 0,
					0, 0, 1, 0, 0, 0, 0, 1);
			return res;
		}
	}

	@property Matrix4f[4] getDerivativesOfInverseTetradsElementsAtPoint() const
	{
		with (cache)
		{
			auto null_mat = Matrix4f(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			auto s_tmp = sqrt(tmp);
			auto r_00 = schwarzschild_radius / (2 * r2 * s_tmp);
			auto r_11 = -(schwarzschild_radius / (2 * r2 * s_tmp * s_tmp * s_tmp));
			auto r_mat = Matrix4f(r_00, 0, 0, 0, 0, r_11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

			return [null_mat, r_mat, null_mat, null_mat];
		}
	}

	@property bool isInForbidenZone() const
	{
		with (cache)
		{
			if (r <= schwarzschild_radius)
				return true;
			else
				return false;
		}
	}

	@property CoordinateChanger coordinate_system() const
	{
		return cast(CoordinateChanger) cord;
	}

	DebugDraw[string] returnDebugRenderObjects() const
	{
		DebugDraw[string] res;
		res["@event_horizon"] = DebugDraw(DrawType.Sphere,
				schwarzschild_radius, 0, new Plane(origin, vectorf(0, 0, 0)), null);
		return res;
	}

	fpnum[string] returnConstantsOfMotion(Vectorf point, Vectorf dir)
	{
		with (cache)
		{
			fpnum[string] res;

			import metric.util;

			fpnum[4] vec = returnTransformedCartesianVectorAndPrepareInitiator(point,
					dir, cast(Initiator) this);

			res["E"] = -tmp * vec[0];
			res["L"] = r2 * sin_theta * sin_theta * vec[3];

			return res;
		}
	}

}
