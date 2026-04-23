# Code Review Feedback

## Findings

### 1. High: `getNextSnapshots()` can revert when current snapshot is already the last scheduled snapshot
- Location: `contracts/library/SnapshotBase.sol:86-90`, `contracts/library/SnapshotBase.sol:431-434`
- What happens:
  - `_findScheduledMostRecentPastSnapshot()` can return `(0, currentArraySize)` when `_currentSnapshotIndex + 1 == currentArraySize` and `_currentSnapshotTime != 0`.
  - `getNextSnapshots()` then evaluates `indexLowerBound + 1 != $._scheduledSnapshots.length` as `true` (because `currentArraySize + 1 != currentArraySize`).
  - It computes `arraySize = length - indexLowerBound - 1`, which underflows and reverts in Solidity 0.8+.
- Impact:
  - Read-only calls to `getNextSnapshots()` can unexpectedly revert for valid protocol state (no future snapshots left), breaking integrations and monitoring.
- Recommended fix:
  - In `getNextSnapshots()`, use a strict guard before computing `arraySize`:
    - `if (indexLowerBound + 1 < $._scheduledSnapshots.length) { ... }`
  - Preferred approach: fix this in `getNextSnapshots()` only.
  - Do **not** change `_findScheduledMostRecentPastSnapshot()` return semantics unless strictly necessary, because that function is also used by `_setCurrentSnapshot()` and has broader behavioral impact.

### 2. Medium: Missing `SnapshotUnschedule` event in non-optimized unschedule path
- Location: `contracts/library/SnapshotBase.sol:238-251`
- What happens:
  - `_unscheduleLastSnapshot()` emits `SnapshotUnschedule(time)`.
  - `_unscheduleSnapshotNotOptimized()` removes a snapshot but does not emit `SnapshotUnschedule`.
- Impact:
  - Off-chain indexers/audit logs miss unschedule actions taken through this code path, creating inconsistent event-driven state.
- Recommended fix:
  - Emit `SnapshotUnschedule(time)` at the end of `_unscheduleSnapshotNotOptimized()`.

## Open Questions / Assumptions
- I assumed both unschedule functions are intended to have equivalent externally observable behavior except algorithmic complexity.
- I assumed `getNextSnapshots()` should return an empty array (not revert) when there are no future snapshots.

## Testing Gaps
- No test currently appears to assert the terminal-index path for `getNextSnapshots()` (current snapshot at the end, no future snapshots).
- No test currently appears to assert `SnapshotUnschedule` emission for `unscheduleSnapshotNotOptimized()`.

## Verification Notes
- `npx hardhat compile` succeeds.
- `npx hardhat test` could not be completed in this environment due a Mocha reporter/runtime issue:
  - `ERR_MOCHA_INVALID_REPORTER`
  - `TypeError: spawnSync .../node EPERM`
