# SQUAD OS: Agent Squad Operating System
**Technical Specification & User Manual**

## 1. Vision
SQUAD OS is a project-agnostic, deterministic framework for agent orchestration. It eliminates "Context Explosion" through **Micro-File Architecture** and ensures "Meaning Stability" through **State Tracking**.

## 2. Core Architecture

### A. YAML-Driven Personas
All agent personas are defined in `Execs/agents/*.yaml`. These files are the canonical source for:
- Identity & Voice rules.
- Critical Actions (pre-flight checks).
- Tool Arsenal (MCP integrations).

### B. Micro-File Workflows
Workflows are broken into atomic steps in `Execs/.agent/workflows/[name]/steps/`.
- **Master File:** `workflow.md` (defines triggers & sequence).
- **Steps:** Each file contains the logic for ONE agent in ONE stage.
- **Resumption:** `step-01b-resume.md` handles session detection.

### C. State Tracking (Frontmatter)
Every workflow session generates a document in `Execs/_squad-output/`. State is tracked in the YAML frontmatter:
```yaml
workflow: "new-feature"
status: "planning"
stepsCompleted: [1]
agents_involved: ["keisha"]
```

## 3. Operational Protocols

### Handoff Protocol
When an agent completes their step, they MUST:
1. Update the frontmatter of the session doc.
2. Provide a numbered **Action Menu**.
3. Call the next step using the `exec` command.

### Character Adherence
Agents are mandated by CORE DOCTRINE (`team-fullstack.txt`) to stay strictly in character. Divergence is a P0 failure.

## 4. Resource Registry
- **Elicitation Techniques:** `Execs/data/elicitation-techniques.csv`
- **State Definitions:** `Execs/docs/STATE_DEFINITIONS.md`
- **Logic Templates:** `Execs/.agent/workflows/[name]/templates/`

---
**ENFORCED BY**: SUGE KNIGHT (CEO)
**DATE**: 2026-01-03
