#include <gtest/gtest.h>
#include "range_doppler.h"
#include "load_data.h"

int main(int argc, char **argv)
{
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}

TEST(RangeDopplerTest, AzimuthCompression)
{
    // Setup
    RangeDoppler rd("../data/parameters.bin");

    vector2D<std::complex<double>> data(rd.rows(), rd.cols());
    loadComplexBin("../data/data.bin", data);

    vector2D<std::complex<double>> expected(rd.rows(), rd.cols());
    loadComplexBin("../data/ifft.bin", expected);

    rd.azimuthCompression(data);

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