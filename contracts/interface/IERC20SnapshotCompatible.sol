//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

/**
 * @title IERC20SnapshotCompatible
 * @notice Minimal token interface required by SnapshotEngine state queries.
 */
interface IERC20SnapshotCompatible {
    function balanceOf(address account) external view returns (uint256);

    function totalSupply() external view returns (uint256);
}
