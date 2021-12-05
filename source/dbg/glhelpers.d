module dbg.glhelpers;

import glad.gl.all;
import glad.gl.loader;
import bindbc.glfw;
import std.conv, std.math;
import std.string, std.algorithm;
public import std.exception;

private string LoadFileAsStrRet(string path)
{
	import std.file : readText;

	return readText!string(path);
}

/// Floating-point type
alias GFXnum = float;
/// Integer type
alias GFXint = int;
/// Unsigned integer type
alias GFXuint = uint;
private GFXnum _dummy_num = GFXnum.nan;

/// 3D Vector type
struct GFXvector3
{
	/// X
	GFXnum x = 0;
	/// Y
	GFXnum y = 0;
	/// Z
	GFXnum z = 0;
	alias v0 = x;
	alias v1 = y;
	alias v2 = z;

	/// Convert to GFXvector4
	GFXvector4 to4(GFXnum w = 0)
	{
		return gVec4(x, y, z, w);
	}

	GFXvector3 opUnary(string op)() if (op == "-")
	{
		return GFXvector3(-x, -y, -z);
	}

	GFXvector3 opUnary(string op)() if (op == "+")
	{
		return GFXvector3(x, y, z);
	}

	GLdouble* opCast(T : GLdouble*)()
	{
		return [x, y, z].ptr;
	}

	float[] arr()
	{
		return [x, y, z];
	}

	private static pure string strOpBinary(string op)
	{
		return "GFXvector3 opBinary(string op)(GFXvector3 o) if(op==\"" ~ op ~ "\")"
			~ "{return GFXvector3(x" ~ op ~ "o.x," ~ "y" ~ op ~ "o.y, z" ~ op ~ "o.z);}";
	}

	public ref GFXnum opIndex(size_t i) return
	{
		switch (i)
		{
		case 0:
			return x;
		case 1:
			return y;
		case 2:
			return z;
		default:
			return _dummy_num;
		}
	}

	mixin(strOpBinary("+"));
	mixin(strOpBinary("-"));
	mixin(strOpBinary("*"));
	mixin(strOpBinary("/"));

}

/// 4D Vector type
struct GFXvector4
{
	/// X
	GFXnum x = 0;
	/// Y
	GFXnum y = 0;
	/// Z
	GFXnum z = 0;
	/// W
	GFXnum w = 0;
	alias v0 = x;
	alias v1 = y;
	alias v2 = z;
	alias v3 = w;

	/// Convert to GFXvector3 (cut out w coordinate)
	GFXvector3 to3()
	{
		return gVec3(x, y, z);
	}

	float[] arr()
	{
		return [x, y, z, w];
	}

	GFXvector4 opUnary(string op)() if (op == "-")
	{
		return GFXvector4(-x, -y, -z, -w);
	}

	GFXvector4 opUnary(string op)() if (op == "+")
	{
		return GFXvector4(x, y, z, w);
	}

	GLdouble* opCast(T : GLdouble*)()
	{
		return [x, y, z, w].ptr;
	}

	private static pure string strOpBinary(string op)
	{
		return "GFXvector4 opBinary(string op)(GFXvector4 o) if(op==\"" ~ op ~ "\")"
			~ "{return GFXvector4(x" ~ op ~ "o.x," ~ "y" ~ op ~ "o.y, z" ~ op
			~ "o.z,w" ~ op ~ "o.w);}";
	}

	public ref GFXnum opIndex(size_t i) return
	{
		switch (i)
		{
		case 0:
			return x;
		case 1:
			return y;
		case 2:
			return z;
		case 3:
			return w;
		default:
			return _dummy_num;
		}
	}

	mixin(strOpBinary("+"));
	mixin(strOpBinary("-"));
	mixin(strOpBinary("*"));
	mixin(strOpBinary("/"));
}

/// 3x3 matrix type
alias GFXmatrix3 = GFXnum[9];
/// 4x4 matrix type
alias GFXmatrix4 = GFXnum[16];

// ---------------------------------------------------------
//  Basic vector operations
// ---------------------------------------------------------

/// Helper for creating new 3d vector
GFXvector3 gVec3(GFXnum x, GFXnum y, GFXnum z)
{
	return GFXvector3(x, y, z);
}

/// Helper for creating new 4d vector
GFXvector4 gVec4(GFXnum x, GFXnum y, GFXnum z, GFXnum w)
{
	return GFXvector4(x, y, z, w);
}

/// Vector3 dot product (a . b)
GFXnum gDot3(GFXvector3 a, GFXvector3 b)
{
	return a.x * b.x + a.y * b.y + a.z * b.z;
}

/// Vector3 cross product (a x b)
GFXvector3 gCross3(GFXvector3 a, GFXvector3 b)
{
	return gVec3(a.y * b.z - a.z * b.y, a.z * b.x - a.x * b.z, a.x * b.y - a.y * b.x);
}

/// Vector4 dot product (a . b)
GFXnum gDot4(GFXvector4 a, GFXvector4 b)
{
	return a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w;
}

/// Convert homogenous vector to a 3d vector
GFXvector3 gFromHomogenous(GFXvector4 X)
{
	return gVec3(X.x / X.w, X.y / X.w, X.z / X.w);
}

/// Calculates the square of length of a Vector3
GFXnum gLengthSq3(GFXvector3 A)
{
	return ((A.x * A.x) + (A.y * A.y) + (A.z * A.z));
}

/// Calculates the length of a Vector3
GFXnum gLength3(GFXvector3 A)
{
	return sqrt(gLengthSq3(A));
}

/// Returns normalized Vector3
GFXvector3 gNormalize3(GFXvector3 A)
{
	GFXnum len = gLength3(A);
	return gVec3(A.x / len, A.y / len, A.z / len);
}

// ---------------------------------------------------------
//  Matrix operations 
// ---------------------------------------------------------

/// Returns an 3x3 identity matrix
GFXmatrix3 gIdentity3()
{
	return [1, 0, 0, 0, 1, 0, 0, 0, 1];
}

/// Returns an 4x4 identity matrix
GFXmatrix4 gIdentity4()
{
	return [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1];
}

/// Returns product of 3x3 matrices (A x B)
GFXmatrix3 gMat3Mul(GFXmatrix3 A, GFXmatrix3 B)
{
	GFXnum[3] C1 = [B[0], B[3], B[6]];
	GFXnum[3] C2 = [B[1], B[4], B[7]];
	GFXnum[3] C3 = [B[2], B[5], B[8]];
	GFXmatrix3 O;
	GFXnum[3] T;
	for (int i = 0; i < 3; i++)
	{
		GFXnum[3] R = A[i .. i + 3];
		T[] = R[] * C1[];
		O[3 * i + 0] = T[0] + T[1] + T[2];
		T[] = R[] * C2[];
		O[3 * i + 1] = T[0] + T[1] + T[2];
		T[] = R[] * C3[];
		O[3 * i + 2] = T[0] + T[1] + T[2];
	}
	return O;
}

