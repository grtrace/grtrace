module math.util;

import std.math;
import std.functional;

alias msin = sin;
alias mcos = cos;

enum double DEG2RAD = 3.14159265 / 180.0;

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
