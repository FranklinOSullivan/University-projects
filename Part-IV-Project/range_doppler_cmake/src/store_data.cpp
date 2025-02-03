#include "store_data.h"
#include <fstream>
#include <iostream>

int storeComplexBin(const std::string &filename, vector2D<std::complex<double>> &data)
{
    std::ofstream file(filename, std::ios::binary);
    if (!file.is_open())
    {
        std::cerr << "Error opening binary file for writing!" << std::endl;
        return 1;
    }
    // Write the binary data from the 2D vector
    file.write(reinterpret_cast<const char *>(data.data().data()), data.rows() * data.cols() * sizeof(std::complex<double>));
    if (!file)
    {
        std::cerr << "Error writing binary file!" << std::endl;
        return 1;
    }
    return 0;
}