GFXvector4 gVecMatTransform(GFXmatrix4 M, GFXvector4 V)
{
	return gVec4(M[0] * (V.x) + M[1] * (V.y) + M[2] * V.z + M[3] * V.w,
			M[4] * (V.x) + M[5] * (V.y) + M[6] * V.z + M[7] * V.w,
			M[8] * (V.x) + M[9] * (V.y) + M[10] * V.z + M[11] * V.w,
			M[12] * (V.x) + M[13] * (V.y) + M[14] * V.z + M[15] * V.w);
}

/// Returns product of 4x4 matrices (A x B)
GFXmatrix4 gMat4Mul(GFXmatrix4 A, GFXmatrix4 B)
{
	GFXnum[4] C1 = [B[0], B[4], B[8], B[12]];
	GFXnum[4] C2 = [B[1], B[5], B[9], B[13]];
	GFXnum[4] C3 = [B[2], B[6], B[10], B[14]];
	GFXnum[4] C4 = [B[3], B[7], B[11], B[15]];
	GFXmatrix4 O;
	GFXnum[4] T;
	for (int i = 0; i < 4; i++)
	{
		GFXnum[4] R = A[4 * i .. 4 * (i + 1)];
		T[] = R[] * C1[];
		O[4 * i + 0] = T[0] + T[1] + T[2] + T[3];
		T[] = R[] * C2[];
		O[4 * i + 1] = T[0] + T[1] + T[2] + T[3];
		T[] = R[] * C3[];
		O[4 * i + 2] = T[0] + T[1] + T[2] + T[3];
		T[] = R[] * C4[];
		O[4 * i + 3] = T[0] + T[1] + T[2] + T[3];
	}
	return O;
}

/// Transposes 3x3 matrix (A^T)
GFXmatrix3 gMat3Transpose(GFXmatrix3 A)
{
	GFXmatrix3 T;
	T[0] = A[0];
	T[1] = A[3];
	T[2] = A[6];
	T[3] = A[1];
	T[4] = A[4];
	T[5] = A[7];
	T[6] = A[2];
	T[7] = A[5];
	T[8] = A[8];
	return T;
}

/// Transposes 4x4 matrix (A^T)
GFXmatrix4 gMat4Transpose(GFXmatrix4 A)
{
	GFXmatrix4 T;
	T[0] = A[0];
	T[1] = A[4];
	T[2] = A[8];
	T[3] = A[12];
	T[4] = A[1];
	T[5] = A[5];
	T[6] = A[9];
	T[7] = A[13];
	T[8] = A[2];
	T[9] = A[6];
	T[10] = A[10];
	T[11] = A[14];
	T[12] = A[3];
	T[13] = A[7];
	T[14] = A[11];
	T[15] = A[15];
	return T;
}

/// Calculates the determinant of 3x3 matrix (|A|)
GFXnum gMat3Det(GFXmatrix3 A)
{
	GFXnum D = 0;
	D += A[0] * (A[4] * A[8] - A[5] * A[7]);
	D -= A[1] * (A[3] * A[8] - A[5] * A[6]);
	D += A[2] * (A[3] * A[7] - A[4] * A[6]);
	return D;
}

/// Calculates the determinant of 4x4 matrix (|A|)
/// Thanks http://stackoverflow.com/questions/2922690/calculating-an-nxn-matrix-determinant-in-c-sharp/2980966#2980966
GFXnum gMat4Det(GFXmatrix4 A)
{
	return A[12] * A[9] * A[6] * A[3] - A[8] * A[13] * A[6] * A[3] - A[12] * A[5]
		* A[10] * A[3] + A[4] * A[13] * A[10] * A[3] + A[8] * A[5] * A[14] * A[3]
		- A[4] * A[9] * A[14] * A[3] - A[12] * A[9] * A[2] * A[7] + A[8] * A[13]
		* A[2] * A[7] + A[12] * A[1] * A[10] * A[7] - A[0] * A[13] * A[10] * A[7]
		- A[8] * A[1] * A[14] * A[7] + A[0] * A[9] * A[14] * A[7] + A[12] * A[5]
		* A[2] * A[11] - A[4] * A[13] * A[2] * A[11] - A[12] * A[1] * A[6]
		* A[11] + A[0] * A[13] * A[6] * A[11] + A[4] * A[1] * A[14] * A[11]
		- A[0] * A[5] * A[14] * A[11] - A[8] * A[5] * A[2] * A[15] + A[4] * A[9]
		* A[2] * A[15] + A[8] * A[1] * A[6] * A[15] - A[0] * A[9] * A[6] * A[15]
		- A[4] * A[1] * A[10] * A[15] + A[0] * A[5] * A[10] * A[15];
}

/// Calculates the inverse of a 4x4 matrix
GFXmatrix4 gMat4Inverse(GFXmatrix4 vals)
{
	GFXmatrix4 tmp;

	tmp[0] = gMat3Det([vals[5], vals[6], vals[7], vals[9], vals[10], vals[11],
			vals[13], vals[14], vals[15]]);

	tmp[1] = -gMat3Det([vals[4], vals[6], vals[7], vals[8], vals[10], vals[11],
			vals[12], vals[14], vals[15]]);

	tmp[2] = gMat3Det([vals[4], vals[5], vals[7], vals[8], vals[9], vals[11],
			vals[12], vals[13], vals[15]]);

	tmp[3] = -gMat3Det([vals[4], vals[5], vals[6], vals[8], vals[9], vals[10],
			vals[12], vals[13], vals[14]]);

	tmp[4] = -gMat3Det([vals[1], vals[2], vals[3], vals[9], vals[10], vals[11],
			vals[13], vals[14], vals[15]]);

	tmp[5] = gMat3Det([vals[0], vals[2], vals[3], vals[8], vals[10], vals[11],
			vals[12], vals[14], vals[15]]);

	tmp[6] = -gMat3Det([vals[0], vals[1], vals[3], vals[8], vals[9], vals[11],
			vals[12], vals[13], vals[15]]);

	tmp[7] = gMat3Det([vals[0], vals[1], vals[2], vals[8], vals[9], vals[10],
			vals[12], vals[13], vals[14]]);

	tmp[8] = gMat3Det([vals[1], vals[2], vals[3], vals[5], vals[6], vals[7],
			vals[13], vals[14], vals[15]]);

	tmp[9] = -gMat3Det([vals[0], vals[2], vals[3], vals[4], vals[6], vals[7],
			vals[12], vals[14], vals[15]]);

	tmp[10] = gMat3Det([vals[0], vals[1], vals[3], vals[4], vals[5], vals[7],
			vals[12], vals[13], vals[15]]);

	tmp[11] = -gMat3Det([vals[0], vals[1], vals[2], vals[4], vals[5], vals[6],
			vals[12], vals[13], vals[14]]);

	tmp[12] = -gMat3Det([vals[1], vals[2], vals[3], vals[5], vals[6], vals[7],
			vals[9], vals[10], vals[11]]);

	tmp[13] = gMat3Det([vals[0], vals[2], vals[3], vals[4], vals[6], vals[7],
			vals[8], vals[10], vals[11]]);

	tmp[14] = -gMat3Det([vals[0], vals[1], vals[3], vals[4], vals[5], vals[7],
			vals[8], vals[9], vals[11]]);

	tmp[15] = gMat3Det([vals[0], vals[1], vals[2], vals[4], vals[5], vals[6],
			vals[8], vals[9], vals[10]]);

	return gMat4Scale(gMat4Transpose(tmp), 1 / gMat4Det(vals));
}

