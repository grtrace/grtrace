module math.util;

import std.math;
import std.functional;

alias msin = sin;
alias mcos = cos;

T fsin(T)(T x)
{
	return cast(T)msin(cast(real)x);
}

T fcos(T)(T x)
{
	return cast(T)mcos(cast(real)x);
}

bool InRange(T)(T val, T min, T max)
{
	return (val>=min)&&(val<=max);
}
