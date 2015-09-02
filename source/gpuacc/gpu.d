module gpuacc.gpu;

import std.math, std.algorithm, std.string, std.format, std.conv, std.range, std.array, std.stdio;
import derelict.cuda.driverapi;

public void InitGPU()
{
	try
  {
    DerelictCUDADriver.load();
    writeln("CUDA driver API initialized.");
  }
  catch(Exception e)
  {
    writeln("Warning: no CUDA drivers found.");
  }
}
