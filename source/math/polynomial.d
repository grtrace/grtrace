module math.polynomial;

import grtrace;
import math.util;
import std.math;
import std.string, std.array;

struct Polynomial
{
	fpnum[] coeffs = [0];

	this(size_t deg)
	{
		coeffs.length = deg + 1;
		coeffs[0 .. $] = 0;
	}

	this(fpnum[] coef)
	{
		coeffs = coef;
	}

	this(ref Polynomial p)
	{
		coeffs = p.coeffs.dup;
	}

	@property size_t degree() const
	{
		return coeffs.length - 1;
	}

	@property size_t size() const
	{
		return coeffs.length;
	}

	@property Polynomial compress()
	{
		while (fabs(coeffs[$ - 1]) < eps)
		{
			coeffs.length = coeffs.length - 1;
		}
		return this;
	}

	Polynomial opBinary(string op)(fpnum d) const if (op == "*")
	{
		Polynomial res = Polynomial();
		res.coeffs = this.coeffs.dup;
		res.coeffs[] = coeffs[] * d;
		return res;
	}

	Polynomial opBinary(string op)(fpnum d) const if (op == "/")
	{
		Polynomial res = Polynomial();
		res.coeffs = this.coeffs.dup;
		res.coeffs[] = coeffs[] / d;
		return res;
	}

	Polynomial opBinary(string op)(Polynomial o) const if (op == "+")
	{
		if (degree > o.degree)
		{
			Polynomial R = Polynomial(degree);
			R.coeffs[0 .. o.size] = coeffs[0 .. o.size] + o.coeffs[0 .. o.size];
			R.coeffs[o.size .. $] = coeffs[o.size .. $];
			return R;
		}
		else
		{
			Polynomial R = Polynomial(o.degree);
			R.coeffs[0 .. size] = coeffs[0 .. size] + o.coeffs[0 .. size];
			R.coeffs[size .. $] = o.coeffs[size .. $];
			return R;
		}
	}

	Polynomial opBinary(string op)(Polynomial o) const if (op == "-")
	{
		auto size = this.size();
		if (degree > o.degree)
		{
			Polynomial R = Polynomial(degree);
			R.coeffs[0 .. o.size] = coeffs[0 .. o.size] - o.coeffs[0 .. o.size];
			R.coeffs[o.size .. $] = coeffs[o.size .. $];
			return R;
		}
		else
		{
			Polynomial R = Polynomial(o.degree);
			R.coeffs[0 .. size] = coeffs[0 .. size] - o.coeffs[0 .. size];
			R.coeffs[size .. $] = -o.coeffs[size .. $];
			return R;
		}
	}

	string toString()
	{
		import std.format;

		if (coeffs.length == 0)
		{
			return "0";
		}
		auto ap = appender("");
		for (ptrdiff_t i = coeffs.length - 1; i >= 0; i--)
		{
			ap.put("%+.2f * x^%d  ".format(coeffs[i], i));
		}
		return ap.data;
	}

	fpnum value(fpnum x)
	{
		real[] cfs;
		cfs.length = coeffs.length;
		cfs[] = cast(real[]) coeffs[];
		return cast(fpnum)(poly(cast(real) x, cfs));
	}

	@property Polynomial deriv() const
	{
		fpnum[] cfs;
		cfs.length = coeffs.length - 1;
		for (int i = 1; i < size; i++)
		{
			cfs[i - 1] = coeffs[i] * i;
		}
		return Polynomial(cfs);
	}

	Polynomial integr(fpnum C) const
	{
		fpnum[] cfs;
		cfs.length = coeffs.length + 1;
		for (int i = 0; i < size; i++)
		{
			cfs[i + 1] = coeffs[i] / (i + 1);
		}
		cfs[0] = C;
		return Polynomial(cfs);
	}

	/// Integral such that P(x)=val
	Polynomial integr(fpnum x, fpnum val) const
	{
		Polynomial P = integr(0);
		P.coeffs[0] = val - P.value(x);
		return P;
	}
}