/// Returns 3x3 matrix multiplied by a scalar (A*n)
GFXmatrix3 gMat3Scale(GFXmatrix3 A, GFXnum n)
{
	GFXmatrix3 S = A.dup;
	S[] *= n;
	return S;
}

/// Returns 4x4 matrix multiplied by a scalar (A*n)
GFXmatrix4 gMat4Scale(GFXmatrix4 A, GFXnum n)
{
	GFXmatrix4 S = A.dup;
	S[] *= n;
	return S;
}

/// -
GFXmatrix4 gMatTranslation(GFXvector3 v)
{
	return [1, 0, 0, v.x, 0, 1, 0, v.y, 0, 0, 1, v.z, 0, 0, 0, 1];
}

/// -
GFXmatrix4 gMatScaling(GFXvector3 v)
{
	return [v.x, 0, 0, 0, 0, v.y, 0, 0, 0, 0, v.z, 0, 0, 0, 0, 1];
}

/// X
GFXmatrix4 gMatRotX(float a)
{
	return [1, 0, 0, 0, 0, cos(a), -sin(a), 0, 0, sin(a), cos(a), 0, 0, 0, 0, 1];
}

/// Y
GFXmatrix4 gMatRotY(float a)
{
	return [cos(a), 0, -sin(a), 0, 0, 1, 0, 0, sin(a), 0, cos(a), 0, 0, 0, 0, 1];
}

/// Z
GFXmatrix4 gMatRotZ(float a)
{
	return [cos(a), -sin(a), 0, 0, sin(a), cos(a), 0, 0, 0, 0, 1, 0, 0, 0, 0, 1];
}

GFXvector3 gMat3MulVec3(GFXmatrix3 mat, GFXvector3 vec)
{
	return gVec3(mat[0] * vec.x + mat[1] * vec.y + mat[2] * vec.z,
			mat[3] * vec.x + mat[4] * vec.y + mat[5] * vec.z,
			mat[6] * vec.x + mat[7] * vec.y + mat[8] * vec.z);
}

//Based on
//math.stackexchange.com/questions/180418/calculate-rotation-matrix-to-align-vector-a-to-vector-b-in-3d
GFXmatrix3 gMat3RotateVectorOntoVector(GFXvector3 vec, GFXvector3 target)
{
	vec = gNormalize3(vec);
	target = gNormalize3(target);

	GFXvector3 v = gCross3(vec, target);
	double s = gLength3(v);
	double c = gDot3(vec, target);

	GFXmatrix3 v_mat = [0, -v.z, v.y, v.z, 0, -v.x, -v.y, v.x, 0];

	GFXmatrix3 res = gIdentity3()[] + v_mat[] + gMat3Scale(gMat3Mul(v_mat, v_mat), (1 - c) / (s * s))[];

	return res;
}

/**
Constructs a projection matrix with given arguments
Params:
	fov		=	Vertical Field of View in radians
	aspectratio=Width/Height of the viewport
	near	=	Distance to the near clipping plane
	far		=	Distance to the far clipping plane (far > near)
**/
GFXmatrix4 gMatProjection(GFXnum fov, GFXnum aspectratio, GFXnum near, GFXnum far)
{
	GFXnum e = 1.0 / (tan(fov * 0.5));
	auto a = aspectratio;
	return [e, 0, 0, 0, 0, e / a, 0, 0, 0, 0, (far + near) / (near - far),
		(2 * far * near) / (near - far), 0, 0, -1, 0];
}

/// Works the same way as gMatProjection but far clipping plane is at infinity.
GFXmatrix4 gMatProjectionInfty(GFXnum fov, GFXnum aspectratio, GFXnum near)
{
	GFXnum e = 1.0 / (tan(fov * 0.5));
	auto a = aspectratio;
	return [e, 0, 0, 0, 0, e / a, 0, 0, 0, 0, -1, -2 * near, 0, 0, -1, 0];
}

/// Constructs an orthographic projection matrix
GFXmatrix4 gMatOrthographic(GFXnum Xmin, GFXnum Xmax, GFXnum Ymin, GFXnum Ymax,
		GFXnum Znear, GFXnum Zfar)
{
	alias left = Xmin;
	alias right = Xmax;
	alias top = Ymax;
	alias bottom = Ymin;
	GFXnum Xn = 2.0 / (right - left);
	GFXnum Yn = 2.0 / (top - bottom);
	GFXnum Zn = 2.0 / (Znear - Zfar);
	GFXnum Xt = (-right - left) / (left - right);
	GFXnum Yt = (-top - bottom) / (bottom - top);
	GFXnum Zt = (Zfar + Znear) / (Zfar - Znear);
	return [Xn, 0, 0, Xt, 0, Yn, 0, Yt, 0, 0, Zn, Zt, 0, 0, 0, 1];
}

/// Convert OpenGL error code to a human-readable string
string gErrorStr(int code)
{
	switch (code)
	{
	case GL_NO_ERROR:
		return "No error";
	case GL_INVALID_ENUM:
		return "Invalid enum value";
	case GL_INVALID_VALUE:
		return "Invalid value";
	case GL_INVALID_OPERATION:
		return "Invalid operation";
	case GL_INVALID_FRAMEBUFFER_OPERATION:
		return "Invalid framebuffer operation";
	case GL_OUT_OF_MEMORY:
		return "Out of memory";
	default:
		return "Unknown error " ~ text(code);
	}
}

/// Enforce there is no OpenGL error currently.
void gAssertGl()
{
	auto err = glGetError();
	if (err != GL_NO_ERROR)
	{
		throw new Error("OpenGL error: " ~ gErrorStr(err));
	}
}

/// Check if there are OpenGL errors (do not throw an error).
bool gCheckGl() nothrow
{
	return (glGetError() != GL_NO_ERROR);
}

/// Enum defining data types
/// S* means the type is signed and U* means unsigned, A* are array types (numerically-indexed tables in Lua)
enum gDataType
{
	Sint8,
	Uint8,
	Sint16,
	Uint16,
	Sint32,
	Uint32,
	Sint64,
	Uint64,
	Sfloat32,
	Sfloat64,
	Avector3,
	Avector4,
	Amatrix3x3,
	Amatrix4x4,
	Tpad8 /// special type that has no effect except adding 1-byte padding in the structure.
}

private class gDataTypeField
{
	public gDataType type;
	public ptrdiff_t offset;
	public this(gDataType T)
	{
		type = T;
	}

	size_t size()
	{
		return 1;
	}

	void SetFromD(T)(void* ptr, T val)
	{
		SetFromDvoid(ptr, cast(void*)(&val));
	}

	T GetToD(T)(void* ptr)
	{
		return *(cast(T*) GetToDvoid(ptr));
	}

	void SetFromDvoid(void* ptr, void* val)
	{
		assert(0);
	}

	void* GetToDvoid(void* ptr)
	{
		assert(0);
	}
}

private class gDataImpl(T) : gDataTypeField
{
	public this(gDataType T)
	{
		super(T);
	}

