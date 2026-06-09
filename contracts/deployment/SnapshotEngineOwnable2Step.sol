//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

/* ==== OpenZeppelin === */
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Ownable2Step} from "@openzeppelin/contracts/access/Ownable2Step.sol";
/* ==== Deployment === */
import {SnapshotEngineBase} from "../base/SnapshotEngineBase.sol";
import {IERC20SnapshotCompatible} from "../interface/IERC20SnapshotCompatible.sol";

contract SnapshotEngineOwnable2Step is SnapshotEngineBase, Ownable2Step {
    /* ============ Constructor ============ */
    constructor(IERC20SnapshotCompatible erc20_, address admin) SnapshotEngineBase(erc20_) Ownable(admin) {
        // Nothing to do
    }

    function _authorizeSnapshot() internal virtual override onlyOwner {
        // Nothing to do
    }
}
