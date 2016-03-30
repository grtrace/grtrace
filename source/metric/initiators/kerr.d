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
	private fpnum cot_theta;
	private fpnum delta;
	private fpnum A;
	
	private fpnum sigma;
	private fpnum sigma2;
	private fpnum sigma3;

	this(fpnum mass, fpnum angular_momentum, Vectorf orig)
	{
		m = mass;
		Rs = 2 * m;
		origin = orig;
		j = angular_momentum;
		if (mass == 0)
			a = 0;
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
		cot_theta = o.cot_theta;
		delta = o.delta;
		A = o.A;
		
		sigma = o.sigma;
		sigma2 = o.sigma2;
		sigma3 = o.sigma3;
	}

	@property Initiator clone() const
	{
		return new Kerr(this);
	}

	void prepareForRequest(Vectorf point)
	{
		Vectorf tmp = point - origin;
		fpnum B = (*tmp) - a2;
		fpnum C = a2 * tmp.z * tmp.z;

		r = sqrt((B + sqrt(B * B + 4 * C)) / 2);
		theta = acos(tmp.z / r);

		r2 = r * r;

		sin_theta = sin(theta);
		sin2_theta = sin_theta * sin_theta;
		sin3_theta = sin2_theta * sin_theta;

		cos_theta = cos(theta);
		cos2_theta = cos_theta * cos_theta;
		
		cot_theta = cos_theta/sin_theta;

		delta = r2 - Rs * r + a2;

		A = (r2 + a2) * (r2 + a2) - a2 * delta * sin2_theta;

		sigma = r2 + a2 * cos2_theta;
		sigma2 = sigma * sigma;
		sigma3 = sigma2 * sigma;
	}

	@property Metric4 getMetricAtPoint() const
	{
		auto met = Metric4(0,0,0,0, 0,0,0, 0,0, 0);
		met[0,0] = -(1-(Rs*r)/sigma);
		met[0,3] = -(2*Rs*a*r*sin2_theta)/sigma;
		met[1,1] = sigma/delta;
		met[2,2] = sigma;
		met[3,3] = (r2 + a2 + (Rs*a2*r*sin2_theta)/sigma)*sin2_theta;
		return met;
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
		Metric4 time, radius, theta, phi;
		
		time = radius = theta = phi = Metric4(0,0,0,0, 0,0,0, 0,0, 0);
		
		radius[0,0] = (Rs*delta*(r2-a2*cos2_theta))/(2*sigma3);
		theta[0,0] = -(Rs*a2*r*sin_theta*cos_theta)/sigma3;
		time[0,1] = (Rs*(r2+a2)*(r2-a2*cos2_theta))/(2*sigma2*delta);
		phi[0,1] = (Rs*a*(r2-a2*cos2_theta))/(2*sigma2*delta);
		time[0,2] = -(Rs*a2*r*sin_theta*cos_theta)/sigma2;
		phi[0,2] = -(Rs*a*r*cot_theta)/sigma2;
		radius[0,3] = -(delta*Rs*a*sin2_theta*(r2-a2*cos2_theta))/(2*sigma3);
		theta[0,3] = (Rs*a*r*(r2+a2)*sin_theta*cos_theta)/sigma3;
		radius[1,1] = (2*r*a2*sin2_theta - Rs*(r2-a2*cos2_theta))/(2*sigma*delta);
		theta[1,1] = (a2*sin_theta*cos_theta)/(sigma*delta);
		radius[1,2] = -(a2*sin_theta*cos_theta)/sigma;
		theta[1,2] = r/sigma;
		radius[2,2] = -(r*delta)/sigma;
		theta[2,2] = -(a2*sin_theta*cos_theta)/sigma;
		phi[2,3] = (cot_theta/sigma2)*(sigma2+Rs*a2*r*sin2_theta);
		time[2,3] = (Rs*a2*a*r*sin3_theta*cos_theta)/sigma2;
		time[1,3] = (Rs*a*sin2_theta*(a2*cos2_theta*(a2-r2) - r2*(a2+3*r2)))/(2*sigma2*delta);
		phi[1,3] = (2*r*sigma2 + Rs*(a2*a2*sin2_theta*cos2_theta - r2*(sigma+r2+a2)))/(2*sigma2*delta);
		radius[3,3] = ((delta*sin2_theta)/(2*sigma3))*(-2*r*sigma2 + Rs*a2*sin2_theta*(r2-a2*cos2_theta));
		theta[3,3] = -((sin_theta*cos_theta)/sigma3)*(A*sigma + (r2+a2)*Rs*a2*r*sin2_theta);
		
		return [time, radius, theta, phi];
	}

	//locally nonrotating frame
	@property Matrix4f getTetradsElementsAtPoint() const  //localy nonrotating frame
	{
		fpnum e0 = sqrt(A/(sigma*delta));
		auto res = Matrix4f(
			e0, 0,                                                0, ((Rs*a*r)/A)*e0,
			0,                      sqrt(((r2+a2*cos2_theta)/(r2+a2))*(delta/sigma)), 0, 0,
			0,                      0,                                                1, 0,
			0,                      0,                                                0, sqrt((r2+a2)*(sigma/A)));

		return res;
	}

	@property Matrix4f getInverseTetradsElementsAtPoint() const
	{
		// sage-math inverse :P
		fpnum e0 = sqrt(A/(sigma*delta));
		fpnum x = e0;
		fpnum y = ((Rs*a*r)/A)*e0;
		fpnum z = sqrt(((r2+a2*cos2_theta)/(r2+a2))*(delta/sigma));
		fpnum w = sqrt((r2+a2)*(sigma/A));
		return Matrix4f(
			1.0/x, 0,  0, -y/(w*x),
			0, 1.0/z, 0, 0,
			0, 0, 1, 0,
			0, 0, 0, 1.0/w);
	}
	
	@property Matrix4f[4] getDerivativesOfInverseTetradsElementsAtPoint() const
	{
		/*auto deriv_normal_t = Matrix4f(
			0, 0, 0, 0,
			0, 0, 0, 0,
			0, 0, 0, 0,
			0, 0, 0, 0);*/
		
		auto d_r_delta = 2*r-Rs;
		auto d_r_sigma = 2*r;
		auto d_r_A = 2*(r2+a2)*2*r - a2*(d_r_delta)*sin2_theta;
		
		auto dr_00 = (1/(2*sqrt(A/(sigma*delta))))*( (d_r_A*sigma*delta - A*(d_r_sigma*delta + sigma*d_r_delta))/((sigma*delta)*(sigma*delta)) );
		auto dr_03 = Rs*a*( (r*dr_00)/A + (sqrt(A/(sigma*delta)))*((A-r*d_r_A)/(A*A)) );
		auto dr_11 = 2*Rs*((r2-a2)/((r2+a2)*(r2+a2)))*sqrt(1-((Rs*r)/(r2+a2)));
		auto dr_33 = (1/(2*sqrt( (r2+a2)*sigma/A )))*((A*((r2+a2)*d_r_sigma + 2*r*sigma)-(r2+a2)*sigma*d_r_A)/(A*A));

		
		auto d_theta_A = -2*a2*delta*sin_theta*cos_theta;
		auto d_theta_sigma = -2*a2*sin_theta*cos_theta;
		
		auto theta_common = (1/(2*sqrt(A/(sigma*delta))))*((d_theta_A*sigma*delta - A*d_theta_sigma*delta)/((delta*sigma)*(delta*sigma)));
		
		/*auto deriv_normal_theta = Matrix4f(
			theta_common, 0, 0, (Rs*a*r)*(theta_common*A - sqrt(A/(sigma*delta))*d_theta_A)/(A*A),
			0,            0, 0, 0,
			0,            0, 0, 0,
			0,            0, 0, (sqrt(r2+a2))*( (1/(2*sqrt(sigma/A)))*((d_theta_sigma*A - sigma*d_theta_A)/(A*A)) ) );*/

		
		/*auto deriv_normal_phi = Matrix4f(
			0, 0, 0, 0,
			0, 0, 0, 0,
			0, 0, 0, 0,
			0, 0, 0, 0);*/
		
		Matrix4f inverse_tetrad = getInverseTetradsElementsAtPoint;
		
		fpnum a = inverse_tetrad.at!(0);
		fpnum b = inverse_tetrad.at!(3);
		fpnum c = inverse_tetrad.at!(5);
		fpnum d = inverse_tetrad.at!(15);
		
		fpnum x,y,z,w;

		Matrix4f t_mat = Matrix4f.Zero;//(inverse_tetrad*deriv_normal_t*inverse_tetrad);
		/*
		
		IT*DerR*IT =
		[                a^2*x                     0                     0 a*b*x + (b*w + a*y)*d]
		[                    0                 c^2*z                     0                     0]
		[                    0                     0                     0                     0]
		[                    0                     0                     0                 d^2*w]
		
		IT*DerT*IT = 
		[                a^2*x                     0                     0 a*b*x + (a*y + b*z)*d]
		[                    0                     0                     0                     0]
		[                    0                     0                     0                     0]
		[                    0                     0                     0                 d^2*z]
		*/
		x = dr_00;
		y = dr_03;
		z = dr_11;
		w = dr_33;
		//Matrix4f r_mat = (inverse_tetrad*deriv_normal_r*inverse_tetrad);
		//Matrix4f theta_mat = (inverse_tetrad*deriv_normal_theta*inverse_tetrad);
		Matrix4f r_mat = Matrix4f(
			a*a*x, 0, 0, a*b*x + (b*w + a*y)*d,
			0, c*c*z, 0, 0,
			0, 0, 0, 0,
			0, 0, 0, d*d*w
		);
		x = theta_common;
		y = (Rs*a*r)*(theta_common*A - sqrt(A/(sigma*delta))*d_theta_A)/(A*A);
		z = (sqrt(r2+a2))*( (1/(2*sqrt(sigma/A)))*((d_theta_sigma*A - sigma*d_theta_A)/(A*A)) );
		w = 0.0;
		Matrix4f theta_mat = Matrix4f(
			a*a*x, 0, 0, a*b*x + (a*y + b*z)*d,
			0, 0, 0, 0,
			0, 0, 0, 0,
			0, 0, 0, d*d*z
		);
		Matrix4f phi_mat = Matrix4f.Zero;//(inverse_tetrad*deriv_normal_phi*inverse_tetrad);
		
		Matrix4f[4] res = [t_mat, r_mat, theta_mat, phi_mat];
		
		for(byte mat = 0; mat<4; mat++)
		{
			for(byte i = 0; i<16; i++)
			{
				res[mat][i] = -res[mat][i];
			}
		}
		
		return res;
	}

	@property CoordinateChanger coordinate_system() const
	{
		return cast(CoordinateChanger) coord;
	}
	
	DebugDraw[string] returnDebugRenderObjects() const
	{
		DebugDraw[string] res;
		
		//TODO:Implement
		res["@event_horizon"] = DebugDraw(DrawType.Sphere, Rs, 0, new Plane(origin, vectorf(0, 0,
			0)), null);
		res["@ergosphere"] = DebugDraw(DrawType.Sphere, Rs, 0, new Plane(origin, vectorf(0, 0,
			0)), null);
		
		return null;
	}
}
