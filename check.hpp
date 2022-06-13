#pragma once
#include "cuda.h"
#include <iostream>

static inline CUresult x_check(CUresult result, const char* file = "", int line = 0) {
	if (result != CUDA_SUCCESS)
	{
		const char* err_str = (char*)malloc(256);
		cuGetErrorString(result, &err_str);
		if (*err_str == NULL)
		{
			std::cerr << "unknown error";
			free((void*)err_str);
			exit(EXIT_FAILURE);
		}
		std::cerr << file << " (line " << line << " ): " << err_str;
		free((void*)err_str);
		exit(EXIT_FAILURE);
	}
	return result;
}

#define check(x) x_check((x), __FILE__, __LINE__)