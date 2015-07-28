module metric.initiators.flat;

import metric.interfaces;
import math.metric;
import math.matrix;
import math.vector;

class Flat(T) : Initiator!T
{
	T getMetricAt(Vectorf point) const
	{
		static if(is(T==Metric4))
		{
			return T(Matrix4f(
					1,0,0,0,
					0,-1,0,0,
					0,0,-1,0,
					0,0,0,-1
					));
		}
		static if(is(T==Matrix4f))
		{
			return T(
				1,0,0,0,
				0,-1,0,0,
				0,0,-1,0,
				0,0,0,-1
				);
		}
	}

	T[3] getDerivativesAt(Vectorf point)
	{
		static if(is(T==Metric4))
		{
			auto tmp = T(Matrix4f.Zero);
		}
		static if(is(T==Matrix4f))
		{
			auto tmp = T.Zero;
		}
		return [tmp,tmp,tmp];
	}

	T[4] getChristoffelSymbolsAt(Vectorf point)
	{
		static if(is(T==Metric4))
		{
			auto tmp = T(Matrix4f.Zero);
		}
		static if(is(T==Matrix4f))
		{
			auto tmp = T.Zero;
		}
		return [tmp,tmp,tmp,tmp];
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

alias DoCompile = Flat!Matrix4f;