	override size_t size()
	{
		return T.sizeof;
	}

}

private template mixDataInt(T)
{
	public this(gDataType T)
	{
		super(T);
	}

	immutable static size_t sz = T.sizeof;
	override size_t size()
	{
		return sz;
	}

	override void SetFromDvoid(void* ptr, void* val)
	{
		ptr[0 .. sz] = val[0 .. sz];
	}

	T bufV;
	override void* GetToDvoid(void* ptr)
	{
		T V;
		(cast(void*)(&V))[0 .. sz] = ptr[0 .. sz];
		bufV = V;
		return &bufV;
	}
}

private template mixDataUInt(T)
{
	public this(gDataType T)
	{
		super(T);
	}

	immutable static size_t sz = T.sizeof;
	override size_t size()
	{
		return sz;
	}

	override void SetFromDvoid(void* ptr, void* val)
	{
		ptr[0 .. sz] = val[0 .. sz];
	}

	T bufV;
	override void* GetToDvoid(void* ptr)
	{
		T V;
		(cast(void*)(&V))[0 .. sz] = ptr[0 .. sz];
		bufV = V;
		return &bufV;
	}
}

private template mixDataFloat(T)
{
	public this(gDataType T)
	{
		super(T);
	}

	immutable static size_t sz = T.sizeof;
	override size_t size()
	{
		return sz;
	}

	override void SetFromDvoid(void* ptr, void* val)
	{
		ptr[0 .. sz] = val[0 .. sz];
	}

	T bufV;
	override void* GetToDvoid(void* ptr)
	{
		T V;
		(cast(void*)(&V))[0 .. sz] = ptr[0 .. sz];
		bufV = V;
		return &bufV;
	}
}

private class gDataImpl(T : void) : gDataTypeField
{
	static void* nptr = null;
	public this(gDataType T)
	{
		super(T);
	}

	override size_t size()
	{
		return 1;
	}

	override void SetFromDvoid(void* ptr, void* val)
	{
	}

	override void* GetToDvoid(void* ptr)
	{
		return &nptr;
	}
}

private class gDataImpl(T : byte) : gDataTypeField
{
	mixin mixDataInt!(T);
}

private class gDataImpl(T : short) : gDataTypeField
{
	mixin mixDataInt!(T);
}

private class gDataImpl(T : int) : gDataTypeField
{
	mixin mixDataInt!(T);
}

private class gDataImpl(T : long) : gDataTypeField
{
	mixin mixDataUInt!(T);
}

private class gDataImpl(T : ubyte) : gDataTypeField
{
	mixin mixDataUInt!(T);
}

private class gDataImpl(T : ushort) : gDataTypeField
{
	mixin mixDataUInt!(T);
}

private class gDataImpl(T : uint) : gDataTypeField
{
	mixin mixDataUInt!(T);
}

private class gDataImpl(T : ulong) : gDataTypeField
{
	mixin mixDataUInt!(T);
}

private class gDataImpl(T : float) : gDataTypeField
{
	mixin mixDataFloat!(T);
}

private class gDataImpl(T : double) : gDataTypeField
{
	mixin mixDataFloat!(T);
}

private class gDataImpl(T : GFXvector3) : gDataTypeField
{
	public this(gDataType T)
	{
		super(T);
	}

	immutable static size_t sz = float.sizeof * 3;
	override size_t size()
	{
		return sz;
	}

	override void SetFromDvoid(void* ptr, void* val)
	{
		GFXvector3 V = *(cast(T*) val);
		float[3] A = [V.x, V.y, V.z];
		ptr[0 .. sz] = (cast(void*)(A.ptr))[0 .. sz];
	}

	T bufV;
	override void* GetToDvoid(void* ptr)
	{
		float[3] A;
		(cast(void*)(A.ptr))[0 .. sz] = ptr[0 .. sz];
		bufV = gVec3(A[0], A[1], A[2]);
		return &bufV;
	}
}

private class gDataImpl(T : GFXmatrix3) : gDataTypeField
{
	public this(gDataType T)
	{
		super(T);
	}

	immutable static size_t sz = float.sizeof * 9;
	override size_t size()
	{
		return sz;
	}

	override void SetFromDvoid(void* ptr, void* val)
	{
		T* V = cast(T*) val;
		ptr[0 .. sz] = (cast(void*)(V))[0 .. sz];
	}

	T bufV;
	override void* GetToDvoid(void* ptr)
	{
		(cast(void*)(bufV.ptr))[0 .. sz] = ptr[0 .. sz];
		return &bufV;
	}
}

private class gDataImpl(T : GFXvector4) : gDataTypeField
{
	public this(gDataType T)
	{
		super(T);
	}

	immutable static size_t sz = float.sizeof * 4;
	override size_t size()
	{
		return sz;
	}

	override void SetFromDvoid(void* ptr, void* val)
	{
		T* V = cast(T*) val;
		float[4] A = [V.x, V.y, V.z, V.w];
		ptr[0 .. sz] = (cast(void*)(A))[0 .. sz];
	}

	T bufV;
	override void* GetToDvoid(void* ptr)
	{
		float[4] A;
		(cast(void*)(A.ptr))[0 .. sz] = ptr[0 .. sz];
		bufV = gVec4(A[0], A[1], A[2], A[3]);
		return &bufV;
	}
}

private class gDataImpl(T : GFXmatrix4) : gDataTypeField
{
	public this(gDataType T)
	{
		super(T);
	}

	immutable static size_t sz = float.sizeof * 16;
	override size_t size()
	{
		return sz;
	}

	override void SetFromDvoid(void* ptr, void* val)
	{
		T* V = cast(T*) val;
		ptr[0 .. sz] = (cast(void*)(V))[0 .. sz];
	}

	T bufV;
	override void* GetToDvoid(void* ptr)
	{
		(cast(void*)(bufV.ptr))[0 .. sz] = ptr[0 .. sz];
		return &bufV;
	}
}

/** Class for storing arbitrary binary formatted data. It represents a structure dynamic array. (0-indexed!!!)
	Initially it is in defining mode, which means you can only append new gDataTypes to the type definition.
	After calling declarationComplete() it switches to data mode, in which it can only accept data.
*/
class GFXdataStruct
{
	private bool _defining = true;
	/// Checks if the struct is still in defining mode.
	public @property bool defining()
	{
		return _defining;
	}

	public this()
	{

	}

	// Do not modify!!! [public for performance reasons]
	public gDataTypeField[] fieldTypes;
	protected uint _stride = 0, _len = 0;
	public uint stride()
	{
		return _stride;
	}

	public uint length()
	{
		return _len;
	};
	public ubyte[] data;

