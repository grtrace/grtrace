#include "basicdefs.h"
#include <math.h>

extern "C"
__global__ void vectorAdd(double *a, double *b, double *c, int n)
{
	int id = blockIdx.x*blockDim.x+threadIdx.x;
	
	if (id < n)
	{
		c[id] = a[id] + b[id];
	}
}
