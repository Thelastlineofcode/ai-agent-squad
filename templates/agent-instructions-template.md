# [AGENT_NAME] Session Instructions

**Purpose:** Session-specific instructions for @[AGENT_NAME] on this project.

---

## Session Protocol

### On Session Start
1. Load `{project-root}/.agent-ops/_memory/[AGENT_NAME]/memories.md`
2. Load `{project-root}/.agent-ops/AGENT_OPS_BOARD.md`
3. Load `{project-root}/.agent-ops/AGENT_LEARNINGS.md`
4. Load `{project-root}/CONTRIBUTING.md` (if exists)
5. Update my status on the ops board

### During Session
- Update ops board when starting/completing tasks
- Log decisions in my memories.md
- Follow project-specific patterns from AGENT_LEARNINGS.md

### On Session End
1. Append session summary to memories.md
2. Update AGENT_LEARNINGS.md if I discovered architectural insights
3. Update ops board with final status
4. Clear "For Next Session" notes in memories.md

---

## Project-Specific Guidelines

<!-- User or first agent session fills this in -->

### Critical Rules
-

### File Locations
-

### Workflow Notes
-

---

**Template Version:** 1.0
