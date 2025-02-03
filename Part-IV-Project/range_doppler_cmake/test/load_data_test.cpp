#include <gtest/gtest.h>
#include "load_data.h"
#include "range_doppler.h"

TEST(RangeDopplerTest, LoadComplexBin)
{
    size_t rows = 3;
    size_t cols = 3;
    vector2D<std::complex<double>> data(rows, cols);
    int status = loadComplexBin("../data/test/complex_array_2d.bin", data);

    ASSERT_EQ(status, 0);
    ASSERT_EQ(data(0, 0), std::complex<double>(1, 1));
    ASSERT_EQ(data(0, 1), std::complex<double>(2, 2));
    ASSERT_EQ(data(0, 2), std::complex<double>(3, 3));
    ASSERT_EQ(data(1, 0), std::complex<double>(4, 4));
    ASSERT_EQ(data(1, 1), std::complex<double>(5, 5));
    ASSERT_EQ(data(1, 2), std::complex<double>(6, 6));
    ASSERT_EQ(data(2, 0), std::complex<double>(7, 7));
    ASSERT_EQ(data(2, 1), std::complex<double>(8, 8));
    ASSERT_EQ(data(2, 2), std::complex<double>(9, 9));
}

TEST(RangeDopplerTest, LoadParameterBin)
{
    RangeDoppler rd("../data/test/param.bin");

    // Access and assert private fields
    std::cout << rd.rows() << std::endl;
    ASSERT_EQ(rd.rows(), 2000);
    std::cout << rd.cols() << std::endl;
    ASSERT_EQ(rd.cols(), 100);
    ASSERT_EQ(rd.radarPrf(), 6e3);
    ASSERT_EQ(rd.radarGeometryAbsV(), 120.45);
    ASSERT_EQ(rd.radarGeometryFSA(), 93.2);
    ASSERT_EQ(rd.radarFC(), 5.5);
    ASSERT_EQ(rd.radarPulseRate(), 11);
}