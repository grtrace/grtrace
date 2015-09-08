module metric.initiators.schwarzschild;

import metric.interfaces;
import metric.coordinates.radial;
import math;
import config;
import std.math;

class Schwarzschild : Initiator
{
	private Vectorf origin;
	private fpnum schwarzschild_radius;
	private fpnum mass;
	private Radial cord;

	this(fpnum m, Vectorf orig)
	{
		origin = orig;
		cord = new Radial(orig);
		schwarzschild_radius = 2*m;
		mass = m;
	}

	Metric4 getMetricAt(Vectorf point)
	{
		Vectorf v = point-origin;
		fpnum r2 = (*v);
		fpnum r = sqrt(r2);
		fpnum sin_theta = sin(acos(v.z/r));

		fpnum tmp = (1.-schwarzschild_radius/r);

		return Metric4(
			-tmp,  0,    0,           0,
			     1./tmp, 0,           0,
			             r2,          0,
			                r2*sin_theta*sin_theta
			);
	}

	Metric4[3] getDerivativesAt(Vectorf point)
	{
		assert(0);
	}

	Metric4[4] getChristoffelSymbolsAt(Vectorf point)
	{
		Vectorf v = point-origin;
		//FIXME:radial
		fpnum r2 = (*v);
		fpnum r = sqrt(r2);
		fpnum inv_r = 1./r;
		fpnum inv_r2 = 1./r2;

		fpnum theta = acos(v.z/r);
		fpnum sin_theta = sin(theta);

		fpnum tmp = (1.-schwarzschild_radius*inv_r);
		fpnum inv_tmp = 1./tmp;

		auto a = Metric4(
			0, mass*inv_tmp*inv_r2, 0, 0,
			           0,           0, 0,
			                        0, 0,
			                           0
			);

		auto b = Metric4(
			mass*tmp*inv_r2,          0,           0,              0,
			               -mass*inv_tmp*inv_r2,   0,              0,
			                                    -r*tmp,            0,
			                                           -r*sin_theta*sin_theta*tmp
			);

		auto c = Metric4(
			0, 0,   0,         0,
			   0, inv_r,       0,
			        0,         0,
			          -sin_theta*cos(theta)
			);

		auto d = Metric4(
			0, 0, 0,      0,
			   0, 0,    inv_r,
			      0, 1./tan(theta),
			              0 
			);

		return [a, b, c, d];
	}

	@property CoordinateChanger coordinate_system()
	{
		return cord;
	}

	bool hasFunction(string f)
	{
		if(f=="christoffels")
		{
			return true;
		}
		else
		{
			return false;
		}
	}
}
