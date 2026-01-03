# Swarm Workflow
# Trigger: /swarm

**Goal:** Parallel execution of multiple squad workflows.
**Squad:** Suge (Orchestrator) → Multiple Agents

---

## Workflow Architecture

This workflow uses **Parallel Track Management**:
- **Step 1:** @suge validates inputs and maps resources.
- **Step 2:** Background launch of Member Workflows.
- **Step 3:** Result Aggregation.

---

## Initialization

### Configuration
- `installed_path` = `Execs/.agent/workflows/swarm`
- `output_dir` = `Execs/_squad-output/swarm`

### Execution
Load and execute Step 1:

```bash
exec Execs/.agent/workflows/swarm/steps/step-01-suge-orchestra.md
```
