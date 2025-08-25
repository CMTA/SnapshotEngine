//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;
/* ==== OpenZeppelin === */
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
/* ==== Library === */
import {SnapshotBase} from "../library/SnapshotBase.sol";
import {ISnapshotScheduler} from "../interface/ISnapshotScheduler.sol";
abstract contract SnapshotScheduler is SnapshotBase, AccessControl, ISnapshotScheduler {
    /* ============ State Variables ============ */
    bytes32 public constant SNAPSHOOTER_ROLE = keccak256("SNAPSHOOTER_ROLE");

    /*//////////////////////////////////////////////////////////////
                            PUBLIC/EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/


    /**
    * @inheritdoc ISnapshotScheduler
    */
    function scheduleSnapshot(uint256 time) public onlyRole(SNAPSHOOTER_ROLE) {
        SnapshotBase._scheduleSnapshot(time);
    }

    /**
    * @inheritdoc ISnapshotScheduler
    */
    function scheduleSnapshotNotOptimized(
        uint256 time
    ) public onlyRole(SNAPSHOOTER_ROLE) {
        SnapshotBase._scheduleSnapshotNotOptimized(time);
    }

    /**
    * @inheritdoc ISnapshotScheduler
    */
    function rescheduleSnapshot(
        uint256 oldTime,
        uint256 newTime
    ) public onlyRole(SNAPSHOOTER_ROLE) {
        SnapshotBase._rescheduleSnapshot(oldTime, newTime);
    }

    /**
    * @inheritdoc ISnapshotScheduler
    */
    function unscheduleLastSnapshot(
        uint256 time
    ) public onlyRole(SNAPSHOOTER_ROLE) {
        SnapshotBase._unscheduleLastSnapshot(time);
    }

    /**
    * @inheritdoc ISnapshotScheduler
    */
    function unscheduleSnapshotNotOptimized(
        uint256 time
    ) public onlyRole(SNAPSHOOTER_ROLE) {
        SnapshotBase._unscheduleSnapshotNotOptimized(time);
    }
}
