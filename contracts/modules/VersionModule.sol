// SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

/* ==== CMTAT === */
import {IERC3643Base} from "../../CMTAT/contracts/interfaces/tokenization/IERC3643Partial.sol";

abstract contract VersionModule is IERC3643Base {
    /* ============ State Variables ============ */
    /**
     * @dev
     * Get the current version of the smart contract
     */
    string private constant VERSION = "0.3.0";

    /* ============ Events ============ */
    /*//////////////////////////////////////////////////////////////
                            PUBLIC/EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    /**
     * @inheritdoc IERC3643Base
     */
    function version()
        public
        view
        virtual
        override(IERC3643Base)
        returns (string memory version_)
    {
        return VERSION;
    }
}