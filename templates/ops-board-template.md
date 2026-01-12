# Agent Operations Board
**Project**: [Project Name]
**Last Updated**: [YYYY-MM-DD HH:MM]

---

## Active Tasks

<!-- Tasks are added here by workflow scripts -->
<!-- Format: | Task ID | Task | Assigned | Priority | Status | Files | -->

| Task ID | Task | Assigned | Priority | Status | Files |
|---------|------|----------|----------|--------|-------|
| EXAMPLE | Example task - delete this row | @agent | 🟢 Medium | 🟢 Ready | N/A |

---

## Task Status Legend

| Symbol | Meaning |
|--------|---------|
| 🟢 Ready | Task is ready to start |
| 🟡 In Progress | Task is currently being worked on |
| ✅ Done | Task completed successfully |
| ❌ Failed | Task failed, needs attention |
| 🔴 Blocked | Task blocked by dependency |

---

## Priority Legend

| Symbol | Meaning |
|--------|---------|
| 🔴 Critical | Must be done immediately, blocks other work |
| 🟡 High | Should be done soon, important for milestone |
| 🟢 Medium | Normal priority, part of planned work |
| ⚪ Low | Nice to have, can be deferred |

---

## Agent Assignments

### @keisha (Planner)
- **Role**: Creates PRDs, plans features, analyzes requirements
- **Tools**: git, gh (PR list), semgrep, psql (schema analysis)
- **Output**: PRD documents, task breakdowns, architectural decisions

### @ox (Builder/Coder)
- **Role**: Implements features, writes code, runs builds
- **Tools**: cargo, trunk, wasm-pack, sqlx, docker, rustfmt, git
- **Output**: Working code, passing builds, database migrations

### @soulja (Tester)
- **Role**: Runs tests, verifies coverage, validates functionality
- **Tools**: cargo test, wasm-pack test, stripe trigger, psql, redis
- **Output**: Test results, coverage reports, bug reports

### @dmx (Quality Gatekeeper)
- **Role**: Enforces quality gates, reviews code, approves/blocks PRs
- **Tools**: cargo clippy, rustfmt check, semgrep, gh (review/comment), git diff
- **Output**: Code review feedback, quality gate results, PR approvals

### @jules (Automation/Orchestrator)
- **Role**: Manages PRs, coordinates workflows, automates deployments
- **Tools**: gh (full suite), git, cargo test, docker
- **Output**: PR summaries, deployment status, workflow coordination

---

## Workflow Stages

```
┌─────────┐      ┌────────┐      ┌─────────┐      ┌──────┐
│ Keisha  │─────>│   Ox   │─────>│ Soulja  │─────>│ DMX  │
│ (Plan)  │      │ (Code) │      │ (Test)  │      │(Gate)│
└─────────┘      └────────┘      └─────────┘      └──────┘
    │                │                 │               │
    v                v                 v               v
   PRD          Implementation     Test Results   Approval
```

**Stage 1: Planning (Keisha)**
- User requests feature
- Keisha analyzes codebase
- Creates PRD with task breakdown
- Updates ops board with tasks for Ox
- Handoff: `bash keisha-to-ox.sh`

**Stage 2: Implementation (Ox)**
- Ox reads PRD and ops board
- Implements tasks
- Runs builds and local tests
- Updates ops board with completion
- Handoff: `bash ox-to-soulja.sh`

**Stage 3: Testing (Soulja)**
- Soulja runs full test suite
- Verifies coverage meets threshold
- Documents test results
- Updates ops board with results
- Handoff: `bash soulja-to-dmx.sh`

**Stage 4: Quality Gate (DMX)**
- DMX runs quality checks (clippy, rustfmt, semgrep)
- Verifies all gates pass
- Approves or requests changes
- Updates ops board with decision
- Tool: `bash dmx-review.sh`

---

## Completed Tasks Archive

<!-- Move completed tasks here weekly to keep Active Tasks section clean -->

### Week of [YYYY-MM-DD]

| Task ID | Task | Assigned | Completed | Outcome |
|---------|------|----------|-----------|---------|
| - | No completed tasks yet | - | - | - |

---

## Blocked Tasks

<!-- Tasks that are blocked by external dependencies -->

| Task ID | Task | Blocked By | Resolution |
|---------|------|------------|------------|
| - | No blocked tasks | - | - |

---

## Notes & Decisions

<!-- Quick notes about decisions made during task execution -->

- [YYYY-MM-DD] Initial ops board created
- Add notes here as agents make decisions

---

## Quick Reference

**View Current Task Status**:
```bash
grep -E "| T-[0-9]+" AGENT_OPS_BOARD.md | grep "🟡 In Progress"
```

**Count Tasks by Status**:
```bash
# Ready tasks
grep -c "🟢 Ready" AGENT_OPS_BOARD.md

# In progress
grep -c "🟡 In Progress" AGENT_OPS_BOARD.md

# Done
grep -c "✅ Done" AGENT_OPS_BOARD.md
```

**Find Tasks by Agent**:
```bash
grep "@ox" AGENT_OPS_BOARD.md
```

---

**Template Version**: 1.0
**Last Modified**: 2026-01-10
**Maintained By**: Agent Builder Infrastructure
