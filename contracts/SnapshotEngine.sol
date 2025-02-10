//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {SnapshotBase} from "./library/SnapshotBase.sol";
import {ISnapshotState} from "./interface/ISnapshotState.sol";
import {ISnapshotEngine} from "../CMTAT/contracts/interfaces/engine/ISnapshotEngine.sol";
import {Errors} from "./library/Errors.sol";
contract SnapshotEngine is SnapshotBase, AccessControl, ISnapshotEngine, ISnapshotState {
    /* ============ State Variables ============ */
    bytes32 public constant SNAPSHOOTER_ROLE = keccak256("SNAPSHOOTER_ROLE");
    /// @notice token contract
    bytes32 public constant TOKEN_CONTRACT_ROLE =
        keccak256("TOKEN_CONTRACT_ROLE");
    /** 
    * @notice 
    * Get the current version of the smart contract
    */
    string public constant VERSION = "0.1.0";
    IERC20 immutable erc20;
    
    /* ============ Constructor ============ */
    constructor(IERC20 erc20_, address admin) {
        require(address(erc20_) != address(0), Errors.SnapshotEngine_AddressZeroNotAllowedForERC20());
        require(admin != address(0), Errors.SnapshotEngine_AddressZeroNotAllowedForAdmin());
        erc20 = erc20_;
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(TOKEN_CONTRACT_ROLE, address(erc20_));
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
    * @dev Update balance and/or total supply snapshots before the values are modified. This is implemented
    * in the _beforeTokenTransfer hook, which is executed for _mint, _burn, and _transfer operations.
    */
   function operateOnTransfer(address from, address to, uint256 balanceFrom, uint256 balanceTo, uint256 totalSupply) public override onlyRole(TOKEN_CONTRACT_ROLE) {
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
    

    /*//////////////////////////////////////////////////////////////
                          GET SNAPSHOT STATE
    //////////////////////////////////////////////////////////////*/
    /**
    * @notice Return snapshotBalanceOf and snapshotTotalSupply to avoid multiple calls
    * @return ownerBalance ,  totalSupply - see snapshotBalanceOf and snapshotTotalSupply
    */
    function snapshotInfo(uint256 time, address owner) public view returns (uint256 ownerBalance, uint256 totalSupply) {
        ownerBalance = snapshotBalanceOf(time, owner);
        totalSupply = snapshotTotalSupply(time);
    }

    /**
    * @notice Return snapshotBalanceOf for each address in the array and the total supply
    * @return ownerBalances array with the balance of each address, the total supply
    */
    function snapshotInfoBatch(uint256 time, address[] calldata addresses) public view returns (uint256[] memory ownerBalances, uint256 totalSupply) {
        ownerBalances = new uint256[](addresses.length);
        for(uint256 i = 0; i < addresses.length; ++i){
             ownerBalances[i]  = snapshotBalanceOf(time, addresses[i]);
        }
        totalSupply = snapshotTotalSupply(time);
    }

    /**
    * @notice Return snapshotBalanceOf for each address in the array and the total supply
    * @return ownerBalances array with the balance of each address, the total supply
    */
    function snapshotInfoBatch(uint256[] calldata times, address[] calldata addresses) public view returns (uint256[][] memory ownerBalances, uint256[] memory totalSupply) {
        ownerBalances = new uint256[][](times.length);
        totalSupply = new uint256[](times.length);
        for(uint256 iT = 0; iT < times.length; ++iT){
            (ownerBalances[iT], totalSupply[iT]) = snapshotInfoBatch(times[iT],addresses);
        }
    }

    /** 
    * @notice Return the number of tokens owned by the given owner at the time when the snapshot with the given time was created.
    * @return value stored in the snapshot, or the actual balance if no snapshot
    */
    function snapshotBalanceOf(
        uint256 time,
        address owner
    ) public view returns (uint256) {
        return SnapshotBase._snapshotBalanceOf(time, owner, erc20.balanceOf(owner));
    }

    /**
    * @dev See {OpenZeppelin - ERC20Snapshot}
    * Retrieves the total supply at the specified time.
    * @return value stored in the snapshot, or the actual totalSupply if no snapshot
    */
    function snapshotTotalSupply(uint256 time) public view returns (uint256) {
        return SnapshotBase._snapshotTotalSupply(time, erc20.totalSupply());
    }

    /*//////////////////////////////////////////////////////////////
                        RESTRICTED FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /** 
    * @notice 
    * Schedule a snapshot at the given time specified as a number of seconds since epoch.
    * The time cannot be before the time of the latest scheduled, but not yet created snapshot.  
    */
    function scheduleSnapshot(uint256 time) public onlyRole(SNAPSHOOTER_ROLE) {
        SnapshotBase._scheduleSnapshot(time);
    }

    /** 
    * @notice 
    * Schedule a snapshot at the given time specified as a number of seconds since epoch.
    * The time cannot be before the time of the latest scheduled, but not yet created snapshot.  
    */
    function scheduleSnapshotNotOptimized(
        uint256 time
    ) public onlyRole(SNAPSHOOTER_ROLE) {
        SnapshotBase._scheduleSnapshotNotOptimized(time);
    }

    /** 
    * @notice
    * Reschedule the scheduled snapshot, but not yet created snapshot with the given oldTime to be created at the given newTime specified as a number of seconds since epoch. 
    * The newTime cannot be before the time of the previous scheduled, but not yet created snapshot, or after the time fo the next scheduled snapshot. 
    */
    function rescheduleSnapshot(
        uint256 oldTime,
        uint256 newTime
    ) public onlyRole(SNAPSHOOTER_ROLE) {
        SnapshotBase._rescheduleSnapshot(oldTime, newTime);
    }

    /**
    * @notice 
    * Cancel creation of the scheduled snapshot, but not yet created snapshot with the given time. 
    * There should not be any other snapshots scheduled after this one. 
    */
    function unscheduleLastSnapshot(
        uint256 time
    ) public onlyRole(SNAPSHOOTER_ROLE) {
        SnapshotBase._unscheduleLastSnapshot(time);
    }

    /** 
    * @notice 
    * Cancel creation of the scheduled snapshot, but not yet created snapshot with the given time. 
    */
    function unscheduleSnapshotNotOptimized(
        uint256 time
    ) public onlyRole(SNAPSHOOTER_ROLE) {
        SnapshotBase._unscheduleSnapshotNotOptimized(time);
    }
}
