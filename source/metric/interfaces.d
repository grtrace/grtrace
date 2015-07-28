module metric.interfaces;

import math;

interface Initiator(T)
{
	static assert(is(T==Matrix4f) || is(T== Metric4));

	T getMetricAt(Vectorf point);
	T[3] getDerivativesAt(Vectorf point);
	T[4] getChristoffelSymbolsAt(Vectorf point);

	bool hasFunction(string f);
}

interface MetricContainer
{
	fpnum Raytrace(bool doP, bool doN, bool doO)(Line ray, bool* didHit, Vectorf* hitpoint=null, Vectorf* hitnormal=null, Renderable* hit=null);
}

interface DiscreteMetricContainer : MetricContainer
{
	@property ref Initiator!Metric4 initiator();
	void InitializeMetric();
}

interface AnaliticMetricContainer : MetricContainer
{
	@property Initiator!Matrix4f getInitiator();

	@property void setInitiator(Initiator!Matrix4f init)
	in
	{
		assert(init.hasFunction("derivatives"));
		assert(init.hasFunction("christoffels"));
	}
}





//TODO: NOT CHECKED
Matrix4f[4] returnChristoffelsSymbols(const Matrix4f g, const Matrix4f[3] dgs)
{
	Matrix4f[4] dg = Matrix4f.Zero~dgs;

	Matrix4f inv_g = g.inverse;

	Matrix4f[4] christoffel_symbols;

	for(size_t y = 0; y<4; y++)
	{
		for(size_t a = 0; a<4; a++)
		{
			for(size_t b = 0; b<4; b++)
			{
				for(size_t p = 0; p<4; p++)
				{
					christoffel_symbols[y][a*4+b] = christoffel_symbols[y][a*4+b]+inv_g[p*4+y]*(dg[a][b*4+p] + dg[b][a*4+p] - dg[p][a*4+b]);
				}
				christoffel_symbols[y][a*4+b] = christoffel_symbols[y][a*4+b]/2;
			}
		}
	}

	return christoffel_symbols;
}
