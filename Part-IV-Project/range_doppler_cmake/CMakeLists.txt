cmake_minimum_required(VERSION 3.10)
project(RangeDoppler CXX)

# Set output directories
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# Set source directories
set(SRC_PATH ${CMAKE_SOURCE_DIR}/src)
set(INC_PATH ${CMAKE_SOURCE_DIR}/include)
set(TEST_PATH ${CMAKE_SOURCE_DIR}/test)

# Find all source files
file(GLOB_RECURSE SOURCES "${SRC_PATH}/*.cpp")
file(GLOB_RECURSE TESTS "${TEST_PATH}/*.cpp")

# Include directories
include_directories(${INC_PATH})

# Find the FFTW3 library
find_package(FFTW3 REQUIRED)

# Executable target
add_executable(${PROJECT_NAME} ${SOURCES})

# Link FFTW3 to your target
target_link_libraries(${PROJECT_NAME} ${FFTW3_LIBRARIES})

# Ensure C++11 standard
set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 20)


# Fetch Google Test
include(FetchContent)
FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG v1.14.0
)
FetchContent_MakeAvailable(googletest)

# Enable testing with CTest
enable_testing()

# Define a test executable
list(REMOVE_ITEM SOURCES ${SRC_PATH}/main.cpp)
add_executable(${PROJECT_NAME}_test ${TESTS} ${SOURCES})

# Link Google Test to the test executable
target_link_libraries(${PROJECT_NAME}_test gtest_main)

# Link FFTW3 to your target
target_link_libraries(${PROJECT_NAME}_test ${FFTW3_LIBRARIES})

# Include Google Test's include directory
target_include_directories(${PROJECT_NAME}_test PRIVATE ${googletest_SOURCE_DIR}/include)

# Register the test executable with CTest
include(GoogleTest)
gtest_discover_tests(${PROJECT_NAME}_test)