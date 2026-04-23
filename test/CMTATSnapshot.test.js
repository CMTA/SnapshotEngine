const {
  registerSnapshotCommonSuites
} = require('./ERC20SnapshotModuleCommon/registerSnapshotCommonSuites')
const { ethers, upgrades } = require('hardhat')
const {
  deployCMTATProxyWithParameter,
  fixture,
  loadFixture
} = require('../CMTAT/test/deploymentUtils')
const { buildCmtatInitParams } = require('./helpers/cmtatInitParams')
describe('CMTAT Snapshot Upgradeable', function () {
  beforeEach(async function () {
    this.snapshotAdminMode = 'access-control'
    const {
      ERC20Attributes,
      extraInformationAttributes,
      engines
    } = buildCmtatInitParams()

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
    ).catch(async (error) => {
      if (!String(error).includes('code is too large')) {
        throw error
      }

      this.cmtat = await deployCMTATProxyWithParameter(
        this.deployerAddress.address,
        this._.address,
        this.admin.address,
        ERC20Attributes.name,
        ERC20Attributes.symbol,
        ERC20Attributes.decimalsIrrevocable,
        extraInformationAttributes.tokenId,
        extraInformationAttributes.terms,
        extraInformationAttributes.information,
        engines
      )
      this.transferEngineMock = await ethers.deployContract('SnapshotEngine', [
        this.cmtat.target, this.admin
      ])
      await this.cmtat.connect(this.admin).setSnapshotEngine(this.transferEngineMock)
      return this.cmtat
    })

    if (!this.transferEngineMock) {
      this.transferEngineMock = this.cmtat
    }
  })
  registerSnapshotCommonSuites()
})
