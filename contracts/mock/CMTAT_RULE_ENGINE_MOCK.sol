//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

import {RuleEngineMock as CMTATRuleEngineMockExternal} from "../../CMTAT/contracts/mocks/RuleEngine/RuleEngineMock.sol";

/**
 * @dev Local alias used to test SnapshotEngine compatibility with the upstream
 * CMTAT rule engine mock without treating submodule contracts as local
 * deployment artifacts.
 */
contract CMTAT_RULE_ENGINE_MOCK is CMTATRuleEngineMockExternal {
    constructor(address spender) CMTATRuleEngineMockExternal(spender) {}
}
