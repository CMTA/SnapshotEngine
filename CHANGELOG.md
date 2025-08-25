# CHANGELOG

Please follow <https://changelog.md/> conventions.

## Checklist

> Before a new release, perform the following tasks

- Code: Update the version name defined in [SnapshotEngine.sol](contracts/SnapshotEngine.sol)
- Run linter

> npm run-script lint:all:prettier

- Documentation
  - Perform a code coverage and update the files in the corresponding directory [./doc/coverage](./doc/coverage)
  - Perform an audit with several audit tools (e.g Slither), update the report in the corresponding directory  [./doc/audits/](./doc/audits/)
  - Update surya doc by running the 3 scripts in [./doc/script](./doc/script)
  
  - Update changelog

## 0.2.0

- Dependencies
  - Update CMTAT to [v3.0.0-rc7](https://github.com/CMTA/CMTAT/releases/tag/v3.0.0-rc2)
  - Update OpenZeppelin library to [v5.4.0](https://github.com/OpenZeppelin/openzeppelin-contracts/releases/tag/v5.4.0)
  - Update Solidity to 0.8.30
  - Update EVM version to Prague

- Better code separation trough the creation of modules

- Use [ERC-7201](https://eips.ethereum.org/EIPS/eip-7201) for storage for compatibility with CMTAT

## 0.1.0

First release !
