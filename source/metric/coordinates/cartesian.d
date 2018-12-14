module metric.coordinates.cartesian;

import metric.interfaces;
import math;
import grtrace;

class Cartesian : CoordinateChanger
{

	fpnum[4] transformForwardPosition(Vectorf a)
	{
		return [0, a.x, a.y, a.z];
	}

	fpnum[4] transformForwardSpacialFirstDerivatives(Vectorf pos, Vectorf d1)
	{
		return transformForwardPosition(d1);
	}

	Vectorf transformBackSpacialFirstDerivatives(fpnum[4] pos, fpnum[4] d1)
	{
		return Vectorf(d1[1], d1[2], d1[3]);
	}

	Vectorf transformBackSpacialSecondDerivatives(fpnum[4] pos, fpnum[4] d1, fpnum[4] d2)
	{
		return Vectorf(d2[1], d2[2], d2[3]);
	}

	override string toString()
	{
		return "Cartesian";
	}
}
