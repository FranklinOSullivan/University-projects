import numpy as np
import struct

with open('./data/test/param.bin', 'wb') as f:
    channel_dict = {}
    shape = (2000, 100)
    f.write(struct.pack('l', shape[0]))
    f.write(struct.pack('l', shape[1]))
    f.write(struct.pack('d', 6e3))
    f.write(struct.pack('d', 120.45))
    f.write(struct.pack('d', 93.2))
    f.write(struct.pack('d', 5.5))
    f.write(struct.pack('d', 11))


file = open("./data/test/param.bin", "rb")
data = file.read(1)
while data:
    print(data.hex())
    data = file.read(1)
file.close()