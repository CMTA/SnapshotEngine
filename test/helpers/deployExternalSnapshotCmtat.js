const { ethers } = require('hardhat')
const { buildCmtatInitParams } = require('./cmtatInitParams')

async function deployExternalSnapshotCmtat (forwarder, admin) {
  const {
    ERC20Attributes,
    extraInformationAttributes,
    engines
  } = buildCmtatInitParams()

  return ethers.deployContract('CMTAT_EXTERNAL_SNAPSHOT_STANDALONE_MOCK', [
    forwarder,
    admin,
    ERC20Attributes,
    extraInformationAttributes,
    engines
  ])
}

module.exports = {
  deployExternalSnapshotCmtat
}
