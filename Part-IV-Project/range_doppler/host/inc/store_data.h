
#ifndef STORE_DATA_H
#define STORE_DATA_H

#include <vector2D.h>
#include <complex>
#include <string>

int storeComplexBin(const std::string &filename, vector2D<std::complex<double>> &data);

#endif