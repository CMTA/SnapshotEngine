const ERC20SnapshotModuleCommonRescheduling = require('./ERC20SnapshotModuleCommon/ERC20SnapshotModuleCommonRescheduling')
const ERC20SnapshotModuleCommonScheduling = require('./ERC20SnapshotModuleCommon/ERC20SnapshotModuleCommonScheduling')
const ERC20SnapshotModuleCommonUnschedule = require('./ERC20SnapshotModuleCommon/ERC20SnapshotModuleCommonUnschedule')
const ERC20SnapshotModuleCommonGetNextSnapshot = require('./ERC20SnapshotModuleCommon/ERC20SnapshotModuleCommonGetNextSnapshot')
const ERC20SnapshotModuleMultiplePlannedTest = require('./ERC20SnapshotModuleCommon/global/ERC20SnapshotModuleMultiplePlannedTest')
const ERC20SnapshotModuleOnePlannedSnapshotTest = require('./ERC20SnapshotModuleCommon/global/ERC20SnapshotModuleOnePlannedSnapshotTest')
const ERC20SnapshotModuleZeroPlannedSnapshotTest = require('./ERC20SnapshotModuleCommon/global/ERC20SnapshotModuleZeroPlannedSnapshot')
const { ethers,  upgrades } = require("hardhat");
const { ZeroAddress, keccak256, toUtf8Bytes } = require("ethers");
const {
  fixture,
  loadFixture
} = require('../CMTAT/test/deploymentUtils')
const { zeroAddress } = require('ethereumjs-util')
describe('CMTAT Snapshot Upgradeable', function () {
  beforeEach(async function () {
    const ruleEngine = ZeroAddress;
  const snapshotEngine = ZeroAddress;
  const documentEngine = ZeroAddress;
  const ERC20Attributes = {
    name: "Security Token",
    symbol: "ST",
    decimalsIrrevocable: 0 // Compliant with CMTAT spec but can be different
  };

  const terms = {
    name: "Token Terms v1",
    uri: "https://cmta.ch/standards/cmta-token-cmtat",
    documentHash: keccak256(toUtf8Bytes("terms-v1"))
  };

  const extraInformationAttributes = {
    tokenId: "1234567890", // ISIN or identifier
    terms: terms,
    information: "CMTAT smart contract"
  };

  const engines = {
    ruleEngine: ruleEngine,
    snapshotEngine: snapshotEngine,
    documentEngine: documentEngine
  };

    Object.assign(this, await loadFixture(fixture))
    const ETHERS_CMTAT_PROXY_FACTORY = await ethers.getContractFactory(
      'CMTATUpgradeableSnapshot'
    )
    this.cmtat = await upgrades.deployProxy(
      ETHERS_CMTAT_PROXY_FACTORY,
      [
        this.admin.address,
        ERC20Attributes,
        extraInformationAttributes,
        engines
      ],
      {
        initializer: 'initialize',
        from: this.admin.address,
        unsafeAllow: ['missing-initializer']
      }
    )
    this.transferEngineMock = this.cmtat
  })
  ERC20SnapshotModuleMultiplePlannedTest()
  ERC20SnapshotModuleOnePlannedSnapshotTest()
  ERC20SnapshotModuleZeroPlannedSnapshotTest()
  ERC20SnapshotModuleCommonRescheduling()
  ERC20SnapshotModuleCommonScheduling()
  ERC20SnapshotModuleCommonUnschedule()
  ERC20SnapshotModuleCommonGetNextSnapshot()
})
