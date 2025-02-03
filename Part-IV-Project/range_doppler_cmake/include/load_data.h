#ifndef LOAD_DATA_H
#define LOAD_DATA_H

#include <vector2D.h>
#include <complex>
#include <string>

int loadComplexBin(const std::string &filename, vector2D<std::complex<double>> &data);

#endif