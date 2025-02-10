//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

/*
* @dev SnapshotEngine custom errors
*/
library Errors {
    // Constructor
    error SnapshotEngine_AddressZeroNotAllowedForERC20();
    error SnapshotEngine_AddressZeroNotAllowedForAdmin();

    error SnapshotEngine_SnapshotScheduledInThePast(
        uint256 time,
        uint256 timestamp
    );
    error SnapshotEngine_SnapshotTimestampBeforeLastSnapshot(
        uint256 time,
        uint256 lastSnapshotTimestamp
    );
    error SnapshotEngine_SnapshotTimestampAfterNextSnapshot(
        uint256 time,
        uint256 nextSnapshotTimestamp
    );
    error SnapshotEngine_SnapshotTimestampBeforePreviousSnapshot(
        uint256 time,
        uint256 previousSnapshotTimestamp
    );
    error SnapshotEngine_SnapshotAlreadyExists();
    error SnapshotEngine_SnapshotAlreadyDone();
    error SnapshotEngine_NoSnapshotScheduled();
    error SnapshotEngine_SnapshotNotFound();
}
