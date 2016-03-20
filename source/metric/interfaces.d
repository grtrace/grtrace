module metric.interfaces;

import math;
import scene;
import config;

import metric.coordinates;

interface Initiator
{
	@property Initiator clone() const;
	void prepareForRequest(Vectorf point);
	@property Metric4 getMetricAtPoint() const;
	@property Metric4 getLocalMetricAtPoint() const;
	@property Metric4[3] getDerivativesAtPoint() const; //we assume that the metric doesn't depend on time
	@property Metric4[4] getChristoffelSymbolsAtPoint() const;
	@property Matrix4f getTetradsElementsAtPoint() const;
	@property Matrix4f getInverseTetradsElementsAtPoint() const;
	@property Matrix4f[4] getDerivativesOfInverseTetradsElementsAtPoint() const;

	@property CoordinateChanger coordinate_system() const;
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
	fpnum TraceRay(Line ray, bool* didHit, Vectorf* hitpoint = null,
		Vectorf* hitnormal = null, Renderable* hit = null, int cnt = 0);
}

interface DiscreteMetricContainer : MetricContainer
{
	@property ref Initiator initiator();
	void InitializeMetric();
}

interface AnalyticMetricContainer : MetricContainer
{
	@property Initiator initiator();
	@property void initiator(Initiator inx);
}
