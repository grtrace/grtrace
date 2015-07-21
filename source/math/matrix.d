module math.matrix;
 
import std.math;
import math.util;
import math.vector;
import config;

struct Matrix4(T)
{
private:

	pragma(inline, true) T det3(	
		T a0, T a1, T a2,
		T a3, T a4, T a5,
		T a6, T a7, T a8)
	{
		return a0*(a4*a8-a5*a7) + a1*(a5*a6-a3*a8) + a2*(a3*a7-a4*a6);
	}

public:
	T[16] vals;

	static enum Matrixes : Matrix4!T
	{
		Zero = Matrix4!T(
			0,0,0,0,
			0,0,0,0,
			0,0,0,0,
			0,0,0,0),
		Indentity = Matrix4!T(
			1,0,0,0,
			0,1,0,0,
			0,0,1,0,
			0,0,0,1)
	}

	static Matrix4!T Translation(Vector!T vec)
	{
		return Matrix4!T(
			1,0,0,vec.x,
			0,1,0,vec.y,
			0,0,1,vec.z,
			0,0,0,1);
	}

	static Matrix4!T Scale(Vector!T vec)
	{
		return Matrix4!T(
			vec.x,0,0,0,
			0,vec.y,0,0,
			0,0,vec.z,0,
			0,0,0,    1);
	}

	static Matrix4!T RotateZ(T angle)
	{
		return Matrix4!T(
			fcos!T(angle), -fsin!T(angle), 0, 0,
			fsin!T(angle), fcos!T(angle),  0, 0,
			0,             0,              1, 0,
			0,             0,              0, 1
			);
	}

	static Matrix4!T RotateX(T angle)
	{
		return Matrix4!T(
			1, 0,             0,              0,
			0, fcos!T(angle), -fsin!T(angle), 0,
			0, fsin!T(angle), fcos!T(angle),  0,
			0, 0,             0,              1
			);
	}

	static Matrix4!T RotateY(T angle)
	{
		return Matrix4!T(
			fcos!T(angle),  0, fsin!T(angle), 0,
			0,              1, 0,             0,
			-fsin!T(angle), 0, fcos!T(angle), 0,
			0,              0, 0,             1
			);
	}

	static Matrix4!T Rotate(Vector!T axis, T angle)
	in
	{
		assert(fabs(*axis - 1.0)<eps);
	}
	body
	{
		return Matrix4!T(
			fcos!T(angle) + axis.x*axis.x*(1- fcos!T(angle)),
			axis.x*axis.y*(1-fcos!T(angle)) - axis.z*fsin!T(angle),
			axis.x*axis.z*(1-fcos!T(angle)) + axis.y*fsin!T(angle),
			0,

			axis.y*axis.x*(1-fcos!T(angle)) + axis.z*fsin!T(angle),
			fcos!T(angle) + axis.y*axis.y*(1-fcos!T(angle)),
			axis.y*axis.z*(1-fcos!T(angle)) - axis.x*fsin!T(angle),
			0,

			axis.z*axis.x*(1-fcos!T(angle)) - axis.y*fsin!T(angle),
			axis.z*axis.y*(1-fcos!T(angle)) + axis.x*fsin!T(angle),
			fcos!T(angle) + axis.z*axis.z*(1-fcos!T(angle)),
			0,
			0,0,0,1
			);
	}

	this(
		T e0 , T e1 , T e2 , T e3 ,
		T e4 , T e5 , T e6 , T e7 ,
		T e8 , T e9, T e10, T e11,
		T e12, T e13, T e14, T e15)
	{
		vals[0] = e0;   vals[1] = e1;   vals[2] = e2;   vals[3] = e3;
		vals[4] = e4;   vals[5] = e5;   vals[6] = e6;   vals[7] = e7;
		vals[8] = e8;   vals[9] = e9;   vals[10] = e10; vals[11] = e11;
		vals[12] = e12; vals[13] = e13; vals[14] = e14; vals[15] = e15;
	}

