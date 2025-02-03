#include <gtest/gtest.h>
#include "range_doppler.h"
#include "fft.h"
#include "load_data.h"

TEST(RangeDopplerTest, IFFTShift)
{
    // Setup
    std::vector<std::complex<double>> data = {
        std::complex<double>(1.0, 1.0),
        std::complex<double>(4.0, 4.0),
        std::complex<double>(7.0, 7.0),
    };

    // Expected result
    std::vector<std::complex<double>> expected = {
        std::complex<double>(4.0, 4.0),
        std::complex<double>(7.0, 7.0),
        std::complex<double>(1.0, 1.0),
    };

    auto result = ifftshift(data);

    // Assert
    ASSERT_EQ(expected.size(), result.size()) << "Result vector size mismatch";
    for (size_t i = 0; i < expected.size(); ++i)
    {
        EXPECT_NEAR(expected[i].real(), result[i].real(), 1e-9) << "Real part mismatch at index " << i;
        EXPECT_NEAR(expected[i].imag(), result[i].imag(), 1e-9) << "Imaginary part mismatch at index " << i;
    }
}

TEST(RangeDopplerTest, FFT)
{
    // Setup
    std::vector<std::complex<double>> data = {
        std::complex<double>(4.0, 4.0),
        std::complex<double>(7.0, 7.0),
        std::complex<double>(1.0, 1.0),
    };

    // Expected result
    std::vector<std::complex<double>> expected = {
        std::complex<double>(12.0, 12.0),
        std::complex<double>(5.19615, -5.19615),
        std::complex<double>(-5.19615, 5.19615),
    };

    auto result = fft(data);

    // Assert
    ASSERT_EQ(expected.size(), result.size()) << "Result vector size mismatch";
    for (size_t i = 0; i < expected.size(); ++i)
    {
        EXPECT_NEAR(expected[i].real(), result[i].real(), 1e-5) << "Real part mismatch at index " << i;
        EXPECT_NEAR(expected[i].imag(), result[i].imag(), 1e-5) << "Imaginary part mismatch at index " << i;
    }
}

TEST(RangeDopplerTest, FFTShift)
{
    // Setup
    std::vector<std::complex<double>> data = {
        std::complex<double>(12.0, 12.0),
        std::complex<double>(5.19615, -5.19615),
        std::complex<double>(-5.19615, 5.19615),
    };

    // Expected result
    std::vector<std::complex<double>> expected = {
        std::complex<double>(-5.19615, 5.19615),
        std::complex<double>(12.0, 12.0),
        std::complex<double>(5.19615, -5.19615),
    };

    auto result = fftshift(data);

    // Assert
    ASSERT_EQ(expected.size(), result.size()) << "Result vector size mismatch";
    for (size_t i = 0; i < expected.size(); ++i)
    {
        EXPECT_NEAR(expected[i].real(), result[i].real(), 1e-5) << "Real part mismatch at index " << i;
        EXPECT_NEAR(expected[i].imag(), result[i].imag(), 1e-5) << "Imaginary part mismatch at index " << i;
    }
}

TEST(RangeDopplerTest, AzimuthFFTBasic)
{
    // Setup
    RangeDoppler rd(3, 3, 6e3);
    vector2D<std::complex<double>> data({
        {
            std::complex<double>(1.0, 1.0),
            std::complex<double>(2.0, 2.0),
            std::complex<double>(3.0, 3.0),
        },
        {
            std::complex<double>(4.0, 4.0),
            std::complex<double>(5.0, 5.0),
            std::complex<double>(6.0, 6.0),
        },
        {
            std::complex<double>(7.0, 7.0),
            std::complex<double>(8.0, 8.0),
            std::complex<double>(9.0, 9.0),
        },
    });

    // Expected result
    vector2D<std::complex<double>> expected({
        {
            std::complex<double>(-0.0008660254, 0.0008660254),
            std::complex<double>(-0.0008660254, 0.0008660254),
            std::complex<double>(-0.0008660254, 0.0008660254),
        },
        {
            std::complex<double>(0.002, 0.002),
            std::complex<double>(0.0025, 0.0025),
            std::complex<double>(0.003, 0.003),
        },
        {
            std::complex<double>(0.0008660254, -0.0008660254),
            std::complex<double>(0.0008660254, -0.0008660254),
            std::complex<double>(0.0008660254, -0.0008660254),
        },
    });

    rd.azimuthFFT(data);

    // Assert
    for (size_t i = 0; i < expected.rows(); ++i)
    {
        for (size_t j = 0; j < expected.cols(); ++j)
        {
            ASSERT_NEAR(expected(i, j).real(), data(i, j).real(), 1e-9) << "Real part mismatch at index [" << i << "][" << j << "]";
            ASSERT_NEAR(expected(i, j).imag(), data(i, j).imag(), 1e-9) << "Imaginary part mismatch at index [" << i << "][" << j << "]";
        }
    }
}

TEST(RangeDopplerTest, AzimuthFFT)
{
    // Setup
    RangeDoppler rd("../data/parameters.bin");

    vector2D<std::complex<double>> data(rd.rows(), rd.cols());
    loadComplexBin("../data/data.bin", data);

    vector2D<std::complex<double>> expected(rd.rows(), rd.cols());
    loadComplexBin("../data/fft.bin", expected);

    rd.azimuthFFT(data);

    std::cout << "Azimuth FFT Done" << std::endl;

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