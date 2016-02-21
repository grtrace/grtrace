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
	Finished
}

enum RayFlags : ushort
{
	None = 0,
	SearchingLight = 0x1
}

struct RayComputation
{
	Line curRay;
	RayState state;
	RayFlags flags;
	uint imgX, imgY, imgSample;
	uint owner;
	ubyte[] data;
}
