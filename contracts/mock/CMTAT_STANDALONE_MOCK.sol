//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

import  "../../CMTAT/contracts/CMTAT_STANDALONE.sol";


/**
 * @dev using to make available CMTAT_STANDALONE in hardhat test
 */
contract CMTAT_STANDALONE_MOCK is CMTAT_STANDALONE {
        /**
     * @notice Contract version for standalone deployment
     * @param forwarderIrrevocable address of the forwarder, required for the gasless support
     * @param admin address of the admin of contract (Access Control)
     * @param ERC20Attributes_ ERC20 name, symbol and decimals
     * @param baseModuleAttributes_ tokenId, terms, information
     * @param engines_ external contract
     */
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor(
        address forwarderIrrevocable,
        address admin,
        ICMTATConstructor.ERC20Attributes memory ERC20Attributes_,
        ICMTATConstructor.BaseModuleAttributes memory baseModuleAttributes_,
        ICMTATConstructor.Engine memory engines_ 
    ) CMTAT_STANDALONE(forwarderIrrevocable, admin, ERC20Attributes_, baseModuleAttributes_, engines_) {
    }
}
