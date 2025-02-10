## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./SnapshotEngine.sol | 6d685c270a37aecfc1fe43b063e2a24b05b82ba6 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **SnapshotEngine** | Implementation | SnapshotBase, AccessControl, ISnapshotEngine, ISnapshotState |||
| └ | <Constructor> | Public ❗️ | 🛑  |NO❗️ |
| └ | hasRole | Public ❗️ |   |NO❗️ |
| └ | operateOnTransfer | Public ❗️ | 🛑  | onlyRole |
| └ | snapshotInfo | Public ❗️ |   |NO❗️ |
| └ | snapshotInfoBatch | Public ❗️ |   |NO❗️ |
| └ | snapshotInfoBatch | Public ❗️ |   |NO❗️ |
| └ | snapshotBalanceOf | Public ❗️ |   |NO❗️ |
| └ | snapshotTotalSupply | Public ❗️ |   |NO❗️ |
| └ | scheduleSnapshot | Public ❗️ | 🛑  | onlyRole |
| └ | scheduleSnapshotNotOptimized | Public ❗️ | 🛑  | onlyRole |
| └ | rescheduleSnapshot | Public ❗️ | 🛑  | onlyRole |
| └ | unscheduleLastSnapshot | Public ❗️ | 🛑  | onlyRole |
| └ | unscheduleSnapshotNotOptimized | Public ❗️ | 🛑  | onlyRole |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
