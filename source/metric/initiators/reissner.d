module metric.initiators.reissner;

import metric.interfaces;
import metric.coordinates.radial;
import math;
import config;
import std.math;
import dbg.draws;

class Reissner : Initiator
{
	public Vectorf origin;
	public fpnum Rs;
	public fpnum Q;
	public fpnum Q2;
	public fpnum M;
	public Radial cord;
	public fpnum r_cauchy, r_ext;
	public fpnum det;

	struct CachedData
	{
		fpnum r2;
		fpnum r;
		fpnum r3;
		fpnum inv_r;
		fpnum inv_r2;
		fpnum inv_r3;
		fpnum theta;
		fpnum sin_theta;
		fpnum sin2_theta;
		fpnum cos_theta;
		fpnum Arn;
		fpnum inv_Arn;
	}
	
	private CachedData* cache = null;

	this(fpnum mass, fpnum charge, Vectorf orig)
	{
		origin = orig;
		cord = new Radial(orig);
		M = mass;
		Rs = 2 * mass;
		Q = charge;
		Q2 = charge*charge;
		
		if(1-(4*Q2)/(Rs*Rs)>=0)
		{
			det = (Rs/2) * sqrt(1-(4*Q2)/(Rs*Rs));
			r_ext = (Rs/2) + det;
			r_cauchy = (Rs/2) - det;
		}
		else r_ext=r_cauchy=0;
	}
	
	this(const Reissner o)
	{
		origin = o.origin;
		Rs = o.Rs;
		Q = o.Q;
		Q2 = o.Q2;
		M = o.M;
		cord = new Radial(o.cord);
		r_cauchy = o.r_cauchy;
		r_ext = o.r_ext;
		det = o.det;
	}
	
	@property Initiator clone() const
	{
		auto cloned = new Reissner(this);
		cloned.cache = new CachedData;
		return cloned;
	}
	
	@property Initiator cloneParams() const
	{
		return new Reissner(this);
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
			Vectorf v = point - origin;
	
			r2 = (*v);
			r = sqrt(r2);
			r3 = r2*r;
			inv_r = 1. / r;
			inv_r2 = 1. / r2;
			inv_r3 = 1. / r3;
	
			theta = acos(v.z / r);
			sin_theta = sin(theta);
			sin2_theta = sin_theta*sin_theta;
			cos_theta = cos(theta);
	
			Arn = (1. - Rs * inv_r + Q2 * inv_r2);
			inv_Arn = 1. / Arn;
		}
	}
	
	@property Metric4 getMetricAtPoint() const
	{
		with(cache)
		{
			return Metric4(-Arn, 0, 0, 0, inv_Arn, 0, 0, r2, 0, r2 * sin_theta * sin_theta);
		}
	}
	
	@property Metric4 getLocalMetricAtPoint() const
	{
		with(cache)
		{
			return Metric4(-1, 0, 0, 0, 1, 0, 0, r2, 0, r2 * sin_theta * sin_theta);
		}
	}
	
	@property Metric4[3] getDerivativesAtPoint() const
	{
		assert(0, "NIY");
	}
	
	@property Metric4[4] getChristoffelSymbolsAtPoint() const
	{
		with(cache)
		{
			Metric4 time, radius, theta, phi;
			
			time = radius = theta = phi = Metric4(0,0,0,0, 0,0,0, 0,0, 0);
			
			radius[0,0] = (Arn*(Rs*r - 2*Q2)*inv_r3)/2;
			theta[1,2] = inv_r;
			phi[2,3] = cos_theta / sin_theta;
			time[0,1] = ((Rs*r - 2*Q2)*inv_r3*inv_Arn)/2;
			phi[1,3] = inv_r;
			radius[3,3] = -(r*Arn*sin2_theta);
			radius[1,1] = -time[0,1];
			radius[2,2] = -(r*Arn);
			theta[3,3] = -(sin_theta*cos_theta);
			
			return [time,radius,theta,phi];
		}
	}
	
	@property Matrix4f getTetradsElementsAtPoint() const
	{
		with(cache)
		{
			auto res = Matrix4f(sqrt(inv_Arn), 0, 0, 0, 0, sqrt(Arn), 0, 0, 0, 0, 1, 0,
				0, 0, 0, 1);
			return res;
		}
	}

	@property Matrix4f getInverseTetradsElementsAtPoint() const
	{
		with(cache)
		{
			auto res = Matrix4f(sqrt(Arn), 0, 0, 0, 0, sqrt(inv_Arn), 0, 0, 0, 0, 1, 0,
				0, 0, 0, 1);
			return res;
		}
	}
	
	@property Matrix4f[4] getDerivativesOfInverseTetradsElementsAtPoint() const //TODO: implement fully
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
		with(cache)
		{
			if(r <= r_ext) return true;
			else return false;
		}
	}
	
	DebugDraw[string] returnDebugRenderObjects() const
	{	
		DebugDraw[string] res;
		res["@ext_event_horizon"] = DebugDraw(DrawType.Sphere, r_ext, 0, new Plane(origin, vectorf(0, 0,
			0)), null);
		res["@cauchy_event_horizon"] = DebugDraw(DrawType.Sphere, r_cauchy, 0, new Plane(origin, vectorf(0, 0,
			0)), null);
		return res;
	}
	
	fpnum[string] returnConstantsOfMotion(Vectorf point, Vectorf dir)
	{
		with(cache)
		{
			fpnum[string] res;
			
			import metric.util;
			fpnum[4] vec = returnTransformedCartesianVectorAndPrepareInitiator(point, dir, cast(Initiator)this);
			
			res["E"] = -Arn * vec[0];
			res["L"] = r2 * sin_theta*sin_theta * vec[3];
			
			return res;
		}
	}
};
