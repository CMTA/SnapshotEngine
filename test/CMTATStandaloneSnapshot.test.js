const { ethers } = require('hardhat')
const {
  registerCmtatInternalSnapshotBasePassThroughSuites
} = require('./CMTATInternalSnapshotBase.behavior')
const {
  registerSnapshotCommonSuites
} = require('./ERC20SnapshotModuleCommon/registerSnapshotCommonSuites')
const {
  deployCMTATStandaloneWithParameter,
  fixture,
  loadFixture
} = require('../CMTAT/test/deploymentUtils')
const { buildCmtatInitParams } = require('./helpers/cmtatInitParams')

describe('SnapshotEngine CMTAT Standalone', function () {
  beforeEach(async function () {
    this.snapshotAdminMode = 'access-control'
    const {
      ERC20Attributes,
      extraInformationAttributes,
      engines
    } = buildCmtatInitParams()

    Object.assign(this, await loadFixture(fixture))
    this.cmtat = await ethers.deployContract(
      'CMTATStandaloneInternalSnapshot',
      [
        this.admin.address,
        ERC20Attributes,
        extraInformationAttributes,
        engines
      ]
    )
    this.transferEngineMock = this.cmtat
  })

  registerSnapshotCommonSuites()
  registerCmtatInternalSnapshotBasePassThroughSuites()
})
