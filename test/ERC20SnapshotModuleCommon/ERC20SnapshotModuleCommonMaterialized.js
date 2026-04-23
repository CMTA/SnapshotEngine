const { time } = require('@nomicfoundation/hardhat-network-helpers')
const { anyValue } = require('@nomicfoundation/hardhat-chai-matchers/withArgs')
const { expect } = require('chai')
const { SNAPSHOOTER_ROLE } = require('../utils')

function ERC20SnapshotModuleCommonMaterialized () {
  context('Snapshot materialization', function () {
    beforeEach(async function () {
      this.currentTime = await time.latest()
      this.snapshotTime = this.currentTime + time.duration.seconds(3)
    })

    it('emits SnapshotMaterialized when a due snapshot is materialized by token activity', async function () {
      await this.transferEngineMock.connect(this.admin).scheduleSnapshot(this.snapshotTime)
      await time.increase(time.duration.seconds(10))

      const logs = await this.cmtat.connect(this.admin).mint(this.address1, 1)
      await expect(logs)
        .to.emit(this.transferEngineMock, 'SnapshotMaterialized')
        .withArgs(this.snapshotTime, anyValue)
    })

    it('poke is access controlled', async function () {
      await expect(this.transferEngineMock.connect(this.address1).poke())
        .to.be.revertedWithCustomError(
          this.transferEngineMock,
          'AccessControlUnauthorizedAccount'
        )
        .withArgs(this.address1.address, SNAPSHOOTER_ROLE)
    })

    it('poke materializes once and does not emit repeatedly for same snapshot', async function () {
      await this.transferEngineMock.connect(this.admin).scheduleSnapshot(this.snapshotTime)
      await time.increase(time.duration.seconds(10))

      const firstPoke = await this.transferEngineMock.connect(this.admin).poke()
      await expect(firstPoke)
        .to.emit(this.transferEngineMock, 'SnapshotMaterialized')
        .withArgs(this.snapshotTime, anyValue)

      const secondPoke = await this.transferEngineMock.connect(this.admin).poke()
      await expect(secondPoke).to.not.emit(this.transferEngineMock, 'SnapshotMaterialized')
    })
  })
}

module.exports = ERC20SnapshotModuleCommonMaterialized
