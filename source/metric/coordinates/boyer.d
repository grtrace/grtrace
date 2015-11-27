module metric.coordinates.boyer;

import std.math;
import math;
import config;
import metric.interfaces;

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

	this(Vectorf center = Vectorf(0,0,0), fpnum mass = 1, fpnum angular_momentum = 0)
	{
		origin = center;
		a = angular_momentum/mass;
		a2 = a*a;
	}
	
	this(const BoyerLinguist o)
	{
		origin = o.origin;
		a = o.a;
		a2 = o.a2;
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

		return Vectorf(dx, dy, dz);
	}

	Vectorf transformBackSpacialSecondDerivatives(fpnum[4] pos, fpnum[4] d1, fpnum[4] d2)
	{
		fpnum sinT = sin(pos[2]); fpnum cosT = cos(pos[2]);
		fpnum sinP = sin(pos[3]); fpnum cosP = cos(pos[3]);

		fpnum r2a2 = pos[1]*pos[1] + a2;
		fpnum ra = sqrt(r2a2);
		fpnum rra = pos[1]/ra;
		fpnum a2ra3 = a2/(r2a2*ra);

		fpnum d2x = 
			a2ra3*sinT*cosP*d1[1]*d1[1] + rra*(sinT*cosP*d2[1] + 2*d1[1]*(cosT*cosP*d1[2] - sinT*sinP*d1[3]))
			- ra*(sinT*cosP*(d1[2]*d1[2] + d1[3]*d1[3]) + 2*cosT*sinP*d1[2]*d1[3] + sinT*sinP*d2[3] - cosT*cosP*d2[2]);

		fpnum d2y = 
			a2ra3*sinT*sinP*d1[1]*d1[1] + rra*(sinT*sinP*d2[1] + 2*d1[1]*(cosT*sinP*d1[2] + sinT*cosP*d1[3]))
			- ra*(sinT*sinP*(d1[2]*d1[2] + d1[3]*d1[3]) - 2*cosT*cosP*d1[2]*d1[3] - cosT*sinP*d2[2] - sinT*cosP*d2[3]);

		fpnum d2z = cosT*(d2[1]-pos[1]*d1[2]*d1[2])-sinT*(2*d1[1]*d1[2]+pos[1]*d2[2]);

		return Vectorf(d2x, d2y, d2z);
	}
}
