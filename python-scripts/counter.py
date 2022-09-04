from eth_abi import encode_single
import argparse

def main(args):
    ans = args.number + args.i
    # encode the answer
    enc = encode_single('uint256', int(ans))
    # this print statement must be here for ffi to work
    print("0x" + enc.hex())

def parse_args(): 
    """
    Add more input values here by:
    ```parser.add_argument("--new_var", type=int)```
    Note: the order of these variables must match the order they are placed in in the solidity test
    """
    parser = argparse.ArgumentParser()
    parser.add_argument("--number", type=int)
    parser.add_argument("--i", type=int)
    return parser.parse_args()

if __name__ == '__main__':
    args = parse_args() 
    main(args)