import numpy as np
import argparse
import os
import logging

def load(fp):
    with np.load(fp) as data:
        return data['x']

def save(fp, x):
    x.tofile(fp)

def transpose_and_shave(x):
    x = np.transpose(x, axes=(3,0,1,2))
    s = x.shape
    # The raw files have a buffer of 2 around each edge with nothing in it
    x = x[:, 2:s[1]-2, 2:s[2]-2, 2:s[3]-2]
    return x


def main(args):

    for i in range(args.start, args.stop):
        fp_out = os.path.join(args.out_dir, "0_0_{:03d}.bin".format(i))
        fp_in = os.path.join(args.in_dir, "0_0_{}.npz".format(i))

        logging.info("Loading file: {}".format(fp_in))

        x = load(fp_in)
        x = transpose_and_shave(x)
        save(fp_out, x)
        logging.info("Saved file: {}".format(fp_out))

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

