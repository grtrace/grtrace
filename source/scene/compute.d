/// Ray compute structures
module scene.compute;

import config;
import core.time;
import std.array;
import std.string;
import std.math;
import std.functional;
import math.vector;
import math.geometric;
import math.matrix;
import image.memory;
import image.imgio;
import image.color;
import scene.camera;
import scene.objects.interfaces;
import scene.objects.sphere;
import std.algorithm;
import metric;

/// The state of ray's computation
enum RayState : ushort
{
	Initialised = 0,
	InComputation1 = 1,
	InComputation2,
	InComputation3,
	InComputation4,
	InComputation5,
	InComputation6,
	InComputation7,
	InComputation8,
	InComputation9,
	Finished,
	Failed
}

/// Additional state flags for a ray
enum RayFlags : ushort
{
	None = 0,
	SearchingLight = 0x1
}

/// A single ray computation in progress
struct RayComputation
{
	/// The ray
	Line curRay;
	/// State of computation
	RayState state;
	/// ditto
	RayFlags flags;
	/// Target X position in the image
	uint imgX;
	/// Target Y position in the image
	uint imgY;
	/// Target sample in the image
	uint imgSample;
	/// Current color of the ray
	Color color;
	/// Owner of the computation, for example a thread id
	uint owner;
	/// Additional data associated with the ray
	ubyte[] data;
}

/** Definition of a CPU computation function
Returns the next state, should not change the state field by itself.
*/
public alias CpuComputeFunction = RayState function(RayComputation* rc);

/// Dummy computation function, always fails the raytrace
RayState failTrace(RayComputation* rc)
{
	return RayState.Failed;
}

/// Definition of a computation step
struct ComputeStep
{
	/// Which state is this
	RayState me = RayState.Failed;
	/// The following state if the trace doesn't fail/finish
	RayState nextState = RayState.Failed;
	/// Function pointer to the CPU raytracing code
	CpuComputeFunction cpuFun = &failTrace;
	/// Is this step implemented on the GPU
	bool gpuSupported = false;
	/// Kernel name of the gpu function
	string gpuFun;
}
