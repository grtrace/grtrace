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
	Metric4 getMetricAt(Vectorf point)
	{
		static auto tmp = Metric4(
						  1,0,0,0,
						   -1,0,0,
						     -1,0,
						       -1);
		return tmp;
	}

	Metric4[3] getDerivativesAt(Vectorf point)
	{
		static auto tmp = Metric4(
						  0,0,0,0,
							0,0,0,
							  0,0,
								0);
		return [tmp,tmp,tmp];
	}

	Metric4[4] getChristoffelSymbolsAt(Vectorf point)
	{
		static auto tmp = Metric4(
						  0,0,0,0,
						    0,0,0,
						      0,0,
						        0);
		return [tmp,tmp,tmp,tmp];
	}

	@property CoordinateChanger coordinate_system()
	{
		return new Cartesian();
	}

	bool hasFunction(string f)
	{
		if(f=="derivatives" || f=="christoffels")
		{
			return true;
		}
		else
		{
			return false;
		}
	}
}

class FlatRadial : Initiator
{
	Metric4 getMetricAt(Vectorf point)
	{
		fpnum r2 = (*point);
		fpnum r = sqrt(r2);
		fpnum sin_theta = sin(acos(point.z/r));
		
		return Metric4(
			-1,  0,    0,           0,
			     1,    0,           0,
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
		fpnum r2 = (*point);
		fpnum r = sqrt(r2);
		fpnum inv_r = 1./r;
		fpnum inv_r2 = 1./r2;
		
		fpnum theta = acos(point.z/r);
		fpnum sin_theta = sin(theta);
		
		static auto a = Metric4(
			0, 0, 0, 0,
			0,           0, 0,
			0, 0,
			0
			);
		
		auto b = Metric4(
			0,    0,    0,     0,
			      0,    0,     0,
			            -r,    0,
			          -r*sin_theta*sin_theta
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
		return new Radial();
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
