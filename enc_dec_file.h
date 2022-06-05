#pragma once
#include "magma.cuh"
#include "kuznechik.cuh"

int addition(magma::block* buf, size_t byte);

int cut_addition(const magma::block& b);

int addition_kuz(kuznechik::block* buf, size_t byte);

int cut_addition_kuz(const kuznechik::block& b);

void encrypt_file(const magma& m, const char* input_file, const char* output_file, size_t buf_size);

void decrypt_file(const magma& m, const char* input_file, const char* output_file, size_t buf_size);

void encrypt_file_kuz(const kuznechik& m, const char* input_file, const char* output_file, size_t buf_size);

void decrypt_file_kuz(const kuznechik& m, const char* input_file, const char* output_file, size_t buf_size);

