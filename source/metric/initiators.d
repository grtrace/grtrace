module metric.initiators;

import metric.interfaces;
import math.metric;
import math.matrix;
import math.vector;

class Flat : Initiator
{
	Metric4 getMetricAt(Vectorf point) const
	{
		return Metric4(Matrix4f(
				1,0,0,0,
				0,-1,0,0,
				0,0,-1,0,
				0,0,0,-1
				));
	}
}
