# AuditAgent Feedback - v0.4.0

This file contains the project feedback for the AI-generated findings reported in [audit_agent_report_v0.4.0.pdf](./audit_agent_report_v0.4.0.pdf).

## Summary

| Severity | Finding | Status | Feedback |
| --- | --- | --- | --- |
| Info | Unbounded scan of overdue scheduled snapshots can make transfer hooks and `poke()` run out of gas | Acknowledged | Valid scalability limitation of the current scheduling model; no direct fund loss, but a sufficiently large overdue backlog can make snapshot materialization and transfer hooks fail. |

## Detailed Feedback

### Unbounded scan of overdue scheduled snapshots can make transfer hooks and `poke()` run out of gas

- Status: `Acknowledged`
- Finding:
  `SnapshotBase._setCurrentSnapshot()` advances by linearly scanning overdue scheduled snapshots from the current index until the first future timestamp. If too many scheduled snapshots accumulate in the past without being materialized, one later transfer, mint, burn, or `poke()` call may need to process that entire overdue suffix in a single transaction.
- Feedback:
  This is a real scalability limitation of the current design rather than a direct loss-of-funds vulnerability. The issue is operational: if an excessively large overdue backlog is allowed to accumulate, snapshot materialization can become too expensive to execute in one transaction, which then also blocks transfer flows that depend on the snapshot hook.

  In practice, the intended mitigation is operational discipline:

  - avoid scheduling an excessively dense backlog of timestamps;
  - materialize snapshots regularly via normal token activity or `poke()`;
  - avoid using the engine in scenarios where an unbounded number of missed historical timestamps must be processed later in one call.

  If stronger resilience is required, the architectural fix would be to redesign backlog processing so that overdue snapshots can be materialized incrementally across multiple transactions instead of all at once.
