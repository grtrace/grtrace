module gpuacc.gpu;

import config;
import std.math, std.algorithm, std.string, std.format, std.conv, std.range, std.array, std.stdio;
import std.path, std.file, std.traits;
import derelict.cuda.driverapi;
import core.vararg;

__gshared CUdevice   device;
__gshared CUcontext  context;
__gshared public CUmodule cudaModule;

enum string GPU_MODULE_FILE = "cudakernels.cubin";

void SynchronizeGPU(string file = __FILE__, int line = __LINE__)
{
	checkCuda(cuCtxSynchronize(),file,line);
}

void FinalizeGPU()
{
	if(context !is null)
	{
		cuCtxDetach(context);
	}
}

class CudaException : Exception
{
	@nogc @safe pure nothrow this(string msg, string file = __FILE__, size_t line = __LINE__, Throwable next = null)
    {
        super(msg, file, line, next);
    }
}

void checkCuda(CUresult err, string file = __FILE__, int line = __LINE__)
{
	if(err!=CUDA_SUCCESS)
	{
		const(char)* cstr;
		cuGetErrorString(err, &cstr);
		string xstr = "?";
		if(cstr !is null)
		{
			xstr = to!string(cstr);
		}
		throw new CudaException("Cuda error #%.04d [%s] in file %s @ %d".format(err, xstr, file, line));
	}
}

struct GPUPointer
{
	CUdeviceptr gptr;
	@disable this(void*);
	@disable this(GPUPointer);
	~this()
	{
		if(gptr != 0)
		{
			cuMemFree(gptr);
		}
	}
}

struct GPUGridSz
{
	uint x = 1;
	uint y = 1;
	uint z = 1;
}

struct GPUThreadSz
{
	uint x = 1;
	uint y = 1;
	uint z = 1;
}

struct GPUFunction
{
	CUfunction gfunc;
	@disable this();
	@disable this(CUfunction);
	this(string name)
	{
		checkCuda(cuModuleGetFunction(&gfunc, cudaModule, toStringz(name)));
	}
	void Call(GPUGridSz gsz, GPUThreadSz tsz, int sharedBytes, ...)
	{
		void*[] kargs;
		for(int i=0; i<_arguments.length; i++)
		{
			if(_arguments[i] == typeid(GPUPointer*))
			{
				GPUPointer *gptr = va_arg!(GPUPointer*)(_argptr);
				kargs ~= [cast(void*)&gptr.gptr];
			}
			else if(_arguments[i] == typeid(int))
			{
				int val = va_arg!(int)(_argptr);
				kargs ~= [cast(void*)&val];
			}
			else if(_arguments[i] == typeid(long))
			{
				long val = va_arg!(long)(_argptr);
				kargs ~= [cast(void*)&val];
			}
			else if(_arguments[i] == typeid(short))
			{
				short val = va_arg!(short)(_argptr);
				kargs ~= [cast(void*)&val];
			}
			else if(_arguments[i] == typeid(float))
			{
				float val = va_arg!(float)(_argptr);
				kargs ~= [cast(void*)&val];
			}
			else if(_arguments[i] == typeid(double))
			{
				double val = va_arg!(double)(_argptr);
				kargs ~= [cast(void*)&val];
			}
			else
			{
				throw new CudaException("Unsupported argument type for CUDA kernel call: "~_arguments[i].toString());
			}
		}
		checkCuda(cuLaunchKernel(gfunc, gsz.x, gsz.y, gsz.z, tsz.x, tsz.y, tsz.z, sharedBytes, null, kargs.ptr, null));
	}
}

GPUPointer gpuMalloc(T)(int count)
{
	int sz = cast(int)(T.sizeof * count);
	GPUPointer gptr = void;
	gptr.gptr = 0;
	checkCuda(cuMemAlloc(&gptr.gptr, sz));
	return gptr;
}

void gpuCopyToG(T)(ref GPUPointer ptr, T[] data)
{
	checkCuda(cuMemcpyHtoD(ptr.gptr, data.ptr, T.sizeof * data.length));
}

void gpuCopyToH(T)(ref GPUPointer ptr, T[] data)
{
	checkCuda(cuMemcpyDtoH(data.ptr, ptr.gptr, T.sizeof * data.length));
}

void initCuda()
{
	int devCount;
	char[100] dvname;
	int major, minor;
	ulong memory;
	CUresult err = cuInit(0);
	checkCuda(err);
	checkCuda(cuDeviceGetCount(&devCount));
	if(devCount==0)
	{
		throw new CudaException("No CUDA devices found");
	}
	if(devCount>1)
	{
		writeln("Warning: more than one CUDA-capable device found. Using the first one");
	}
	checkCuda(cuDeviceGet(&device, 0));
	cuDeviceGetName(dvname.ptr, dvname.length, device);
	writeln("Using CUDA device: ", dvname[0..dvname.indexOf('\0')]);
	checkCuda(cuDeviceGetAttribute(&major, CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MAJOR, device));
	checkCuda(cuDeviceGetAttribute(&minor, CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MINOR, device));
	checkCuda(cuDeviceTotalMem(&memory, device));
	writefln("Compute v%d.%d, Memory: %d MBytes", major, minor, memory>>20);
	checkCuda(cuCtxCreate(&context, 0, device));
	checkCuda(cuModuleLoad(&cudaModule, GPU_MODULE_FILE));
	SynchronizeGPU();
}

public void InitGPU()
{
	try
	{
		DerelictCUDADriver.load();
		if(!exists(GPU_MODULE_FILE))
		{
			writefln("Warning: No '%s' file found.", GPU_MODULE_FILE);
			cfgGpuAcc = false;
			return;
		}
		try
		{
			initCuda();
		}
		catch(CudaException e)
		{
			writeln("Warning: CUDA device initialization failed with message:\n",e.msg);
			cfgGpuAcc = false;
			return;
		}
		writeln("CUDA driver API initialized.");
		
		static if(false) // Sample
		{
			double[10] A, B, C;
			A[] = [1,2,3,4,5,6,7,8,9,10.0];
			B[] = [5,6,6,1,2,7,4,1,9,3.0];
			auto gA = gpuMalloc!double(A.length);
			auto gB = gpuMalloc!double(A.length);
			auto gC = gpuMalloc!double(A.length);
			gpuCopyToG(gA, A[]);
			gpuCopyToG(gB, B[]);
			GPUFunction vadd = GPUFunction("vectorAdd");
			vadd.Call(GPUGridSz(1,1,1), GPUThreadSz(A.length,1,1), 32, &gA, &gB, &gC, cast(int)(A.length));
			SynchronizeGPU();
			gpuCopyToH!double(gC, C[]);
			SynchronizeGPU();
			writeln("GPU vector addition test:");
			writeln(A);
			writeln(B);
			writeln(C);
		}
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
