**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [uninitialized-local](#uninitialized-local) (1 results) (Medium)
 - [timestamp](#timestamp) (3 results) (Low)
 - [dead-code](#dead-code) (18 results) (Informational)
 - [solc-version](#solc-version) (1 results) (Informational)
 - [unused-import](#unused-import) (2 results) (Informational)
 - [unused-state](#unused-state) (6 results) (Informational)
 - [constable-states](#constable-states) (2 results) (Optimization)
## uninitialized-local

> In Solidity, variables are initialized at 0 by default, which is what we want here

Impact: Medium
Confidence: Medium

 - [ ] ID-0
[SnapshotBase._findScheduledMostRecentPastSnapshot().mostRecent](contracts/library/SnapshotBase.sol#L359) is a local variable never initialized

contracts/library/SnapshotBase.sol#L359

## timestamp

> With the Proof of Work, it was possible for a miner to modify the timestamp in a range of about 15 seconds
>
> With the Proof Of Stake, a new block is created every 12 seconds
>
> In all cases, we are not looking for such precision

Impact: Low
Confidence: Medium

 - [ ] ID-1
	[SnapshotBase._checkTimeInThePast(uint256)](contracts/library/SnapshotBase.sol#L431-L438) uses timestamp for comparisons
	Dangerous comparisons:
	- [time <= block.timestamp](contracts/library/SnapshotBase.sol#L432)

contracts/library/SnapshotBase.sol#L431-L438


 - [ ] ID-2
	[SnapshotBase._findScheduledMostRecentPastSnapshot()](contracts/library/SnapshotBase.sol#L345-L372) uses timestamp for comparisons
	Dangerous comparisons:
	- [_scheduledSnapshots[i] <= block.timestamp](contracts/library/SnapshotBase.sol#L363)

contracts/library/SnapshotBase.sol#L345-L372


 - [ ] ID-3
	[SnapshotBase._checkTimeSnapshotAlreadyDone(uint256)](contracts/library/SnapshotBase.sol#L439-L443) uses timestamp for comparisons
	Dangerous comparisons:
	- [time <= block.timestamp](contracts/library/SnapshotBase.sol#L440)

contracts/library/SnapshotBase.sol#L439-L443

## dead-code

> They are used, don't really know why there are flagged as useless

Impact: Informational
Confidence: Medium

 - [ ] ID-4
[SnapshotBase._findScheduledSnapshotIndex(uint256)](contracts/library/SnapshotBase.sol#L319-L339) is never used and should be removed

contracts/library/SnapshotBase.sol#L319-L339


 - [ ] ID-5
[SnapshotBase._findScheduledMostRecentPastSnapshot()](contracts/library/SnapshotBase.sol#L345-L372) is never used and should be removed

contracts/library/SnapshotBase.sol#L345-L372


 - [ ] ID-6
[SnapshotBase._updateAccountSnapshot(address,uint256)](contracts/library/SnapshotBase.sol#L379-L381) is never used and should be removed

contracts/library/SnapshotBase.sol#L379-L381


 - [ ] ID-7
[SnapshotBase._checkTimeSnapshotAlreadyDone(uint256)](contracts/library/SnapshotBase.sol#L439-L443) is never used and should be removed

contracts/library/SnapshotBase.sol#L439-L443


 - [ ] ID-8
[SnapshotBase._findAndRevertScheduledSnapshotIndex(uint256)](contracts/library/SnapshotBase.sol#L422-L430) is never used and should be removed

contracts/library/SnapshotBase.sol#L422-L430


 - [ ] ID-9
[SnapshotBase._setCurrentSnapshot()](contracts/library/SnapshotBase.sol#L291-L300) is never used and should be removed

contracts/library/SnapshotBase.sol#L291-L300


 - [ ] ID-10
[SnapshotBase._scheduleSnapshot(uint256)](contracts/library/SnapshotBase.sol#L114-L135) is never used and should be removed

contracts/library/SnapshotBase.sol#L114-L135


 - [ ] ID-11
[SnapshotBase._snapshotTotalSupply(uint256,uint256)](contracts/library/SnapshotBase.sol#L411-L417) is never used and should be removed

contracts/library/SnapshotBase.sol#L411-L417


 - [ ] ID-12
[SnapshotBase._checkTimeInThePast(uint256)](contracts/library/SnapshotBase.sol#L431-L438) is never used and should be removed

contracts/library/SnapshotBase.sol#L431-L438


 - [ ] ID-13
[SnapshotBase._unscheduleLastSnapshot(uint256)](contracts/library/SnapshotBase.sol#L204-L216) is never used and should be removed

contracts/library/SnapshotBase.sol#L204-L216


 - [ ] ID-14
[SnapshotBase._lastSnapshot(uint256[])](contracts/library/SnapshotBase.sol#L305-L313) is never used and should be removed

contracts/library/SnapshotBase.sol#L305-L313


 - [ ] ID-15
[SnapshotBase._unscheduleSnapshotNotOptimized(uint256)](contracts/library/SnapshotBase.sol#L224-L233) is never used and should be removed

contracts/library/SnapshotBase.sol#L224-L233


 - [ ] ID-16
[SnapshotBase._updateSnapshot(SnapshotBase.Snapshots,uint256)](contracts/library/SnapshotBase.sol#L275-L284) is never used and should be removed

contracts/library/SnapshotBase.sol#L275-L284


 - [ ] ID-17
[SnapshotBase._rescheduleSnapshot(uint256,uint256)](contracts/library/SnapshotBase.sol#L168-L199) is never used and should be removed

contracts/library/SnapshotBase.sol#L168-L199


 - [ ] ID-18
[SnapshotBase._updateTotalSupplySnapshot(uint256)](contracts/library/SnapshotBase.sol#L386-L388) is never used and should be removed

contracts/library/SnapshotBase.sol#L386-L388


 - [ ] ID-19
[SnapshotBase._scheduleSnapshotNotOptimized(uint256)](contracts/library/SnapshotBase.sol#L140-L163) is never used and should be removed

contracts/library/SnapshotBase.sol#L140-L163


 - [ ] ID-20
[SnapshotBase._valueAt(uint256,SnapshotBase.Snapshots)](contracts/library/SnapshotBase.sol#L242-L267) is never used and should be removed

contracts/library/SnapshotBase.sol#L242-L267


 - [ ] ID-21
[SnapshotBase._snapshotBalanceOf(uint256,address,uint256)](contracts/library/SnapshotBase.sol#L394-L404) is never used and should be removed

contracts/library/SnapshotBase.sol#L394-L404

## solc-version

> Defined in the config file

Impact: Informational
Confidence: High

 - [ ] ID-22
	Version constraint ^0.8.20 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- VerbatimInvalidDeduplication
	- FullInlinerNonExpressionSplitArgumentEvaluationOrder
	- MissingSideEffectsOnSelectorAccess.
	 It is used by:
	- node_modules/@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#4
	- node_modules/@openzeppelin/contracts-upgradeable/metatx/ERC2771ContextUpgradeable.sol#4
	- node_modules/@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#4
	- node_modules/@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol#4
	- node_modules/@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#4
	- node_modules/@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol#4
	- node_modules/@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol#4
	- node_modules/@openzeppelin/contracts/access/AccessControl.sol#4
	- node_modules/@openzeppelin/contracts/access/IAccessControl.sol#4
	- node_modules/@openzeppelin/contracts/interfaces/draft-IERC6093.sol#3
	- node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol#4
	- node_modules/@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol#4
	- node_modules/@openzeppelin/contracts/utils/Arrays.sol#5
	- node_modules/@openzeppelin/contracts/utils/Comparators.sol#4
	- node_modules/@openzeppelin/contracts/utils/Context.sol#4
	- node_modules/@openzeppelin/contracts/utils/Panic.sol#4
	- node_modules/@openzeppelin/contracts/utils/SlotDerivation.sol#5
	- node_modules/@openzeppelin/contracts/utils/StorageSlot.sol#5
	- node_modules/@openzeppelin/contracts/utils/introspection/ERC165.sol#4
	- node_modules/@openzeppelin/contracts/utils/introspection/IERC165.sol#4
	- node_modules/@openzeppelin/contracts/utils/math/Math.sol#4
	- node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#5
	- CMTAT/contracts/CMTAT_STANDALONE.sol#3
	- CMTAT/contracts/interfaces/ICCIPToken.sol#3
	- CMTAT/contracts/interfaces/ICMTATConstructor.sol#2
	- CMTAT/contracts/interfaces/draft-IERC1404/draft-IERC1404.sol#3
	- CMTAT/contracts/interfaces/draft-IERC1404/draft-IERC1404EnumCode.sol#3
	- CMTAT/contracts/interfaces/draft-IERC1404/draft-IERC1404Wrapper.sol#3
	- CMTAT/contracts/interfaces/engine/IDebtEngine.sol#3
	- CMTAT/contracts/interfaces/engine/IDebtGlobal.sol#3
	- CMTAT/contracts/interfaces/engine/IRuleEngine.sol#3
	- CMTAT/contracts/interfaces/engine/ISnapshotEngine.sol#3
	- CMTAT/contracts/interfaces/engine/draft-IERC1643.sol#3
	- CMTAT/contracts/libraries/Errors.sol#3
	- CMTAT/contracts/modules/CMTAT_BASE.sol#3
	- CMTAT/contracts/modules/internal/EnforcementModuleInternal.sol#3
	- CMTAT/contracts/modules/internal/ValidationModuleInternal.sol#3
	- CMTAT/contracts/modules/security/AuthorizationModule.sol#3
	- CMTAT/contracts/modules/wrapper/controllers/ValidationModule.sol#3
	- CMTAT/contracts/modules/wrapper/core/BaseModule.sol#3
	- CMTAT/contracts/modules/wrapper/core/ERC20BaseModule.sol#3
	- CMTAT/contracts/modules/wrapper/core/ERC20BurnModule.sol#3
	- CMTAT/contracts/modules/wrapper/core/ERC20MintModule.sol#3
	- CMTAT/contracts/modules/wrapper/core/EnforcementModule.sol#3
	- CMTAT/contracts/modules/wrapper/core/PauseModule.sol#3
	- CMTAT/contracts/modules/wrapper/extensions/DebtModule.sol#3
	- CMTAT/contracts/modules/wrapper/extensions/DocumentModule.sol#3
	- CMTAT/contracts/modules/wrapper/extensions/MetaTxModule.sol#3
	- CMTAT/contracts/modules/wrapper/extensions/SnapshotEngineModule.sol#3
	- contracts/SnapshotEngine.sol#3
	- contracts/interface/ISnapshotState.sol#3
	- contracts/library/Errors.sol#3
	- contracts/library/SnapshotBase.sol#3
	- contracts/mock/CMTAT_STANDALONE_MOCK.sol#3

## unused-import

> used inside the constructor

Impact: Informational
Confidence: High
 - [ ] ID-23
The following unused import(s) in contracts/SnapshotEngine.sol should be removed: 
	-import {Errors} from "./library/Errors.sol"; (contracts/SnapshotEngine.sol#10)

 - [ ] ID-24
	The following unused import(s) in CMTAT/contracts/modules/wrapper/extensions/SnapshotEngineModule.sol should be removed: 
	-import {Errors} from "../../../libraries/Errors.sol"; (CMTAT/contracts/modules/wrapper/extensions/SnapshotEngineModule.sol#6)

## unused-state

> They are used, don't really know why there are flagged as useless

Impact: Informational
Confidence: High
 - [ ] ID-25
[SnapshotEngine.erc20](contracts/SnapshotEngine.sol#L22) is never used in [SnapshotEngine](contracts/SnapshotEngine.sol#L11-L191)

contracts/SnapshotEngine.sol#L22


 - [ ] ID-26
[SnapshotBase._currentSnapshotTime](contracts/library/SnapshotBase.sol#L50) is never used in [SnapshotEngine](contracts/SnapshotEngine.sol#L11-L191)

contracts/library/SnapshotBase.sol#L50


 - [ ] ID-27
[SnapshotBase._accountBalanceSnapshots](contracts/library/SnapshotBase.sol#L44) is never used in [SnapshotEngine](contracts/SnapshotEngine.sol#L11-L191)

contracts/library/SnapshotBase.sol#L44


 - [ ] ID-28
[SnapshotBase._scheduledSnapshots](contracts/library/SnapshotBase.sol#L58) is never used in [SnapshotEngine](contracts/SnapshotEngine.sol#L11-L191)

contracts/library/SnapshotBase.sol#L58


 - [ ] ID-29
[SnapshotBase._totalSupplySnapshots](contracts/library/SnapshotBase.sol#L45) is never used in [SnapshotEngine](contracts/SnapshotEngine.sol#L11-L191)

contracts/library/SnapshotBase.sol#L45


 - [ ] ID-30
[SnapshotBase._currentSnapshotIndex](contracts/library/SnapshotBase.sol#L52) is never used in [SnapshotEngine](contracts/SnapshotEngine.sol#L11-L191)

contracts/library/SnapshotBase.sol#L52

## constable-states

> They can be updated  with the function _setCurrentSnapshot

Impact: Optimization
Confidence: High
 - [ ] ID-31
[SnapshotBase._currentSnapshotIndex](contracts/library/SnapshotBase.sol#L52) should be constant 

contracts/library/SnapshotBase.sol#L52


 - [ ] ID-32
[SnapshotBase._currentSnapshotTime](contracts/library/SnapshotBase.sol#L50) should be constant 

contracts/library/SnapshotBase.sol#L50

