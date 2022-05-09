#include "kuznechik.cuh"
#include <memory>
#include <stdio.h>

constexpr unsigned char L1[16][16] =
{ {0, 148, 235, 127, 21, 129, 254, 106, 42, 190, 193, 85, 63, 171, 212, 64},
{0, 32, 64, 96, 128, 160, 192, 224, 195, 227, 131, 163, 67, 99, 3, 35},
{0, 133, 201, 76, 81, 212, 152, 29, 162, 39, 107, 238, 243, 118, 58, 191},
{0, 16, 32, 48, 64, 80, 96, 112, 128, 144, 160, 176, 192, 208, 224, 240},
{0, 194, 71, 133, 142, 76, 201, 11, 223, 29, 152, 90, 81, 147, 22, 212},
{0, 192, 67, 131, 134, 70, 197, 5, 207, 15, 140, 76, 73, 137, 10, 202},
{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15},
{0, 251, 53, 206, 106, 145, 95, 164, 212, 47, 225, 26, 190, 69, 139, 112},
{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15},
{0, 192, 67, 131, 134, 70, 197, 5, 207, 15, 140, 76, 73, 137, 10, 202},
{0, 194, 71, 133, 142, 76, 201, 11, 223, 29, 152, 90, 81, 147, 22, 212},
{0, 16, 32, 48, 64, 80, 96, 112, 128, 144, 160, 176, 192, 208, 224, 240},
{0, 133, 201, 76, 81, 212, 152, 29, 162, 39, 107, 238, 243, 118, 58, 191},
{0, 32, 64, 96, 128, 160, 192, 224, 195, 227, 131, 163, 67, 99, 3, 35},
{0, 148, 235, 127, 21, 129, 254, 106, 42, 190, 193, 85, 63, 171, 212, 64},
{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15},
};

constexpr unsigned char L2[16][16] = 
{ {0, 84, 168, 252, 147, 199, 59, 111, 229, 177, 77, 25, 118, 34, 222, 138},
{0, 69, 138, 207, 215, 146, 93, 24, 109, 40, 231, 162, 186, 255, 48, 117},
{0, 135, 205, 74, 89, 222, 148, 19, 178, 53, 127, 248, 235, 108, 38, 161},
{0, 195, 69, 134, 138, 73, 207, 12, 215, 20, 146, 81, 93, 158, 24, 219},
{0, 125, 250, 135, 55, 74, 205, 176, 110, 19, 148, 233, 89, 36, 163, 222},
{0, 93, 186, 231, 183, 234, 13, 80, 173, 240, 23, 74, 26, 71, 160, 253},
{0, 16, 32, 48, 64, 80, 96, 112, 128, 144, 160, 176, 192, 208, 224, 240},
{0, 107, 214, 189, 111, 4, 185, 210, 222, 181, 8, 99, 177, 218, 103, 12},
{0, 16, 32, 48, 64, 80, 96, 112, 128, 144, 160, 176, 192, 208, 224, 240},
{0, 93, 186, 231, 183, 234, 13, 80, 173, 240, 23, 74, 26, 71, 160, 253},
{0, 125, 250, 135, 55, 74, 205, 176, 110, 19, 148, 233, 89, 36, 163, 222},
{0, 195, 69, 134, 138, 73, 207, 12, 215, 20, 146, 81, 93, 158, 24, 219},
{0, 135, 205, 74, 89, 222, 148, 19, 178, 53, 127, 248, 235, 108, 38, 161},
{0, 69, 138, 207, 215, 146, 93, 24, 109, 40, 231, 162, 186, 255, 48, 117},
{0, 84, 168, 252, 147, 199, 59, 111, 229, 177, 77, 25, 118, 34, 222, 138},
{0, 16, 32, 48, 64, 80, 96, 112, 128, 144, 160, 176, 192, 208, 224, 240},
};

void kuznechik::decrypt_block(block& src) const
{

}

kuznechik::kuznechik(const std::array<unsigned int, 8>& key)
{
	for (size_t i = 0; i < 8; ++i)
	{
		keys[i] = key[i];
	}
}

void kuznechik::encrypt(block* buf, size_t n) const
{
#pragma omp parallel for
	for (int64_t i = 0; i < n; ++i)
		encrypt_block(buf[i]);
}

void kuznechik::decrypt(block* buf, size_t n) const
{
#pragma omp parallel for
	for (int64_t i = 0; i < n; ++i)
		decrypt_block(buf[i]);
}