	/// Appends a new type to the struct declaration
	/// Returns: field index if succeeded, -1 if in not in defining mode, -2 if T is not a correct value.
	public int appendType(gDataType T)
	{
		if (!_defining)
			return -1;
		gDataTypeField F;
		switch (T)
		{
		case gDataType.Sint8:
			F = new gDataImpl!(byte)(T);
			break;
		case gDataType.Sint16:
			F = new gDataImpl!(short)(T);
			break;
		case gDataType.Sint32:
			F = new gDataImpl!(int)(T);
			break;
		case gDataType.Sint64:
			F = new gDataImpl!(long)(T);
			break;
		case gDataType.Uint8:
			F = new gDataImpl!(ubyte)(T);
			break;
		case gDataType.Uint16:
			F = new gDataImpl!(ushort)(T);
			break;
		case gDataType.Uint32:
			F = new gDataImpl!(uint)(T);
			break;
		case gDataType.Uint64:
			F = new gDataImpl!(ulong)(T);
			break;
		case gDataType.Sfloat32:
			F = new gDataImpl!(float)(T);
			break;
		case gDataType.Sfloat64:
			F = new gDataImpl!(double)(T);
			break;
		case gDataType.Avector3:
			F = new gDataImpl!(GFXvector3)(T);
			break;
		case gDataType.Avector4:
			F = new gDataImpl!(GFXvector4)(T);
			break;
		case gDataType.Amatrix3x3:
			F = new gDataImpl!(GFXmatrix3)(T);
			break;
		case gDataType.Amatrix4x4:
			F = new gDataImpl!(GFXmatrix4)(T);
			break;
		case gDataType.Tpad8:
			F = new gDataImpl!(void)(T);
			break;
		default:
			return -2;
		}
		F.offset = _stride;
		_stride += F.size();
		fieldTypes ~= [F];
		return cast(int)(fieldTypes.length - 1);
	}

	/// Switch to data mode.
	public void declarationComplete()
	{
		if (!_defining)
			throw new Error(
					"Trying to use a defining mode function in data mode in a GFXdataStruct");
		// Setup place for 1 object.
		data.length = 0;
		_len = 0;
		_defining = false;
	}

	/// Sets the length of the struct array to numels (1 is a single struct)
	public void setLength(int numels)
	{
		if (_defining)
			throw new Error(
					"Trying to use a data mode function in defining mode in a GFXdataStruct");
		data.length = numels * _stride;
		_len = numels;
	}

	/// D template-aware version of setValue
	public void setValueD(T)(int field, int idx, T val)
	{
		if (_defining)
			throw new Error(
					"Trying to use a data mode function in defining mode in a GFXdataStruct");
		if (field >= fieldTypes.length)
			throw new Error("Trying to access a non-existant field of a GFXdataStruct");
		if (idx >= _len)
			throw new Error("Trying to access a non-existant index of a GFXdataStruct");
		void* ptr = data.ptr + _stride * idx;
		fieldTypes[field].SetFromD(ptr, val);
	}

	/// D template-aware version of getValue
	public T getValueD(T)(int field, int idx)
	{
		if (_defining)
			throw new Error(
					"Trying to use a data mode function in defining mode in a GFXdataStruct");
		if (field >= fieldTypes.length)
			throw new Error("Trying to access a non-existant field of a GFXdataStruct");
		if (idx >= _len)
			throw new Error("Trying to access a non-existant index of a GFXdataStruct");
		void* ptr = data.ptr + _stride * idx;
		return fieldTypes[field].GetFromD!T(ptr);
	}

	override public string toString() const
	{
		return to!string(data);
	}
}

/** Buffer usage
	Static - rarely updated
	Dynamic - updated quite often
	Stream - updated very often
	Push - the buffer will be used mostly for sending data to OpenGL
	Pull - the buffer will be used mostly for receiving data from OpenGL
	Server - the buffer will be used mostly for in-GPU-memory data transfers
*/
enum gBufferUsage
{
	StaticPush,
	DynamicPush,
	StreamPush,
	StaticPull,
	DynamicPull,
	StreamPull,
	StaticServer,
	DynamicServer,
	StreamServer
}

/// Converts gBufferUsage enum to a correct OpenGL enum value
public GLuint gBufferUsageEnum(gBufferUsage u)
{
	switch (u)
	{
	case gBufferUsage.StaticPush:
		return GL_STATIC_DRAW;
	case gBufferUsage.StaticPull:
		return GL_STATIC_READ;
	case gBufferUsage.StaticServer:
		return GL_STATIC_COPY;

	case gBufferUsage.DynamicPush:
		return GL_DYNAMIC_DRAW;
	case gBufferUsage.DynamicPull:
		return GL_DYNAMIC_READ;
	case gBufferUsage.DynamicServer:
		return GL_DYNAMIC_COPY;

	case gBufferUsage.StreamPush:
		return GL_STREAM_DRAW;
	case gBufferUsage.StreamPull:
		return GL_STREAM_READ;
	case gBufferUsage.StreamServer:
		return GL_STREAM_COPY;

	default:
		return GL_DYNAMIC_DRAW;
	}
}

/// Enum describing binding targets of a buffer object (See: $(LINK https://www.opengl.org/wiki/Buffer_Object#General_use) )
enum gBufferTarget
{
	VertexArray,
	ElementArray,
	CopyRead,
	CopyWrite,
	PixelUnpack,
	PixelPack,
	Query,
	Texture,
	TransformFeedback,
	Uniform
}

/// Converts gBufferTarget enum to a correct OpenGL enum value
public GLuint gBufferTargetEnum(gBufferTarget t)
{
	switch (t)
	{
	case gBufferTarget.VertexArray:
		return GL_ARRAY_BUFFER;
	case gBufferTarget.ElementArray:
		return GL_ELEMENT_ARRAY_BUFFER;
	case gBufferTarget.CopyRead:
		return GL_COPY_READ_BUFFER;
	case gBufferTarget.CopyWrite:
		return GL_COPY_WRITE_BUFFER;
	case gBufferTarget.PixelUnpack:
		return GL_PIXEL_UNPACK_BUFFER;
	case gBufferTarget.PixelPack:
		return GL_PIXEL_PACK_BUFFER;
	case gBufferTarget.Query:
		return GL_QUERY_BUFFER;
	case gBufferTarget.Texture:
		return GL_TEXTURE_BUFFER;
	case gBufferTarget.TransformFeedback:
		return GL_TRANSFORM_FEEDBACK_BUFFER;
	case gBufferTarget.Uniform:
		return GL_UNIFORM_BUFFER;
	default:
		return GL_COPY_READ_BUFFER;
	}
}

public GLuint gBufferTargetBindingEnum(gBufferTarget t)
{
	switch (t)
	{
	case gBufferTarget.VertexArray:
		return GL_ARRAY_BUFFER_BINDING;
	case gBufferTarget.ElementArray:
		return GL_ELEMENT_ARRAY_BUFFER_BINDING;
	case gBufferTarget.PixelUnpack:
		return GL_PIXEL_UNPACK_BUFFER_BINDING;
	case gBufferTarget.PixelPack:
		return GL_PIXEL_PACK_BUFFER_BINDING;
	case gBufferTarget.Query:
		return GL_QUERY_BUFFER_BINDING;
	case gBufferTarget.TransformFeedback:
		return GL_TRANSFORM_FEEDBACK_BUFFER_BINDING;
	case gBufferTarget.Uniform:
		return GL_UNIFORM_BUFFER_BINDING;
	default:
		return GL_ARRAY_BUFFER_BINDING;
	}
}

