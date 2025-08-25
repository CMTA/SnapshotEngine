// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title ISnapshotScheduler
/// @notice Interface for scheduling, rescheduling, and canceling snapshots
interface ISnapshotScheduler {
    /**
     * @notice Schedule a snapshot at the given time specified as a number of seconds since epoch.
     * @dev The time cannot be before the latest scheduled but not yet created snapshot.
     * Access restricted to accounts with SNAPSHOOTER_ROLE.
     * @param time The scheduled time of the snapshot.
     */
    function scheduleSnapshot(uint256 time) external;

    /**
     * @notice Schedule a snapshot at the given time specified as a number of seconds since epoch (non-optimized version).
     * @dev The time cannot be before the latest scheduled but not yet created snapshot.
     * Access restricted to accounts with SNAPSHOOTER_ROLE.
     * @param time The scheduled time of the snapshot.
     */
    function scheduleSnapshotNotOptimized(uint256 time) external;

    /**
     * @notice Reschedule a snapshot from oldTime to newTime.
     * @dev The new time cannot be before the previous scheduled snapshot
     *      or after the next scheduled snapshot.
     * Access restricted to accounts with SNAPSHOOTER_ROLE.
     * @param oldTime The original scheduled time of the snapshot.
     * @param newTime The new scheduled time of the snapshot.
     */
    function rescheduleSnapshot(uint256 oldTime, uint256 newTime) external;

    /**
     * @notice Cancel creation of the last scheduled snapshot at the given time.
     * @dev There must not be any other snapshots scheduled after this one.
     * Access restricted to accounts with SNAPSHOOTER_ROLE.
     * @param time The scheduled time of the snapshot to cancel.
     */
    function unscheduleLastSnapshot(uint256 time) external;

    /**
     * @notice Cancel creation of the scheduled snapshot at the given time (non-optimized version).
     * @dev Access restricted to accounts with SNAPSHOOTER_ROLE.
     * @param time The scheduled time of the snapshot to cancel.
     */
    function unscheduleSnapshotNotOptimized(uint256 time) external;
}