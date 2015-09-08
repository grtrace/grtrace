module metric.interfaces;

import math;
import scene;
import config;

interface Initiator
{
	Metric4 getMetricAt(Vectorf point);
	Metric4[3] getDerivativesAt(Vectorf point);
	Metric4[4] getChristoffelSymbolsAt(Vectorf point);

	@property CoordinateChanger coordinate_system();

	bool hasFunction(string f);
}

interface CoordinateChanger
{
	fpnum[4] transformForwardPosition(Vectorf a);
	fpnum[4] transformForwardSpacialFirstDerivatives(Vectorf pos, Vectorf d1);
	Vectorf transformBackSpacialFirstDerivatives(fpnum[4] pos, fpnum[4] d1);
	Vectorf transformBackSpacialSecondDerivatives(fpnum[4] pos, fpnum[4] d1, fpnum[4] d2);
}

interface MetricContainer
{
	fpnum TraceRay(Line ray, bool* didHit, Vectorf* hitpoint=null, Vectorf* hitnormal=null, Renderable* hit=null, int cnt=0);
}

interface DiscreteMetricContainer : MetricContainer
{
	@property ref Initiator initiator();
	void InitializeMetric();
}

interface AnaliticMetricContainer : MetricContainer
{
	@property Initiator getInitiator();

	@property void setInitiator(Initiator init)
	in
	{
		assert((init.hasFunction("derivatives") || init.hasFunction("christoffels")));
	}
}
