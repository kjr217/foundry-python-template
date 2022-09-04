# Foundry <> Python Differential Fuzz Testing template

Foundry is a blazing fast testing environment for EVM smart contracts. Python is the leading programming language for quantitative analysis and data science. A lot of financial quant work gets modelled in Python and sometimes these models needs to be implemented in Solidity to be used in a protocol. 

This template provides a reference implementation for creating foundry tests that compare solidity code to an implementation of the same code in Python. It does this by taking advantage of [foundry ffi](https://book.getfoundry.sh/forge/differential-ffi-testing?highlight=ffi#primer-the-ffi-cheatcode) and foundry's inbuilt fuzz tooling. Being able to compare python code against solidity code for correctness and differential analysis helps improve the security and reliability of quantitative solidity development and helps understand the limits of the EVM when it comes to developing quantitative models to be used on the EVM.

Note: this template assumes some familiarity with foundry and forge, if you are not familiar refer to the [amazing foundry docs](https://book.getfoundry.sh/)

Example implementations: 

- [GDAs by FrankieIsLost](https://github.com/FrankieIsLost/gradual-dutch-auction/blob/master/src/test/ContinuousGDA.t.sol)
- SABR by Rysk - to be opensourced soon (TBOSS ;)).

## Installation Instructions

1. Make sure you have foundry installed, if you do not then follow the instructions here: https://book.getfoundry.sh/getting-started/installation#install-the-latest-release-by-using-foundryup

2. Make sure you have python3 installed, if you do not then follow the instructions here: https://www.python.org/downloads/ 

3. Make sure you have pipenv installed, if you do not then follow the instructions here: https://pipenv.pypa.io/en/latest/install/#isolated-installation-of-pipenv-with-pipx

4. Run ```pipenv install``` to install python dependencies.

Note: you can use any python virtual environment that you are comfortable with, this template uses pipenv.

5. Run ```forge install``` to install foundry dependencies.


## Operation Instructions

To run the example test ```Counter.t.sol``` do ```pipenv run forge test --ffi```. This test fuzzes the function ```incrementByInput(i)``` in Counter.sol and compares the output against a python implementation of the same function which can be seen in ```python-scripts/counter.py```. The test suite ```Counter.t.sol``` uses [foundry ffi](https://book.getfoundry.sh/forge/differential-ffi-testing?highlight=ffi#primer-the-ffi-cheatcode) to run the python script alongside the foundry test. The example of its use can be seen in: ```testIncrementByInputFFIFuzz``` and ```ffiPy``` This allows for comparison between a python reference implementation of a function and a solidity function.

### How to run tests

```pipenv run forge test --ffi```

When running the tests you must include the ```pipenv run``` and the ```--ffi``` in order to run the python-foundry differential fuzz tests.

### How to add more python packages

Run ```pipenv install <package-name>```

### How to add more variables to the test

1. In the reference python script follow the instructions in ```parse_args()``` to add more variables. These can then be accessed in the main function via ```args.<var>```

2. In the ```ffiPy``` function add in more elements to the ```inputs``` array making sure to include the tag and variable pair, also increase the array length of ```inputs``` to match the new array length. Instructions are provided in ```ffiPy```

### How to change the targeted python script

Change ```inputs[2]``` in the ```ffiPy``` function to represent the correct file path to the targeted script.

