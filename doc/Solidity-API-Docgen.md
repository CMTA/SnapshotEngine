# Solidity API

## SnapshotEngine

### SNAPSHOOTER_ROLE

```solidity
bytes32 SNAPSHOOTER_ROLE
```

### TOKEN_CONTRACT_ROLE

```solidity
bytes32 TOKEN_CONTRACT_ROLE
```

token contract

### VERSION

```solidity
string VERSION
```

Get the current version of the smart contract

### erc20

```solidity
contract IERC20 erc20
```

### constructor

```solidity
constructor(contract IERC20 erc20_, address admin) public
```

### hasRole

```solidity
function hasRole(bytes32 role, address account) public view virtual returns (bool)
```

_Returns `true` if `account` has been granted `role`._

### operateOnTransfer

```solidity
function operateOnTransfer(address from, address to, uint256 balanceFrom, uint256 balanceTo, uint256 totalSupply) public
```

_Update balance and/or total supply snapshots before the values are modified. This is implemented
in the _beforeTokenTransfer hook, which is executed for _mint, _burn, and _transfer operations._

### snapshotInfo

```solidity
function snapshotInfo(uint256 time, address owner) public view returns (uint256 ownerBalance, uint256 totalSupply)
```

Return snapshotBalanceOf and snapshotTotalSupply to avoid multiple calls

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| ownerBalance | uint256 | ,  totalSupply - see snapshotBalanceOf and snapshotTotalSupply |
| totalSupply | uint256 |  |

### snapshotInfoBatch

```solidity
function snapshotInfoBatch(uint256 time, address[] addresses) public view returns (uint256[] ownerBalances, uint256 totalSupply)
```

Return snapshotBalanceOf for each address in the array and the total supply

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| ownerBalances | uint256[] | array with the balance of each address, the total supply |
| totalSupply | uint256 |  |

### snapshotInfoBatch

```solidity
function snapshotInfoBatch(uint256[] times, address[] addresses) public view returns (uint256[][] ownerBalances, uint256[] totalSupply)
```

Return snapshotBalanceOf for each address in the array and the total supply

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| ownerBalances | uint256[][] | array with the balance of each address, the total supply |
| totalSupply | uint256[] |  |

### snapshotBalanceOf

```solidity
function snapshotBalanceOf(uint256 time, address owner) public view returns (uint256)
```

Return the number of tokens owned by the given owner at the time when the snapshot with the given time was created.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | value stored in the snapshot, or the actual balance if no snapshot |

### snapshotTotalSupply

```solidity
function snapshotTotalSupply(uint256 time) public view returns (uint256)
```

_See {OpenZeppelin - ERC20Snapshot}
Retrieves the total supply at the specified time._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | value stored in the snapshot, or the actual totalSupply if no snapshot |

### scheduleSnapshot

```solidity
function scheduleSnapshot(uint256 time) public
```

Schedule a snapshot at the given time specified as a number of seconds since epoch.
The time cannot be before the time of the latest scheduled, but not yet created snapshot.

### scheduleSnapshotNotOptimized

```solidity
function scheduleSnapshotNotOptimized(uint256 time) public
```

Schedule a snapshot at the given time specified as a number of seconds since epoch.
The time cannot be before the time of the latest scheduled, but not yet created snapshot.

### rescheduleSnapshot

```solidity
function rescheduleSnapshot(uint256 oldTime, uint256 newTime) public
```

@notice
Reschedule the scheduled snapshot, but not yet created snapshot with the given oldTime to be created at the given newTime specified as a number of seconds since epoch. 
The newTime cannot be before the time of the previous scheduled, but not yet created snapshot, or after the time fo the next scheduled snapshot.

### unscheduleLastSnapshot

```solidity
function unscheduleLastSnapshot(uint256 time) public
```

Cancel creation of the scheduled snapshot, but not yet created snapshot with the given time. 
There should not be any other snapshots scheduled after this one.

### unscheduleSnapshotNotOptimized

```solidity
function unscheduleSnapshotNotOptimized(uint256 time) public
```

Cancel creation of the scheduled snapshot, but not yet created snapshot with the given time.

## ISnapshotState

minimum interface to represent a CMTAT with snapshot

### snapshotBalanceOf

```solidity
function snapshotBalanceOf(uint256 time, address owner) external view returns (uint256)
```

