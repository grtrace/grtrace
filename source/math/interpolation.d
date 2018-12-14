module math.interpolation;

import image.color;
import grtrace;
import math.polynomial;

fpnum LinearInterpolation(fpnum a, fpnum b, fpnum weight)
{
	return (1 - weight) * a + weight * b;
}

Color LinearInterpolation(Color a, Color b, fpnum weight)
{
	return Color(LinearInterpolation(a.r, b.r, weight),
			LinearInterpolation(a.g, a.g, weight), LinearInterpolation(a.b, a.b, weight));
}

fpnum BilinearInterpolation(fpnum a, fpnum b, fpnum c, fpnum d, fpnum U, fpnum V)
{
	return c * (1 - U) * (1 - V) + d * U * (1 - V) + a * (1 - U) * V + b * U * V;
}

Color BilinearInterpolation(Color a, Color b, Color c, Color d, fpnum U, fpnum V)
{
	return Color(BilinearInterpolation(a.r, b.r, c.r, d.r, U, V),
			BilinearInterpolation(a.g, b.g, c.g, d.g, U, V),
			BilinearInterpolation(a.b, b.b, c.b, d.b, U, V));
}

fpnum TrilinearInterpolation(fpnum C000, fpnum C010, fpnum C100, fpnum C110,
		fpnum C001, fpnum C011, fpnum C101, fpnum C111, fpnum X, fpnum Y, fpnum Z)
{
	return LinearInterpolation(BilinearInterpolation(C000, C010, C100, C110, X,
			Y), BilinearInterpolation(C001, C011, C101, C111, X, Y), Z);
}

//multiply polynomial by x-a
private Polynomial MultiplyByLinear(fpnum a, in Polynomial p)
{
	Polynomial tmp = Polynomial();
	tmp.coeffs = p.coeffs.dup;
	Polynomial pa = p * a;
	tmp.coeffs = [cast(fpnum) 0] ~ p.coeffs;
	tmp = tmp - pa;
	return tmp;
}

Polynomial PolynomialInterpolation(fpnum[] x, fpnum[] y)
in
{
	assert(x.length == y.length);
}
body
{
	Polynomial res = Polynomial(x.length - 1);

	for (int i = 0; i < x.length; i++)
	{
		Polynomial tmp = Polynomial(0);
		tmp.coeffs[0] = 1;

		fpnum mul = 1;

		for (int j = 0; j < x.length; j++)
		{
			if (i == j)
				continue;
			tmp = MultiplyByLinear(x[j], tmp);
			mul *= x[i] - x[j];
		}
		mul = y[i] / mul;
		tmp = tmp * mul;
		res = res + tmp;
	}

	return res;
}
