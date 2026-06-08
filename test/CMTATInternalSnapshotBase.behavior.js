const { expect } = require('chai')

function registerCmtatInternalSnapshotBasePassThroughSuites () {
  describe('CMTATInternalSnapshotBase pass-through overrides', function () {
    it('forwards approve() to the CMTAT base implementation', async function () {
      await this.cmtat.connect(this.address1).approve(this.address2, 7)

      expect(await this.cmtat.allowance(this.address1, this.address2)).to.equal(7)
    })

    it('forwards transferFrom() to the CMTAT base implementation', async function () {
      await this.cmtat.connect(this.admin).mint(this.address1, 10)
      await this.cmtat.connect(this.address1).approve(this.address2, 4)
      await this.cmtat.connect(this.address2).transferFrom(this.address1, this.address3, 3)

      expect(await this.cmtat.balanceOf(this.address1)).to.equal(7)
      expect(await this.cmtat.balanceOf(this.address3)).to.equal(3)
      expect(await this.cmtat.allowance(this.address1, this.address2)).to.equal(1)
    })

    it('forwards metadata accessors to the CMTAT base implementation', async function () {
      expect(await this.cmtat.decimals()).to.equal(0)
      expect(await this.cmtat.name()).to.equal('Security Token')
      expect(await this.cmtat.symbol()).to.equal('ST')
    })
  })
}

module.exports = {
  registerCmtatInternalSnapshotBasePassThroughSuites
}
