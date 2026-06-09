import numpy as np
import os

base_dir = "/projects/cnncae/2m_drivAer_r1025_n49/simulations"
samples_ordering_file = "/projects/cnncae/2m_drivAer_r1025_n49/samples_ordering.txt"

with open(samples_ordering_file, 'r') as f:
    dirs = f.read().splitlines()

ip1 = np.load(os.path.join(base_dir, dirs[0], "input.npy"))
op1 = np.load(os.path.join(base_dir, dirs[0], "output.npy"))

ip_c = np.zeros((ip1.shape[0], ip1.shape[1], ip1.shape[2], len(dirs)), dtype=np.uint8)
op_c = np.zeros((op1.shape[0], op1.shape[1], op1.shape[2], len(dirs)), dtype=np.uint8)

print(ip_c.shape)
print(op_c.shape)

for i, dir_name in enumerate(dirs):
    dir_path = os.path.join(base_dir, dir_name)
    print(dir_path)
    input_file = os.path.join(dir_path, "input.npy")
    output_file = os.path.join(dir_path, "output.npy")

    input_array = np.load(input_file)
    output_array = np.load(output_file)

    ip_c[:, :, :, i] = input_array
    op_c[:, :, :, i] = output_array

np.save(os.path.join(base_dir, "inputs.npy"), ip_c)
np.save(os.path.join(base_dir, "outputs.npy"), op_c)

