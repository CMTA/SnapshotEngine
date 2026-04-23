# CHANGELOG

Please follow <https://changelog.md/> conventions.

## Semantic Version 2.0.0

Given a version number MAJOR.MINOR.PATCH, increment the:

1. MAJOR version when the new version makes:
   -  Incompatible proxy **storage** change internally or through the upgrade of an external library (OpenZeppelin)
   - A significant change in external APIs (public/external functions) or in the internal architecture
2. MINOR version when the new version adds functionality in a backward compatible manner
3. PATCH version when the new version makes backward compatible bug fixes

See [https://semver.org](https://semver.org)

## Type of changes

- `Added` for new features.
- `Changed` for changes in existing functionality.
- `Deprecated` for soon-to-be removed features.
- `Removed` for now removed features.
- `Fixed` for any bug fixes.
- `Security` in case of vulnerabilities.

Reference: [keepachangelog.com/en/1.1.0/](https://keepachangelog.com/en/1.1.0/)

Custom changelog tag: `Dependencies`, `Documentation`, `Testing`

## Checklist

> Before a new release, perform the following tasks

- Code: Update the version name in the `Version` core module, variable VERSION
- Run linter

> npm run-script lint:all:prettier

- Documentation
  - Perform a code coverage and update the files in the corresponding directory [./doc/general/test/coverage](./doc/general/test/coverage)
  - Perform an audit with several audit tools (Aderyn and Slither), update the report in the corresponding directory  [./doc/audits/tools](./doc/audits/tools)
  - Update surya doc by running the 3 scripts in [./doc/script](./doc/script)
  
  - Update changelog

## 0.4.0

- Dependencies
  - Align integration for `CMTAT v3.2.0`.
  - Update `CMTATBaseRuleEngine` import path (`1_CMTATBaseRuleEngine.sol` -> `2_CMTATBaseRuleEngine.sol`).
  - Update version interface usage from `IERC3643Base` to `IERC3643Version`.
  - Update OpenZeppelin dependencies to `@openzeppelin/contracts` and `@openzeppelin/contracts-upgradeable` `5.6.1`.

- Documentation
  - Clarify and document the `0.3.0` known issue and `0.4.0` resolution for `getNextSnapshots()` arithmetic underflow when no future snapshots remain.
  - Document strict snapshot query semantics with exact-time APIs:
    - `snapshotExists(time)`
    - `snapshotBalanceOfExact(time, tokenHolder)` (reverts if `time` is not scheduled)
    - `snapshotTotalSupplyExact(time)` (reverts if `time` is not scheduled)
  - Document snapshot materialization observability:
    - `SnapshotMaterialized(time, blockNumber)` emitted when `_setCurrentSnapshot()` advances.
    - `poke()` can be used by authorized accounts to materialize due snapshots without requiring token transfers.

- Testing
  - Add tests for exact snapshot queries (scheduled vs non-scheduled timestamps and parity with legacy queries on scheduled timestamps).
  - Add tests for snapshot materialization event emission.
  - Add tests for `poke()` access control and idempotent behavior.
  - Add test coverage for `SnapshotUnschedule(time)` emission in `unscheduleSnapshotNotOptimized`.

## 0.3.0 - 2025-08-27

Commit: `b5750a0a6f75e73ab00ace6a2cf3e482b1a64352`

- Add deployment version  with snapshot for CMTAT
- Better code separation
- Create new module ` SnapshotUpdateModule`
- Known issue for this release:
  - `getNextSnapshots()` may revert (panic `0x11`) in edge cases once the most-recent-past-snapshot optimization branch is enabled/fixed, due to an underflow in future-snapshot array size computation.

## 0.2.0 - 2025-08-25

- Dependencies
  - Update CMTAT to [v3.0.0-rc7](https://github.com/CMTA/CMTAT/releases/tag/v3.0.0-rc2)
  - Update OpenZeppelin library to [v5.4.0](https://github.com/OpenZeppelin/openzeppelin-contracts/releases/tag/v5.4.0)
  - Update Solidity to 0.8.30
  - Update EVM version to Prague

- Better code separation trough the creation of modules

- Use [ERC-7201](https://eips.ethereum.org/EIPS/eip-7201) for storage for compatibility with CMTAT

## 0.1.0 - 2025-08-19

First release !
