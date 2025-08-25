//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;
/* ==== OpenZeppelin === */
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
/* ==== Interfaces and library === */
import {SnapshotStateInternal} from "../library/SnapshotStateInternal.sol";
import {ISnapshotState} from "../interface/ISnapshotState.sol";


abstract contract SnapshotState is SnapshotStateInternal, ISnapshotState  {
    IERC20 internal immutable erc20;

    /*//////////////////////////////////////////////////////////////
                            PUBLIC/EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /*//////////////////////////////////////////////////////////////
                         VIEW FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    /**
    * @inheritdoc ISnapshotState
    */
    function snapshotInfo(uint256 time, address tokenHolder) public view override(ISnapshotState) returns (uint256 tokenHolderBalance, uint256 totalSupply) {
        (tokenHolderBalance, totalSupply) = _snapshotInfo(erc20, time, tokenHolder);
    }

    /**
    * @inheritdoc ISnapshotState
    */
    function snapshotInfoBatch(uint256 time, address[] calldata addresses) public view override(ISnapshotState) returns (uint256[] memory tokenHolderBalances, uint256 totalSupply) {
       (tokenHolderBalances, totalSupply) = _snapshotInfoBatch(erc20, time, addresses);
    }

    /**
    * @inheritdoc ISnapshotState
    */
    function snapshotInfoBatch(uint256[] calldata times, address[] calldata addresses) public view override(ISnapshotState) returns (uint256[][] memory tokenHolderBalances, uint256[] memory totalSupply) {
        (tokenHolderBalances, totalSupply) = _snapshotInfoBatch(erc20, times, addresses);
    }

    /**
    * @inheritdoc ISnapshotState
    */
    function snapshotBalanceOf(
        uint256 time,
        address tokenHolder
    ) public view override(ISnapshotState) returns (uint256) {
        return _snapshotBalanceOf(erc20, time, tokenHolder);
    }

    /**
    * @inheritdoc ISnapshotState
    */
    function snapshotTotalSupply(uint256 time) public view override(ISnapshotState) returns (uint256 totalSupply) {
        return _snapshotTotalSupply(erc20, time);
    }
}
