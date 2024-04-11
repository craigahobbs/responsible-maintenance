# Licensed under the MIT License
# https://github.com/craigahobbs/responsible-maintenance/blob/main/LICENSE

"""
responsible-maintenance command-line script main module
"""

import argparse


def main(argv=None):
    """
    responsible-maintenance command-line script main entry point
    """

    # Command line arguments
    parser = argparse.ArgumentParser(prog='responsible-maintenance')
    parser.add_argument('numbers', metavar='N', type=float, nargs='+',
                        help='an integer for the accumulator')
    args = parser.parse_args(args=argv)

    # Report the sum
    print(f'The sum is {sum(args.numbers)}')
