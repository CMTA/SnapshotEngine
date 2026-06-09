// SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

/* ==== CMTAT === */
import {IERC3643Version} from "../../CMTAT/contracts/interfaces/tokenization/IERC3643Partial.sol";

/**
 * @title VersionModule
 * @notice Exposes the current SnapshotEngine version string through the ERC-3643 version interface.
 */
abstract contract VersionModule is IERC3643Version {
    /* ============ State Variables ============ */
    /**
     * @dev
     * Get the current version of the smart contract
     */
    string private constant VERSION = "0.5.0";

    /* ============ Events ============ */
    /*//////////////////////////////////////////////////////////////
                            PUBLIC/EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    /**
     * @inheritdoc IERC3643Version
     */
    function version()
        public
        view
        virtual
        override(IERC3643Version)
        returns (string memory version_)
    {
        return VERSION;
    }
}
