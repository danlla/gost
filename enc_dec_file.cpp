#include <fstream>
#include "enc_dec_file.h"

int addition(magma::block* buf, size_t byte)
{
    if (byte % 8 == 0)
    {
        for (int i = 0; i < 8; ++i)
            buf[byte / 8].c[i] = 8;
    }
    else
    {
        int dif = 8 - byte % 8;
        for (int i = 8 - dif; i < 8; ++i)
            buf[byte / 8].c[i] = dif;
    }
    return 1;
}

int cut_addition(const magma::block& b)
{
    return b.c[7];
}

int addition_kuz(kuznechik::block* buf, size_t byte)
{
    if (byte % 16 == 0)
    {
        for (int i = 0; i < 16; ++i)
            buf[byte / 16].c[i] = 16;
    }
    else
    {
        int dif = 16 - byte % 16;
        for (int i = 16 - dif; i < 16; ++i)
            buf[byte / 16].c[i] = dif;
    }
    return 1;
}

int cut_addition_kuz(const kuznechik::block& b)
{
    return b.c[15];
}

void encrypt_file(const magma& m, const char* input_file, const char* output_file, size_t buf_size)
{
    std::ifstream ifile(input_file, std::ios::binary);
    std::ofstream ofile(output_file, std::ios::binary);
    magma::block* buf = new magma::block[buf_size + 1];
    size_t count = 0;
    while (true)
    {
        ifile.read((char*)buf, buf_size * sizeof(magma::block));
        count = ifile.gcount();
        if (!ifile)
            break;
        m.encrypt(buf, count / 8);
        ofile.write((char*)buf, (count / 8) * sizeof(magma::block));
    }
    int add = addition(buf, count);
    m.encrypt(buf, count / 8 + add);
    ofile.write((char*)buf, (count / 8 + add) * sizeof(magma::block));
    delete[] buf;
}

void decrypt_file(const magma& m, const char* input_file, const char* output_file, size_t buf_size)
{
    std::ifstream ifile(input_file, std::ios::binary);
    std::ofstream ofile(output_file, std::ios::binary);
    magma::block* buf = new magma::block[buf_size + 1];
    size_t count = 0;
    while (true)
    {
        ifile.read((char*)buf, buf_size * sizeof(magma::block));
        count = ifile.gcount();
        if (!ifile)
            break;
        m.decrypt(buf, count / 8);
        ofile.write((char*)buf, (count / 8) * sizeof(magma::block));
    }
    int extra = 0;
    m.decrypt(buf, count / 8);
    extra = cut_addition(buf[count / 8 - 1]);
    ofile.write((char*)buf, (count / 8) * sizeof(magma::block) - extra);
    delete[] buf;
}

void encrypt_file_kuz(const kuznechik& m, const char* input_file, const char* output_file, size_t buf_size)
{
    std::ifstream ifile(input_file, std::ios::binary);
    std::ofstream ofile(output_file, std::ios::binary);
    kuznechik::block* buf = new kuznechik::block[buf_size + 1];
    size_t count = 0;
    while (true)
    {
        ifile.read((char*)buf, buf_size * sizeof(kuznechik::block));
        count = ifile.gcount();
        if (!ifile)
            break;
        m.encrypt(buf, count / 16);
        ofile.write((char*)buf, (count / 16) * sizeof(kuznechik::block));
    }
    int add = addition_kuz(buf, count);
    m.encrypt(buf, count / 16 + add);
    ofile.write((char*)buf, (count / 16 + add) * sizeof(kuznechik::block));
    delete[] buf;
}



void decrypt_file_kuz(const kuznechik& m, const char* input_file, const char* output_file, size_t buf_size)
{
    std::ifstream ifile(input_file, std::ios::binary);
    std::ofstream ofile(output_file, std::ios::binary);
    kuznechik::block* buf = new kuznechik::block[buf_size + 1];
    size_t count = 0;
    while (true)
    {
        ifile.read((char*)buf, buf_size * sizeof(kuznechik::block));
        count = ifile.gcount();
        if (!ifile)
            break;
        m.encrypt(buf, count / 16);
        ofile.write((char*)buf, (count / 16) * sizeof(kuznechik::block));
    }
    int extra = 0;
    m.encrypt(buf, count / 16);
    extra = cut_addition_kuz(buf[count / 16 - 1]);
    ofile.write((char*)buf, (count / 16) * sizeof(kuznechik::block) - extra);
    delete[] buf;
}