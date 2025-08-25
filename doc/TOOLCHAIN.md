# TOOLCHAIN

[TOC]

## Node.JS  package

This part describe the list of libraries present in the file `package.json`.

### Dev

This section concerns the packages installed in the section `devDependencies` of package.json

#### Test

**[Chai](https://www.chaijs.com/)**
Library used for the tests

**[Coveralls](https://coveralls.io/)**
It is used to perform a code coverage

#### Nomiclabs - Hardhat

**[hardhat-web3](https://hardhat.org/hardhat-runner/plugins/nomiclabs-hardhat-web3)**

This plugin integrates [Web3.js](https://github.com/ethereum/web3.js) `1.x` into [Hardhat](https://hardhat.org/).

**[hardhat-ethers](https://www.npmjs.com/package/@nomicfoundation/hardhat-ethers)**

[Hardhat](https://hardhat.org/) plugin for integration with [ethers.js](https://github.com/ethers-io/ethers.js/)

**[hardhat-contract-sizer](https://www.npmjs.com/package/hardhat-contract-sizer)**

Output Solidity contract sizes with Hardhat.

**[hardhat-gas-reporter](https://www.npmjs.com/package/hardhat-gas-reporter)**

[eth-gas-reporter](https://github.com/cgewecke/eth-gas-reporter) plugin for [hardhat](http://gethardhat.com/).

#### OpenZeppelin

**[openzeppelin/test-helpers](openzeppelin/test-helpers)**

Assertion library for Ethereum smart contract testing

#### Linter

**[eslint](https://eslint.org/)**
JavaScript static analyzer, and the following plugins:

* **[eslint-config-standard](https://github.com/standard/eslint-config-standard)**
Shareable configs designed to work with the extends feature of .eslintrc files.

* **[eslint-plugin-import](https://github.com/import-js/eslint-plugin-import)**
Plugin to support linting of ES2015+ (ES6+) import/export syntax, and prevent issues with misspelling of file paths and import names. 

* **[eslint-plugin-node](https://github.com/mysticatea/eslint-plugin-node)**
Additional ESLint's rules for Node.js

* **[eslint-plugin-promise](https://github.com/eslint-community/eslint-plugin-promise)**
Enforcement best practices for JavaScript promises.

**[Ethlint](https://github.com/duaraghav8/Ethlint)**
Solidity static analyzer.


#### Ethereum / Solidity

**[ethereumjs-util](https://www.npmjs.com/package/ethereumjs-util)**
Collection of utility functions for Ethereum (account, address,
signature, etc.).

**[ethjs-abi](https://github.com/ethjs/ethjs-abi)**
Encode and decode method and event from the smart contract ABI. Warning:
marked as experimental package on 22.08.2022.

**[solc](https://github.com/ethereum/solc-js)**
JavaScript bindings for the Solidity compiler.

#### Documentation

**[sol2uml](https://github.com/naddison36/sol2uml)**

Generate UML for smart contracts

**[solidity-coverage](https://github.com/sc-forks/solidity-coverage/)**

Code coverage for Solidity smart-contracts

**[solidity-docgen](https://github.com/OpenZeppelin/solidity-docgen)**

Program that extracts documentation for a Solidity project.

**[Surya](https://github.com/ConsenSys/surya)**

Utility tool for smart contract systems.



## Generate documentation

### [sol2uml](https://github.com/naddison36/sol2uml)

Generate UML for smart contracts

You can generate UML for smart contracts by running the following command:

```bash
npm run-script uml
```

Warning:

This command is not working and generates the following error

> RangeError: Maximum call stack size exceeded
