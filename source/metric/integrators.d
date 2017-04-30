module metric.integrators;

import config;
import math.geometric;
import metric.interfaces;
import metric.util;

enum Integrator
{
	RK4,
}

Line integrateStep(Integrator intal, Line ray, fpnum istep, Initiator initi)
{
	final switch (intal) with (Integrator)
	{
	case RK4:
		return rungeKutta4Step(ray, istep, initi);
	}
}

Line rungeKutta4Step(Line ray, fpnum istep, Initiator initi)
{
	Line newRay;
	newRay.ray = true;
	auto x1 = ray.origin;
	auto v1 = ray.direction;
	auto a1 = returnSecondDerivativeOfGeodescis(x1, v1, initi);
	if (initi.isInForbidenZone())
		return Line.infinity;

	auto x2 = ray.origin + (v1 * istep * 0.5);
	auto v2 = ray.direction + (a1 * istep * 0.5);
	auto a2 = returnSecondDerivativeOfGeodescis(x2, v2, initi);
	if (initi.isInForbidenZone())
		return Line.infinity;

	auto x3 = ray.origin + (v2 * istep * 0.5);
	auto v3 = ray.direction + (a2 * istep * 0.5);
	auto a3 = returnSecondDerivativeOfGeodescis(x3, v3, initi);
	if (initi.isInForbidenZone())
		return Line.infinity;

	auto x4 = ray.origin + (v3 * istep);
	auto v4 = ray.direction + (a3 * istep);
	auto a4 = returnSecondDerivativeOfGeodescis(x4, v4, initi);
	if (initi.isInForbidenZone())
		return Line.infinity;

	newRay.origin = ray.origin + ((v1 + (v2 * 2) + (v3 * 2) + v4) * (istep / 6.));
	newRay.direction = ray.direction + ((a1 + (a2 * 2) + (a3 * 2) + a4) * (istep / 6.));

	newRay.direction = newRay.direction.normalized;
	newRay.direction.w = 0; //be sure it's zero

	return newRay;
}
