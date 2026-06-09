const {
  registerSnapshotCommonSuites
} = require('./ERC20SnapshotModuleCommon/registerSnapshotCommonSuites')
const {
  fixture,
  loadFixture
} = require('../CMTAT/test/deploymentUtils')
const { deployExternalSnapshotCmtat } = require('./helpers/deployExternalSnapshotCmtat')

describe('Standard - ERC20SnapshotModule Ownable2Step', function () {
  beforeEach(async function () {
    Object.assign(this, await loadFixture(fixture))
    this.snapshotAdminMode = 'ownable-2step'
    this.cmtat = await deployExternalSnapshotCmtat(
      this._.address,
      this.admin.address
    )
    this.transferEngineMock = await ethers.deployContract('SnapshotEngineOwnable2Step', [
      this.cmtat.target, this.admin
    ])
    await this.cmtat.connect(this.admin).setSnapshotEngine(this.transferEngineMock)
  })

  registerSnapshotCommonSuites()
})
