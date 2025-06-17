//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

import  {CMTATStandalone} from "../../CMTAT/contracts/deployment/CMTATStandalone.sol";
import  {ICMTATConstructor} from "../../CMTAT/contracts/interfaces/technical/ICMTATConstructor.sol";

/**
 * @dev using to make available CMTAT_STANDALONE in hardhat test
 */
contract CMTAT_STANDALONE_MOCK is CMTATStandalone {
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
    ) CMTATStandalone(forwarderIrrevocable, admin, ERC20Attributes_, baseModuleAttributes_, engines_) {
    }
}
