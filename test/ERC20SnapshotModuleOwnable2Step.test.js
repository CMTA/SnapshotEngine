const {
  registerSnapshotCommonSuites
} = require('./ERC20SnapshotModuleCommon/registerSnapshotCommonSuites')
const {
  deployCMTATStandalone,
  fixture,
  loadFixture
} = require('../CMTAT/test/deploymentUtils')

describe('Standard - ERC20SnapshotModule Ownable2Step', function () {
  beforeEach(async function () {
    Object.assign(this, await loadFixture(fixture))
    this.snapshotAdminMode = 'ownable-2step'
    this.cmtat = await deployCMTATStandalone(
      this._.address,
      this.admin.address,
      this.deployerAddress.address
    )
    this.transferEngineMock = await ethers.deployContract('SnapshotEngineOwnable2Step', [
      this.cmtat.target, this.admin
    ])
    this.cmtat.connect(this.admin).setSnapshotEngine(this.transferEngineMock)
  })

  registerSnapshotCommonSuites()
})
