module metric.coordinates.boyer;

import std.math;
import math;
import config;
import metric.initiators;

class BoyerLinguist : CoordinateChanger
{
	private Vectorf origin;
	private fpnum a;

	//Cache
	private fpnum a2;
	
	this(Vectorf center = Vectorf(0,0,0), fpnum a_param = 0)
	{
		origin = center;
		a = a_param;
		a2 = a*a;
	}

	this(Vectorf center = Vector(0,0,0), fpnum mass = 1, fpnum angular_momentum = 0)
	{
		origin = center;
		a = angular_momentum/m;
		a2 = a*a;
	}

	fpnum[4] transformForwardPosition(Vectorf a)
	{
		Vectorf tmp = a-origin;
		fpnum A = (*tmp) - a2;
		fpnum C = a2*tmp.z*tmp.z;

		fpnum radius = sqrt((A + sqrt(A*A + 4*C))/2);
		fpnum theta = acos(tmp.z/radius);
		fpnum phi = atan2(tmp.y,tmp.x);

		return [0, radius, theta, phi];
	}

	fpnum[4] transformForwardSpacialFirstDerivatives(Vectorf pos, Vectorf d1)
	{
		Vectorf tmp = pos-origin;

		fpnum A = (*tmp) - a2;
		fpnum dA = 2*(tmp*d1);

		fpnum C = a2*tmp.z*tmp.z;
		fpnum dC = 2*a2*tmp.z*d1.z;

		fpnum det = sqrt(A*A + 4*C);
		fpnum radius = sqrt((A + det)/2);

		fpnum dr = (dA + (A*dA + 2*dC)/det)/(4*radius);
		fpnum dt = (tmp.z*dr/radius - d1.z)/sqrt(radius*radius-tmp.z*tmp.z);
		fpnum dp = (tmp.x*d1.y - tmp.y*d1.x)/(tmp.x*tmp.x + tmp.y*tmp.y);

		return [0, dr, dt, dp];
	}

	Vectorf transformBackSpacialFirstDerivatives(fpnum[4] pos, fpnum[4] d1)
	{
		fpnum sinT = sin(pos[2]); fpnum cosT = cos(pos[2]);
		fpnum sinP = sin(pos[3]); fpnum cosP = cos(pos[3]);

		fpnum ra = sqrt(pos[1]*pos[1] + a2);
		fpnum rra = pos[1]/ra;

		fpnum dx = rra*sinT*cosP*d1[1] + ra*(cosT*cosP*d1[2] - sinT*sinP*d1[3]);
		fpnum dy = rra*sinT*sinP*d1[1] + ra*(cosT*sinP*d1[2] + sinT*cosP*d1[3]);
		fpnum dz = cosT*d1[1] - pos[1]*sinT*d1[2];
	}

	Vectorf transformBackSpacialSecondDerivatives(fpnum[4] pos, fpnum[4] d1, fpnum[4] d2);
}
