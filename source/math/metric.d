module math.metric;

import config;
import math.matrix;
import std.range, std.traits;

private enum int[4][4] ercmap = [[0, 1, 2, 3], [1, 4, 5, 6], [2, 5, 7, 8], [3, 6, 8, 9]];
private immutable rcmap = ercmap;

struct Metric4
{
	/**
	 * [ 0, 1, 2, 3 ]
	 * [ 1, 4, 5, 6 ]
	 * [ 2, 5, 7, 8 ]
	 * [ 3, 6, 8, 9 ]
	 */
	fpnum[10] vals;

	this(Matrix4f mat)
	in
	{
		assert(mat == mat.transposed);
	}
	body
	{
		vals[0] = mat[0];
		vals[1] = mat[1];
		vals[2] = mat[2];
		vals[3] = mat[3];
		vals[4] = mat[5];
		vals[5] = mat[6];
		vals[6] = mat[7];
		vals[7] = mat[10];
		vals[8] = mat[11];
		vals[9] = mat[15];
	}

	this(fpnum e0, fpnum e1, fpnum e2, fpnum e3, fpnum e4, fpnum e5, fpnum e6,
		fpnum e7, fpnum e8, fpnum e9)
	{
		vals[0] = e0;
		vals[1] = e1;
		vals[2] = e2;
		vals[3] = e3;
		vals[4] = e4;
		vals[5] = e5;
		vals[6] = e6;
		vals[7] = e7;
		vals[8] = e8;
		vals[9] = e9;
	}

	Matrix4f opCast(U)() const if (is(U == Matrix4f))
	{
		return Matrix4f(vals[0], vals[1], vals[2], vals[3], vals[1], vals[4],
			vals[5], vals[6], vals[2], vals[5], vals[7], vals[8], vals[3],
			vals[6], vals[8], vals[9]);
	}

	Matrix4f opCall() const
	{
		return cast(Matrix4f) this;
	}

	ref fpnum opIndex(int row, int col)
	{
		return vals[rcmap[row][col]];
	}
	
	/// Fast compile-time indexed fetch
	ref fpnum at(int row, int col)()
	{
		return vals[ercmap[row][col]];
	}

	alias vals this;
}
