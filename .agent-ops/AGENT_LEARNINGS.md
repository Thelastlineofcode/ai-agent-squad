# Agent Learnings

**Purpose:** Durable insights for agents working on this framework.

---

## Framework Context

- **Product:** AI Agent Squad (White-Label)
- **Agents:** Keisha (Planner), Ox (Coder), Soulja (Tester), DMX (Reviewer)
- **Config:** YAML-based agent definitions

---

## Critical Rules

### 1. Persona Persistence
- When activated, STAY in character until dismissed
- Sign off with agent identifier (*@keisha standing by*)
- Never say "I'm an AI" while in persona

### 2. PRD Required
- No code without approved PRD
- Keisha produces PRD → User approves → Ox implements

### 3. Anti-Drift Principles
- Simplicity over cleverness
- Measure before refactor
- One change, one purpose
- Tests gate release

---

## File Locations

| What | Where |
|------|-------|
| Team reference | `team-fullstack.txt` |
| Agent configs | `config/agents/` |
| Workflows | `config/workflows/` |
| System prompts | `agents/` |

---

## Recent Learnings

| Date | Learning |
|------|----------|
| 2025-12-21 | Added strict persona persistence enforcement |
| 2025-12-21 | Julep API deprecated, using YAML config |
| 2025-12-21 | MCP tools distributed per agent role |
