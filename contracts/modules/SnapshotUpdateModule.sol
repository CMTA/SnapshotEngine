//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

import {SnapshotBase} from "../library/SnapshotBase.sol";
abstract contract SnapshotUpdateModule is SnapshotBase {
    /** 
    * @dev Update balance and/or total supply snapshots before the values are modified. This is implemented
    * in the _beforeTokenTransfer hook, which is executed for _mint, _burn, and _transfer operations.
    */
    function _snapshotUpdate(
        address from, address to, uint256 balanceFrom, uint256 balanceTo, uint256 totalSupply
    ) internal virtual  {
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
