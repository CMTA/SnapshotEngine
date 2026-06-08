const {
  registerSnapshotCommonSuites
} = require('./ERC20SnapshotModuleCommon/registerSnapshotCommonSuites')
const { ethers, upgrades } = require('hardhat')
const { fixture, loadFixture } = require('../CMTAT/test/deploymentUtils')
const { buildCmtatInitParams } = require('./helpers/cmtatInitParams')
describe('CMTAT Internal Snapshot Upgradeable', function () {
  beforeEach(async function () {
    this.snapshotAdminMode = 'access-control'
    const {
      ERC20Attributes,
      extraInformationAttributes,
      engines
    } = buildCmtatInitParams()

    Object.assign(this, await loadFixture(fixture))
    const ETHERS_CMTAT_PROXY_FACTORY = await ethers.getContractFactory(
      'CMTATUpgradeableInternalSnapshot'
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
  registerSnapshotCommonSuites()
})
