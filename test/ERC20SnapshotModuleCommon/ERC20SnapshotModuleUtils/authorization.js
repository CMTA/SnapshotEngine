const { expect } = require('chai')
const { SNAPSHOOTER_ROLE } = require('../../utils')

async function expectUnauthorizedSnapshotAdmin (context, callPromise, caller) {
  const mode = context.snapshotAdminMode || 'access-control'

  if (mode === 'ownable-2step') {
    await expect(callPromise)
      .to.be.revertedWithCustomError(
        context.transferEngineMock,
        'OwnableUnauthorizedAccount'
      )
      .withArgs(caller.address)
    return
  }

  await expect(callPromise)
    .to.be.revertedWithCustomError(
      context.transferEngineMock,
      'AccessControlUnauthorizedAccount'
    )
    .withArgs(caller.address, SNAPSHOOTER_ROLE)
}

module.exports = {
  expectUnauthorizedSnapshotAdmin
}
