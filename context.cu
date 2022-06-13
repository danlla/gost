#include "context.cuh"
#include <iostream>
#include "check.hpp"

bool is_context = false;
CUcontext context;

CUcontext get_context()
{
	if (!is_context)
	{
		check(cuInit(0));
		CUdevice device;
		check(cuDeviceGet(&device, 0));
		check(cuCtxCreate(&context, 0, device));
		is_context = true;
	}
	return context;
}



