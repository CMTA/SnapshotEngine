const ERC20SnapshotModuleCommonRescheduling = require('./ERC20SnapshotModuleCommonRescheduling')
const ERC20SnapshotModuleCommonScheduling = require('./ERC20SnapshotModuleCommonScheduling')
const ERC20SnapshotModuleCommonUnschedule = require('./ERC20SnapshotModuleCommonUnschedule')
const ERC20SnapshotModuleCommonGetNextSnapshot = require('./ERC20SnapshotModuleCommonGetNextSnapshot')
const ERC20SnapshotModuleCommonExact = require('./ERC20SnapshotModuleCommonExact')
const ERC20SnapshotModuleCommonMaterialized = require('./ERC20SnapshotModuleCommonMaterialized')
const ERC20SnapshotModuleMultiplePlannedTest = require('./global/ERC20SnapshotModuleMultiplePlannedTest')
const ERC20SnapshotModuleOnePlannedSnapshotTest = require('./global/ERC20SnapshotModuleOnePlannedSnapshotTest')
const ERC20SnapshotModuleZeroPlannedSnapshotTest = require('./global/ERC20SnapshotModuleZeroPlannedSnapshot')

function registerSnapshotCommonSuites () {
  ERC20SnapshotModuleMultiplePlannedTest()
  ERC20SnapshotModuleOnePlannedSnapshotTest()
  ERC20SnapshotModuleZeroPlannedSnapshotTest()
  ERC20SnapshotModuleCommonRescheduling()
  ERC20SnapshotModuleCommonScheduling()
  ERC20SnapshotModuleCommonUnschedule()
  ERC20SnapshotModuleCommonGetNextSnapshot()
  ERC20SnapshotModuleCommonExact()
  ERC20SnapshotModuleCommonMaterialized()
}

module.exports = {
  registerSnapshotCommonSuites
}
