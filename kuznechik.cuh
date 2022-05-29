#pragma once
#include <memory>
#include <array>
#include <utility>
#include "cuda_runtime.h"
class kuznechik
{
public:
	union block
	{
		unsigned char c[16];
		unsigned int uint[4];
		unsigned long long ull[2];
	};

protected:
	block keys[10];
	__host__ void encrypt_block(block& src, int index) const;
public:
	kuznechik(const std::pair<unsigned long long, unsigned long long> key[10]);
	virtual void encrypt(block* buf, size_t n) const;
};