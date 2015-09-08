module gpuacc.gpu;

import config;
import std.math, std.algorithm, std.string, std.format, std.conv, std.range, std.array, std.stdio;
import derelict.cuda.runtimeapi;



public void InitGPU()
{
	try
	{
		DerelictCUDARuntime.load();
		if(cudaDeviceSynchronize()!=cudaSuccess)
		{
			writeln("Warning: CUDA device initialization failed.");
			cfgGpuAcc = false;
			return;
		}
		writeln("CUDA runtime API initialized.");
	}
	catch(Exception e)
	{
		if(cfgGpuAcc)
		{
			writeln("Warning: no CUDA runtime found.");
			cfgGpuAcc = false;
		}
	}
}
