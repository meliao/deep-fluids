import numpy as np
import argparse
import os
import logging

def load(fp):
    with np.load(fp) as data:
        return data['x']

def save_2d(out_dir, x, tag):
    for i in range(x.shape[1]):
        fp_out = os.path.join(out_dir, "2d_{}_z_{:02d}.bin".format(tag, i))
        slice_i = x[1:, i, :, :]
        slice_i.tofile(fp_out)

def save_3d(out_dir, x, tag):
    for i in range(x.shape[1]):
        fp_out = os.path.join(out_dir, "3d_{}_z_{:02d}.bin".format(tag, i))
        slice_i = x[:, i, :, :]
        slice_i.tofile(fp_out)

def transpose_and_shave(x):
    x = np.transpose(x, axes=(3,0,1,2))
    x = np.flip(x, axis=2) #We want the smoke rising to the top of the figure
    s = x.shape
    # The raw files have a buffer of 2 around each edge with nothing in it
    x = x[:, 2:s[1]-2, 2:s[2]-2, 2:s[3]-2]
    return x


def main(args):
    if not os.path.isdir(args.out_dir):
        os.mkdir(args.out_dir)

    for i in range(args.start, args.stop):
        tag = "0_0_{:03d}".format(i)
        fp_in = os.path.join(args.in_dir, "0_0_{}.npz".format(i))

        logging.info("Loading file: {}".format(fp_in))

        x = load(fp_in)
        x = transpose_and_shave(x)
        save_2d(args.out_dir, x, tag)
        save_3d(args.out_dir, x, tag)

if __name__ == '__main__':

    parser = argparse.ArgumentParser()

    parser.add_argument("-in_dir")
    parser.add_argument("-out_dir")
    parser.add_argument("-start", type=int, default=0)
    parser.add_argument("-stop", type=int, default=250)

    args = parser.parse_args()
    fmt = "%(asctime)s: %(levelname)s - %(message)s"
    time_fmt = '%Y-%m-%d %H:%M:%S'
    logging.basicConfig(level=logging.INFO,
                        format=fmt,
                        datefmt=time_fmt)
    main(args)
