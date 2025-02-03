import numpy as np
import struct

# Create a 2D array of complex doubles
arr = np.array([[1 + 1j, 2 + 2j, 3 + 3j], [4 + 4j, 5 + 5j, 6 + 6j], [7 + 7j, 8 + 8j, 9 + 9j]], dtype=np.complex128)
# Save the 2D array to a binary file
arr.tofile('data/test/complex_array_2d.bin')


file = open("data/test/complex_array_2d.bin", "rb")
data = file.read(16)
while data:
    print(struct.unpack('dd', data))
    data = file.read(16)
file.close()