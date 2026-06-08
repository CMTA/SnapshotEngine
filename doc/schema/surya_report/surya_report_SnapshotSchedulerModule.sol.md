## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./modules/SnapshotSchedulerModule.sol | ee8b5e455b46fffa7233c59de1ab435799090124 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **SnapshotSchedulerModule** | Implementation | SnapshotBase, ISnapshotScheduler |||
| └ | poke | Public ❗️ | 🛑  | onlySnapshotManager |
| └ | scheduleSnapshot | Public ❗️ | 🛑  | onlySnapshotManager |
| └ | scheduleSnapshotNotOptimized | Public ❗️ | 🛑  | onlySnapshotManager |
| └ | rescheduleSnapshot | Public ❗️ | 🛑  | onlySnapshotManager |
| └ | unscheduleLastSnapshot | Public ❗️ | 🛑  | onlySnapshotManager |
| └ | unscheduleSnapshotNotOptimized | Public ❗️ | 🛑  | onlySnapshotManager |
| └ | _authorizeSnapshot | Internal 🔒 | 🛑  | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
