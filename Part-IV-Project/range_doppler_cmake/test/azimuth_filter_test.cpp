#include <gtest/gtest.h>
#include "range_doppler.h"
#include "load_data.h"
#include <vector>
#include <fstream>

TEST(RangeDopplerTest, CreateAzimuthFilterMatrix)
{
    RangeDoppler rd("../data/parameters.bin");

    vector2D<std::complex<double>> expected(rd.rows(), rd.cols());
    loadComplexBin("../data/azimuth_filter_matrix.bin", expected);

    auto doppler_axis = rd.computeDopplerAxis();
    auto result = rd.createAzimuthFilter(doppler_axis);

    // Assert
    for (size_t i = 0; i < expected.rows(); ++i)
    {
        for (size_t j = 0; j < expected.cols(); ++j)
        {
            ASSERT_NEAR(expected(i, j).real(), result(i, j).real(), std::max(abs(expected(i, j).real() * 2e-6), 2e-6)) << "Real part mismatch at index [" << i << "][" << j << "]";
            ASSERT_NEAR(expected(i, j).imag(), result(i, j).imag(), std::max(abs(expected(i, j).imag() * 2e-6), 2e-6)) << "Imaginary part mismatch at index [" << i << "][" << j << "]";
        }
    }
}

TEST(RangeDopplerTest, AzimuthFiltering)
{
    RangeDoppler rd("../data/parameters.bin");

    vector2D<std::complex<double>> data(rd.rows(), rd.cols());
    loadComplexBin("../data/rcmc.bin", data);

    vector2D<std::complex<double>> expected(rd.rows(), rd.cols());
    loadComplexBin("../data/filtered.bin", expected);

    rd.azimuthFiltering(data);

    // Assert
    for (size_t i = 0; i < expected.rows(); ++i)
    {
        for (size_t j = 0; j < expected.cols(); ++j)
        {
            ASSERT_NEAR(expected(i, j).real(), data(i, j).real(), std::max(abs(expected(i, j).real() * 1e-3), 1e-3)) << "Real part mismatch at index [" << i << "][" << j << "]";
            ASSERT_NEAR(expected(i, j).imag(), data(i, j).imag(), std::max(abs(expected(i, j).imag() * 1e-3), 1e-3)) << "Imaginary part mismatch at index [" << i << "][" << j << "]";
        }
    }
}