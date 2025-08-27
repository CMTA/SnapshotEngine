//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

/* ==== OpenZeppelin === */
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
/* ==== CMTAT === */
import {ISnapshotEngine} from "../CMTAT/contracts/interfaces/engine/ISnapshotEngine.sol";
/* ==== Modules === */
import {SnapshotSchedulerModule} from "./modules/SnapshotSchedulerModule.sol";
import {SnapshotUpdateModule} from "./modules/SnapshotUpdateModule.sol";
import {SnapshotStateModule} from "./modules/SnapshotStateModule.sol";
import {VersionModule} from "./modules/VersionModule.sol";
/* ==== Interfaces and library === */
import {Errors} from "./library/Errors.sol";
contract SnapshotEngine is SnapshotStateModule, SnapshotUpdateModule, SnapshotSchedulerModule, VersionModule, AccessControl, ISnapshotEngine {
    /* ============ State Variables ============ */
    bytes32 public constant SNAPSHOOTER_ROLE = keccak256("SNAPSHOOTER_ROLE");
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
        } else {
            return AccessControl.hasRole(role, account);
        }
    }

    /*//////////////////////////////////////////////////////////////
                        ERC-20 ENTRY POINT
    //////////////////////////////////////////////////////////////*/
    /**
    * @inheritdoc ISnapshotEngine
    */
   function operateOnTransfer(address from, address to, uint256 balanceFrom, uint256 balanceTo, uint256 totalSupply) public override onlyBoundToken() {
         _snapshotUpdate(from, to, balanceFrom, balanceTo, totalSupply);
    }


     function _authorizeSnapshot() internal virtual override onlyRole(SNAPSHOOTER_ROLE){
        // Nothing to do
     }
}
