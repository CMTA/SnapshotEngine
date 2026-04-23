const { ZeroAddress, keccak256, toUtf8Bytes } = require('ethers')

function buildCmtatInitParams () {
  const ruleEngine = ZeroAddress
  const snapshotEngine = ZeroAddress
  const documentEngine = ZeroAddress

  const ERC20Attributes = {
    name: 'Security Token',
    symbol: 'ST',
    decimalsIrrevocable: 0
  }

  const terms = {
    name: 'Token Terms v1',
    uri: 'https://cmta.ch/standards/cmta-token-cmtat',
    documentHash: keccak256(toUtf8Bytes('terms-v1'))
  }

  const extraInformationAttributes = {
    tokenId: '1234567890',
    terms,
    information: 'CMTAT smart contract'
  }

  const engines = {
    ruleEngine,
    snapshotEngine,
    documentEngine
  }

  return {
    ERC20Attributes,
    extraInformationAttributes,
    engines
  }
}

module.exports = {
  buildCmtatInitParams
}
