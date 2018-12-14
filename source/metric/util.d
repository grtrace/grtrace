module metric.util;

import math;
import metric.interfaces;
import std.math;
import std.algorithm;
import grtrace;

fpnum returnTimeDerivativeFromSpatialDerivatives(Metric4 g, const fpnum[4] v)
{
	fpnum A = g.at!(0, 0);
	fpnum B = 2 * (g.at!(0, 1) * v[1] + g.at!(0, 2) * v[2] + g.at!(0, 3) * v[3]);
	fpnum C = 2 * (v[1] * (g.at!(1, 2) * v[2] + g.at!(1, 3) * v[3]) + g.at!(2, 3) * v[2] * v[3]) + g.at!(1,
			1) * v[1] * v[1] + g.at!(2, 2) * v[2] * v[2] + g.at!(3, 3) * v[3] * v[3];

	fpnum s_det = sqrt(B * B - 4 * A * C);

	if (A > 0)
		return (-B + s_det) / (2 * A);
	else
		return (-B - s_det) / (2 * A);
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
	Matrix4f[4] d_inv_tetrad = init.getDerivativesOfInverseTetradsElementsAtPoint;

	fpnum[4] local_dr = coords.transformForwardSpacialFirstDerivatives(point, direction);

	local_dr[0] = returnTimeDerivativeFromSpatialDerivatives(local_metric, local_dr);

	fpnum[4] dr = [0, 0, 0, 0];

	/**Unrolled:for (byte i = 0; i < 4; i++)
	{
		for (byte j = 0; j < 4; j++)
		{
			dr[i] += tetrad[j * 4 + i] * local_dr[j];
		}
	}*/
	dr[0] = tetrad.at!(0) * local_dr[0] + tetrad.at!(
			4) * local_dr[1] + tetrad.at!(8) * local_dr[2] + tetrad.at!(12) * local_dr[3];
	dr[1] = tetrad.at!(1) * local_dr[0] + tetrad.at!(
			5) * local_dr[1] + tetrad.at!(9) * local_dr[2] + tetrad.at!(13) * local_dr[3];
	dr[2] = tetrad.at!(2) * local_dr[0] + tetrad.at!(
			6) * local_dr[1] + tetrad.at!(10) * local_dr[2] + tetrad.at!(14) * local_dr[3];
	dr[3] = tetrad.at!(3) * local_dr[0] + tetrad.at!(
			7) * local_dr[1] + tetrad.at!(11) * local_dr[2] + tetrad.at!(15) * local_dr[3];

	fpnum[4] d2r = [0, 0, 0, 0];

	//calculate the second derivatives
	/*Unrolled:for (byte i = 0; i < 4; i++)
	{
		for (byte a = 0; a < 4; a++)
		{
			for (byte b = 0; b < 4; b++)
			{
				d2r[i] += christoffels[i][a, b] * dr[a] * dr[b];
			}
		}
	}*/
	d2r[0] = -((christoffels[0].at!(0, 0)) * dr[0] * dr[0] + (2 * christoffels[0].at!(0,
			1)) * dr[0] * dr[1] + (2 * christoffels[0].at!(0, 2)) * dr[0] * dr[2] + (
			2 * christoffels[0].at!(0, 3)) * dr[0] * dr[3] + (christoffels[0].at!(1,
			1)) * dr[1] * dr[1] + (2 * christoffels[0].at!(1, 2)) * dr[1] * dr[2] + (
			2 * christoffels[0].at!(1, 3)) * dr[1] * dr[3] + (christoffels[0].at!(2,
			2)) * dr[2] * dr[2] + (2 * christoffels[0].at!(2, 3)) * dr[2] * dr[3] + (
			christoffels[0].at!(3, 3)) * dr[3] * dr[3]);
	d2r[1] = -((christoffels[1].at!(0, 0)) * dr[0] * dr[0] + (2 * christoffels[1].at!(0,
			1)) * dr[0] * dr[1] + (2 * christoffels[1].at!(0, 2)) * dr[0] * dr[2] + (
			2 * christoffels[1].at!(0, 3)) * dr[0] * dr[3] + (christoffels[1].at!(1,
			1)) * dr[1] * dr[1] + (2 * christoffels[1].at!(1, 2)) * dr[1] * dr[2] + (
			2 * christoffels[1].at!(1, 3)) * dr[1] * dr[3] + (christoffels[1].at!(2,
			2)) * dr[2] * dr[2] + (2 * christoffels[1].at!(2, 3)) * dr[2] * dr[3] + (
			christoffels[1].at!(3, 3)) * dr[3] * dr[3]);
	d2r[2] = -((christoffels[2].at!(0, 0)) * dr[0] * dr[0] + (2 * christoffels[2].at!(0,
			1)) * dr[0] * dr[1] + (2 * christoffels[2].at!(0, 2)) * dr[0] * dr[2] + (
			2 * christoffels[2].at!(0, 3)) * dr[0] * dr[3] + (christoffels[2].at!(1,
			1)) * dr[1] * dr[1] + (2 * christoffels[2].at!(1, 2)) * dr[1] * dr[2] + (
			2 * christoffels[2].at!(1, 3)) * dr[1] * dr[3] + (christoffels[2].at!(2,
			2)) * dr[2] * dr[2] + (2 * christoffels[2].at!(2, 3)) * dr[2] * dr[3] + (
			christoffels[2].at!(3, 3)) * dr[3] * dr[3]);
	d2r[3] = -((christoffels[3].at!(0, 0)) * dr[0] * dr[0] + (2 * christoffels[3].at!(0,
			1)) * dr[0] * dr[1] + (2 * christoffels[3].at!(0, 2)) * dr[0] * dr[2] + (
			2 * christoffels[3].at!(0, 3)) * dr[0] * dr[3] + (christoffels[3].at!(1,
			1)) * dr[1] * dr[1] + (2 * christoffels[3].at!(1, 2)) * dr[1] * dr[2] + (
			2 * christoffels[3].at!(1, 3)) * dr[1] * dr[3] + (christoffels[3].at!(2,
			2)) * dr[2] * dr[2] + (2 * christoffels[3].at!(2, 3)) * dr[2] * dr[3] + (
			christoffels[3].at!(3, 3)) * dr[3] * dr[3]);

	fpnum[4] local_d2r = [0, 0, 0, 0];
	//fpnum[4] local_d2r = [d2r[0], d2r[1], d2r[2], d2r[3]];

	for (byte i = 0; i < 4; i++)
	{
		for (byte j = 0; j < 4; j++)
		{
			local_d2r[i] += inv_tetrad[i * 4 + j] * d2r[j];
			/*Unrolled:for (byte k = 0; k < 4; k++)
			{
				acc += d_inv_tetrad[k][i * 4 + j] * dr[k];
			}*/
			local_d2r[i] += dr[j] * (d_inv_tetrad[0][i * 4 + j] * dr[0]
					+ d_inv_tetrad[1][i * 4 + j] * dr[1]
					+ d_inv_tetrad[2][i * 4 + j] * dr[2] + d_inv_tetrad[3][i * 4 + j] * dr[3]);
		}
	}

	Vectorf second = coords.transformBackSpacialSecondDerivatives(
			coords.transformForwardPosition(point), local_dr, local_d2r);

	return second;
}

