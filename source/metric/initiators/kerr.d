module metric.initiators.kerr;

import metric.interfaces;
import metric.coordinates.radial;
import math;
import config;

class Kerr : Initiator
{
	private Vectorf origin;
	private Radial coord;
	private fpnum mass;
	private fpnum angular_momentum;

	this(fpnum m, fpnum j, Vectorf orig)
	{
		origin = orig;
		coord = new Radial(origin);
		angular_momentum = j;
		mass = m;
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
		assert(0, "NIY");
	}

	@property Metric4[3] getDerivativesAtPoint() const
	{
		assert(0, "NIY");
	}

	@property Metric4[4] getChristoffelSymbolsAtPoint() const
	{
		assert(0, "NIY");
	}

	@property Matrix4f getTetradsElementsAtPoint() const
	{
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
