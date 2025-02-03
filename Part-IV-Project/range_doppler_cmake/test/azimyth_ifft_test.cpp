#include <gtest/gtest.h>
#include "fft.h"
#include "range_doppler.h"
#include "load_data.h"

TEST(RangeDopplerTest, IFFT)
{
    // Setup
    std::vector<std::complex<double>> data = {
        std::complex<double>(4.0, 4.0),
        std::complex<double>(7.0, 7.0),
        std::complex<double>(1.0, 1.0),
    };

    auto temp = fft(data);
    auto result = ifft(temp);

    // Assert
    ASSERT_EQ(data.size(), result.size()) << "Result vector size mismatch";
    for (size_t i = 0; i < data.size(); ++i)
    {
        EXPECT_NEAR(data[i].real(), result[i].real(), 1e-5) << "Real part mismatch at index " << i;
        EXPECT_NEAR(data[i].imag(), result[i].imag(), 1e-5) << "Imaginary part mismatch at index " << i;
    }
}

TEST(RangeDopplerTest, AzimuthIFFT)
{
    // Setup
    RangeDoppler rd("../data/parameters.bin");

    vector2D<std::complex<double>> data(rd.rows(), rd.cols());
    loadComplexBin("../data/filtered.bin", data);

    vector2D<std::complex<double>> expected(rd.rows(), rd.cols());
    loadComplexBin("../data/ifft.bin", expected);

    rd.azimuthIFFT(data);

    std::cout << "Azimuth IFFT Done" << std::endl;

    // Assert
    for (size_t i = 0; i < expected.rows(); ++i)
    {
        for (size_t j = 0; j < expected.cols(); ++j)
        {
            ASSERT_NEAR(expected(i, j).real(), data(i, j).real(), std::max(abs(expected(i, j).real() * 2e-6), 2e-6)) << "Real part mismatch at index [" << i << "][" << j << "]";
            ASSERT_NEAR(expected(i, j).imag(), data(i, j).imag(), std::max(abs(expected(i, j).imag() * 2e-6), 2e-6)) << "Imaginary part mismatch at index [" << i << "][" << j << "]";
        }
    }
}