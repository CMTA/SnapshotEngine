//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

import {CMTATStandaloneSnapshot as CMTATStandaloneSnapshotExternal} from "../../CMTAT/contracts/deployment/snapshot/CMTATStandaloneSnapshot.sol";
import {ICMTATConstructor} from "../../CMTAT/contracts/interfaces/technical/ICMTATConstructor.sol";

/**
 * @dev Local alias used to test the external SnapshotEngine against the upstream
 * CMTAT snapshot-enabled deployment without exposing that deployment as this
 * repository's own recommended integration path.
 */
contract CMTAT_EXTERNAL_SNAPSHOT_STANDALONE_MOCK is CMTATStandaloneSnapshotExternal {
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor(
        address forwarderIrrevocable,
        address admin,
        ICMTATConstructor.ERC20Attributes memory ERC20Attributes_,
        ICMTATConstructor.ExtraInformationAttributes memory extraInformationAttributes_,
        ICMTATConstructor.Engine memory engines_
    )
        CMTATStandaloneSnapshotExternal(
            forwarderIrrevocable,
            admin,
            ERC20Attributes_,
            extraInformationAttributes_,
            engines_
        )
    {}
}
