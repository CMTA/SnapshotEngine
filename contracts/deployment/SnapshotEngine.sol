//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

/* ==== OpenZeppelin === */
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {AccessControlEnumerable} from "@openzeppelin/contracts/access/extensions/AccessControlEnumerable.sol";
import {IAccessControl} from "@openzeppelin/contracts/access/IAccessControl.sol";
/* ==== Deployment === */
import {SnapshotEngineBase} from "../base/SnapshotEngineBase.sol";
/* ==== Interfaces and library === */
import {IERC20SnapshotCompatible} from "../interface/IERC20SnapshotCompatible.sol";
import {Errors} from "../library/Errors.sol";

contract SnapshotEngine is SnapshotEngineBase, AccessControlEnumerable {
    /* ============ State Variables ============ */
    bytes32 public constant SNAPSHOOTER_ROLE = keccak256("SNAPSHOOTER_ROLE");

    /* ============ Constructor ============ */
    constructor(IERC20SnapshotCompatible erc20_, address admin) SnapshotEngineBase(erc20_) {
        require(admin != address(0), Errors.SnapshotEngine_AddressZeroNotAllowedForAdmin());
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
    }

    /*//////////////////////////////////////////////////////////////
                            PUBLIC/EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    /** 
     * @dev Returns `true` if `account` has been granted `role`.
     */
    function hasRole(
        bytes32 role,
        address account
    ) public view virtual override(AccessControl, IAccessControl) returns (bool) {
        // The Default Admin has all roles
        if (AccessControl.hasRole(DEFAULT_ADMIN_ROLE, account)) {
            return true;
        } else {
            return AccessControl.hasRole(role, account);
        }
    }

    function _authorizeSnapshot() internal virtual override onlyRole(SNAPSHOOTER_ROLE) {
        // Nothing to do
    }
}
