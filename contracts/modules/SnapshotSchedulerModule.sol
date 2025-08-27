//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

/* ==== Library === */
import {SnapshotBase} from "../library/SnapshotBase.sol";
import {ISnapshotScheduler} from "../interface/ISnapshotScheduler.sol";
abstract contract SnapshotSchedulerModule is SnapshotBase, ISnapshotScheduler {
    /*//////////////////////////////////////////////////////////////
                            PUBLIC/EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    /**
    * @inheritdoc ISnapshotScheduler
    */
    function scheduleSnapshot(uint256 time) public virtual {
         _authorizeSnapshot();
        SnapshotBase._scheduleSnapshot(time);
    }

    /**
    * @inheritdoc ISnapshotScheduler
    */
    function scheduleSnapshotNotOptimized(
        uint256 time
    ) public virtual {
        _authorizeSnapshot();
        SnapshotBase._scheduleSnapshotNotOptimized(time);
    }

    /**
    * @inheritdoc ISnapshotScheduler
    */
    function rescheduleSnapshot(
        uint256 oldTime,
        uint256 newTime
    ) public virtual {
        _authorizeSnapshot();
        SnapshotBase._rescheduleSnapshot(oldTime, newTime);
    }

    /**
    * @inheritdoc ISnapshotScheduler
    */
    function unscheduleLastSnapshot(
        uint256 time
    ) public virtual {
        _authorizeSnapshot();
        SnapshotBase._unscheduleLastSnapshot(time);
    }

    /**
    * @inheritdoc ISnapshotScheduler
    */
    function unscheduleSnapshotNotOptimized(
        uint256 time
    ) public virtual  {
        _authorizeSnapshot();
        SnapshotBase._unscheduleSnapshotNotOptimized(time);
    }

    /**
    * @dev manage access control by overriding this function
    */
    function _authorizeSnapshot() internal virtual;
}
