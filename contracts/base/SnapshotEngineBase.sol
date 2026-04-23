//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

/* ==== OpenZeppelin === */
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
/* ==== CMTAT === */
import {ISnapshotEngine} from "../../CMTAT/contracts/interfaces/engine/ISnapshotEngine.sol";
/* ==== Modules === */
import {SnapshotSchedulerModule} from "../modules/SnapshotSchedulerModule.sol";
import {SnapshotUpdateModule} from "../modules/SnapshotUpdateModule.sol";
import {SnapshotStateModule} from "../modules/SnapshotStateModule.sol";
import {VersionModule} from "../modules/VersionModule.sol";
/* ==== Interfaces and library === */
import {Errors} from "../library/Errors.sol";

abstract contract SnapshotEngineBase is SnapshotStateModule, SnapshotUpdateModule, SnapshotSchedulerModule, VersionModule, ISnapshotEngine {
    /* ==== Modifier === */
    modifier onlyBoundToken() {
        if (msg.sender != address(erc20)) {
            revert Errors.SnapshotEngine_UnauthorizedCaller();
        }
        _;
    }

    constructor(IERC20 erc20_) {
        require(address(erc20_) != address(0), Errors.SnapshotEngine_AddressZeroNotAllowedForERC20());
        erc20 = erc20_;
    }

    /*//////////////////////////////////////////////////////////////
                        ERC-20 ENTRY POINT
    //////////////////////////////////////////////////////////////*/
    /**
    * @inheritdoc ISnapshotEngine
    */
    function operateOnTransfer(
        address from,
        address to,
        uint256 balanceFrom,
        uint256 balanceTo,
        uint256 totalSupply
    ) public override onlyBoundToken {
        _snapshotUpdate(from, to, balanceFrom, balanceTo, totalSupply);
    }
}
