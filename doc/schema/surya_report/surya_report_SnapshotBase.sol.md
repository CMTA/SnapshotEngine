## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./library/SnapshotBase.sol | 6af4125c0ed36eb5dabb74755b2a6aebe5a79594 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **SnapshotBase** | Implementation | ISnapshotBase |||
| └ | getAllSnapshots | Public ❗️ |   |NO❗️ |
| └ | getNextSnapshots | Public ❗️ |   |NO❗️ |
| └ | _scheduleSnapshot | Internal 🔒 | 🛑  | |
| └ | _scheduleSnapshotNotOptimized | Internal 🔒 | 🛑  | |
| └ | _rescheduleSnapshot | Internal 🔒 | 🛑  | |
| └ | _unscheduleLastSnapshot | Internal 🔒 | 🛑  | |
| └ | _unscheduleSnapshotNotOptimized | Internal 🔒 | 🛑  | |
| └ | _setCurrentSnapshot | Internal 🔒 | 🛑  | |
| └ | _updateAccountSnapshot | Internal 🔒 | 🛑  | |
| └ | _updateTotalSupplySnapshot | Internal 🔒 | 🛑  | |
| └ | _snapshotBalanceOf | Internal 🔒 |   | |
| └ | _snapshotTotalSupply | Internal 🔒 |   | |
| └ | _snapshotExists | Internal 🔒 |   | |
| └ | _requireSnapshotExists | Internal 🔒 |   | |
| └ | _updateSnapshot | Private 🔐 | 🛑  | |
| └ | _valueAt | Private 🔐 |   | |
| └ | _lastSnapshot | Private 🔐 |   | |
| └ | _findScheduledSnapshotIndex | Private 🔐 |   | |
| └ | _findScheduledMostRecentPastSnapshot | Private 🔐 |   | |
| └ | _findAndRevertScheduledSnapshotIndex | Private 🔐 |   | |
| └ | _checkTimeInThePast | Private 🔐 |   | |
| └ | _checkTimeSnapshotAlreadyDone | Private 🔐 |   | |
| └ | _getSnapshotBaseStorage | Private 🔐 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
