const { ZERO_ADDRESS } = require('./utils.js')
const { expect } = require('chai')
const {
  deployCMTATStandalone,
  fixture,
  loadFixture
} = require('../CMTAT/test/deploymentUtils.js')
describe('Deploy Snapshot Engine', function () {
  beforeEach(async function () {
    Object.assign(this, await loadFixture(fixture))
    this.cmtat = await deployCMTATStandalone(
      this._.address,
      this.admin.address,
      this.deployerAddress.address
    )
   this.transferEngineCustomError = await ethers.deployContract('SnapshotEngine', [
    this.cmtat.target, this.admin])
    this.cmtat.connect(this.admin).setSnapshotEngine(this.transferEngineMock)
  })

  context('SnapshotEngineDeployment', function () {
    it('testCannotDeployIfERC20IsZero', async function () {
      await expect(
        ethers.deployContract('SnapshotEngine', [ZERO_ADDRESS, this.admin])
      ).to.be.revertedWithCustomError(
        this.transferEngineCustomError,
        'SnapshotEngine_AddressZeroNotAllowedForERC20'
      )
    })

    it('testCannotDeployIfSnapshotEngineAdminIsZero', async function () {
      await expect(
        ethers.deployContract('SnapshotEngine', [
          this.cmtat.target,
          ZERO_ADDRESS
        ])
      ).to.be.revertedWithCustomError(
        this.transferEngineCustomError,
        'SnapshotEngine_AddressZeroNotAllowedForAdmin'
      )
    })
  })
})
