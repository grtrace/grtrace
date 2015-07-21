module math.polynomial;

import config;
import math.util;
import std.math;
import std.string, std.array;

struct Polynomial
{
	fpnum[] coeffs = [0];

	this(size_t deg)
	{
		coeffs.length = deg+1;
	}

	@property size_t degree() const
	{
		return coeffs.length-1;
	}

	@property size_t size() const
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

	Polynomial opBinary(string op)(fpnum d) const if (op=="*"||op=="/")
	{
		Polynomial res = Polynomial(degree);
		res.coeffs[] = mixin("coeffs[]"~op~"d");
		return res;
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

	string toString()
	{
		import std.format;
		auto ap = appender("");
		if(coeffs.length==0)
		{
			return "0";
		}
		for(ptrdiff_t i=coeffs.length-1;i>=0;i--)
		{
			ap.put("%+.2f*x^%d ".format(coeffs[i],i));
		}
		return ap.data;
	}
}