/// Wraps OpenGL buffer objects, uses GFXdataStruct.
class GFXbufferObject
{
	protected GLuint _id;
	protected size_t _dsz = size_t.max;
	protected gBufferUsage _usage;
	protected gBufferTarget _bndX;
	protected GLuint _bnd;
	protected long _bid = 0;
	protected static long _shbid = -1;
	/// Gets the buffer id
	public uint id()
	{
		return cast(uint) _id;
	}

	/// Gets the buffer usage
	public gBufferUsage usage()
	{
		return _usage;
	}

	/// Sets buffer usage
	public void changeUsage(gBufferUsage usg)
	{
		_usage = usg;
	}

	/// Constructor
	public this(gBufferUsage usg)
	{
		glGenBuffers(1, &_id);
		gAssertGl();
		_usage = usg;
		_bnd = GL_COPY_READ_BUFFER;
		_bndX = gBufferTarget.CopyRead;
	}

	/// Binds a buffer to the given target
	public void bindTo(gBufferTarget target)
	{
		_bndX = target;
		_bnd = gBufferTargetEnum(target);
		glBindBuffer(_bnd, _id);
		gAssertGl();
		_bid = ++_shbid;
	}

	/// Unbinds the buffer from a target
	public void unbindFrom(gBufferTarget target)
	{
		_bndX = gBufferTarget.CopyRead;
		_bnd = GL_COPY_READ_BUFFER;
		glBindBuffer(gBufferTargetEnum(target), 0);
		gAssertGl();
		++_shbid;
	}

	/// Ensure this is bound.
	protected void fenceMe()
	{
		if (_bid != _shbid)
		{
			GLint boundid;
			glGetIntegerv(gBufferTargetBindingEnum(_bndX), &boundid);
			if (boundid != _id)
				throw new Error("Trying to use unbound GFXbufferObject");
			else
				_bid = _shbid;
		}
	}

	/// Updates the buffer data from a GFXdataStruct (requires previous binding)
	public void updateData(GFXdataStruct data)
	{
		fenceMe();
		if (data.data.length != _dsz)
		{
			_dsz = data.data.length;
			glBufferData(_bnd, _dsz, cast(const(GLvoid)*)(data.data.ptr),
					gBufferUsageEnum(_usage));
		}
		else
		{
			glBufferSubData(_bnd, 0, _dsz, cast(const(GLvoid)*)(data.data.ptr));
		}
		gAssertGl();
	}

	/// Updates the buffer data from bytes
	public void updateData(ubyte[] data)
	{
		fenceMe();
		if (data.length != _dsz)
		{
			_dsz = data.length;
			glBufferData(_bnd, _dsz, cast(const(GLvoid)*)(data.ptr), gBufferUsageEnum(_usage));
		}
		else
		{
			glBufferSubData(_bnd, 0, _dsz, cast(const(GLvoid)*)(data.ptr));
		}
		gAssertGl();
	}

	/// Updates a part of buffer data from a GFXdataStruct (requires previous binding)
	public void updateDataPart(GFXdataStruct data, GFXuint offsetBuffer,
			GFXuint amount, GFXuint offsetStruct)
	{
		fenceMe();
		amount *= data.stride;
		offsetBuffer *= data.stride;
		offsetStruct *= data.stride;
		GFXuint str2 = offsetStruct + amount;
		(str2 <= data.data.length) || assert(0);
		glBufferSubData(_bnd, offsetBuffer, amount,
				cast(const(GLvoid)*)(data.data[offsetStruct .. $].ptr));
		gAssertGl();
	}

	/// Copies data to another buffer object (both must be bound to different targets and the other buffer must have enough space for the source data)
	public void copyData(GFXbufferObject target)
	{
		fenceMe();
		target.fenceMe();
		glCopyBufferSubData(this._bnd, target._bnd, 0, 0, this._dsz);
		gAssertGl();
	}
}

// ---------------------------------------------------------
//  Vertex Array Object
// ---------------------------------------------------------

/// Wraps OpenGL Vertex Array Objects
class GFXvertexArrayObject
{
	protected GLuint id;

	protected long _bid = 0;
	protected static long _shbid = -1;
	protected int[] attribs;

	/// Constructor
	public this()
	{
		glGenVertexArrays(1, &id);
		bind();
	}

	/// Binds this VAO
	public void bind()
	{
		_shbid++;
		_bid = _shbid;
		glBindVertexArray(id);
		gAssertGl();
	}

	protected void fenceMe()
	{
		if (_bid != _shbid)
		{
			GLint bound;
			glGetIntegerv(GL_VERTEX_ARRAY_BINDING, &bound);
			if (bound != id)
				throw new Error("Trying to use unbound gVertexArrayObject");
			else
				_bid = _shbid;
		}
	}

	public void enableAttribs()
	{
		foreach (int attr; attribs)
		{
			glEnableVertexAttribArray(attr);
		}
	}

	public void disableAttribs()
	{
		foreach (int attr; attribs)
		{
			glDisableVertexAttribArray(attr);
		}
	}

