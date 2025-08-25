//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

import {SnapshotBase} from "./SnapshotBase.sol";
/* ==== OpenZeppelin === */
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
abstract contract SnapshotStateInternal is SnapshotBase {
    /*//////////////////////////////////////////////////////////////
                         INTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    function _snapshotInfoBatch(IERC20 erc20_, uint256[] calldata times, address[] calldata addresses) internal view returns (uint256[][] memory ownerBalances, uint256[] memory totalSupply) {
        ownerBalances = new uint256[][](times.length);
        totalSupply = new uint256[](times.length);
        for(uint256 iT = 0; iT < times.length; ++iT){
            (ownerBalances[iT], totalSupply[iT]) = _snapshotInfoBatch(erc20_, times[iT],addresses);
        }
    }
    function _snapshotInfoBatch(IERC20 erc20_, uint256 time, address[] calldata addresses) internal view returns (uint256[] memory ownerBalances, uint256 totalSupply) {
        ownerBalances = new uint256[](addresses.length);
        for(uint256 i = 0; i < addresses.length; ++i){
             ownerBalances[i]  = _snapshotBalanceOf(erc20_, time, addresses[i]);
        }
        totalSupply = _snapshotTotalSupply(erc20_, time);
    }

     function _snapshotInfo( IERC20 erc20_, uint256 time, address owner) internal view returns (uint256 ownerBalance, uint256 totalSupply) {
        ownerBalance = _snapshotBalanceOf(erc20_, time, owner);
        totalSupply = _snapshotTotalSupply(erc20_, time);
    }

     function _snapshotBalanceOf(
        IERC20 erc20_,
        uint256 time,
        address owner
    ) internal view returns (uint256) {
        return SnapshotBase._snapshotBalanceOf(time, owner, erc20_.balanceOf(owner));
    }
    function _snapshotTotalSupply(IERC20 erc20_, uint256 time) internal view returns (uint256) {
        return SnapshotBase._snapshotTotalSupply(time, erc20_.totalSupply());
    }
}
