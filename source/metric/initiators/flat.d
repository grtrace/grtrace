module metric.initiators.flat;

import metric.interfaces;
import metric.coordinates.cartesian;
import metric.coordinates.radial;
import math.metric;
import math.matrix;
import math.vector;
import std.math;
import config;
import dbg.draws;

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
	
	@property Initiator cloneParams() const
	{
		return new FlatCartesian();
	}
	
	@nogc nothrow size_t getCacheSize() const
	{
		return 0;
	}
	@nogc nothrow void setCacheBuffer(ubyte* prt)
	{
		return;
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
	
	@property bool isInForbidenZone() const
	{
		return false;
	}
	
	DebugDraw[string] returnDebugRenderObjects() const
	{
		return null;
	}
	
	fpnum[string] returnConstantsOfMotion(Vectorf point, Vectorf dir) //TODO: implement
	{
		fpnum[string] res;
		return res;
	}
}

class FlatRadial : Initiator
{
	private static const Radial cord = new Radial;

	struct CachedData
	{
		fpnum r2;
		fpnum r;
		fpnum inv_r;
		fpnum inv_r2;
		fpnum theta;
		fpnum sin_theta;
	}
	
	private CachedData* cache = null;

	this()
	{
	}

	this(const FlatRadial o)
	{
	}

	@property Initiator clone() const
	{
		auto cloned = new FlatRadial(this);
		cloned.cache = new CachedData;
		return cloned;
	}
	
	@property Initiator cloneParams() const
	{
		return new FlatRadial(this);
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
		with(cache)
		{
			r2 = (*point);
			r = sqrt(r2);
			inv_r = 1. / r;
			inv_r2 = 1. / r2;
			theta = acos(point.z / r);
			sin_theta = sin(theta);
		}
	}

	@property Metric4 getMetricAtPoint() const
	{
		with(cache)
		{
			return Metric4(-1, 0, 0, 0, 1, 0, 0, r2, 0, r2 * sin_theta * sin_theta);
		}
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
		with(cache)
		{
			static auto a = Metric4(0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	
			auto b = Metric4(0, 0, 0, 0, 0, 0, 0, -r, 0, -r * sin_theta * sin_theta);
	
			auto c = Metric4(0, 0, 0, 0, 0, inv_r, 0, 0, 0, -sin_theta * cos(theta));
	
			auto d = Metric4(0, 0, 0, 0, 0, 0, inv_r, 0, 1. / tan(theta), 0);
	
			return [a, b, c, d];
		}
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
	
	@property bool isInForbidenZone() const
	{
		return false;
	}
	
	DebugDraw[string] returnDebugRenderObjects() const
	{
		return null;
	}
	
	fpnum[string] returnConstantsOfMotion(Vectorf point, Vectorf dir) //TODO: Implement
	{
		fpnum[string] res;
		return res;
	}
}
