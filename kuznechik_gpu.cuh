#pragma once
#include "kuznechik.cuh"

class kuznechik_gpu :public kuznechik
{
public:
    void encrypt(block* buf, size_t n) const override;
    //void decrypt(block* buf, size_t n) const override;
    kuznechik_gpu(const std::array<unsigned int, 8>& key);
};