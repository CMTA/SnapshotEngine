//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

/* ==== OpenZeppelin === */
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
/* ==== Modules === */
import {SnapshotScheduler} from "./modules/SnapshotScheduler.sol";
import {SnapshotState} from "./modules/SnapshotState.sol";
import {VersionModule} from "./modules/VersionModule.sol";
/* ==== Interfaces and library === */
import {SnapshotBase} from "./library/SnapshotBase.sol";
import {ISnapshotEngine} from "../CMTAT/contracts/interfaces/engine/ISnapshotEngine.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Errors} from "./library/Errors.sol";
contract SnapshotEngine is SnapshotState, SnapshotScheduler, VersionModule, ISnapshotEngine {
    /* ==== Modifier === */
    modifier onlyBoundToken() {
        if (_msgSender() != address(erc20)) {
            revert Errors.SnapshotEngine_UnauthorizedCaller();
        }
        _;
    }
    
    /* ============ Constructor ============ */
    constructor(IERC20 erc20_, address admin) {
        require(address(erc20_) != address(0), Errors.SnapshotEngine_AddressZeroNotAllowedForERC20());
        require(admin != address(0), Errors.SnapshotEngine_AddressZeroNotAllowedForAdmin());
        erc20 = erc20_;
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
    ) public view virtual override(AccessControl) returns (bool) {
        // The Default Admin has all roles
        if (AccessControl.hasRole(DEFAULT_ADMIN_ROLE, account)) {
            return true;
        }
        return AccessControl.hasRole(role, account);
    }

    /*//////////////////////////////////////////////////////////////
                        ERC-20 ENTRY POINT
    //////////////////////////////////////////////////////////////*/
    /**
    * @inheritdoc ISnapshotEngine
    */
   function operateOnTransfer(address from, address to, uint256 balanceFrom, uint256 balanceTo, uint256 totalSupply) public override onlyBoundToken() {
        SnapshotBase._setCurrentSnapshot();
        if (from != address(0)) {
            // for both burn and transfer
            SnapshotBase._updateAccountSnapshot(from, balanceFrom);
            if (to != address(0)) {
                // transfer
                SnapshotBase._updateAccountSnapshot(to, balanceTo);
            } else {
                // burn
                SnapshotBase._updateTotalSupplySnapshot(totalSupply);
            }
        } else {
            // mint
            SnapshotBase._updateAccountSnapshot(to, balanceTo);
            SnapshotBase._updateTotalSupplySnapshot(totalSupply);
        }
    }
}