Return the number of tokens owned by the given owner at the time when the snapshot with the given time was created.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | value stored in the snapshot, or the actual balance if no snapshot |

### snapshotTotalSupply

```solidity
function snapshotTotalSupply(uint256 time) external view returns (uint256)
```

_See {OpenZeppelin - ERC20Snapshot}
Retrieves the total supply at the specified time._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | value stored in the snapshot, or the actual totalSupply if no snapshot |

### snapshotInfo

```solidity
function snapshotInfo(uint256 time, address owner) external view returns (uint256 ownerBalance, uint256 totalSupply)
```

Return snapshotBalanceOf and snapshotTotalSupply to avoid multiple calls

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| ownerBalance | uint256 | ,  totalSupply - see snapshotBalanceOf and snapshotTotalSupply |
| totalSupply | uint256 |  |

### snapshotInfoBatch

```solidity
function snapshotInfoBatch(uint256 time, address[] addresses) external view returns (uint256[] ownerBalances, uint256 totalSupply)
```

Return snapshotBalanceOf for each address in the array and the total supply

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| ownerBalances | uint256[] | array with the balance of each address, the total supply |
| totalSupply | uint256 |  |

### snapshotInfoBatch

```solidity
function snapshotInfoBatch(uint256[] times, address[] addresses) external view returns (uint256[][] ownerBalances, uint256[] totalSupply)
```

Return snapshotBalanceOf for each address in the array and the total supply

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| ownerBalances | uint256[][] | array with the balance of each address, the total supply |
| totalSupply | uint256[] |  |

## Errors

### SnapshotEngine_AddressZeroNotAllowedForERC20

```solidity
error SnapshotEngine_AddressZeroNotAllowedForERC20()
```

### SnapshotEngine_AddressZeroNotAllowedForAdmin

```solidity
error SnapshotEngine_AddressZeroNotAllowedForAdmin()
```

### SnapshotEngine_SnapshotScheduledInThePast

```solidity
error SnapshotEngine_SnapshotScheduledInThePast(uint256 time, uint256 timestamp)
```

### SnapshotEngine_SnapshotTimestampBeforeLastSnapshot

```solidity
error SnapshotEngine_SnapshotTimestampBeforeLastSnapshot(uint256 time, uint256 lastSnapshotTimestamp)
```

### SnapshotEngine_SnapshotTimestampAfterNextSnapshot

```solidity
error SnapshotEngine_SnapshotTimestampAfterNextSnapshot(uint256 time, uint256 nextSnapshotTimestamp)
```

### SnapshotEngine_SnapshotTimestampBeforePreviousSnapshot

```solidity
error SnapshotEngine_SnapshotTimestampBeforePreviousSnapshot(uint256 time, uint256 previousSnapshotTimestamp)
```

### SnapshotEngine_SnapshotAlreadyExists

```solidity
error SnapshotEngine_SnapshotAlreadyExists()
```

### SnapshotEngine_SnapshotAlreadyDone

```solidity
error SnapshotEngine_SnapshotAlreadyDone()
```

### SnapshotEngine_NoSnapshotScheduled

```solidity
error SnapshotEngine_NoSnapshotScheduled()
```

### SnapshotEngine_SnapshotNotFound

```solidity
error SnapshotEngine_SnapshotNotFound()
```

## SnapshotBase

_Base for the Snapshot Engine

Useful to take a snapshot of token holder balance and total supply at a specific time
Inspired by Openzeppelin - ERC20Snapshot but use the time as Id instead of a counter.
Contrary to OpenZeppelin, the function _getCurrentSnapshotId is not available 
 because overriding this function can break the contract._

### Snapshots

```solidity
struct Snapshots {
  uint256[] ids;
  uint256[] values;
}
```

### SnapshotSchedule

```solidity
event SnapshotSchedule(uint256 oldTime, uint256 newTime)
```

Emitted when the snapshot with the specified oldTime was scheduled or rescheduled at the specified newTime.

### SnapshotUnschedule

```solidity
event SnapshotUnschedule(uint256 time)
```

Emitted when the scheduled snapshot with the specified time was cancelled.

### _accountBalanceSnapshots

```solidity
mapping(address => struct SnapshotBase.Snapshots) _accountBalanceSnapshots
```

_See {OpenZeppelin - ERC20Snapshot}_

### _totalSupplySnapshots

```solidity
struct SnapshotBase.Snapshots _totalSupplySnapshots
```

