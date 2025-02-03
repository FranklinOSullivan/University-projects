#include <gtest/gtest.h>
#include "range_doppler.h"
#include <vector>
#include <fstream>

TEST(RangeDopplerTest, TrueRangeAxis)
{
    RangeDoppler rd("../data/parameters.bin");

    // Expected result
    std::vector<double> expected(rd.cols());
    {
        std::ifstream file("../data/true_range.bin", std::ios::binary);
        if (!file.is_open())
        {
            throw std::runtime_error("Error opening binary file!");
        }
        // Read the binary data into the 2D vector
        file.read(reinterpret_cast<char *>(expected.data()), rd.cols() * sizeof(double));
        if (!file)
        {
            throw std::runtime_error("Error reading binary file!");
        }
    }

    auto result = rd.computeTrueRangeAxis();
    for (size_t i = 0; i < expected.size(); ++i)
    {
        ASSERT_NEAR(expected[i], result[i], std::max(abs(expected[i] * 1e-6), 1e-6)) << "Mismatch at index [" << i << "]";
    }
}

TEST(RangeDopplerTest, DopplerAxis)
{
    RangeDoppler rd("../data/parameters.bin");

    // Expected result
    std::vector<double> expected(rd.cols());
    {
        std::ifstream file("../data/doppler_axis.bin", std::ios::binary);
        if (!file.is_open())
        {
            throw std::runtime_error("Error opening binary file!");
        }
        // Read the binary data into the 2D vector
        file.read(reinterpret_cast<char *>(expected.data()), rd.cols() * sizeof(double));
        if (!file)
        {
            throw std::runtime_error("Error reading binary file!");
        }
    }

    auto result = rd.computeDopplerAxis();
    for (size_t i = 0; i < expected.size(); ++i)
    {
        ASSERT_NEAR(expected[i], result[i], std::max(abs(expected[i] * 1e-6), 1e-6)) << "Mismatch at index [" << i << "]";
    }
}

TEST(RangeDopplerTest, LamdaC)
{
    RangeDoppler rd("../data/parameters.bin");

    auto result = rd.lambdaC();
    auto expected = 299792458.0 / 1e10;
    ASSERT_NEAR(expected, result, 1e-6);
}

TEST(RangeDopplerTest, DopplerCentroid)
{
    RangeDoppler rd("../data/parameters.bin");

    auto result = rd.dopplerCentroid();
    auto expected = 0.0;
    ASSERT_NEAR(expected, result, 1e-6);
}