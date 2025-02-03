#include "opencl.h"

bool init()
{
  cl_int status;

  if (!setCwdToExeDir())
  {
    return false;
  }

  // Get the OpenCL platform.
  platform = findPlatform("Intel(R) FPGA SDK for OpenCL(TM)");
  if (platform == NULL)
  {
    printf("ERROR: Unable to find Intel(R) FPGA OpenCL platform.\n");
    return false;
  }

  // Query the available OpenCL devices.
  scoped_array<cl_device_id> devices;
  cl_uint num_devices;

  devices.reset(getDevices(platform, CL_DEVICE_TYPE_ALL, &num_devices));

  // We'll just use the first device.
  device = devices[0];

  // Display some device information.
  // display_device_info(device);

  // Create the context.
  context = clCreateContext(NULL, 1, &device, &oclContextCallback, NULL, &status);
  checkError(status, "Failed to create context");

  // Create the command queue.
  queue = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue");

  // Create the program.
  std::string binary_file = getBoardBinaryFile("range_doppler_kernel", device);
  printf("Using AOCX: %s\n", binary_file.c_str());
  program = createProgramFromBinary(context, binary_file.c_str(), &device, 1);

  // Build the program that was just created.
  status = clBuildProgram(program, 0, NULL, "", NULL, NULL);
  checkError(status, "Failed to build program");

  // Create the kernel - name passed in here must match kernel name in the
  // original CL file, that was compiled into an AOCX file using the AOC tool
  const char *kernel_name = "range_doppler_kernel"; // Kernel name, as defined in the CL file
  kernel = clCreateKernel(program, kernel_name, &status);
  checkError(status, "Failed to create kernel");

  return true;
}

void run_kernel(std::complex<double> *input_data, std::complex<double> *output_data, double *tm_fs_values, size_t *t_idx_values, size_t cols)
{
  cl_int err;
  // Prepare the input row and output row buffers
  cl_mem input_row_buffer = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
                                           sizeof(std::complex<double>) * cols, input_data, &err);
  cl_mem output_row_buffer = clCreateBuffer(context, CL_MEM_WRITE_ONLY,
                                            sizeof(std::complex<double>) * cols, NULL, &err);

  // Prepare the precomputed tm_fs, and t_idx buffers for the row
  cl_mem tm_fs_row_buffer = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
                                           sizeof(double) * cols, tm_fs_values, &err);
  cl_mem t_idx_row_buffer = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
                                           sizeof(size_t) * cols, t_idx_values, &err);

  // Set kernel arguments for the current row
  clSetKernelArg(kernel, 0, sizeof(cl_mem), &input_row_buffer);
  clSetKernelArg(kernel, 1, sizeof(cl_mem), &output_row_buffer);
  clSetKernelArg(kernel, 2, sizeof(cl_mem), &tm_fs_row_buffer);
  clSetKernelArg(kernel, 3, sizeof(cl_mem), &t_idx_row_buffer);
  clSetKernelArg(kernel, 4, sizeof(size_t), &cols);

// Launch the kernel with work size of 'cols' for this row
#ifdef SWI
  size_t global_work_size[1] = {1};
#else
  size_t global_work_size[1] = {cols};
#endif
  clEnqueueNDRangeKernel(queue, kernel, 1, NULL, global_work_size, NULL, 0, NULL, NULL);

  // Read back the processed row
  clEnqueueReadBuffer(queue, output_row_buffer, CL_TRUE, 0, sizeof(std::complex<double>) * cols,
                      output_data, 0, NULL, NULL);

  // Release the buffers after use
  clReleaseMemObject(input_row_buffer);
  clReleaseMemObject(output_row_buffer);
  clReleaseMemObject(tm_fs_row_buffer);
  clReleaseMemObject(t_idx_row_buffer);
}

// Free the resources allocated during initialization
void cleanup()
{
  if (kernel)
  {
    clReleaseKernel(kernel);
  }
  if (program)
  {
    clReleaseProgram(program);
  }
  if (queue)
  {
    clReleaseCommandQueue(queue);
  }
  if (context)
  {
    clReleaseContext(context);
  }
}

