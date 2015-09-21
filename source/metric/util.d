module metric.util;

import math;
import metric.interfaces;
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

Vectorf returnSecondDerivativeOfGeodescis(Vectorf point, Vectorf direction, Initiator init)
{
	init.prepareForRequest(point);

	CoordinateChanger coords = init.coordinate_system;

	//get metric at point
	//Metric4 metric = init.getMetricAtPoint;
	Metric4 local_metric = init.getLocalMetricAtPoint;
	
	//get christoffels symbols at point
	Metric4[4] christoffels = init.getChristoffelSymbolsAtPoint;
	
	Matrix4f tetrad = init.getTetradsElementsAtPoint;
	Matrix4f inv_tetrad = init.getInverseTetradsElementsAtPoint;

	fpnum[4] dr = coords.transformForwardSpacialFirstDerivatives(point, direction);

	dr[0] = returnTimeDerivativeFromSpacialDerivatives(local_metric, dr);

	fpnum[4] local_dr = [dr[0], dr[1], dr[2], dr[3]];

	for(byte i = 0; i<4; i++)
	{
		dr[i] = 0;
		for(byte j = 0; j<4; j++)
		{
			dr[i] += tetrad[j*4+i]*local_dr[j];
		}
	}

	fpnum[4] d2r = [0,0,0,0];

	//calculate the second derivatives
	for(byte i = 0; i<4; i++)
	{
		for(byte a = 0; a<4; a++)
		{
			for(byte b = 0; b<4; b++)
			{
				d2r[i] += christoffels[i][a,b]*dr[a]*dr[b];
			}
		}

		d2r[i] = -d2r[i];
	}

	fpnum[4] local_d2r = [0,0,0,0];
	//fpnum[4] local_d2r = [d2r[0], d2r[1], d2r[2], d2r[3]];

	for(byte i = 0; i<4; i++)
	{
		for(byte j = 0; j<4; j++)
		{
			local_d2r[i] += inv_tetrad[j*4+i]*d2r[j];
		}
	}

	Vectorf second = coords.transformBackSpacialSecondDerivatives(coords.transformForwardPosition(point), local_dr, local_d2r);

	return second;
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
