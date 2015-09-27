module metric.initiators.kerr;

import metric.interfaces;
import metric.coordinates.boyer;
import math;
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
	private fpnum p;
	private fpnum p2;
	private fpnum p4;
	private fpnum p6;

	this(fpnum mass, fpnum angular_momentum, Vectorf orig)
	{
		origin = orig;
		j = angular_momentum;
		a = angular_momentum/m;
		coord = new BoyerLinguist(origin, a);
		a2 = a*a;
		m = mass;
		Rs = 2*m;
	}

	void prepareForRequest(Vectorf point)
	{
		assert(0, "NIY");
	}

	@property Metric4 getMetricAtPoint() const
	{
		assert(0, "NIY");
	}

	@property Metric4 getLocalMetricAtPoint() const
	{
		return Metric4(
			-1,  0,                           0,                 0,
			     (r2+a2*cos2_theta)/(r2+a2), 0,                 0,
			                                  r2+a2*cos2_theta, 0,
			                                                     (r2+a2)*sin2_theta
			);
	}

	@property Metric4[3] getDerivativesAtPoint() const
	{
		assert(0, "NIY");
	}

	@property Metric4[4] getChristoffelSymbolsAtPoint() const
	{
		auto time = Metric4(
			0, Rs/(2*p4*delta)*(r2+a2)*(2*r2-p2), -2*a*j*r/p4*sin_theta*cos_theta, 0,
			                   0,                              0,                  -j*sin2_theta/(p4*delta)*(p2*(r2-a2)+2*r2*(r2+a2)),
			                                                   0,                  2*a2*j*r/p4*cos_theta*sin3_theta,
			                                                                       0);

		auto radius = Metric4(
			Rs*delta/(2*p6)*(2*r2-p2), 0,                                   0,                          -j*delta/p6*(2*r2-p2)*sin_theta,
			                           1./(p2*delta)*(p2*(Rs/2-r)+r*delta), -a2/p2*sin_theta*cos_theta, 0,
			                                                                -r*delta/p2,                0,
			                                                                                            -delta*sin2_theta/p6*(r*p4-a*j*(2*r2-p2)*sin2_theta));

		auto theta = Metric4(
			-2*a*j*r/p6*sin_theta*cos_theta, 0,                                 0,      2*j*r/p6*(r2+a2)*sin_theta*cos_theta,
			                                 a2/(p2*delta)*sin_theta*cos_theta, r/p2,   0,
			                                                                    radius[1,2], 0,
			                                                                            -sin_theta*cos_theta/p6*(p4*delta+Rs*r*(r2+a2)*(r2+a2)));

		auto phi = Metric4(
			0, j/(p4*delta)*(2*r2-p2), -2*j*r*cos_theta/(p4*sin_theta), 0,
			   0,                      0,                               1./(p4*delta)*(r*p2*(p2-Rs*r)-a*j*sin2_theta*(2*r2-p2)),
			                           0,                               cos_theta/(p4*sin_theta)*(p4+2*a*j*r*sin2_theta),
			                                                            0);

		return [time,radius,theta,phi];
	}

	@property Matrix4f getTetradsElementsAtPoint() const //localy nonrotating frame
	{
		//TODO: Calculate that
		assert(0, "NIY");
	}

	@property Matrix4f getInverseTetradsElementsAtPoint() const
	{
		assert(0, "NIY");
	}
	
	@property CoordinateChanger coordinate_system() const
	{
		return cast(CoordinateChanger) coord;
	}
}
