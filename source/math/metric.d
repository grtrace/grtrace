module math.metric;

import config;
import math.matrix;

struct Metric4
{
	enum int[4][4] rcmap = [
		[ 0, 1, 2, 3 ],
		[ 1, 4, 5, 6 ],
		[ 2, 5, 7, 8 ],
		[ 3, 6, 8, 9 ]
	];
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
		assert(mat==mat.transposed);
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

	Matrix4f opCast(U)() if (is(U==Matrix4f))
	{
		return Matrix4f(
			vals[0], vals[1], vals[2], vals[3],
			vals[1], vals[4], vals[5], vals[6],
			vals[2], vals[5], vals[7], vals[8],
			vals[3], vals[6], vals[8], vals[9]
			);
	}

	Matrix4f opCall()
	{
		return cast(Matrix4f)this;
	}

	ref fpnum opIndex(int row, int col)
	{
		return vals[rcmap[row][col]];
	}

	alias vals this;
}