	@property Matrix4!T transposed()
	{
		Matrix4!T res;

		res.vals[0] = vals[0];
		res.vals[1] = vals[4];
		res.vals[2] = vals[8];
		res.vals[3] = vals[12];
		res.vals[4] = vals[1];
		res.vals[5] = vals[5];
		res.vals[6] = vals[9];
		res.vals[7] = vals[13];
		res.vals[8] = vals[2];
		res.vals[9] = vals[6];
		res.vals[10] = vals[10];
		res.vals[11] = vals[14];
		res.vals[12] = vals[3];
		res.vals[13] = vals[7];
		res.vals[14] = vals[11];
		res.vals[15] = vals[15];

		return res;
	}

	@property T determinant()
	{
		return vals[12] * vals[9] * vals[6] * vals[3] - vals[8] * vals[13] * vals[6] * vals[3] - vals[12] * vals[5] * vals[10] * vals[3] + vals[
			4] * vals[13] * vals[10] * vals[3] + vals[8] * vals[5] * vals[14] * vals[3] - vals[4] * vals[9] * vals[14] * vals[3] - vals[12] * vals[
			9] * vals[2] * vals[7] + vals[8] * vals[13] * vals[2] * vals[7] + vals[12] * vals[1] * vals[10] * vals[7] - vals[0] * vals[13] * vals[
			10] * vals[7] - vals[8] * vals[1] * vals[14] * vals[7] + vals[0] * vals[9] * vals[14] * vals[7] + vals[12] * vals[5] * vals[2] * vals[
			11] - vals[4] * vals[13] * vals[2] * vals[11] - vals[12] * vals[1] * vals[6] * vals[11] + vals[0] * vals[13] * vals[6] * vals[
			11] + vals[4] * vals[1] * vals[14] * vals[11] - vals[0] * vals[5] * vals[14] * vals[11] - vals[8] * vals[5] * vals[2] * vals[15] + vals[
			4] * vals[9] * vals[2] * vals[15] + vals[8] * vals[1] * vals[6] * vals[15] - vals[0] * vals[9] * vals[6] * vals[15] - vals[4] * vals[
			1] * vals[10] * vals[15] + vals[0] * vals[5] * vals[10] * vals[15];
	}

	@property Matrix4!T inverse()
	in
	{
		assert(this.determinant != 0);
	}
	body
	{
		Matrix4!T tmp;

		tmp.vals[0] = det3(
			vals[5],  vals[6],  vals[7],
			vals[9],  vals[10], vals[11],
			vals[13], vals[14], vals[15]);

		tmp.vals[1] = -det3(
			vals[4],  vals[6],  vals[7],
			vals[8],  vals[10], vals[11],
			vals[12], vals[14], vals[15]);

		tmp.vals[2] = det3(
			vals[4],  vals[5],  vals[7],
			vals[8],  vals[9],  vals[11],
			vals[12], vals[13], vals[15]);

		tmp.vals[3] = -det3(
			vals[4], vals[5], vals[6],
			vals[8], vals[9], vals[10],
			vals[12], vals[13], vals[14]);


		tmp.vals[4] = -det3(
			vals[1],  vals[2],  vals[3],
			vals[9],  vals[10], vals[11],
			vals[13], vals[14], vals[15]);
		
		tmp.vals[5] = det3(
			vals[0],  vals[2],  vals[3],
			vals[8],  vals[10], vals[11],
			vals[12], vals[14], vals[15]);
		
		tmp.vals[6] = -det3(
			vals[0],  vals[1],  vals[3],
			vals[8],  vals[9],  vals[11],
			vals[12], vals[13], vals[15]);
		
		tmp.vals[7] = det3(
			vals[0],  vals[1],  vals[2],
			vals[8],  vals[9],  vals[10],
			vals[12], vals[13], vals[14]);


		tmp.vals[8] = det3(
			vals[1],  vals[2],  vals[3],
			vals[5],  vals[6],  vals[7],
			vals[13], vals[14], vals[15]);
		
		tmp.vals[9] = -det3(
			vals[0],  vals[2],  vals[3],
			vals[4],  vals[6],  vals[7],
			vals[12], vals[14], vals[15]);
		
		tmp.vals[10] = det3(
			vals[0],  vals[1],  vals[3],
			vals[4],  vals[5],  vals[7],
			vals[12], vals[13], vals[15]);
		
		tmp.vals[11] = -det3(
			vals[0],  vals[1],  vals[2],
			vals[4],  vals[5],  vals[6],
			vals[12], vals[13], vals[14]);


		tmp.vals[12] = -det3(
			vals[1],  vals[2],  vals[3],
			vals[5],  vals[6],  vals[7],
			vals[9],  vals[10], vals[11]);
		
		tmp.vals[13] = det3(
			vals[0],  vals[2],  vals[3],
			vals[4],  vals[6],  vals[7],
			vals[8],  vals[10], vals[11]);
		
		tmp.vals[14] = -det3(
			vals[0],  vals[1],  vals[3],
			vals[4],  vals[5],  vals[7],
			vals[8],  vals[9],  vals[11]);
		
		tmp.vals[15] = det3(
			vals[0], vals[1], vals[2],
			vals[4], vals[5], vals[6],
			vals[8], vals[9], vals[10]);

		return tmp.transposed/this.determinant;
	}

