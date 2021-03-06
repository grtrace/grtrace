module scene.camera;

import grtrace;
import math.vector;
import math.geometric;
import math.matrix;
import math.util;
import std.string, std.getopt, std.array, std.range, std.math, std.algorithm;
import glad.gl.all;
import scene.objects.interfaces;

interface ICamera
{
	/// set camera origin
	@property ref Vectorf origin();
	/// look direction
	@property ref Vectorf lookdir();
	/// right direction
	@property ref Vectorf rightdir();
	/// up direction
	@property Vectorf updir();
	/// set camera Y/X ratio
	@property ref fpnum yxratio();
	/// parse options string (from script)
	@property void options(SValue[string] opts);
	/// X,Y in <-1;1>
	bool fetchRay(fpnum X, fpnum Y, out Line ray);
}

class OrthogonalCamera : ICamera
{
	private Vectorf orig, dir, righ, up;
	private fpnum yx = 1.0;
	private fpnum xdim = 1.0;
	/// set camera origin
	@property ref Vectorf origin()
	{
		return orig;
	}
	/// look direction
	@property ref Vectorf lookdir()
	{
		return dir;
	}
	/// right direction
	@property ref Vectorf rightdir()
	{
		return righ;
	}
	/// up direction
	@property Vectorf updir()
	{
		return up;
	}
	/// set camera Y/X ratio
	@property ref fpnum yxratio()
	{
		return yx;
	}
	/// parse options string (from script)
	@property void options(SValue[string] opts)
	{
		xdim = optFloat(opts, "XSIZE", xdim);
		up = dir % righ;
	}
	/// X,Y in <-1;1>
	bool fetchRay(fpnum X, fpnum Y, out Line ray)
	{
		ray = Line(orig + righ * X * xdim + up * Y * xdim * yx, -dir, true);
		return true;
	}
}

class LinearPerspectiveCamera : ICamera
{
	private Vectorf orig, dir, righ, up, dirm;
	private fpnum yx = 1.0;
	private fpnum FOVM = 1.0;
	private fpnum FOV = 45.0;
	/// set camera origin
	@property ref Vectorf origin()
	{
		return orig;
	}
	/// look direction
	@property ref Vectorf lookdir()
	{
		return dir;
	}
	/// right direction
	@property ref Vectorf rightdir()
	{
		return righ;
	}
	/// up direction
	@property Vectorf updir()
	{
		return up;
	}
	/// set camera Y/X ratio
	@property ref fpnum yxratio()
	{
		return yx;
	}
	/// parse options string (from script)
	@property void options(SValue[string] opts)
	{
		FOV = optFloat(opts, "FOV", FOV);
		up = -dir % righ;
		FOVM = 1.0 / tan(FOV * PI / 180.0);
		dirm = dir * FOVM;
	}
	/// X,Y in <-1;1>
	bool fetchRay(fpnum X, fpnum Y, out Line ray)
	{
		ray = Line(orig, -(dirm + rightdir * X + up * Y * yx).normalized, true);
		return true;
	}
}

/// sets camera angles from degrees
void SetCameraAngles(ICamera cam, fpnum pitch, fpnum yaw, fpnum roll)
{
	Vectorf R, F;
	anglesToAxes(vectorf(pitch, yaw, roll), R, F);
	R = -R;
	cam.lookdir = F;
	cam.rightdir = R;
}

public void anglesToAxes(Vectorf angles, ref Vectorf left, ref Vectorf forward)
{
	enum fpnum DEG2RAD = PI / 180.0;
	fpnum sx, sy, sz, cx, cy, cz, theta;

	// rotation angle about X-axis (pitch)
	theta = angles.x * DEG2RAD;
	sx = fsin!fpnum(theta);
	cx = fcos!fpnum(theta);

	// rotation angle about Y-axis (yaw)
	theta = angles.y * DEG2RAD;
	sy = fsin!fpnum(theta);
	cy = fcos!fpnum(theta);

	// rotation angle about Z-axis (roll)
	theta = angles.z * DEG2RAD;
	sz = fsin!fpnum(theta);
	cz = fcos!fpnum(theta);

	// determine left axis
	left.x = cy * cz;
	left.y = sx * sy * cz + cx * sz;
	left.z = -cx * sy * cz + sx * sz;
	left.w = 0;

	// determine forward axis
	forward.x = sy;
	forward.y = -sx * cy;
	forward.z = cx * cy;
	forward.w = 0;
}
