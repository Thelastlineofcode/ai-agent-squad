# Workflow Persistence Guide: SQUAD OS v2.0

## 1. Automated Checkpoints
Every workflow now supports automated checkpointing. After each successful step, the system executes:
```bash
Execs/.agent/workflows/_shared/checkpoint-workflow.sh path/to/artifact.md
```
This updates the `last_checkpoint` field in the frontmatter, ensuring we know exactly when progress was last saved.

## 2. Global Resumption
If a workflow is interrupted (e.g., tool crash, session timeout), you can resume by calling:
```bash
/resume
```
This triggers `Execs/.agent/workflows/_shared/resume-workflow.md`, which:
1. Scans `Execs/_squad-output/` for files with `status` not in a terminal state.
2. Identifies the `next_step` based on `stepsCompleted`.
3. Loads the appropriate step file to continue execution.

## 3. Monitoring
Use `/list-active` to see all current active sessions without resuming them.

---
**Standard**: Meaning stability + Progress preservation.