	/**
		Configures an attribute in the vertex array (wraps glVertexAttrib[I]Pointer)
		shaderIndex is the location in shader of the specified attribute.
		normalize is only used when the parameter is of type float/matrix3x3/matrix4x4/vector3/vector4.
		WARNING! 64-bit integers will be cut off to first 32 bits!
	*/
	public void configureAttribute(GFXdataStruct str, int fieldIdx,
			int shaderIndex, bool convToFloat = false, bool normalize = false)
	{
		fenceMe();
		glEnableVertexAttribArray(shaderIndex);
		attribs ~= shaderIndex;
		gDataTypeField F = str.fieldTypes[fieldIdx];
		auto ffVertexAttribLPointer = function(GLuint a1, GLint a2, GLenum a3,
				GLsizei a4, const(GLvoid)* a5) {
			glVertexAttribPointer(a1, a2, a3, GL_FALSE, a4, a5);
		};
		if (GL_ARB_vertex_attrib_64bit)
		{
			ffVertexAttribLPointer = function(GLuint a1, GLint a2, GLenum a3,
					GLsizei a4, const(GLvoid)* a5) {
				glVertexAttribLPointer(a1, a2, a3, a4, a5);
			};
		}
		enum void* Z = null;
		switch (F.type)
		{
		case gDataType.Sint8:
			glVertexAttribIPointer(shaderIndex, 1, GL_BYTE,
					str.stride(), Z + F.offset);
			break;
		case gDataType.Sint16:
			glVertexAttribIPointer(shaderIndex, 1, GL_SHORT,
					str.stride(), Z + F.offset);
			break;
		case gDataType.Sint32:
			glVertexAttribIPointer(shaderIndex, 1, GL_INT,
					str.stride(), Z + F.offset);
			break;
		case gDataType.Sint64:
			glVertexAttribIPointer(shaderIndex, 1, GL_INT,
					str.stride(), Z + F.offset + 4);
			break;
		case gDataType.Uint8:
			glVertexAttribIPointer(shaderIndex, 1,
					GL_UNSIGNED_BYTE, str.stride(), Z + F.offset);
			break;
		case gDataType.Uint16:
			glVertexAttribIPointer(shaderIndex, 1,
					GL_UNSIGNED_SHORT, str.stride(), Z + F.offset);
			break;
		case gDataType.Uint32:
			glVertexAttribIPointer(shaderIndex, 1,
					GL_UNSIGNED_INT, str.stride(), Z + F.offset);
			break;
		case gDataType.Uint64:
			glVertexAttribIPointer(shaderIndex, 1,
					GL_UNSIGNED_INT, str.stride(), Z + F.offset + 4);
			break;
		case gDataType.Sfloat32:
			glVertexAttribPointer(shaderIndex, 1,
					GL_FLOAT, (normalize) ? GL_TRUE : GL_FALSE, str.stride(), Z + F.offset);
			break;
		case gDataType.Sfloat64:
			ffVertexAttribLPointer(shaderIndex, 1,
					GL_DOUBLE, str.stride(), Z + F.offset);
			break;
		case gDataType.Avector3:
			glVertexAttribPointer(shaderIndex, 3,
					GL_FLOAT, (normalize) ? GL_TRUE : GL_FALSE, str.stride(), Z + F.offset);
			break;
		case gDataType.Avector4:
			glVertexAttribPointer(shaderIndex, 4,
					GL_FLOAT, (normalize) ? GL_TRUE : GL_FALSE, str.stride(), Z + F.offset);
			break;
		case gDataType.Amatrix3x3:
			glVertexAttribPointer(shaderIndex, 3, GL_FLOAT,
					(normalize) ? GL_TRUE : GL_FALSE, GFXnum.sizeof * 3, Z + F.offset);
			glVertexAttribPointer(shaderIndex + 1, 3, GL_FLOAT, (normalize)
					? GL_TRUE : GL_FALSE, GFXnum.sizeof * 3, Z + F.offset + GFXnum.sizeof);
			glVertexAttribPointer(shaderIndex + 2, 3, GL_FLOAT, (normalize)
					? GL_TRUE : GL_FALSE, GFXnum.sizeof * 3, Z + F.offset + GFXnum.sizeof * 2);
			break;
		case gDataType.Amatrix4x4:
			glVertexAttribPointer(shaderIndex, 3, GL_FLOAT,
					(normalize) ? GL_TRUE : GL_FALSE, GFXnum.sizeof * 4, Z + F.offset);
			glVertexAttribPointer(shaderIndex + 1, 3, GL_FLOAT, (normalize)
					? GL_TRUE : GL_FALSE, GFXnum.sizeof * 4, Z + F.offset + GFXnum.sizeof);
			glVertexAttribPointer(shaderIndex + 2, 3, GL_FLOAT, (normalize)
					? GL_TRUE : GL_FALSE, GFXnum.sizeof * 4, Z + F.offset + GFXnum.sizeof * 2);
			glVertexAttribPointer(shaderIndex + 3, 3, GL_FLOAT, (normalize)
					? GL_TRUE : GL_FALSE, GFXnum.sizeof * 4, Z + F.offset + GFXnum.sizeof * 3);
			break;
		default:
			break;
		}
		gAssertGl();
		//glVertexAttribPointer(shaderIndex, NUMC, TYPE, (normalize)?GL_TRUE:GL_FALSE, str.stride(), str.data.ptr + F.offset);
	}
}

// ---------------------------------------------------------
//  Shaders
// ---------------------------------------------------------

/// Shader Compilation Error
class ShaderCompileError : Error
{
	public this(string msg, string shpath)
	{
		super(format("Shader compile error in file '%s': '%s'", shpath, msg));
	}
}

/// Shader&program wrapper class
class GFXshader
{
	protected int idVert = -1, idGeom = -1, idFrag = -1, idProg = -1;
	protected bool linked = false;

	/// Constructor
	public this()
	{
		idProg = glCreateProgram();
		gAssertGl();
	}

	protected void compileSrc(GLenum shType, string src, string path)
	{
		if (linked)
			assert(0, "Trying to load shader into an already linked program.");
		int* id;
		switch (shType)
		{
		case GL_VERTEX_SHADER:
			id = &idVert;
			break;
		case GL_FRAGMENT_SHADER:
			id = &idFrag;
			break;
		case GL_GEOMETRY_SHADER:
			id = &idProg;
			break;
		default:
			assert(0);
		}
		if ((*id) >= 0)
			assert(0);

		*id = cast(int) glCreateShader(shType);
		int vid = *id;
		glShaderSource(vid, 1, cast(const(char*)*)([src.ptr].ptr), [cast(int)(src.length)].ptr);
		glCompileShader(vid);
		gAssertGl();
		GLint succ = 0;
		glGetShaderiv(vid, GL_COMPILE_STATUS, &succ);
		if (succ == GL_FALSE)
		{
			GLint logSize = 0;
			glGetShaderiv(vid, GL_INFO_LOG_LENGTH, &logSize);
			char[] loga;
			loga.length = logSize;
			glGetShaderInfoLog(vid, logSize, &succ, loga.ptr);
			loga = loga[0 .. succ];
			glDeleteShader(vid);
			throw new ShaderCompileError(loga.idup, path);
		}
		glAttachShader(idProg, *id);
		gAssertGl();
	}

	/// Loads vertex shader from VFS path vpath
	public void loadVertShader(string vpath)
	{
		string src = LoadFileAsStrRet(vpath);
		compileSrc(GL_VERTEX_SHADER, src, vpath);
	}

	/// Loads fragment shader from VFS path vpath
	public void loadFragShader(string vpath)
	{

		string src = LoadFileAsStrRet(vpath);
		compileSrc(GL_FRAGMENT_SHADER, src, vpath);
	}

	/// Loads geometry shader from VFS path vpath
	public void loadGeomShader(string vpath)
	{

		string src = LoadFileAsStrRet(vpath);
		compileSrc(GL_GEOMETRY_SHADER, src, vpath);
	}

	/// Binds attribute location
	int bindAttribLocation(int loc, string attribName)
	{
		if (linked)
			assert(0, "Trying to bind attribute location in an already linked program.");
		glBindAttribLocation(idProg, loc, attribName.toStringz());
		return loc;
	}

	/// Binds FragData location
	void bindFragDataLocation(GLuint colorName, string attribName)
	{
		if (linked)
			assert(0, "Trying to bind fragment data location in an already linked program.");
		glBindFragDataLocation(idProg, colorName, attribName.toStringz());
		gAssertGl();
	}

	/// Links the program
	public void link()
	{
		glLinkProgram(idProg);
		GLint isLinked = 0;
		glGetProgramiv(idProg, GL_LINK_STATUS, &isLinked);
		if (isLinked == GL_FALSE)
		{
			GLint maxLen;
			glGetProgramiv(idProg, GL_INFO_LOG_LENGTH, &maxLen);
			char[] plog;
			plog.length = maxLen;
			glGetProgramInfoLog(idProg, maxLen, &isLinked, plog.ptr);
			plog = plog[0 .. isLinked];
			throw new ShaderCompileError(plog.idup, "[program linking]");
		}
		else
		{
			if (idVert != -1)
			{
				glDetachShader(idProg, idVert);
				glDeleteShader(idVert);
			}
			if (idFrag != -1)
			{
				glDetachShader(idProg, idFrag);
				glDeleteShader(idFrag);
			}
			if (idGeom != -1)
			{
				glDetachShader(idProg, idGeom);
				glDeleteShader(idGeom);
			}
			linked = true;
		}
		gAssertGl();
	}

