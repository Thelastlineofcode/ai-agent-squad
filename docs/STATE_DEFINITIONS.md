# State Definitions: Agent Squad OS
**Registry of Frozen Semantics**

This document serves as the single source of truth for workflow state variables. Any change to these definitions must be approved by @suge.

---

## 1. Global Status Enums

| Value | Definition | Primary Agent |
|-------|------------|---------------|
| `planning` | Requirement gathering and PRD generation active. | @keisha |
| `implementation` | Code construction or refactoring phase. | @ox |
| `validation` | Test execution and QA checkpoints. | @soulja |
| `review` | Final architectural and policy gate. | @dmx |
| `complete` | Mission success. All artifacts signed and archived. | @suge |

## 2. Tracking Variables (Frontmatter)

### `stepsCompleted`
- **Type**: `Array<Integer>`
- **Semantic**: A collection of unique identifiers representing successfully closed workflow phases.
- **Rule**: A step is only "complete" when the next agent in the sequence has loaded the context and verified the previous output.

### `agents_involved`
- **Type**: `Array<String>`
- **Semantic**: List of agent IDs that have contributed to the current artifact.

### `status`
- **Type**: `String`
- **Semantic**: The active operational phase as defined in Section 1.

## 3. Risk Levels

- **CRITICAL**: Immediate action required. Blocks all deployment.
- **HIGH**: Strategic risk. Must be mitigated before phase transition.
- **MEDIUM**: Technical debt or aesthetic drift. Monitor.
- **LOW**: Minor polish or documentation gap.

---
**AUTHORITY**: SUGE KNIGHT (CEO)
**DATE**: 2026-01-03
