//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

/**
 * @title ISnapshotState
 * @notice Minimal interface for a contract (e.g. SnapshotEngine or CMTAT) that supports querying historical balances and total supply using snapshots.
 */
interface ISnapshotState {
 /**
     * @notice Get the balance of a specific tokenHolder at the snapshot corresponding to a given timestamp.
     * @param time The timestamp identifying the snapshot to query.
     * @param tokenHolder The address whose balance is being requested.
     * @return tokenHolderBalance The recorded balance at the snapshot, or the current balance if no snapshot exists for that timestamp.
     */
    function snapshotBalanceOf(uint256 time,address tokenHolder) external view returns (uint256 tokenHolderBalance);
    
    /**
     * @notice Get the total token supply at the snapshot corresponding to a given timestamp.
     * @param time The timestamp identifying the snapshot to query.
     * @return totalSupply The recorded total supply at the snapshot, or the current total supply if no snapshot exists for that timestamp.
     */
    function snapshotTotalSupply(uint256 time) external view returns (uint256 totalSupply);

    /**
     * @notice Retrieve both an account's balance and the total supply at the snapshot for a given timestamp in a single call.
     * @param time The timestamp identifying the snapshot to query.
     * @param tokenHolder The address whose balance is being requested.
     * @return tokenHolderBalance The recorded balance of the tokenHolder at the snapshot (or current balance if no snapshot).
     * @return totalSupply The recorded total supply at the snapshot (or current total supply if no snapshot).
     */
    function snapshotInfo(uint256 time, address tokenHolder) external view returns (uint256 tokenHolderBalance, uint256 totalSupply);
    /**
     * @notice Retrieve the balances of multiple accounts and the total supply at the snapshot for a given timestamp in a single call.
     * @param time The timestamp identifying the snapshot to query.
     * @param addresses The array of addresses to query balances for.
     * @return tokenHolderBalances An array containing each address's balance at the snapshot (or current balance if no snapshot).
     * @return totalSupply The recorded total supply at the snapshot (or current total supply if no snapshot).
     */
    function snapshotInfoBatch(uint256 time, address[] calldata addresses) external view returns (uint256[] memory tokenHolderBalances, uint256 totalSupply);

    /**
     * @notice Retrieve balances of multiple accounts at multiple snapshots, as well as the total supply at each snapshot.
     * @param times An array of timestamps identifying each snapshot to query.
     * @param addresses The array of addresses to query balances for at each snapshot.
     * @return tokenHolderBalances A 2D array where each row corresponds to the balances of all provided addresses at a given snapshot time.
     * @return totalSupplies An array containing the total supply at each snapshot time (or current supply if no snapshot).
     */
    function snapshotInfoBatch(uint256[] calldata times, address[] calldata addresses) external view returns (uint256[][] memory tokenHolderBalances, uint256[] memory totalSupplies);
}
