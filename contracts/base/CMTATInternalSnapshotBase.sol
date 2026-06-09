//SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

/* ==== Modules === */
import {SnapshotSchedulerModule} from "../modules/SnapshotSchedulerModule.sol";
import {SnapshotUpdateModule} from "../modules/SnapshotUpdateModule.sol";
/* ==== CMTAT === */
import {ERC20Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import {CMTATBaseCommon} from "../../CMTAT/contracts/modules/0_CMTATBaseCommon.sol";
import {CMTATBaseRuleEngine} from "../../CMTAT/contracts/modules/3_CMTATBaseRuleEngine.sol";
/* ==== Interfaces and library === */
import {IERC20SnapshotCompatible} from "../interface/IERC20SnapshotCompatible.sol";
import {ISnapshotState} from "../interface/ISnapshotState.sol";
import {SnapshotStateInternal} from "../library/SnapshotStateInternal.sol";

/**
 * @title CMTATInternalSnapshotBase
 * @notice Shared base for CMTAT deployments with integrated internal snapshot scheduling, state queries, and update hooks.
 */
abstract contract CMTATInternalSnapshotBase is
    SnapshotUpdateModule,
    SnapshotSchedulerModule,
    CMTATBaseRuleEngine,
    SnapshotStateInternal,
    ISnapshotState
{
    bytes32 public constant SNAPSHOOTER_ROLE = keccak256("SNAPSHOOTER_ROLE");

    /*//////////////////////////////////////////////////////////////
                         VIEW FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    /**
    * @inheritdoc ISnapshotState
    */
    function snapshotExists(uint256 time) public view virtual override(ISnapshotState) returns (bool) {
        return _isScheduledSnapshot(time);
    }

    /**
    * @inheritdoc ISnapshotState
    */
    function snapshotInfo(uint256 time, address tokenHolder) public view virtual override(ISnapshotState) returns (uint256 tokenHolderBalance, uint256 totalSupply) {
        (tokenHolderBalance, totalSupply) = _snapshotInfo(IERC20SnapshotCompatible(address(this)), time, tokenHolder);
    }

    /**
    * @inheritdoc ISnapshotState
    */
    function snapshotInfoBatch(uint256 time, address[] calldata addresses) public view virtual override(ISnapshotState) returns (uint256[] memory tokenHolderBalances, uint256 totalSupply) {
        (tokenHolderBalances, totalSupply) = _snapshotInfoBatch(IERC20SnapshotCompatible(address(this)), time, addresses);
    }

    /**
    * @inheritdoc ISnapshotState
    */
    function snapshotInfoBatch(uint256[] calldata times, address[] calldata addresses) public view virtual override(ISnapshotState) returns (uint256[][] memory tokenHolderBalances, uint256[] memory totalSupply) {
        (tokenHolderBalances, totalSupply) = _snapshotInfoBatch(IERC20SnapshotCompatible(address(this)), times, addresses);
    }

    /**
    * @inheritdoc ISnapshotState
    */
    function snapshotBalanceOf(
        uint256 time,
        address tokenHolder
    ) public view virtual override(ISnapshotState) returns (uint256) {
        return _snapshotBalanceOf(IERC20SnapshotCompatible(address(this)), time, tokenHolder);
    }

    /**
    * @inheritdoc ISnapshotState
    */
    function snapshotBalanceOfExact(
        uint256 time,
        address tokenHolder
    ) public view virtual override(ISnapshotState) returns (uint256) {
        return _snapshotBalanceOfExact(IERC20SnapshotCompatible(address(this)), time, tokenHolder);
    }

    /**
    * @inheritdoc ISnapshotState
    */
    function snapshotTotalSupply(uint256 time) public view virtual override(ISnapshotState) returns (uint256 totalSupply) {
        return _snapshotTotalSupply(IERC20SnapshotCompatible(address(this)), time);
    }

    /**
    * @inheritdoc ISnapshotState
    */
    function snapshotTotalSupplyExact(uint256 time) public view virtual override(ISnapshotState) returns (uint256 totalSupply) {
        return _snapshotTotalSupplyExact(IERC20SnapshotCompatible(address(this)), time);
    }

    /*//////////////////////////////////////////////////////////////
                        ERC-20 ENTRY POINT
    //////////////////////////////////////////////////////////////*/
    function _update(
        address from,
        address to,
        uint256 amount
    ) internal virtual override(ERC20Upgradeable) {
        SnapshotUpdateModule._snapshotUpdate(from, to, balanceOf(from), balanceOf(to), totalSupply());
        ERC20Upgradeable._update(from, to, amount);
    }

    function transfer(address to, uint256 value)
        public
        virtual
        override(CMTATBaseCommon)
        returns (bool)
    {
        return CMTATBaseCommon.transfer(to, value);
    }

    function transferFrom(address from, address to, uint256 value)
        public
        virtual
        override(CMTATBaseCommon)
        returns (bool)
    {
        return CMTATBaseCommon.transferFrom(from, to, value);
    }

    function approve(address spender, uint256 value)
        public
        virtual
        override(CMTATBaseRuleEngine)
        returns (bool)
    {
        return CMTATBaseRuleEngine.approve(spender, value);
    }

    function decimals()
        public
        view
        virtual
        override(CMTATBaseCommon)
        returns (uint8)
    {
        return CMTATBaseCommon.decimals();
    }

    function name()
        public
        view
        virtual
        override(CMTATBaseCommon)
        returns (string memory)
    {
        return CMTATBaseCommon.name();
    }

    function symbol()
        public
        view
        virtual
        override(CMTATBaseCommon)
        returns (string memory)
    {
        return CMTATBaseCommon.symbol();
    }

    function _authorizeSnapshot() internal virtual override onlyRole(SNAPSHOOTER_ROLE) {
        // Nothing to do
    }
}
