//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

import {CMTATInternalSnapshotBase} from "../base/CMTATInternalSnapshotBase.sol";
import {ICMTATConstructor} from "../../CMTAT/contracts/interfaces/technical/ICMTATConstructor.sol";

/**
 * @title Local CMTAT deployment with internal snapshots for standalone use
*/
contract CMTATStandaloneInternalSnapshot is CMTATInternalSnapshotBase {
    /**
     * @notice Contract version for standalone deployment with snapshot support
     * @param admin address of the admin of contract (Access Control)
     * @param ERC20Attributes_ ERC20 name, symbol and decimals
     * @param extraInformationAttributes_ tokenId, terms, information
     * @param engines_ external contract
     */
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor(
        address admin,
        ICMTATConstructor.ERC20Attributes memory ERC20Attributes_,
        ICMTATConstructor.ExtraInformationAttributes memory extraInformationAttributes_,
        ICMTATConstructor.Engine memory engines_
    ) {
        // Initialize the contract to avoid front-running
        initialize(
            admin,
            ERC20Attributes_,
            extraInformationAttributes_,
            engines_
        );
    }
}
