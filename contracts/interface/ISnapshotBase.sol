//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

/// @title ISnapshotBase
/// @notice Base interface for snapshot engines, providing common errors and read-only functions to query snapshots.
interface ISnapshotBase {
    /* ============ Events ============ */
    /**
    * @notice Emitted when a snapshot is scheduled for the first time or rescheduled.
    * @param oldTime The previous scheduled timestamp (0 if newly scheduled).
    * @param newTime The new scheduled timestamp for the snapshot.
    */
    event SnapshotSchedule(uint256 indexed oldTime, uint256 indexed newTime);

    /**
    * @notice Emitted when a previously scheduled snapshot is canceled.
    * @param time The timestamp of the snapshot that was unscheduled.
    */
    event SnapshotUnschedule(uint256 indexed time);

     /* ============ Erros ============ */
     /**
     * @notice Thrown when attempting to schedule a snapshot at a time earlier than the current block timestamp.
     * @param time The snapshot time requested.
     * @param timestamp The current block timestamp.
     */
    error SnapshotEngine_SnapshotScheduledInThePast(
        uint256 time,
        uint256 timestamp
    );
     /**
     * @notice Thrown when a snapshot timestamp is earlier than the last snapshot timestamp.
     * @param time The snapshot time requested.
     * @param lastSnapshotTimestamp The timestamp of the most recent snapshot.
     */
    error SnapshotEngine_SnapshotTimestampBeforeLastSnapshot(
        uint256 time,
        uint256 lastSnapshotTimestamp
    );
     /**
     * @notice Thrown when a snapshot timestamp is later than the next scheduled snapshot timestamp.
     * @param time The snapshot time requested.
     * @param nextSnapshotTimestamp The timestamp of the next scheduled snapshot.
     */
    error SnapshotEngine_SnapshotTimestampAfterNextSnapshot(
        uint256 time,
        uint256 nextSnapshotTimestamp
    );
    /**
     * @notice Thrown when a snapshot timestamp is earlier than the previous snapshot timestamp.
     * @param time The snapshot time requested.
     * @param previousSnapshotTimestamp The timestamp of the previous snapshot.
     */
    error SnapshotEngine_SnapshotTimestampBeforePreviousSnapshot(
        uint256 time,
        uint256 previousSnapshotTimestamp
    );
     /**
     * @notice Thrown when attempting to schedule a snapshot that already exists.
     */
    error SnapshotEngine_SnapshotAlreadyExists();
     /**
     * @notice Thrown when attempting to execute or schedule a snapshot that has already been taken.
     */
    error SnapshotEngine_SnapshotAlreadyDone();
     /**
     * @notice Thrown when attempting to unschedule or interact with a snapshot when no snapshot is currently scheduled.
     */
    error SnapshotEngine_NoSnapshotScheduled();
    /**
     * @notice Thrown when querying or modifying a snapshot that cannot be found.
     */
    error SnapshotEngine_SnapshotNotFound();

    /* ============ Functions ============ */
    /**
     * @notice Get all snapshots that have been created.
     * @return An array of timestamps representing all existing snapshots.
     */
    function getAllSnapshots() external view returns (uint256[] memory);

    /**
     * @notice Get the next scheduled snapshots that have not yet been created.
     * @return An array of timestamps representing all future scheduled snapshots.
     */
    function getNextSnapshots() external view returns (uint256[] memory);
}