// Helper functions to display parameters returned by OpenCL queries
static void device_info_ulong(cl_device_id device, cl_device_info param, const char *name)
{
  cl_ulong a;
  clGetDeviceInfo(device, param, sizeof(cl_ulong), &a, NULL);
  printf("%-40s = %lu\n", name, a);
}
static void device_info_uint(cl_device_id device, cl_device_info param, const char *name)
{
  cl_uint a;
  clGetDeviceInfo(device, param, sizeof(cl_uint), &a, NULL);
  printf("%-40s = %u\n", name, a);
}
static void device_info_bool(cl_device_id device, cl_device_info param, const char *name)
{
  cl_bool a;
  clGetDeviceInfo(device, param, sizeof(cl_bool), &a, NULL);
  printf("%-40s = %s\n", name, (a ? "true" : "false"));
}
static void device_info_string(cl_device_id device, cl_device_info param, const char *name)
{
  char a[STRING_BUFFER_LEN];
  clGetDeviceInfo(device, param, STRING_BUFFER_LEN, &a, NULL);
  printf("%-40s = %s\n", name, a);
}

// Query and display OpenCL information on device and runtime environment
static void display_device_info(cl_device_id device)
{

  printf("Querying device for info:\n");
  printf("========================\n");
  device_info_string(device, CL_DEVICE_NAME, "CL_DEVICE_NAME");
  device_info_string(device, CL_DEVICE_VENDOR, "CL_DEVICE_VENDOR");
  device_info_uint(device, CL_DEVICE_VENDOR_ID, "CL_DEVICE_VENDOR_ID");
  device_info_string(device, CL_DEVICE_VERSION, "CL_DEVICE_VERSION");
  device_info_string(device, CL_DRIVER_VERSION, "CL_DRIVER_VERSION");
  device_info_uint(device, CL_DEVICE_ADDRESS_BITS, "CL_DEVICE_ADDRESS_BITS");
  device_info_bool(device, CL_DEVICE_AVAILABLE, "CL_DEVICE_AVAILABLE");
  device_info_bool(device, CL_DEVICE_ENDIAN_LITTLE, "CL_DEVICE_ENDIAN_LITTLE");
  device_info_ulong(device, CL_DEVICE_GLOBAL_MEM_CACHE_SIZE, "CL_DEVICE_GLOBAL_MEM_CACHE_SIZE");
  device_info_ulong(device, CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE, "CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE");
  device_info_ulong(device, CL_DEVICE_GLOBAL_MEM_SIZE, "CL_DEVICE_GLOBAL_MEM_SIZE");
  device_info_bool(device, CL_DEVICE_IMAGE_SUPPORT, "CL_DEVICE_IMAGE_SUPPORT");
  device_info_ulong(device, CL_DEVICE_LOCAL_MEM_SIZE, "CL_DEVICE_LOCAL_MEM_SIZE");
  device_info_ulong(device, CL_DEVICE_MAX_CLOCK_FREQUENCY, "CL_DEVICE_MAX_CLOCK_FREQUENCY");
  device_info_ulong(device, CL_DEVICE_MAX_COMPUTE_UNITS, "CL_DEVICE_MAX_COMPUTE_UNITS");
  device_info_ulong(device, CL_DEVICE_MAX_CONSTANT_ARGS, "CL_DEVICE_MAX_CONSTANT_ARGS");
  device_info_ulong(device, CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE, "CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE");
  device_info_uint(device, CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS, "CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS");
  device_info_uint(device, CL_DEVICE_MEM_BASE_ADDR_ALIGN, "CL_DEVICE_MEM_BASE_ADDR_ALIGN");
  device_info_uint(device, CL_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE, "CL_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE");
  device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR");
  device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT");
  device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT");
  device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_LONG, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_LONG");
  device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT");
  device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE");

  {
    cl_command_queue_properties ccp;
    clGetDeviceInfo(device, CL_DEVICE_QUEUE_PROPERTIES, sizeof(cl_command_queue_properties), &ccp, NULL);
    printf("%-40s = %s\n", "Command queue out of order? ", ((ccp & CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE) ? "true" : "false"));
    printf("%-40s = %s\n", "Command queue profiling enabled? ", ((ccp & CL_QUEUE_PROFILING_ENABLE) ? "true" : "false"));
  }
}