	/// Binds this program
	public void bind()
	{
		glUseProgram(idProg);
		gAssertGl();
	}

	/// Unbinds current program
	public void unbind()
	{
		glUseProgram(0);
		gAssertGl();
	}

	protected int[string] uniIds;

	/// Gets location of `id` uniform in the linked program.
	public int getUniformLocation(string id)
	{
		if (!linked)
			assert(0, "You cannot get uniform location from an unlinked program");
		int* rid = id in uniIds;
		if (rid is null)
		{
			int V = glGetUniformLocation(idProg, id.toStringz());
			uniIds[id] = V;
			return V;
		}
		else
		{
			return *rid;
		}
	}

	protected int[string] attrIds;

	/// Gets location of `id` vertex attribute in the linked program
	public int getAttribLocation(string id)
	{
		if (!linked)
			assert(0, "You cannot get attribute location from an unlinked program");
		int* rid = id in attrIds;
		if (rid is null)
		{
			int V = glGetAttribLocation(idProg, id.toStringz());
			//if(V==-1){throw new Exception("Could not find attribute "~id~" in shader.");}
			attrIds[id] = V;
			return V;
		}
		else
		{
			return *rid;
		}
	}

	/// Sets uniform value
	public void setUniform1f(string id, float v0)
	{
		glUniform1f(getUniformLocation(id), v0);
	}

	/// Sets uniform value
	public void setUniform1i(string id, int v0)
	{
		glUniform1i(getUniformLocation(id), v0);
	}

	/// Sets uniform value
	public void setUniform2f(string id, float v0, float v1)
	{
		glUniform2f(getUniformLocation(id), v0, v1);
	}

	/// Sets uniform value
	public void setUniform2i(string id, int v0, int v1)
	{
		glUniform2i(getUniformLocation(id), v0, v1);
	}

	/// Sets uniform value
	public void setUniform3f(string id, float v0, float v1, float v2)
	{
		glUniform3f(getUniformLocation(id), v0, v1, v2);
	}

	/// Sets uniform value
	public void setUniform3i(string id, int v0, int v1, int v2)
	{
		glUniform3i(getUniformLocation(id), v0, v1, v2);
	}

	/// Sets uniform value
	public void setUniform4f(string id, float v0, float v1, float v2, float v3)
	{
		glUniform4f(getUniformLocation(id), v0, v1, v2, v3);
	}

	/// Sets uniform value
	public void setUniform4i(string id, int v0, int v1, int v2, int v3)
	{
		glUniform4i(getUniformLocation(id), v0, v1, v2, v3);
	}

	/// Sets uniform array
	public void setUniformAf(string id, int numComponents, float[] values)
	{
		int loc = getUniformLocation(id);
		switch (numComponents)
		{
		case 1:
			glUniform1fv(loc, cast(GLsizei) values.length, values.ptr);
			break;
		case 2:
			glUniform2fv(loc, cast(GLsizei) values.length / 2, values.ptr);
			break;
		case 3:
			glUniform3fv(loc, cast(GLsizei) values.length / 3, values.ptr);
			break;
		case 4:
			glUniform4fv(loc, cast(GLsizei) values.length / 4, values.ptr);
			break;
		default:
			assert(0);
		}
	}

	/// Sets uniform array
	public void setUniformAi(string id, int numComponents, int[] values)
	{
		int loc = getUniformLocation(id);
		switch (numComponents)
		{
		case 1:
			glUniform1iv(loc, cast(GLsizei) values.length, values.ptr);
			break;
		case 2:
			glUniform2iv(loc, cast(GLsizei) values.length / 2, values.ptr);
			break;
		case 3:
			glUniform3iv(loc, cast(GLsizei) values.length / 3, values.ptr);
			break;
		case 4:
			glUniform4iv(loc, cast(GLsizei) values.length / 4, values.ptr);
			break;
		default:
			assert(0);
		}
	}

	/// Sets uniform matrix
	public void setUniformM3(string id, GFXmatrix3 mat)
	{
		glUniformMatrix3fv(getUniformLocation(id), 1, GL_TRUE, mat.ptr);
	}

	/// Sets uniform matrix
	public void setUniformM4(string id, GFXmatrix4 mat)
	{
		glUniformMatrix4fv(getUniformLocation(id), 1, GL_TRUE, mat.ptr);
	}
}

/// -
class GFXtexture
{
	import image.memory : Image;

	protected bool _loaded = false;
	protected bool _monochrome = false;
	protected bool _filter_linear = true;
	protected bool _repeat = true;
	protected uint _id = 0xFFFFFFFF;
	protected int _w, _h;

	/// -
	public @property uint getWidth()
	{
		return _w;
	}

	/// -
	public @property uint getHeight()
	{
		return _h;
	}

	/// Constructor
	this()
	{
		glGenTextures(1, &_id);
		if (_id == 0)
			assert(0, "Couldn't create texture");
		gAssertGl();
	}

	/// Creates/recreates a texture with new image
	public void recreateTexture(Image img)
	{
		_loaded = true;
		_monochrome = false;
		_w = cast(int) img.w;
		_h = cast(int) img.h;

		if (GL_EXT_direct_state_access)
		{
			glTextureImage2DEXT(_id, GL_TEXTURE_2D, 0, (_monochrome) ? (GL_R8)
					: (GL_RGB8), _w, _h, 0, (_monochrome) ? (GL_RED) : (GL_RGB),
					GL_UNSIGNED_BYTE, img.data.ptr);
		}
		else
		{
			glBindTexture(GL_TEXTURE_2D, _id);
			glTexImage2D(GL_TEXTURE_2D, 0, (_monochrome) ? (GL_R8) : (GL_RGB8),
					_w, _h, 0, (_monochrome) ? (GL_RED) : (GL_RGB), GL_UNSIGNED_BYTE, img.data.ptr);
		}
		gAssertGl();
	}

	/// Replaces texture's image with img's image, requires img to be in the same format as the texture.
	public void reuploadTexture(Image img)
	{
		_loaded || assert(0);
		(_w == img.w) || assert(0);
		(_h == img.h) || assert(0);

		if (GL_EXT_direct_state_access)
		{
			glTextureSubImage2DEXT(_id, GL_TEXTURE_2D, 0, 0, 0, _w, _h,
					(_monochrome) ? (GL_RED) : (GL_RGB), GL_UNSIGNED_BYTE, img.data.ptr);
		}
		else
		{
			glBindTexture(GL_TEXTURE_2D, _id);
			glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, _w, _h, (_monochrome)
					? (GL_RED) : (GL_RGB), GL_UNSIGNED_BYTE, img.data.ptr);
		}
		gAssertGl();
	}

	/// -
	public void generateMipmaps()
	{
		glGenerateMipmap(GL_TEXTURE_2D);
	}

	/// Binds the texture
	public void bind()
	{
		glBindTexture(GL_TEXTURE_2D, _id);
		gAssertGl();
	}

}
