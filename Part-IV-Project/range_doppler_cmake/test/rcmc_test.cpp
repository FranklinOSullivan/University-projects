#include <gtest/gtest.h>
#include "range_doppler.h"
#include "load_data.h"

TEST(RangeDopplerTest, RCMC)
{
    // Setup
    RangeDoppler rd("../data/parameters.bin");

    vector2D<std::complex<double>> data(rd.rows(), rd.cols());
    loadComplexBin("../data/fft.bin", data);

    vector2D<std::complex<double>> expected(rd.rows(), rd.cols());
    loadComplexBin("../data/rcmc.bin", expected);

    // auto fft = rd.azimuthFFT(data);
    // std::cout << "Azimuth FFT Done" << std::endl;

    rd.rcmc(data);
    std::cout << "RCMC Done" << std::endl;

    // Assert
    for (size_t i = 0; i < expected.rows(); ++i)
    {
        for (size_t j = 0; j < expected.cols(); ++j)
        {
            ASSERT_NEAR(expected(i, j).real(), data(i, j).real(), std::max(abs(expected(i, j).real() * 1e-6), 1e-6)) << "Real part mismatch at index [" << i << "][" << j << "]";
            ASSERT_NEAR(expected(i, j).imag(), data(i, j).imag(), std::max(abs(expected(i, j).imag() * 1e-6), 1e-6)) << "Imaginary part mismatch at index [" << i << "][" << j << "]";
        }
    }
}
