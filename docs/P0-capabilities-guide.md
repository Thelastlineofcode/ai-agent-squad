# P0 Capabilities Guide: Squad OS v2.0
**Foundation Level: Stability & Performance**

This document covers the three core pillars of the v2.0 foundation.

## 1. Automated State Persistence
Every workflow step now automatically saves progress.

### How it works:
- Whenever a step completes, the `checkpoint-workflow.sh` script is triggered.
- It updates the `last_checkpoint` in your artifact's frontmatter.
- If you lose your session, use `/resume` to find your artifact and pick up exactly where you left off.

## 2. Workflow Validation
We ensure 100% compliance with the **Micro-File Architecture**.

### Tools:
- `bash Execs/dev-tools/validate-workflow.sh [path]`: Validates a single workflow.
- `bash Execs/dev-tools/validate-all-workflows.sh`: Audits the entire system.

## 3. Context Optimization
We track "Token Tax" to keep the agents fast and responsive.

### Metrics:
- **Overhead**: Instruction tokens (the "How").
- **Content**: Generated value (the "What").
- **Goal**: Keep Overhead < 25% of total context.
- **Log**: Check `Execs/.agent-ops/context-metrics.csv` for trends.

---
**Standard**: Stable. Compliant. Optimized.
