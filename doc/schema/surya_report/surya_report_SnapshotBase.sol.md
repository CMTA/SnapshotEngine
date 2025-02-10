## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./library/SnapshotBase.sol | aa92ff8622060b9358957d78b1c5b240abf89247 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **SnapshotBase** | Implementation |  |||
| └ | getAllSnapshots | Public ❗️ |   |NO❗️ |
| └ | getNextSnapshots | Public ❗️ |   |NO❗️ |
| └ | _scheduleSnapshot | Internal 🔒 | 🛑  | |
| └ | _scheduleSnapshotNotOptimized | Internal 🔒 | 🛑  | |
| └ | _rescheduleSnapshot | Internal 🔒 | 🛑  | |
| └ | _unscheduleLastSnapshot | Internal 🔒 | 🛑  | |
| └ | _unscheduleSnapshotNotOptimized | Internal 🔒 | 🛑  | |
| └ | _valueAt | Internal 🔒 |   | |
| └ | _updateSnapshot | Internal 🔒 | 🛑  | |
| └ | _setCurrentSnapshot | Internal 🔒 | 🛑  | |
| └ | _lastSnapshot | Private 🔐 |   | |
| └ | _findScheduledSnapshotIndex | Private 🔐 |   | |
| └ | _findScheduledMostRecentPastSnapshot | Private 🔐 |   | |
| └ | _updateAccountSnapshot | Internal 🔒 | 🛑  | |
| └ | _updateTotalSupplySnapshot | Internal 🔒 | 🛑  | |
| └ | _snapshotBalanceOf | Internal 🔒 |   | |
| └ | _snapshotTotalSupply | Internal 🔒 |   | |
| └ | _findAndRevertScheduledSnapshotIndex | Private 🔐 |   | |
| └ | _checkTimeInThePast | Internal 🔒 |   | |
| └ | _checkTimeSnapshotAlreadyDone | Internal 🔒 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
