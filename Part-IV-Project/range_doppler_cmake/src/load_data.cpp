#include "load_data.h"
#include <fstream>
#include <iostream>

int loadComplexBin(const std::string &filename, vector2D<std::complex<double>> &data)
{
    std::ifstream file(filename, std::ios::binary);
    if (!file.is_open())
    {
        std::cerr << "Error opening binary file!" << std::endl;
        return 1;
    }
    // Read the binary data into the 2D vector
    file.read(reinterpret_cast<char *>(data.data().data()), data.rows() * data.cols() * sizeof(std::complex<double>));
    if (!file)
    {
        std::cerr << "Error reading binary file!" << std::endl;
        return 1;
    }
    file.close(); // Close the file
    return 0;
}