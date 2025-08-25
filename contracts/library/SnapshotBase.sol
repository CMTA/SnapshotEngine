//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;
import {Arrays} from '@openzeppelin/contracts/utils/Arrays.sol';

import {ISnapshotBase} from "../interface/ISnapshotBase.sol";

/**
 * @dev Base for the Snapshot Engine
 *
 * Useful to take a snapshot of token holder balance and total supply at a specific time
 * Inspired by Openzeppelin - ERC20Snapshot but use the time as Id instead of a counter.
 * Contrary to OpenZeppelin, the function _getCurrentSnapshotId is not available 
 *  because overriding this function can break the contract.
 */

abstract contract SnapshotBase is ISnapshotBase {
    using Arrays for uint256[];
    /* ============ Structs ============ *
    /** 
    * @dev See {OpenZeppelin - ERC20Snapshot}
    * Snapshotted values have arrays of ids (time) and the value corresponding to that id.
    * ids is expected to be sorted in ascending order, and to contain no repeated elements 
    * because we use findUpperBound in the function _valueAt
    */
    struct Snapshots {
        uint256[] ids;
        uint256[] values;
    }
    /* ============ State variables ============ */
    /* ============ ERC-7201 ============ */
    // keccak256(abi.encode(uint256(keccak256("SnapshotEngine.storage.SnapshotBase")) - 1)) & ~bytes32(uint256(0xff))
    bytes32 private constant SnapshotBaseStorageLocation = 0x446b515f00c65e1121a2481143a8b54956b614a426d595c02642460414bff800;
 
    /* ==== ERC-7201 State Variables === */
    struct SnapshotBaseStorage {
        /**
        * @dev See {OpenZeppelin - ERC20Snapshot}
        */
        mapping(address => Snapshots) _accountBalanceSnapshots;
        Snapshots _totalSupplySnapshots;
        /**
        * @dev time instead of a counter for OpenZeppelin
        */
        // Initialized to zero
        uint256 _currentSnapshotTime;
        // Initialized to zero
        uint256 _currentSnapshotIndex;
        /** 
        * @dev 
        * list of scheduled snapshot (time)
        * This list is sorted in ascending order
        */
        uint256[] _scheduledSnapshots;
    }

    /*//////////////////////////////////////////////////////////////
                            PUBLIC/EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    /**
    " @inheritdoc ISnapshotBase
    */
    function getAllSnapshots() public view returns (uint256[] memory) {
        SnapshotBaseStorage storage $ = _getSnapshotBaseStorage();
        return $._scheduledSnapshots;
    }


    /**
    " @inheritdoc ISnapshotBase
    */
    function getNextSnapshots() public view returns (uint256[] memory) {
        SnapshotBaseStorage storage $ = _getSnapshotBaseStorage();
        uint256[] memory nextScheduledSnapshot = new uint256[](0);
        // no snapshot were planned
        if ($._scheduledSnapshots.length > 0) {
            (
                uint256 timeLowerBound,
                uint256 indexLowerBound
            ) = _findScheduledMostRecentPastSnapshot($);
            // All snapshots are situated in the futur
            if ((timeLowerBound == 0) && ($._currentSnapshotTime == 0)) {
                return $._scheduledSnapshots;
            } else {
                // There are snapshots situated in the futur
                if (indexLowerBound + 1 != $._scheduledSnapshots.length) {
                    // All next snapshots are located after the snapshot specified by indexLowerBound
                    uint256 arraySize = $._scheduledSnapshots.length -
                        indexLowerBound -
                        1;
                    nextScheduledSnapshot = new uint256[](arraySize);
                    for (uint256 i = 0; i < arraySize; ++i) {
                        nextScheduledSnapshot[i] = $._scheduledSnapshots[
                            indexLowerBound + 1 + i
                        ];
                    }
                }
            }
        }
        return nextScheduledSnapshot;
    }

    /*//////////////////////////////////////////////////////////////
                            INTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /* ============ State functions ============ */

    /** 
    * @dev schedule a snapshot at the specified time
    * You can only add a snapshot after the last previous
    */
    function _scheduleSnapshot(uint256 time) internal {
        SnapshotBaseStorage storage $ = _getSnapshotBaseStorage();
        // Check the time firstly to avoid an useless read of storage
       _checkTimeInThePast(time);

        if ($._scheduledSnapshots.length > 0) {
            // We check the last snapshot on the list
            uint256 nextSnapshotTime = $._scheduledSnapshots[
                $._scheduledSnapshots.length - 1
            ];
            if (time < nextSnapshotTime) {
                revert SnapshotEngine_SnapshotTimestampBeforeLastSnapshot(
                        time,
                        nextSnapshotTime
                    );
            } else if (time == nextSnapshotTime) {
                revert SnapshotEngine_SnapshotAlreadyExists();
            }
        }
        $._scheduledSnapshots.push(time);
        emit SnapshotSchedule(0, time);
    }

    /** 
    * @dev schedule a snapshot at the specified time
    */
    function _scheduleSnapshotNotOptimized(uint256 time) internal {
        SnapshotBaseStorage storage $ = _getSnapshotBaseStorage();
        _checkTimeInThePast(time);
        (bool isFound, uint256 index) = _findScheduledSnapshotIndex($, time);
        // Perfect match
        if (isFound) {
            revert SnapshotEngine_SnapshotAlreadyExists();
        }
        // if no upper bound match found, we push the snapshot at the end of the list
        if (index == $._scheduledSnapshots.length) {
            $._scheduledSnapshots.push(time);
        } else {
            // Increase the array by pushing the value of the current last snapshot at the end
            // Can not use a local variable because push is only available for storage array
            $._scheduledSnapshots.push(
                $._scheduledSnapshots[$._scheduledSnapshots.length - 1]
            );
            // Create a local variable to store computation result
            uint256[] memory scheduledSnapshotLocal = $._scheduledSnapshots;
            // Move to the right the snapshots located after the target snapshot (index)
            for (uint256 i = scheduledSnapshotLocal.length - 2; i > index; ) {
                scheduledSnapshotLocal[i] = scheduledSnapshotLocal[i - 1];
                unchecked {
                    --i;
                }
            }
            // Insert the target snapshot
            scheduledSnapshotLocal[index] = time;

            // Update the storage variable with the local one
            $._scheduledSnapshots = scheduledSnapshotLocal;
        }
        emit SnapshotSchedule(0, time);
    }

    /** 
    * @dev reschedule a scheduled snapshot at the specified newTime
    */
    function _rescheduleSnapshot(uint256 oldTime, uint256 newTime) internal {
        // Check the time firstly to avoid an useless read of storage
        _checkTimeSnapshotAlreadyDone(oldTime);
        _checkTimeInThePast(newTime);
         SnapshotBaseStorage storage $ = _getSnapshotBaseStorage();
        if ($._scheduledSnapshots.length == 0) {
            revert SnapshotEngine_NoSnapshotScheduled();
        }
        uint256 index = _findAndRevertScheduledSnapshotIndex($, oldTime);
        // there is a snapshot after the target new time snapshot
        if (index + 1 < $._scheduledSnapshots.length) {
            uint256 nextSnapshotTime = $._scheduledSnapshots[index + 1];
            // new time can not be after the next current snapshot
            if (newTime > nextSnapshotTime) {
                revert SnapshotEngine_SnapshotTimestampAfterNextSnapshot(
                        newTime,
                        nextSnapshotTime
                    );
            } else if (newTime == nextSnapshotTime) {
                revert SnapshotEngine_SnapshotAlreadyExists();
            }
        }
        // There is a snapshot before the target new time snapshot
        if (index > 0) {
            if (newTime <= $._scheduledSnapshots[index - 1])
                revert SnapshotEngine_SnapshotTimestampBeforePreviousSnapshot(
                        newTime,
                        $._scheduledSnapshots[index - 1]
                    );
        }
        // Update the time for the target snapshot
        $._scheduledSnapshots[index] = newTime;

        emit SnapshotSchedule(oldTime, newTime);
    }

    /**
    * @dev unschedule the last scheduled snapshot
    */
    function _unscheduleLastSnapshot(uint256 time) internal {
        // Check the time firstly to avoid an useless read of storage
        _checkTimeSnapshotAlreadyDone(time);
        SnapshotBaseStorage storage $ = _getSnapshotBaseStorage();
        if ($._scheduledSnapshots.length == 0) {
            revert SnapshotEngine_NoSnapshotScheduled();
        }
        // All snapshot time are unique, so we do not check the indice
        if (time !=$._scheduledSnapshots[$._scheduledSnapshots.length - 1]) {
            revert SnapshotEngine_SnapshotNotFound();
        }
        // Update the storage variable with the local one
        $._scheduledSnapshots.pop();
        emit SnapshotUnschedule(time);
    }

    /** 
    * @dev unschedule (remove) a scheduled snapshot in three steps:
    * - search the snapshot in the list
    * - If found, move all next snapshots one position to the left
    * - Reduce the array size by deleting the last snapshot
    */
    function _unscheduleSnapshotNotOptimized(uint256 time) internal {
        _checkTimeSnapshotAlreadyDone(time);
        SnapshotBaseStorage storage $ = _getSnapshotBaseStorage();
        uint256 index = _findAndRevertScheduledSnapshotIndex($, time);
         // Create a local variable to store computation result
        uint256[] memory scheduledSnapshotLocal = $._scheduledSnapshots;
        for (uint256 i = index; i + 1 < scheduledSnapshotLocal.length; ++i ) {
            scheduledSnapshotLocal[i] = scheduledSnapshotLocal[i + 1];
        }
        // Update the storage variable with the local one
        $._scheduledSnapshots = scheduledSnapshotLocal;
        // pop is only available for storage array
        $._scheduledSnapshots.pop();
    }


    /** 
    * @dev
    * Set the currentSnapshotTime by retrieving the most recent snapshot
    * if a snapshot exists, clear all past scheduled snapshot
    */
    function _setCurrentSnapshot() internal {
        SnapshotBaseStorage storage $ = _getSnapshotBaseStorage();
        (
            uint256 scheduleSnapshotTime,
            uint256 scheduleSnapshotIndex
        ) = _findScheduledMostRecentPastSnapshot($);
        if (scheduleSnapshotTime > 0) {
            $._currentSnapshotTime = scheduleSnapshotTime;
            $._currentSnapshotIndex = scheduleSnapshotIndex;
        }
    }



    /* ============ Require balance and total supply ============ */

    /**
    * @dev See {OpenZeppelin - ERC20Snapshot}
    */
    function _updateAccountSnapshot(address account, uint256 accountBalance) internal {
        SnapshotBaseStorage storage $ = _getSnapshotBaseStorage();
        _updateSnapshot($._accountBalanceSnapshots[account], accountBalance);
    }

    /**
    * @dev See {OpenZeppelin - ERC20Snapshot}
    */
    function _updateTotalSupplySnapshot(uint256 totalSupply) internal {
        SnapshotBaseStorage storage $ = _getSnapshotBaseStorage();
        _updateSnapshot($._totalSupplySnapshots, totalSupply);
    }

       /** 
    * @notice Return the number of tokens owned by the given owner at the time when the snapshot with the given time was created.
    * @return value stored in the snapshot, or the actual balance if no snapshot
    */
    function _snapshotBalanceOf(
        uint256 time,
        address owner,
        uint256 ownerBalance
    ) internal view returns (uint256) {
        SnapshotBaseStorage storage $ = _getSnapshotBaseStorage();
        (bool snapshotted, uint256 value) = _valueAt(
            time,
            $._accountBalanceSnapshots[owner]
        );
        return snapshotted ? value :  ownerBalance;
    }

    /**
    * @dev See {OpenZeppelin - ERC20Snapshot}
    * Retrieves the total supply at the specified time.
    * @return value stored in the snapshot, or the actual totalSupply if no snapshot
    */
    function _snapshotTotalSupply(uint256 time, uint256 totalSupply) internal view returns (uint256) {
        SnapshotBaseStorage storage $ = _getSnapshotBaseStorage();
        (bool snapshotted, uint256 value) = _valueAt(
            time,
            $._totalSupplySnapshots
        );
        return snapshotted ? value : totalSupply;
    }

    
    /*//////////////////////////////////////////////////////////////
                        PRIVATE FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    /** 
    * @dev 
    * Inside a struct Snapshots:
    * - Update the array ids to the current Snapshot time if this one is greater than the snapshot times stored in ids.
    * - Update the value to the corresponding value.
    */
    function _updateSnapshot(
        Snapshots storage snapshots,
        uint256 currentValue
    ) private {
        SnapshotBaseStorage storage $ = _getSnapshotBaseStorage();
        uint256 current = $._currentSnapshotTime;
        if (_lastSnapshot(snapshots.ids) < current) {
            snapshots.ids.push(current);
            snapshots.values.push(currentValue);
        }
    }

    /**
    * @dev See {OpenZeppelin - ERC20Snapshot}
    * @param time where we want a snapshot
    * @param snapshots the struct where are stored the snapshots
    * @return  snapshotExist true if a snapshot is found, false otherwise
    * value 0 if no snapshot, balance value if a snapshot exists
    */
    function _valueAt(
        uint256 time,
        Snapshots storage snapshots
    ) private view returns (bool snapshotExist, uint256 value) {
        // When a valid snapshot is queried, there are three possibilities:
        //  a) The queried value was not modified after the snapshot was taken. Therefore, a snapshot entry was never
        //  created for this id, and all stored snapshot ids are smaller than the requested one. The value that corresponds
        //  to this id is the current one.
        //  b) The queried value was modified after the snapshot was taken. Therefore, there will be an entry with the
        //  requested id, and its value is the one to return.
        //  c) More snapshots were created after the requested one, and the queried value was later modified. There will be
        //  no entry for the requested id: the value that corresponds to it is that of the smallest snapshot id that is
        //  larger than the requested one.
        //
        // In summary, we need to find an element in an array, returning the index of the smallest value that is larger if
        // it is not found, unless said value doesn't exist (e.g. when all values are smaller). Arrays.findUpperBound does
        // exactly this.

        uint256 index = snapshots.ids.findUpperBound(time);

        if (index == snapshots.ids.length) {
            return (false, 0);
        } else {
            return (true, snapshots.values[index]);
        }
    }

    /**
    * @return the last snapshot time inside a snapshot ids array
    */
    function _lastSnapshot(
        uint256[] storage ids
    ) private view returns (uint256) {
        if (ids.length == 0) {
            return 0;
        } else {
            return ids[ids.length - 1];
        }
    }

    /** 
    * @dev Find the snapshot index at the specified time
    * @return (true, index) if the snapshot exists, (false, 0) otherwise
    */
    function _findScheduledSnapshotIndex(
        SnapshotBaseStorage storage $,
        uint256 time
    ) private view returns (bool, uint256) {
        uint256 indexFound = $._scheduledSnapshots.findUpperBound(time);
        uint256 _scheduledSnapshotsLength = $._scheduledSnapshots.length;
        // Exact match
        if (
            indexFound != _scheduledSnapshotsLength &&
            $._scheduledSnapshots[indexFound] == time
        ) {
            return (true, indexFound);
        }
        // Upper bound match
        else if (indexFound != _scheduledSnapshotsLength) {
            return (false, indexFound);
        }
        // no match
        else {
            return (false, _scheduledSnapshotsLength);
        }
    }

    /** 
    * @dev find the most recent past snapshot
    * The complexity of this function is O(N) because we go through the whole list
    */
    function _findScheduledMostRecentPastSnapshot(SnapshotBaseStorage storage $)
        private
        view
        returns (uint256 time, uint256 index)
    {
        uint256 currentArraySize = $._scheduledSnapshots.length;
        // no snapshot or the current snapshot already points on the last snapshot
        if (
            currentArraySize == 0 ||
            (($._currentSnapshotIndex + 1 == currentArraySize) && (time != 0))
        ) {
            return (0, currentArraySize);
        }
        // mostRecent is initialized in the loop
        uint256 mostRecent;
        index = currentArraySize;
        // No need of unchecked block since Soliditiy 0.8.22
        for (uint256 i = $._currentSnapshotIndex; i < currentArraySize; ++i ) {
            if ($._scheduledSnapshots[i] <= block.timestamp) {
                mostRecent = $._scheduledSnapshots[i];
                index = i;
            } else {
                // All snapshot are planned in the futur
                break;
            }
        }
        return (mostRecent, index);
    }
    /* ============ Utility functions ============ */


    function _findAndRevertScheduledSnapshotIndex(
        SnapshotBaseStorage storage $,
        uint256 time
    ) private view returns (uint256){
        (bool isFound, uint256 index) = _findScheduledSnapshotIndex($, time);
        if (!isFound) {
            revert SnapshotEngine_SnapshotNotFound();
        }
        return index;
    }
    function _checkTimeInThePast(uint256 time) private view{
        if (time <= block.timestamp) {
                    revert SnapshotEngine_SnapshotScheduledInThePast(
                        time,
                        block.timestamp
                    );
                }
    }
    function _checkTimeSnapshotAlreadyDone(uint256 time) private view{
        if (time <= block.timestamp) {
            revert SnapshotEngine_SnapshotAlreadyDone();
        }
    }

    /* ============ ERC-7201 ============ */
    function _getSnapshotBaseStorage() private pure returns (SnapshotBaseStorage storage $) {
        assembly {
            $.slot := SnapshotBaseStorageLocation
        }
    }
}
