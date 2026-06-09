const { time } = require('@nomicfoundation/hardhat-network-helpers')
const { expect } = require('chai')
const {
  registerSnapshotCommonSuites
} = require('./ERC20SnapshotModuleCommon/registerSnapshotCommonSuites')
const {
  fixture,
  loadFixture
} = require('../CMTAT/test/deploymentUtils')
const {
  checkSnapshot
} = require('./ERC20SnapshotModuleCommon/ERC20SnapshotModuleUtils/ERC20SnapshotModuleUtils')
const { deployExternalSnapshotCmtat } = require('./helpers/deployExternalSnapshotCmtat')
describe('Standard - ERC20SnapshotModule', function () {
  beforeEach(async function () {
    Object.assign(this, await loadFixture(fixture))
    this.snapshotAdminMode = 'access-control'
    this.cmtat = await deployExternalSnapshotCmtat(
      this._.address,
      this.admin.address
    )
    this.transferEngineMock = await ethers.deployContract('SnapshotEngine', [
      this.cmtat.target, this.admin
    ])
    await this.cmtat.connect(this.admin).setSnapshotEngine(this.transferEngineMock)
  })

  context('Compatibility with RuleEngineMock', function () {
    it('supports using the CMTAT mock rule engine together with the external snapshot engine', async function () {
      const ADDRESSES = [this.address1, this.address2]
      const INITIAL_BALANCE_1 = '31'
      const INITIAL_BALANCE_2 = '32'
      const TRANSFER_AMOUNT = '5'

      await this.cmtat.connect(this.admin).mint(this.address1, INITIAL_BALANCE_1)
      await this.cmtat.connect(this.admin).mint(this.address2, INITIAL_BALANCE_2)

      this.ruleEngineMock = await ethers.deployContract('CMTAT_RULE_ENGINE_MOCK', [this.admin])
      await this.cmtat.connect(this.admin).setRuleEngine(this.ruleEngineMock)

      expect(await this.cmtat.ruleEngine()).to.equal(this.ruleEngineMock.target)

      const currentTime = await time.latest()
      const snapshotTime = currentTime + time.duration.seconds(3)
      await this.transferEngineMock.connect(this.admin).scheduleSnapshot(snapshotTime)
      await time.increase(time.duration.seconds(10))

      await this.cmtat.connect(this.address1).transfer(this.address2, TRANSFER_AMOUNT)

      await checkSnapshot.call(
        this,
        snapshotTime,
        '63',
        ADDRESSES,
        [INITIAL_BALANCE_1, INITIAL_BALANCE_2]
      )
      await checkSnapshot.call(
        this,
        await time.latest(),
        '63',
        ADDRESSES,
        ['26', '37']
      )
      expect((await this.transferEngineMock.getNextSnapshots()).length).to.equal(0)
    })
  })

  registerSnapshotCommonSuites()
})
