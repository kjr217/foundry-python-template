// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Counter.sol";
import "openzeppelin-contracts/contracts/utils/Strings.sol";

contract CounterTest is Test {
    using Strings for uint256;

    Counter public counter;
    function setUp() public {
       counter = new Counter();
       counter.setNumber(0);
    }

    function testIncrement() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testSetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }

    function testIncrementByInputFFIFuzz(uint256 i) public {
        // run python script with same state that the solidity function will run
        uint256 pyNumber = ffiPy(counter.number(), i);
        counter.incrementByInput(i);
        assertEq(counter.number(), pyNumber);
        // to compare a difference (var1, var2, expected difference)
        assertApproxEqAbs(counter.number(), pyNumber, 0);
    }

    function ffiPy(uint256 number, uint256 i) private returns (uint256) {
        // compile a string input that represents the bash script to run the python script
        // increment the number in brackets when adding more input params
        // input 2 should be the location of the python script
        // each variable is made up of a pair of a tag "--tag" and a stringifed version of the variable
        string[] memory inputs = new string[](6);
        inputs[0] = "python3";
        inputs[1] = "python-scripts/counter.py";
        inputs[2] = "--number";
        inputs[3] = uint256(number).toString();
        inputs[4] = "--i";
        inputs[5] = uint256(i).toString();
        // use foundry ffi to run the python script
        bytes memory res = vm.ffi(inputs);
        // decode the result
        uint256 ans = abi.decode(res, (uint256));
        return ans;
    }
}
