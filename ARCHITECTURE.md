# Agent Memory System Architecture

## System Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                        Execs Folder                              │
│                    (Project-Agnostic)                            │
│                                                                  │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │   Agents/    │  │  Scripts/    │  │ Templates/   │          │
│  │              │  │              │  │              │          │
│  │ keisha.yaml  │  │ init-        │  │ agent-memory │          │
│  │ ox.yaml      │  │ project-     │  │ ops-board    │          │
│  │ soulja.yaml  │  │ memory.sh    │  │ learnings    │          │
│  │ dmx.yaml     │  │              │  │ instructions │          │
│  │ igor.yaml    │  │              │  │ project-ctx  │          │
│  │ masterp.yaml │  │              │  │              │          │
│  │ suge.yaml    │  │              │  │              │          │
│  └──────────────┘  └──────────────┘  └──────────────┘          │
│                                                                  │
│  ┌────────────────────────────────────────────────────┐         │
│  │          team-fullstack.txt (Core Doctrine)        │         │
│  └────────────────────────────────────────────────────┘         │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ runs init script
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                       Project A                                  │
│                                                                  │
│  ┌────────────────────────────────────────────────────────┐     │
│  │              .agent-ops/                               │     │
│  │                                                         │     │
│  │  ┌─────────────────────────────────────────────┐       │     │
│  │  │ AGENT_OPS_BOARD.md     (Shared Task Board)  │       │     │
│  │  └─────────────────────────────────────────────┘       │     │
│  │  ┌─────────────────────────────────────────────┐       │     │
│  │  │ AGENT_LEARNINGS.md     (Shared Insights)    │       │     │
│  │  └─────────────────────────────────────────────┘       │     │
│  │                                                         │     │
│  │  _memory/                                               │     │
│  │  ├── keisha/                                            │     │
│  │  │   ├── memories.md      (Keisha's Project A history) │     │
│  │  │   └── instructions.md  (Keisha's Project A rules)   │     │
│  │  ├── ox/                                                │     │
│  │  │   ├── memories.md      (Ox's Project A history)     │     │
│  │  │   └── instructions.md  (Ox's Project A rules)       │     │
│  │  ├── soulja/                                            │     │
│  │  ├── dmx/                                               │     │
│  │  ├── igor/                                              │     │
│  │  ├── masterp/                                           │     │
│  │  └── suge/                                              │     │
│  └─────────────────────────────────────────────────────────┘     │
│                                                                  │
│  ┌────────────────────────────────────────────────────────┐     │
│  │ CONTRIBUTING.md  (Project A specific standards)     │     │
│  └────────────────────────────────────────────────────────┘     │
│                                                                  │
│  [Project A source code...]                                     │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                       Project B                                  │
│                                                                  │
│  ┌────────────────────────────────────────────────────────┐     │
│  │              .agent-ops/                               │     │
│  │                                                         │     │
│  │  ┌─────────────────────────────────────────────┐       │     │
│  │  │ AGENT_OPS_BOARD.md     (Different tasks!)   │       │     │
│  │  └─────────────────────────────────────────────┘       │     │
│  │  ┌─────────────────────────────────────────────┐       │     │
│  │  │ AGENT_LEARNINGS.md     (Different insights!)│       │     │
│  │  └─────────────────────────────────────────────┘       │     │
│  │                                                         │     │
│  │  _memory/                                               │     │
│  │  ├── keisha/                                            │     │
│  │  │   ├── memories.md      (Keisha's Project B history) │     │
│  │  │   └── instructions.md  (Keisha's Project B rules)   │     │
│  │  └── [other agents...]                                 │     │
│  └─────────────────────────────────────────────────────────┘     │
│                                                                  │
│  ┌────────────────────────────────────────────────────────┐     │
│  │ CONTRIBUTING.md  (Project B specific standards)     │     │
│  └────────────────────────────────────────────────────────┘     │
│                                                                  │
│  [Project B source code...]                                     │
└─────────────────────────────────────────────────────────────────┘
```

---

## Agent Session Flow

```
┌─────────────────────────────────────────────────────────────┐
│                    1. User Triggers Agent                    │
│                      "@keisha plan auth"                     │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│              2. Agent Loads Context (Automatic)              │
│                                                              │
│  ✓ Execs/team-fullstack.txt          (Core doctrine)        │
│  ✓ .agent-ops/_memory/keisha/        (Personal history)     │
│    └── memories.md                                           │
│    └── instructions.md                                       │
│  ✓ .agent-ops/AGENT_OPS_BOARD.md     (Current tasks)        │
│  ✓ .agent-ops/AGENT_LEARNINGS.md     (Project insights)     │
│  ✓ CONTRIBUTING.md                (Project standards)    │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                3. Agent Works on Task                        │
│                                                              │
│  • Updates AGENT_OPS_BOARD.md (task status)                 │
│  • Logs decisions to memories.md                            │
│  • Creates PRD/code/tests                                   │
│  • Follows CONTRIBUTING.md standards                     │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│              4. Agent Completes Session                      │
│                                                              │
│  • Appends session summary to memories.md                   │
│  • Updates AGENT_LEARNINGS.md (if new insights)             │
│  • Updates AGENT_OPS_BOARD.md (final status)                │
│  • Logs "For Next Session" notes                            │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│               5. Next Session Remembers All                  │
│                                                              │
│  Agent loads memories.md → sees previous decisions          │
└─────────────────────────────────────────────────────────────┘
```

---

## Memory File Structure

### Agent Personal Memory
```markdown
# keisha Memory Log
**Last Updated:** 2026-01-15 14:30

## Project Context Quick Reference
- **Project Name:** Auth Service
- **Tech Stack:** Rust/Axum, PostgreSQL
- **My Primary Role:** Planning & PRDs
- **Key Files I Work With:** docs/prd/

## Session History

### Session 2026-01-15 14:30
**What I Did:**
- Created PRD-001 for OAuth integration
- Analyzed existing auth middleware
- Broke down implementation into 5 tasks

**Key Decisions:**
- Using OAuth 2.0 (not SAML) for simplicity
- JWT tokens with 24h expiry
- Redis for token blacklist

**Files Modified:**
- docs/prd/PRD-001-oauth.md
- .agent-ops/AGENT_OPS_BOARD.md

**Patterns Noticed:**
- Project uses snake_case for all Rust files
- Tests go in tests/ not inline

**For Next Session:**
- Review Ox's implementation against PRD-001
- Consider adding refresh token flow

---

### Session 2026-01-14 10:15
[Previous session notes...]
```

---

## Shared Knowledge Files

### AGENT_OPS_BOARD.md
```markdown
| Task ID | Task | Assigned | Status | Files |
|---------|------|----------|--------|-------|
| T-001 | OAuth integration | @ox | 🟡 In Progress | src/auth/ |
| T-002 | Token validation | @keisha | 🟢 Ready | - |
```

### AGENT_LEARNINGS.md
```markdown
## Architectural Decisions
| Decision | Rationale | Date |
|----------|-----------|------|
| OAuth 2.0 over SAML | Simpler integration, better client support | 2026-01-15 |
| JWT tokens | Stateless auth, scales horizontally | 2026-01-15 |

## Common Pitfalls
| Pitfall | Solution |
|---------|----------|
| Token expiry edge cases | Always refresh 5min before expiry |
```

---

## Data Flow

```
User Request
     │
     ▼
┌─────────────────┐
│ Agent Triggered │
│   (@keisha)     │
└─────────────────┘
     │
     ├─────────────────────────────────────┐
     │                                     │
     ▼                                     ▼
┌──────────────┐                    ┌──────────────┐
│ Read Shared  │                    │ Read Personal│
│   Context    │                    │   Memory     │
├──────────────┤                    ├──────────────┤
│ • Ops Board  │                    │ • memories.md│
│ • Learnings  │                    │ • instruc.md │
│ • project-   │                    └──────────────┘
│   context.md │
└──────────────┘
     │
     └─────────────────────────────────────┘
                    │
                    ▼
            ┌───────────────┐
            │  Agent Works  │
            │   on Task     │
            └───────────────┘
                    │
                    ├─────────────────────┬──────────────────┐
                    ▼                     ▼                  ▼
            ┌──────────────┐      ┌─────────────┐   ┌──────────────┐
            │ Update Ops   │      │  Update     │   │ Create/Edit  │
            │    Board     │      │  Personal   │   │ Project Files│
            │              │      │   Memory    │   │              │
            └──────────────┘      └─────────────┘   └──────────────┘
                    │                     │                  │
                    └─────────────────────┴──────────────────┘
                                   │
                                   ▼
                           ┌───────────────┐
                           │  Session End  │
                           │ (State Saved) │
                           └───────────────┘
```

---

## Isolation Boundaries

### Project-Level Isolation
```
Each project has its own:
├── .agent-ops/AGENT_OPS_BOARD.md     (Different tasks)
├── .agent-ops/AGENT_LEARNINGS.md     (Different insights)
├── .agent-ops/_memory/keisha/        (Different history)
└── CONTRIBUTING.md                (Different standards)
```

### Agent-Level Isolation
```
Each agent has their own:
└── .agent-ops/_memory/[agent]/
    ├── memories.md         (Their personal notes)
    └── instructions.md     (Their custom rules)
```

### Shared Within Project
```
All agents share:
├── AGENT_OPS_BOARD.md      (Task coordination)
├── AGENT_LEARNINGS.md      (Collective knowledge)
└── CONTRIBUTING.md      (Standards compliance)
```

---

## Memory Lifecycle

```
Day 1: Fresh Project
├── User: bash init-project-memory.sh
├── System: Creates .agent-ops/ structure
└── Result: Empty memory files ready

Day 2: First Work Session
├── User: @keisha plan feature
├── Keisha: Loads empty memories → works → appends session
└── Result: memories.md has 1 session entry

Day 3: Continued Work
├── User: @ox implement feature
├── Ox: Loads empty memories → works → appends session
├── Ox: Reads Keisha's PRD from ops board
└── Result: ox/memories.md has 1 session, keisha/memories.md unchanged

Day 7: Deep Context
├── User: @keisha review progress
├── Keisha: Loads memories → sees all 5 past sessions
├── Keisha: References decisions from Day 2
└── Result: Seamless continuity across week
```

---

## Critical Design Principles

1. **Project Locality**
   - All memories live in `{project-root}/.agent-ops/`
   - Execs folder has ZERO project-specific data
   - Same agent squad works across infinite projects

2. **Automatic Loading**
   - Agents load context via `critical_actions` in YAML
   - No manual intervention required
   - Happens on every session start

3. **Isolation Guarantees**
   - Project A's memories never leak to Project B
   - Agent personal memories don't leak to other agents
   - Shared files (ops board, learnings) visible to all in same project

4. **Append-Only History**
   - Never delete session entries
   - Append new sessions to bottom
   - Full audit trail always available

5. **Human Readable**
   - All files are markdown
   - Can be read/edited by humans
   - Git-friendly (line-based diffs)

---

## Scalability

### Vertical (More Sessions)
- memories.md grows with sessions
- No performance impact (text files)
- Can archive old sessions manually if needed

### Horizontal (More Projects)
- Unlimited projects supported
- Each has isolated memory
- No cross-contamination

### Team (More Developers)
- Commit `.agent-ops/` to share context
- Or gitignore `_memory/` for privacy
- Ops board & learnings always shared

---

## Security Considerations

1. **Secrets in Memories**
   - Agents instructed to never log secrets
   - Review memories.md before committing
   - Add `.agent-ops/_memory/` to .gitignore if sensitive

2. **Access Control**
   - File system permissions apply
   - No special access controls needed
   - Standard git/OS security model

3. **Data Retention**
   - Memories persist indefinitely (append-only)
   - User controls retention policy
   - Can manually prune old sessions

---

**Architecture Version:** 1.0
**Last Updated:** 2026-01-15
