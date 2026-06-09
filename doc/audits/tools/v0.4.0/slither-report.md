**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [uninitialized-local](#uninitialized-local) (1 results) (Medium)
 - [calls-loop](#calls-loop) (6 results) (Low)
 - [timestamp](#timestamp) (3 results) (Low)
 - [assembly](#assembly) (1 results) (Informational)
 - [naming-convention](#naming-convention) (1 results) (Informational)
## uninitialized-local
Impact: Medium
Confidence: Medium
 - [ ] ID-0
[SnapshotBase._findScheduledMostRecentPastSnapshot(SnapshotBase.SnapshotBaseStorage).mostRecent](contracts/library/SnapshotBase.sol#L457) is a local variable never initialized

contracts/library/SnapshotBase.sol#L457


## calls-loop
Impact: Low
Confidence: Medium
 - [ ] ID-1
[SnapshotStateInternal._snapshotBalanceOf(IERC20SnapshotCompatible,uint256,address)](contracts/library/SnapshotStateInternal.sol#L35-L41) has external calls inside a loop: [SnapshotBase._snapshotBalanceOf(time,owner,erc20_.balanceOf(owner))](contracts/library/SnapshotStateInternal.sol#L40)
	Calls stack containing the loop:
		CMTATInternalSnapshotBase.snapshotInfoBatch(uint256,address[])
		SnapshotStateInternal._snapshotInfoBatch(IERC20SnapshotCompatible,uint256,address[])

contracts/library/SnapshotStateInternal.sol#L35-L41


 - [ ] ID-2
[SnapshotStateInternal._snapshotBalanceOf(IERC20SnapshotCompatible,uint256,address)](contracts/library/SnapshotStateInternal.sol#L35-L41) has external calls inside a loop: [SnapshotBase._snapshotBalanceOf(time,owner,erc20_.balanceOf(owner))](contracts/library/SnapshotStateInternal.sol#L40)
	Calls stack containing the loop:
		SnapshotStateModule.snapshotInfoBatch(uint256[],address[])
		SnapshotStateInternal._snapshotInfoBatch(IERC20SnapshotCompatible,uint256[],address[])
		SnapshotStateInternal._snapshotInfoBatch(IERC20SnapshotCompatible,uint256,address[])

contracts/library/SnapshotStateInternal.sol#L35-L41


 - [ ] ID-3
[SnapshotStateInternal._snapshotTotalSupply(IERC20SnapshotCompatible,uint256)](contracts/library/SnapshotStateInternal.sol#L42-L44) has external calls inside a loop: [SnapshotBase._snapshotTotalSupply(time,erc20_.totalSupply())](contracts/library/SnapshotStateInternal.sol#L43)
	Calls stack containing the loop:
		SnapshotStateModule.snapshotInfoBatch(uint256[],address[])
		SnapshotStateInternal._snapshotInfoBatch(IERC20SnapshotCompatible,uint256[],address[])
		SnapshotStateInternal._snapshotInfoBatch(IERC20SnapshotCompatible,uint256,address[])

contracts/library/SnapshotStateInternal.sol#L42-L44


 - [ ] ID-4
[SnapshotStateInternal._snapshotBalanceOf(IERC20SnapshotCompatible,uint256,address)](contracts/library/SnapshotStateInternal.sol#L35-L41) has external calls inside a loop: [SnapshotBase._snapshotBalanceOf(time,owner,erc20_.balanceOf(owner))](contracts/library/SnapshotStateInternal.sol#L40)
	Calls stack containing the loop:
		CMTATInternalSnapshotBase.snapshotInfoBatch(uint256[],address[])
		SnapshotStateInternal._snapshotInfoBatch(IERC20SnapshotCompatible,uint256[],address[])
		SnapshotStateInternal._snapshotInfoBatch(IERC20SnapshotCompatible,uint256,address[])

contracts/library/SnapshotStateInternal.sol#L35-L41


 - [ ] ID-5
[SnapshotStateInternal._snapshotTotalSupply(IERC20SnapshotCompatible,uint256)](contracts/library/SnapshotStateInternal.sol#L42-L44) has external calls inside a loop: [SnapshotBase._snapshotTotalSupply(time,erc20_.totalSupply())](contracts/library/SnapshotStateInternal.sol#L43)
	Calls stack containing the loop:
		CMTATInternalSnapshotBase.snapshotInfoBatch(uint256[],address[])
		SnapshotStateInternal._snapshotInfoBatch(IERC20SnapshotCompatible,uint256[],address[])
		SnapshotStateInternal._snapshotInfoBatch(IERC20SnapshotCompatible,uint256,address[])

contracts/library/SnapshotStateInternal.sol#L42-L44


 - [ ] ID-6
[SnapshotStateInternal._snapshotBalanceOf(IERC20SnapshotCompatible,uint256,address)](contracts/library/SnapshotStateInternal.sol#L35-L41) has external calls inside a loop: [SnapshotBase._snapshotBalanceOf(time,owner,erc20_.balanceOf(owner))](contracts/library/SnapshotStateInternal.sol#L40)
	Calls stack containing the loop:
		SnapshotStateModule.snapshotInfoBatch(uint256,address[])
		SnapshotStateInternal._snapshotInfoBatch(IERC20SnapshotCompatible,uint256,address[])

contracts/library/SnapshotStateInternal.sol#L35-L41


## timestamp
Impact: Low
Confidence: Medium
 - [ ] ID-7
[SnapshotBase._findScheduledMostRecentPastSnapshot(SnapshotBase.SnapshotBaseStorage)](contracts/library/SnapshotBase.sol#L443-L470) uses timestamp for comparisons
	Dangerous comparisons:
	- [$._scheduledSnapshots[i] <= block.timestamp](contracts/library/SnapshotBase.sol#L461)

contracts/library/SnapshotBase.sol#L443-L470


 - [ ] ID-8
[SnapshotBase._checkTimeSnapshotAlreadyDone(uint256)](contracts/library/SnapshotBase.sol#L492-L496) uses timestamp for comparisons
	Dangerous comparisons:
	- [time <= block.timestamp](contracts/library/SnapshotBase.sol#L493)

contracts/library/SnapshotBase.sol#L492-L496


 - [ ] ID-9
[SnapshotBase._checkTimeInThePast(uint256)](contracts/library/SnapshotBase.sol#L484-L491) uses timestamp for comparisons
	Dangerous comparisons:
	- [time <= block.timestamp](contracts/library/SnapshotBase.sol#L485)

contracts/library/SnapshotBase.sol#L484-L491


## assembly
Impact: Informational
Confidence: High
 - [ ] ID-10
[SnapshotBase._getSnapshotBaseStorage()](contracts/library/SnapshotBase.sol#L499-L503) uses assembly
	- [INLINE ASM](contracts/library/SnapshotBase.sol#L500-L502)

contracts/library/SnapshotBase.sol#L499-L503


## naming-convention
Impact: Informational
Confidence: High
 - [ ] ID-11
Constant [SnapshotBase.SnapshotBaseStorageLocation](contracts/library/SnapshotBase.sol#L33) is not in UPPER_CASE_WITH_UNDERSCORES

contracts/library/SnapshotBase.sol#L33