### _currentSnapshotTime

```solidity
uint256 _currentSnapshotTime
```

_time instead of a counter for OpenZeppelin_

### _currentSnapshotIndex

```solidity
uint256 _currentSnapshotIndex
```

### _scheduledSnapshots

```solidity
uint256[] _scheduledSnapshots
```

_list of scheduled snapshot (time)
This list is sorted in ascending order_

### getAllSnapshots

```solidity
function getAllSnapshots() public view returns (uint256[])
```

Get all snapshots

### getNextSnapshots

```solidity
function getNextSnapshots() public view returns (uint256[])
```

_Get the next scheduled snapshots_

### _scheduleSnapshot

```solidity
function _scheduleSnapshot(uint256 time) internal
```

_schedule a snapshot at the specified time
You can only add a snapshot after the last previous_

### _scheduleSnapshotNotOptimized

```solidity
function _scheduleSnapshotNotOptimized(uint256 time) internal
```

_schedule a snapshot at the specified time_

### _rescheduleSnapshot

```solidity
function _rescheduleSnapshot(uint256 oldTime, uint256 newTime) internal
```

_reschedule a scheduled snapshot at the specified newTime_

### _unscheduleLastSnapshot

```solidity
function _unscheduleLastSnapshot(uint256 time) internal
```

_unschedule the last scheduled snapshot_

### _unscheduleSnapshotNotOptimized

```solidity
function _unscheduleSnapshotNotOptimized(uint256 time) internal
```

_unschedule (remove) a scheduled snapshot in three steps:
- search the snapshot in the list
- If found, move all next snapshots one position to the left
- Reduce the array size by deleting the last snapshot_

### _valueAt

```solidity
function _valueAt(uint256 time, struct SnapshotBase.Snapshots snapshots) internal view returns (bool snapshotExist, uint256 value)
```

_See {OpenZeppelin - ERC20Snapshot}_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| time | uint256 | where we want a snapshot |
| snapshots | struct SnapshotBase.Snapshots | the struct where are stored the snapshots |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| snapshotExist | bool | true if a snapshot is found, false otherwise value 0 if no snapshot, balance value if a snapshot exists |
| value | uint256 |  |

### _updateSnapshot

```solidity
function _updateSnapshot(struct SnapshotBase.Snapshots snapshots, uint256 currentValue) internal
```

_Inside a struct Snapshots:
- Update the array ids to the current Snapshot time if this one is greater than the snapshot times stored in ids.
- Update the value to the corresponding value._

### _setCurrentSnapshot

```solidity
function _setCurrentSnapshot() internal
```

@dev
Set the currentSnapshotTime by retrieving the most recent snapshot
if a snapshot exists, clear all past scheduled snapshot

### _updateAccountSnapshot

```solidity
function _updateAccountSnapshot(address account, uint256 accountBalance) internal
```

_See {OpenZeppelin - ERC20Snapshot}_

### _updateTotalSupplySnapshot

```solidity
function _updateTotalSupplySnapshot(uint256 totalSupply) internal
```

_See {OpenZeppelin - ERC20Snapshot}_

### _snapshotBalanceOf

```solidity
function _snapshotBalanceOf(uint256 time, address owner, uint256 ownerBalance) internal view returns (uint256)
```

Return the number of tokens owned by the given owner at the time when the snapshot with the given time was created.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | value stored in the snapshot, or the actual balance if no snapshot |

### _snapshotTotalSupply

```solidity
function _snapshotTotalSupply(uint256 time, uint256 totalSupply) internal view returns (uint256)
```

_See {OpenZeppelin - ERC20Snapshot}
Retrieves the total supply at the specified time._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | value stored in the snapshot, or the actual totalSupply if no snapshot |

### _checkTimeInThePast

```solidity
function _checkTimeInThePast(uint256 time) internal view
```

### _checkTimeSnapshotAlreadyDone

```solidity
function _checkTimeSnapshotAlreadyDone(uint256 time) internal view
```

## CMTAT_STANDALONE_MOCK

_using to make available CMTAT_STANDALONE in hardhat test_

### constructor

```solidity
constructor(address forwarderIrrevocable, address admin, struct ICMTATConstructor.ERC20Attributes ERC20Attributes_, struct ICMTATConstructor.BaseModuleAttributes baseModuleAttributes_, struct ICMTATConstructor.Engine engines_) public
```

