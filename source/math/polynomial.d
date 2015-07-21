module math.polynomial;

import config;
import math.util;
import std.math;

struct Polynomial
{
	fpnum[] coeffs;

	this(size_t deg=0)
	{
		coeffs.length = deg+1;
	}

	@property size_t degree()
	{
		return coeffs.length-1;
	}

	@property size_t size()
	{
		return coeffs.length;
	}

	@property Polynomial compress()
	{
		while(fabs(coeffs[$-1])<eps)
		{
			coeffs.length--;
		}
		return this;
	}

	Polynomial opBinary(string op)(Polynomial o) const if (op=="+")
	{
		if(degree>o.degree)
		{
			Polynomial R = Polynomial(degree);
			R.coeffs[0..o.size] = o.coeffs[0..o.size] + coeffs[0..o.size];
			R.coeffs[o.size..$] = coeffs[o.size..$];
			return R;
		}
		else
		{
			Polynomial R = Polynomial(o.degree);
			R.coeffs[0..size] = o.coeffs[0..size] + coeffs[0..size];
			R.coeffs[size..$] = o.coeffs[size..$];
			return R;
		}
	}

	Polynomial opBinary(string op)(Polynomial o) const if (op=="-")
	{
		if(degree>o.degree)
		{
			Polynomial R = Polynomial(degree);
			R.coeffs[0..o.size] = o.coeffs[0..o.size] - coeffs[0..o.size];
			R.coeffs[o.size..$] = coeffs[o.size..$];
			return R.compress;
		}
		else
		{
			Polynomial R = Polynomial(o.degree);
			R.coeffs[0..size] = o.coeffs[0..size] - coeffs[0..size];
			R.coeffs[size..$] = o.coeffs[size..$];
			return R.compress;
		}
	}
}
