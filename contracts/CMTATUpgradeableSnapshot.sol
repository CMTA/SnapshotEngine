//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

/* ==== OpenZeppelin === */
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
/* ==== Modules === */
import {SnapshotSchedulerModule} from "./modules/SnapshotSchedulerModule.sol";
import {SnapshotUpdateModule} from "./modules/SnapshotUpdateModule.sol";
/* ==== CMTAT === */
import {CMTATBaseCommon, ERC20Upgradeable} from "../CMTAT/contracts/modules/0_CMTATBaseCommon.sol";
import {CMTATBaseRuleEngine} from "../CMTAT/contracts/modules/1_CMTATBaseRuleEngine.sol";
/* ==== Interfaces and library === */
import {ISnapshotState} from "./interface/ISnapshotState.sol";
import {SnapshotStateInternal} from "./library/SnapshotStateInternal.sol";
contract CMTATUpgradeableSnapshot is SnapshotUpdateModule, SnapshotSchedulerModule, CMTATBaseRuleEngine,  SnapshotStateInternal, ISnapshotState{
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor()  {
        // Disable the possibility to initialize the implementation
        _disableInitializers();
    }

    /*//////////////////////////////////////////////////////////////
                            PUBLIC/EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /*//////////////////////////////////////////////////////////////
                         VIEW FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    /**
    * @inheritdoc ISnapshotState
    */
    function snapshotInfo(uint256 time, address tokenHolder) public view override(ISnapshotState) returns (uint256 tokenHolderBalance, uint256 totalSupply) {
        (tokenHolderBalance, totalSupply) = _snapshotInfo(IERC20(IERC20(address(this))), time, tokenHolder);
    }

    /**
    * @inheritdoc ISnapshotState
    */
    function snapshotInfoBatch(uint256 time, address[] calldata addresses) public view override(ISnapshotState) returns (uint256[] memory tokenHolderBalances, uint256 totalSupply) {
       (tokenHolderBalances, totalSupply) = _snapshotInfoBatch(IERC20(address(this)), time, addresses);
    }

    /**
    * @inheritdoc ISnapshotState
    */
    function snapshotInfoBatch(uint256[] calldata times, address[] calldata addresses) public view override(ISnapshotState) returns (uint256[][] memory tokenHolderBalances, uint256[] memory totalSupply) {
        (tokenHolderBalances, totalSupply) = _snapshotInfoBatch(IERC20(address(this)), times, addresses);
    }

    /**
    * @inheritdoc ISnapshotState
    */
    function snapshotBalanceOf(
        uint256 time,
        address tokenHolder
    ) public view override(ISnapshotState) returns (uint256) {
        return _snapshotBalanceOf(IERC20(address(this)), time, tokenHolder);
    }

    /**
    * @inheritdoc ISnapshotState
    */
    function snapshotTotalSupply(uint256 time) public view override(ISnapshotState) returns (uint256 totalSupply) {
        return _snapshotTotalSupply(IERC20(address(this)), time);
    }

    /*//////////////////////////////////////////////////////////////
                        ERC-20 ENTRY POINT
    //////////////////////////////////////////////////////////////*/
    function _update(
        address from,
        address to,
        uint256 amount
    ) internal override(CMTATBaseCommon){
        SnapshotUpdateModule._snapshotUpdate(from, to, balanceOf(from), balanceOf(to), totalSupply());
        CMTATBaseCommon._update(from, to, amount);

    }


    function _authorizeSnapshot() internal virtual override onlyRole(SNAPSHOOTER_ROLE){
        // Nothing to do
     }
}
