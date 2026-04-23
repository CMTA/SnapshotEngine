const { ethers } = require('hardhat')
const {
  registerSnapshotCommonSuites
} = require('./ERC20SnapshotModuleCommon/registerSnapshotCommonSuites')
const {
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
    ])
    this.transferEngineMock = this.cmtat
  })

  registerSnapshotCommonSuites()
})
