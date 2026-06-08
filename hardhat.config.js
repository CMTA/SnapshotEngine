/** @type import('hardhat/config').HardhatUserConfig */
//require('@nomiclabs/hardhat-truffle5')
const deactivateReportGas = process.env.DeactivateReportGas === 'true' || process.env.DeactivateReportGas === '1'
const reportGas = !deactivateReportGas
if (reportGas) {
  require('hardhat-gas-reporter')
}
require("solidity-coverage")
require('solidity-docgen')
require("hardhat-contract-sizer");
require("@nomicfoundation/hardhat-chai-matchers")
require('@openzeppelin/hardhat-upgrades')
module.exports = {
  solidity: {
    version: '0.8.30',
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      },
      evmVersion: 'prague'
    }
  },
  contractSizer: {
    alphaSort: true,
    disambiguatePaths: false,
    runOnCompile: true,
    strict: true,
    //only: [':ERC20$'],
  },
  gasReporter: {
    enabled: reportGas
  }
}
