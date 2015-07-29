module metric.interfaces;

import math;
import scene;
import config;

interface Initiator
{
	Metric4 getMetricAt(Vectorf point);
	Metric4[3] getDerivativesAt(Vectorf point);
	Metric4[4] getChristoffelSymbolsAt(Vectorf point);

	bool hasFunction(string f);
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
		assert(init.hasFunction("derivatives") || init.hasFunction("christoffels"));
	}
}





//TODO: NOT CHECKED
Metric4[4] returnChristoffelsSymbols(const Metric4 g, const Metric4[3] dgs)
{
	Metric4[4] dg = Metric4(Matrix4f.Zero)~dgs;

	Metric4 inv_g = Metric4(g().inverse);

	Metric4[4] christoffel_symbols;

	for(byte y = 0; y<4; y++)
	{
		for(byte a = 0; a<4; a++)
		{
			for(byte b = 0; b<4; b++)
			{
				for(byte p = 0; p<4; p++)
				{
					christoffel_symbols[y][a,b] = christoffel_symbols[y][a,b]+inv_g[p,y]*(dg[a][b,p] + dg[b][a,p] - dg[p][a,b]);
				}
				christoffel_symbols[y][a,b] = christoffel_symbols[y][a,b]/2;
			}
		}
	}

	return christoffel_symbols;
}
