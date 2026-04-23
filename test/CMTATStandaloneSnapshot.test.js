const { ethers } = require('hardhat')
const {
  registerSnapshotCommonSuites
} = require('./ERC20SnapshotModuleCommon/registerSnapshotCommonSuites')
const {
  deployCMTATStandaloneWithParameter,
  fixture,
  loadFixture
} = require('../CMTAT/test/deploymentUtils')
const { buildCmtatInitParams } = require('./helpers/cmtatInitParams')

describe('CMTAT Snapshot Standalone', function () {
  beforeEach(async function () {
    this.snapshotAdminMode = 'access-control'
    const {
      ERC20Attributes,
      extraInformationAttributes,
      engines
    } = buildCmtatInitParams()

    Object.assign(this, await loadFixture(fixture))
    this.cmtat = await ethers.deployContract('CMTATStandaloneSnapshot', [
      this.admin.address,
      ERC20Attributes,
      extraInformationAttributes,
      engines
    ]).catch(async (error) => {
      if (!String(error).includes('code is too large')) {
        throw error
      }

      this.cmtat = await deployCMTATStandaloneWithParameter(
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
