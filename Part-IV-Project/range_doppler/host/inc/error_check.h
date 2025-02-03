#ifndef ERROR_CHECK_H
#define ERROR_CHECK_H

#include "vector2D.h"
#include <complex>
#include <type_traits>
#include <stdexcept>
#include <cmath>
#include <iostream>

template <typename T1, typename T2>
typename std::enable_if<std::is_floating_point<T1>::value && std::is_floating_point<T2>::value, double>::type
calculateMAPE(const vector2D<std::complex<T1>> &expected, const vector2D<std::complex<T2>> &actual)
{
    if (expected.rows() != actual.rows() || expected.cols() != actual.cols())
    {
        throw std::runtime_error("Matrix dimensions do not match");
    }

    double sum_abs = 0.0;
    size_t count = 0;

    for (size_t i = 0; i < expected.rows(); ++i)
    {
        for (size_t j = 0; j < expected.cols(); ++j)
        {
            sum_abs += std::abs((expected(i, j) - actual(i, j)) / expected(i, j)); // std::abs gives the absolute value
            count++;
        }
    }

    return (sum_abs / count) * 100.0;
}

#endif