	auto ref T opIndex()(size_t i) const
	in
	{
		assert( (i>=0)&&(i<16) );
	}
	body
	{
		return vals[i];
	}

	void opIndexAssign()(T val, size_t i)
	in
	{
		assert( (i>=0)&&(i<16) );
	}
	body
	{
		vals[i]=val;
	}

	Matrix4!T opBinary(string op)(Matrix4!T rhs) if (op=="+"||op=="-"||op=="*")
	{
		Matrix4!T res;

		static if(op=="+" || op=="-")
		{
			res.vals[] = mixin("vals[]"~op~"rhs.vals[]");

			return res;
		}
		static if(op=="*")
		{
			res[0]  = vals[0+4*0]*rhs.vals[0+4*0] + vals[1+4*0]*rhs.vals[0+4*1] + vals[2+4*0]*rhs.vals[0+4*2] + vals[3+4*0]*rhs.vals[0+4*3];
			res[1]  = vals[0+4*0]*rhs.vals[1+4*0] + vals[1+4*0]*rhs.vals[1+4*1] + vals[2+4*0]*rhs.vals[1+4*2] + vals[3+4*0]*rhs.vals[1+4*3];
			res[2]  = vals[0+4*0]*rhs.vals[2+4*0] + vals[1+4*0]*rhs.vals[2+4*1] + vals[2+4*0]*rhs.vals[2+4*2] + vals[3+4*0]*rhs.vals[2+4*3];
			res[3]  = vals[0+4*0]*rhs.vals[3+4*0] + vals[1+4*0]*rhs.vals[3+4*1] + vals[2+4*0]*rhs.vals[3+4*2] + vals[3+4*0]*rhs.vals[3+4*3];

			res[4]  = vals[0+4*1]*rhs.vals[0+4*0] + vals[1+4*1]*rhs.vals[0+4*1] + vals[2+4*1]*rhs.vals[0+4*2] + vals[3+4*1]*rhs.vals[0+4*3];
			res[5]  = vals[0+4*1]*rhs.vals[1+4*0] + vals[1+4*1]*rhs.vals[1+4*1] + vals[2+4*1]*rhs.vals[1+4*2] + vals[3+4*1]*rhs.vals[1+4*3];
			res[6]  = vals[0+4*1]*rhs.vals[2+4*0] + vals[1+4*1]*rhs.vals[2+4*1] + vals[2+4*1]*rhs.vals[2+4*2] + vals[3+4*1]*rhs.vals[2+4*3];
			res[7]  = vals[0+4*1]*rhs.vals[3+4*0] + vals[1+4*1]*rhs.vals[3+4*1] + vals[2+4*1]*rhs.vals[3+4*2] + vals[3+4*1]*rhs.vals[3+4*3];

			res[8]  = vals[0+4*2]*rhs.vals[0+4*0] + vals[1+4*2]*rhs.vals[0+4*1] + vals[2+4*2]*rhs.vals[0+4*2] + vals[3+4*2]*rhs.vals[0+4*3];
			res[9]  = vals[0+4*2]*rhs.vals[1+4*0] + vals[1+4*2]*rhs.vals[1+4*1] + vals[2+4*2]*rhs.vals[1+4*2] + vals[3+4*2]*rhs.vals[1+4*3];
			res[10] = vals[0+4*2]*rhs.vals[2+4*0] + vals[1+4*2]*rhs.vals[2+4*1] + vals[2+4*2]*rhs.vals[2+4*2] + vals[3+4*2]*rhs.vals[2+4*3];
			res[11] = vals[0+4*2]*rhs.vals[3+4*0] + vals[1+4*2]*rhs.vals[3+4*1] + vals[2+4*2]*rhs.vals[3+4*2] + vals[3+4*2]*rhs.vals[3+4*3];

			res[12]  = vals[0+4*3]*rhs.vals[0+4*0] + vals[1+4*3]*rhs.vals[0+4*1] + vals[2+4*3]*rhs.vals[0+4*2] + vals[3+4*3]*rhs.vals[0+4*3];
			res[13]  = vals[0+4*3]*rhs.vals[1+4*0] + vals[1+4*3]*rhs.vals[1+4*1] + vals[2+4*3]*rhs.vals[1+4*2] + vals[3+4*3]*rhs.vals[1+4*3];
			res[14]  = vals[0+4*3]*rhs.vals[2+4*0] + vals[1+4*3]*rhs.vals[2+4*1] + vals[2+4*3]*rhs.vals[2+4*2] + vals[3+4*3]*rhs.vals[2+4*3];
			res[15]  = vals[0+4*3]*rhs.vals[3+4*0] + vals[1+4*3]*rhs.vals[3+4*1] + vals[2+4*3]*rhs.vals[3+4*2] + vals[3+4*3]*rhs.vals[3+4*3];

			return res;
		}
	}

