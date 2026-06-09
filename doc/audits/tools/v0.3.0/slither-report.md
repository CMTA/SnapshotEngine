**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [uninitialized-local](#uninitialized-local) (1 results) (Medium)
 - [timestamp](#timestamp) (3 results) (Low)
 - [assembly](#assembly) (1 results) (Informational)
 - [solc-version](#solc-version) (1 results) (Informational)
 - [naming-convention](#naming-convention) (1 results) (Informational)
## uninitialized-local

> In Solidity, variables are initialized at 0 by default, which is what we want here

Impact: Medium
Confidence: Medium
 - [ ] ID-0
[SnapshotBase._findScheduledMostRecentPastSnapshot(SnapshotBase.SnapshotBaseStorage).mostRecent](contracts/library/SnapshotBase.sol#L436) is a local variable never initialized

contracts/library/SnapshotBase.sol#L436

## timestamp

> With the Proof of Work, it was possible for a miner to modify the timestamp in a range of about 15 seconds
>
> With the Proof Of Stake, a new block is created every 12 seconds
>
> In all cases, we are not looking for such precision

Impact: Low
Confidence: Medium
 - [ ] ID-1
	[SnapshotBase._checkTimeSnapshotAlreadyDone(uint256)](contracts/library/SnapshotBase.sol#L471-L475) uses timestamp for comparisons
	Dangerous comparisons:
	- [time <= block.timestamp](contracts/library/SnapshotBase.sol#L472)

contracts/library/SnapshotBase.sol#L471-L475


 - [ ] ID-2
	[SnapshotBase._checkTimeInThePast(uint256)](contracts/library/SnapshotBase.sol#L463-L470) uses timestamp for comparisons
	Dangerous comparisons:
	- [time <= block.timestamp](contracts/library/SnapshotBase.sol#L464)

contracts/library/SnapshotBase.sol#L463-L470


 - [ ] ID-3
	[SnapshotBase._findScheduledMostRecentPastSnapshot(SnapshotBase.SnapshotBaseStorage)](contracts/library/SnapshotBase.sol#L422-L449) uses timestamp for comparisons
	Dangerous comparisons:
	- [$._scheduledSnapshots[i] <= block.timestamp](contracts/library/SnapshotBase.sol#L440)

contracts/library/SnapshotBase.sol#L422-L449

## assembly

> Use to implement ERC-7201

Impact: Informational
Confidence: High
 - [ ] ID-4
	[SnapshotBase._getSnapshotBaseStorage()](contracts/library/SnapshotBase.sol#L478-L482) uses assembly
	- [INLINE ASM](contracts/library/SnapshotBase.sol#L479-L481)

contracts/library/SnapshotBase.sol#L478-L482

## solc-version

> Defined in the config file

Impact: Informational
Confidence: High

 - [ ] ID-5
	Version constraint ^0.8.0 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- FullInlinerNonExpressionSplitArgumentEvaluationOrder
	- MissingSideEffectsOnSelectorAccess
	- AbiReencodingHeadOverflowWithStaticArrayCleanup
	- DirtyBytesArrayToStorage
	- DataLocationChangeInInternalOverride
	- NestedCalldataArrayAbiReencodingSizeValidation
	- SignedImmutables
	- ABIDecodeTwoDimensionalArrayMemory
	- KeccakCaching.
	It is used by:
	- [^0.8.0](contracts/interface/ISnapshotScheduler.sol#L2)

contracts/interface/ISnapshotScheduler.sol#L2

## naming-convention

> Same notation as OpenZeppelin ERC-7201

Impact: Informational
Confidence: High
 - [ ] ID-6
Constant [SnapshotBase.SnapshotBaseStorageLocation](contracts/library/SnapshotBase.sol#L33) is not in UPPER_CASE_WITH_UNDERSCORES

contracts/library/SnapshotBase.sol#L33

