const { time } = require('@nomicfoundation/hardhat-network-helpers')
const { expect } = require('chai')

function ERC20SnapshotModuleCommonExact () {
  context('Exact snapshot queries', function () {
    beforeEach(async function () {
      this.currentTime = await time.latest()
      this.snapshotTime = this.currentTime + time.duration.seconds(3)
      this.nonScheduledTime = this.currentTime + time.duration.seconds(4)
    })

    it('snapshotExists returns true only for exact scheduled times', async function () {
      await this.transferEngineMock.connect(this.admin).scheduleSnapshot(this.snapshotTime)

      expect(await this.transferEngineMock.snapshotExists(this.snapshotTime)).to.equal(true)
      expect(await this.transferEngineMock.snapshotExists(this.nonScheduledTime)).to.equal(false)
    })

    it('exact queries revert for non-scheduled timestamps', async function () {
      await this.transferEngineMock.connect(this.admin).scheduleSnapshot(this.snapshotTime)

      await expect(
        this.transferEngineMock.snapshotBalanceOfExact(this.nonScheduledTime, this.address1)
      ).to.be.revertedWithCustomError(
        this.transferEngineMock,
        'SnapshotEngine_SnapshotNotFound'
      )

      await expect(
        this.transferEngineMock.snapshotTotalSupplyExact(this.nonScheduledTime)
      ).to.be.revertedWithCustomError(
        this.transferEngineMock,
        'SnapshotEngine_SnapshotNotFound'
      )
    })

    it('exact queries match legacy queries for scheduled timestamps', async function () {
      await this.cmtat.connect(this.admin).mint(this.address1, 100)
      await this.transferEngineMock.connect(this.admin).scheduleSnapshot(this.snapshotTime)
      await time.increase(time.duration.seconds(10))
      await this.cmtat.connect(this.admin).mint(this.address1, 50)

      const legacyBalance = await this.transferEngineMock.snapshotBalanceOf(this.snapshotTime, this.address1)
      const exactBalance = await this.transferEngineMock.snapshotBalanceOfExact(this.snapshotTime, this.address1)
      expect(exactBalance).to.equal(legacyBalance)

      const legacyTotalSupply = await this.transferEngineMock.snapshotTotalSupply(this.snapshotTime)
      const exactTotalSupply = await this.transferEngineMock.snapshotTotalSupplyExact(this.snapshotTime)
      expect(exactTotalSupply).to.equal(legacyTotalSupply)
    })
  })
}

module.exports = ERC20SnapshotModuleCommonExact
