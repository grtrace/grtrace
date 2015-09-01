module metric.util;

import math;
import std.math;
import std.algorithm.comparison;
import config;

fpnum returnTimeDerivativeFromSpacialDerivatives(Metric4 g, const fpnum[4] v)
{
	fpnum A = g[0,0];
	fpnum B = 2*(g[0,1]*v[1] + g[0,2]*v[2] + g[0,3]*v[3]);
	fpnum C = 2*(v[1]*(g[1,2]*v[2] + g[1,3]*v[3]) + g[2,3]*v[2]*v[3]) + g[1,1]*v[1]*v[1] + g[2,2]*v[2]*v[2] + g[3,3]*v[3]*v[3];

	fpnum s_det = sqrt(B*B - 4*A*C);

	fpnum dt_1 = (-B - s_det)/(2*A); 
	fpnum dt_2 = (-B + s_det)/(2*A);

	return max(dt_1, dt_2);
}


//TODO: NOT CHECKED
Metric4[4] returnChristoffelsSymbols(const Metric4 g, const Metric4[3] dgs)
{
	Metric4[4] dg = Metric4(Matrix4f.Zero)~dgs;
	
	Metric4 inv_g = Metric4(g().inverse);
	
	Metric4[4] christoffel_symbols;
	
	for(byte y = 0; y<4; y++)
	{
		for(byte a = 0; a<4; a++)
		{
			for(byte b = 0; b<4; b++)
			{
				for(byte p = 0; p<4; p++)
				{
					christoffel_symbols[y][a,b] = christoffel_symbols[y][a,b]+inv_g[p,y]*(dg[a][b,p] + dg[b][a,p] - dg[p][a,b]);
				}
				christoffel_symbols[y][a,b] = christoffel_symbols[y][a,b]/2;
			}
		}
	}
	
	return christoffel_symbols;
}
