## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./modules/SnapshotScheduler.sol | e3542e1c2eb220147e8adf2eefe1581aed1cc062 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **SnapshotScheduler** | Implementation | SnapshotBase, AccessControl, ISnapshotScheduler |||
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
