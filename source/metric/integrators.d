module metric.integrators;

import config;
import std.meta;
import math.vector;
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

private template Iota(int Start, int End)
{
	static if (Start >= End)
		alias Iota = AliasSeq!();
	else static if (Start + 1 == End)
		alias Iota = AliasSeq!(Start);
	else
		alias Iota = AliasSeq!(Iota!(Start, (Start + End) / 2), Iota!((Start + End) / 2, End));
}

Line rungeKuttaGeneralStep(int order, fpnum[][] ca, fpnum[] b)(Line ray, fpnum istep,
		Initiator initi)
{
	Line newRay;
	newRay.ray = true;

	Vectorf[order] X, V, A;
	foreach (i; Iota!(0, order))
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
	foreach (i; Iota!(0, order))
	{
		newRay.origin += V[i] * (b[i] * istep);
		newRay.direction += A[i] * (b[i] * istep);
	}

	newRay.direction = newRay.direction.normalized;
	newRay.direction.w = 0; //be sure it's zero

	return newRay;
}

// dfmt off
alias rungeKutta4Step =
	rungeKuttaGeneralStep!(
		4,
		[
			[0.0,					0.0, 0.0, 0.0],
			[0.5, 0.5,				0.0, 0.0],
			[0.5, 0.0, 0.5,			0.0],
			[1.0, 0.0, 0.0, 1.0		]
		],
		[1.0/6.0, 1.0/3.0, 1.0/3.0, 1.0/6.0]
	);
// dfmt on
