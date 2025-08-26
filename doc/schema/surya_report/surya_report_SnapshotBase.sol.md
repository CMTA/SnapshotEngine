## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./library/SnapshotBase.sol | 385c02bea5486ba60c68b22a91cfce159824e31f |


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
