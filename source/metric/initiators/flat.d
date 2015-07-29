module metric.initiators.flat;

import metric.interfaces;
import math.metric;
import math.matrix;
import math.vector;

class Flat : Initiator
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
