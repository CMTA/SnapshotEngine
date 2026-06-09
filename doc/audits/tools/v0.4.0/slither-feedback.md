# Slither Feedback - v0.4.0

This file contains the project feedback for the static-analysis findings reported in [slither-report.md](./slither-report.md).

## Summary

| Check | Count | Feedback |
| --- | ---: | --- |
| `uninitialized-local` | 1 | Acknowledged as benign default-zero initialization. |
| `calls-loop` | 6 | Acknowledged as acceptable for explicit view batch helpers. |
| `timestamp` | 3 | Acknowledged by design for snapshot scheduling semantics. |
| `assembly` | 1 | Acknowledged as required for ERC-7201 storage access. |
| `naming-convention` | 1 | Acknowledged; follows ERC-7201/OpenZeppelin storage-slot style. |

## Detailed Feedback

### `uninitialized-local`

- Status: `Acknowledged`
- Finding: `SnapshotBase._findScheduledMostRecentPastSnapshot(...)` uses a local variable that Slither reports as uninitialized.
- Feedback:
  The variable intentionally relies on Solidity's default zero initialization. In this code path, `0` is the correct sentinel meaning "no scheduled past snapshot found yet".

### `calls-loop`

- Status: `Acknowledged`
- Finding: batch snapshot query helpers call `balanceOf` and `totalSupply` while iterating.
- Feedback:
  These functions are read-only batch helpers intended to aggregate snapshot state across multiple holders and times. The external calls target the bound token interface and are expected as part of the API design. This does not affect state integrity; the tradeoff is limited to caller-controlled read cost.

### `timestamp`

- Status: `Acknowledged`
- Finding: snapshot scheduling and execution compare snapshot times against `block.timestamp`.
- Feedback:
  Snapshot scheduling is inherently time-based, so timestamp comparisons are part of the intended model. The engine does not require sub-block precision, and the small timestamp variance tolerated by consensus rules is acceptable for this use case.

### `assembly`

- Status: `Acknowledged`
- Finding: inline assembly is used in `SnapshotBase._getSnapshotBaseStorage()`.
- Feedback:
  The assembly block is used to implement ERC-7201 namespaced storage access, matching the OpenZeppelin/CMTAT storage layout approach.

### `naming-convention`

- Status: `Acknowledged`
- Finding: `SnapshotBaseStorageLocation` is not uppercase.
- Feedback:
  The identifier follows the ERC-7201/OpenZeppelin storage-location naming pattern already used in related upstream code, so the project keeps that convention for consistency.
