module metric.coordinates.radial;

import metric.interfaces;
import math;
import std.math;
import config;

class Radial : CoordinateChanger
{
	private Vectorf origin;

	this(Vectorf center = Vectorf(0, 0, 0))
	{
		origin = center;
	}

	this(const Radial o)
	{
		origin = o.origin;
	}

	fpnum[4] transformForwardPosition(Vectorf a)
	{
		Vectorf tmp = a - origin;
		fpnum rt = ~tmp;
		fpnum tt = acos(tmp.z / rt);
		fpnum pt = atan2(tmp.y, tmp.x);
		return [0, rt, tt, pt];
	}

	fpnum[4] transformForwardSpacialFirstDerivatives(Vectorf pos, Vectorf dir)
	{
		Vectorf tmp = pos - origin;
		//Vectorf tmp = origin-pos;

		fpnum r2 = *tmp;
		fpnum r = sqrt(r2);

		fpnum w2 = tmp.x * tmp.x + tmp.y * tmp.y;
		fpnum w = sqrt(w2);

		return [0, (tmp * dir) / r, ((tmp.z / w) * (tmp.x * dir.x + tmp.y * dir.y) - w * dir.z) / r2,
			(tmp.x * dir.y - tmp.y * dir.x) / w2];
	}

	Vectorf transformBackSpacialFirstDerivatives(fpnum[4] pos, fpnum[4] d1)
	{
		fpnum sinT = sin(pos[2]);
		fpnum cosT = cos(pos[2]);
		fpnum sinP = sin(pos[3]);
		fpnum cosP = cos(pos[3]);

		return Vectorf(sinT * cosP * d1[1] + pos[1] * (cosT * cosP * d1[2] - sinT * sinP * d1[3]),
			sinT * sinP * d1[1] + pos[1] * (cosT * sinP * d1[2] + sinT * cosP * d1[3]),
			cosT * d1[1] - pos[1] * sinT * d1[2]);
	}

	Vectorf transformBackSpacialSecondDerivatives(fpnum[4] pos, fpnum[4] d1, fpnum[4] d2)
	{
		fpnum sinT = sin(pos[2]);
		fpnum cosT = cos(pos[2]);
		fpnum sinP = sin(pos[3]);
		fpnum cosP = cos(pos[3]);

		return Vectorf(sinT * cosP * d2[1] + 2 * d1[1] * (cosT * cosP * d1[2] - sinT * sinP * d1[3]) + pos[
			1] * (cosT * (cosP * d2[2] - 2 * sinP * d1[2] * d1[3]) - sinT * (
			cosP * (d1[2] * d1[2] + d1[3] * d1[3]) + sinP * d2[3])),
			sinT * sinP * d2[1] + 2 * d1[1] * (cosT * sinP * d1[2] + sinT * cosP * d1[3]) + pos[1] * (
			sinT * (cosP * d2[3] - sinP * (d1[2] * d1[2] + d1[3] * d1[3])) + cosT * (
			sinP * d2[2] + 2 * cosP * d1[2] * d1[3])),
			cosT * (d2[1] - pos[1] * d1[2] * d1[2]) - sinT * (2 * d1[1] * d1[2] + pos[1] * d2[2]));
	}

	override string toString()
	{
		return "Radial";
	}
}