	Vector!T opBinary(string op)(Vector!T rhs) if (op=="*")
	{
		return Vector!T(
			vals[0+4*0]*rhs.x + vals[1+4*0]*rhs.y + vals[2+4*0]*rhs.z + vals[3+4*0]*rhs.w,
			vals[0+4*1]*rhs.x + vals[1+4*1]*rhs.y + vals[2+4*1]*rhs.z + vals[3+4*1]*rhs.w,
			vals[0+4*2]*rhs.x + vals[1+4*2]*rhs.y + vals[2+4*2]*rhs.z + vals[3+4*2]*rhs.w
			);
	}

	Matrix4!T opBinary(string op)(T rhs) if(op=="*"||op=="/")
	{
		Matrix4!T res;
		res.vals[] = mixin( "vals[]"~op~"rhs" );
		return res;
	}

	void opAssign(Matrix4!T rhs)
	{
		vals[] = rhs.vals[];
	}
}

alias Matrix4f = Matrix4!fpnum;
alias Matrix4i = Matrix4!inum;
alias Matrix4u = Matrix4!unum;

unittest
{
	import std.stdio;
	import std.random;
	Matrix4f a = Matrix4f.Matrixes.Indentity*20;
	while(true)
	{
	for(int i = 0; i<16; i++) a[i] = uniform(0,100);

	//for(int i = 0; i<16; i++) { if(i%4==0) writeln(); writef("%.1f ",a[i]);}

	auto b = a*a.inverse;
	writeln();

	for(int i = 0; i<16; i++) { if(i%4==0) writeln(); writef("%.1f ",b[i]);}
	}
}
