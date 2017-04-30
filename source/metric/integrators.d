module metric.integrators;

import config;
import std.meta;
import math.vector;
import math.geometric;
import metric.interfaces;
import metric.util;

enum Integrator
{
	Euler,
	RK4,
	RK5,
	RK5_4,
}

Line integrateStep(Integrator intal, Line ray, fpnum istep, Initiator initi)
{
	final switch (intal) with (Integrator)
	{
	case Euler:
		return eulerStep(ray, istep, initi);
	case RK4:
		return rungeKutta4Step(ray, istep, initi);
	case RK5:
		return rungeKuttaFehler45Step(ray, istep, initi)[0];
	case RK5_4:
		return rungeKuttaFehler45Step(ray, istep, initi)[1];
	}
}

private template Iota(int Start, int End)
{
	static if (Start >= End)
		alias Iota = AliasSeq!();
	else static if (Start + 1 == End)
		alias Iota = AliasSeq!(Start);
	else
		alias Iota = AliasSeq!(Iota!(Start, (Start + End) / 2), Iota!((Start + End) / 2, End));
}

Line rungeKuttaGeneralStep(int order, int stages, fpnum[][] ca, fpnum[] b)(Line ray,
		fpnum istep, Initiator initi)
{
	Line newRay;
	newRay.ray = true;

	Vectorf[stages] X, V, A;
	foreach (i; Iota!(0, stages))
	{
		X[i] = ray.origin;
		V[i] = ray.direction;
		foreach (j; Iota!(1, i + 1))
		{
			X[i] += V[i - 1] * (ca[i][j] * istep);
			V[i] += A[i - 1] * (ca[i][j] * istep);
		}
		A[i] = returnSecondDerivativeOfGeodescis(X[i], V[i], initi);
		if (initi.isInForbidenZone())
			return Line.infinity;
	}

	newRay.origin = ray.origin;
	newRay.direction = ray.direction;
	foreach (i; Iota!(0, stages))
	{
		newRay.origin += V[i] * (b[i] * istep);
		newRay.direction += A[i] * (b[i] * istep);
	}

	newRay.direction = newRay.direction.normalized;
	newRay.direction.w = 0; //be sure it's zero

	return newRay;
}

Line[2] rungeKuttaGeneralAdaptiveStep(int order, int stages, fpnum[][] ca,
		fpnum[] bHigh, fpnum[] bLow)(Line ray, fpnum istep, Initiator initi)
{
	Line[2] newRay;
	newRay[0].ray = true;
	newRay[1].ray = true;

	Vectorf[stages] X, V, A;
	foreach (i; Iota!(0, stages))
	{
		X[i] = ray.origin;
		V[i] = ray.direction;
		foreach (j; Iota!(1, i + 1))
		{
			X[i] += V[i - 1] * (ca[i][j] * istep);
			V[i] += A[i - 1] * (ca[i][j] * istep);
		}
		A[i] = returnSecondDerivativeOfGeodescis(X[i], V[i], initi);
		if (initi.isInForbidenZone())
			return [Line.infinity, Line.infinity];
	}

	newRay[0].origin = ray.origin;
	newRay[0].direction = ray.direction;
	newRay[1].origin = ray.origin;
	newRay[1].direction = ray.direction;
	foreach (i; Iota!(0, stages))
	{
		newRay[0].origin += V[i] * (bHigh[i] * istep);
		newRay[0].direction += A[i] * (bHigh[i] * istep);
		newRay[1].origin += V[i] * (bLow[i] * istep);
		newRay[1].direction += A[i] * (bLow[i] * istep);
	}

	newRay[0].direction = newRay[0].direction.normalized;
	newRay[0].direction.w = 0; //be sure it's zero
	newRay[1].direction = newRay[1].direction.normalized;
	newRay[1].direction.w = 0; //be sure it's zero

	return newRay;
}

// dfmt off
alias rungeKutta4Step =
	rungeKuttaGeneralStep!(
		4, 4,
		[
			[0.0,					0.0, 0.0, 0.0],
			[0.5, 0.5,				0.0, 0.0],
			[0.5, 0.0, 0.5,			0.0],
			[1.0, 0.0, 0.0, 1.0		]
		],
		[1.0/6.0, 1.0/3.0, 1.0/3.0, 1.0/6.0]
	);

alias eulerStep =
	rungeKuttaGeneralStep!(
		1, 1,
		[
			[0.0]
		],
		[1.0]
	);

alias rungeKuttaFehler45Step =
	rungeKuttaGeneralAdaptiveStep!(
		5, 6,
		[
			[0.0,															0.0, 0.0, 0.0, 0.0, 0.0],
			[0.25, 0.25,													0.0, 0.0, 0.0, 0.0],
			[3.0/8, 3.0/32, 9.0/32,											0.0, 0.0, 0.0],
			[12.0/13, 1932.0/2197, -7200.0/2197, 7296.0/2197,				0.0, 0.0],
			[1.0, 439.0/216, -8.0, 3680.0/513,	-845.0/4104,				0.0],
			[0.5, -8.0/27, 2.0, -3544.0/2565,	1859.0/4104, -11.0/40		]
		],
		[16.0/135, 0.0, 6656.0/12_825, 28_651.0/56_430, -9.0/50, 2.0/55],
		[25.0/216, 0.0, 1408.0/2565,   2197.0/4104,     -1.0/5,  0.0]
	);

// dfmt on
