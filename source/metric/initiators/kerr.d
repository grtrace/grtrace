module metric.initiators.kerr;

import metric.interfaces;
import metric.coordinates.boyer;
import math;
import std.math;
import config;

class Kerr : Initiator
{
	private Vectorf origin;
	private BoyerLinguist coord; //TODO:Werify
	private fpnum m;
	private fpnum j;

	private fpnum Rs;
	private fpnum a;
	private fpnum a2;

	//Cache
	private fpnum r2;
	private fpnum r;
	private fpnum theta;
	private fpnum sin_theta;
	private fpnum sin2_theta;
	private fpnum sin3_theta;
	private fpnum cos_theta;
	private fpnum cos2_theta;
	private fpnum delta;
	private fpnum sigma;
	private fpnum p;
	private fpnum p2;
	private fpnum p4;
	private fpnum p6;

	this(fpnum mass, fpnum angular_momentum, Vectorf orig)
	{
		m = mass;
		Rs = 2 * m;
		origin = orig;
		j = angular_momentum;
		if (mass == 0)
			a = 1;
		else
			a = angular_momentum / m;
		a2 = a * a;
		coord = new BoyerLinguist(origin, a);
	}

	this(const Kerr o)
	{
		origin = o.origin;
		coord = new BoyerLinguist(o.coord);
		m = o.m;
		j = o.j;
		Rs = o.Rs;
		a = o.a;
		a2 = o.a2;
		r2 = o.r2;
		r = o.r;
		theta = o.theta;
		sin_theta = o.sin_theta;
		sin2_theta = o.sin2_theta;
		sin3_theta = o.sin3_theta;
		cos_theta = o.cos_theta;
		cos2_theta = o.cos2_theta;
		delta = o.delta;
		sigma = o.sigma;
		p = o.p;
		p2 = o.p2;
		p4 = o.p4;
		p6 = o.p6;
	}

	@property Initiator clone() const
	{
		return new Kerr(this);
	}

	void prepareForRequest(Vectorf point)
	{
		Vectorf tmp = point - origin;
		fpnum A = (*tmp) - a2;
		fpnum C = a2 * tmp.z * tmp.z;

		r = sqrt((A + sqrt(A * A + 4 * C)) / 2);
		theta = acos(tmp.z / r);

		r2 = r * r;

		sin_theta = sin(theta);
		sin2_theta = sin_theta * sin_theta;
		sin3_theta = sin2_theta * sin_theta;

		cos_theta = cos(theta);
		cos2_theta = cos_theta * cos_theta;

		delta = r2 - Rs * r + a2;

		sigma = (r2 + a2) * (r2 + a2) - a2 * delta * sin2_theta;

		p2 = r2 + a2 * cos2_theta;
		p = sqrt(p2);
		p4 = p2 * p2;
		p6 = p4 * p2;
	}

	@property Metric4 getMetricAtPoint() const
	{
		assert(0, "NIY");
	}

	@property Metric4 getLocalMetricAtPoint() const
	{
		return Metric4(-1, 0, 0, 0, (r2 + a2 * cos2_theta) / (r2 + a2), 0, 0,
			r2 + a2 * cos2_theta, 0, (r2 + a2) * sin2_theta);
	}

	@property Metric4[3] getDerivativesAtPoint() const
	{
		assert(0, "NIY");
	}

	@property Metric4[4] getChristoffelSymbolsAtPoint() const
	{
		auto time = Metric4(0, Rs / (2 * p4 * delta) * (r2 + a2) * (2 * r2 - p2),
			-2 * a * j * r / p4 * sin_theta * cos_theta, 0, 0, 0,
			-j * sin2_theta / (p4 * delta) * (p2 * (r2 - a2) + 2 * r2 * (r2 + a2)),
			0, 2 * a2 * j * r / p4 * cos_theta * sin3_theta, 0);

		auto radius = Metric4(Rs * delta / (2 * p6) * (2 * r2 - p2), 0, 0,
			-j * delta / p6 * (2 * r2 - p2) * sin_theta,
			1. / (p2 * delta) * (p2 * (Rs / 2 - r) + r * delta),
			-a2 / p2 * sin_theta * cos_theta, 0, -r * delta / p2, 0,
			-delta * sin2_theta / p6 * (r * p4 - a * j * (2 * r2 - p2) * sin2_theta));

		auto theta = Metric4(-2 * a * j * r / p6 * sin_theta * cos_theta, 0, 0,
			2 * j * r / p6 * (r2 + a2) * sin_theta * cos_theta,
			a2 / (p2 * delta) * sin_theta * cos_theta, r / p2, 0, radius[1, 2],
			0, -sin_theta * cos_theta / p6 * (p4 * delta + Rs * r * (r2 + a2) * (r2 + a2)));

		auto phi = Metric4(0, j / (p4 * delta) * (2 * r2 - p2),
			-2 * j * r * cos_theta / (p4 * sin_theta), 0, 0, 0,
			1. / (p4 * delta) * (r * p2 * (p2 - Rs * r) - a * j * sin2_theta * (2 * r2 - p2)),
			0, cos_theta / (p4 * sin_theta) * (p4 + 2 * a * j * r * sin2_theta), 0);

		return [time, radius, theta, phi];
	}

	//locally nonrotating frame
	@property Matrix4f getTetradsElementsAtPoint() const  //localy nonrotating frame
	{
		auto res = Matrix4f(
			sigma/(p*sqrt(delta)), 0,                                              0,                          Rs*a*r/(p*sigma*sqrt(delta)),
			0,                     sqrt((r2+a2*cos2_theta)/(r2+a2))*sqrt(delta)/p, 0,                          0,
			0,                     0,                                              (sqrt(r2+a2*cos2_theta))/p, 0,
			0,                     0,                                              0,                          (sqrt(r2+a2))*sin_theta*p/(sigma*sin_theta));

		return res;
		//auto tmp = Matrix4f(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1);
		//return tmp;
	}

	@property Matrix4f getInverseTetradsElementsAtPoint() const
	{
		//TODO:Optimize
		auto res = Matrix4f(
			sigma/(p*sqrt(delta)), 0,                                              0,                          Rs*a*r/(p*sigma*sqrt(delta)),
			0,                     sqrt((r2+a2*cos2_theta)/(r2+a2))*sqrt(delta)/p, 0,                          0,
			0,                     0,                                              (sqrt(r2+a2*cos2_theta))/p, 0,
			0,                     0,                                              0,                          (sqrt(r2+a2))*sin_theta*p/(sigma*sin_theta));

		return (res.inverse);
		//auto tmp = Matrix4f(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1);
		//return tmp;
	}
	
	@property Matrix4f[4] getDerivativesOfInverseTetradsElementsAtPoint() const
	{
		assert(0, "NIY");
	}

	@property CoordinateChanger coordinate_system() const
	{
		return cast(CoordinateChanger) coord;
	}
}
