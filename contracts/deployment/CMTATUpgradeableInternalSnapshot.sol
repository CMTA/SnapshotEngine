//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

import {CMTATInternalSnapshotBase} from "../base/CMTATInternalSnapshotBase.sol";

contract CMTATUpgradeableInternalSnapshot is CMTATInternalSnapshotBase {
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        // Disable the possibility to initialize the implementation
        _disableInitializers();
    }
}
