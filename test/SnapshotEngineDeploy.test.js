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
  

  context('Access Control', function () {
    it('testCannotTransferIfNotTokenBound', async function () {
      // Act
      this.transferEngineMock = await ethers.deployContract('SnapshotEngine', [
      this.cmtat.target, this.admin])
      await expect(
        this.transferEngineMock.operateOnTransfer(this.admin, this.admin, 1,1,1)
        ).to.be.revertedWithCustomError(
          this.transferEngineCustomError,
          'SnapshotEngine_UnauthorizedCaller'
        )
    })
  })

  context('SnapshotEngineDeployment', function () {
    it('testHasTheRightVersion', async function () {
      this.transferEngineMock = await ethers.deployContract('SnapshotEngine', [
        this.cmtat.target, this.admin])
      expect(await this.transferEngineMock.version()).to.equal("0.3.0")
    })

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
