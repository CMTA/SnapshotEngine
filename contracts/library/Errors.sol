//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

/*
* @dev SnapshotEngine custom errors
*/
library Errors {
    error SnapshotEngine_AddressZeroNotAllowedForERC20();
    error SnapshotEngine_AddressZeroNotAllowedForAdmin();
    error SnapshotEngine_UnauthorizedCaller();
}