fpnum[4] returnTransformedCartesianVectorAndPrepareInitiator(Vectorf point,
		Vectorf direction, Initiator init)
{
	init.prepareForRequest(point); //prepare initiator for future requests

	CoordinateChanger coords = init.coordinate_system;

	//get local metric at point
	Metric4 local_metric = init.getLocalMetricAtPoint;

	Matrix4f tetrad = init.getTetradsElementsAtPoint;

	fpnum[4] local_dr = coords.transformForwardSpacialFirstDerivatives(point, direction);
	local_dr[0] = returnTimeDerivativeFromSpatialDerivatives(local_metric, local_dr);

	fpnum[4] dr = [0, 0, 0, 0];

	/**Unrolled:for (byte i = 0; i < 4; i++)
	{
		for (byte j = 0; j < 4; j++)
		{
			dr[i] += tetrad[j * 4 + i] * local_dr[j];
		}
	}*/
	dr[0] = tetrad.at!(0) * local_dr[0] + tetrad.at!(
			4) * local_dr[1] + tetrad.at!(8) * local_dr[2] + tetrad.at!(12) * local_dr[3];
	dr[1] = tetrad.at!(1) * local_dr[0] + tetrad.at!(
			5) * local_dr[1] + tetrad.at!(9) * local_dr[2] + tetrad.at!(13) * local_dr[3];
	dr[2] = tetrad.at!(2) * local_dr[0] + tetrad.at!(
			6) * local_dr[1] + tetrad.at!(10) * local_dr[2] + tetrad.at!(14) * local_dr[3];
	dr[3] = tetrad.at!(3) * local_dr[0] + tetrad.at!(
			7) * local_dr[1] + tetrad.at!(11) * local_dr[2] + tetrad.at!(15) * local_dr[3];

	return dr;
}

//TODO: NOT CHECKED
Metric4[4] returnChristoffelsSymbols(const Metric4 g, const Metric4[3] dgs)
{
	Metric4[4] dg = Metric4(Matrix4f.Zero) ~ dgs;

	Metric4 inv_g = Metric4(g().inverse);

	Metric4[4] christoffel_symbols;

	for (byte y = 0; y < 4; y++)
	{
		for (byte a = 0; a < 4; a++)
		{
			for (byte b = 0; b < 4; b++)
			{
				for (byte p = 0; p < 4; p++)
				{
					christoffel_symbols[y][a, b] = christoffel_symbols[y][a, b] + inv_g[p,
						y] * (dg[a][b, p] + dg[b][a, p] - dg[p][a, b]);
				}
				christoffel_symbols[y][a, b] = christoffel_symbols[y][a, b] / 2;
			}
		}
	}

	return christoffel_symbols;
}
