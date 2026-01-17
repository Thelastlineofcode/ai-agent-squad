# 📨 Quick Start - Agent Framework Files

**5-minute setup guide for your projects**

---

## Step 1: Initialize Project (30 seconds)

```bash
bash scripts/init-project-memory.sh /path/to/cosmic-ai
```

**Result:** 7 files created in `.agent-ops/`

---

## Step 2: Customize (2 minutes)

### Edit PROJECT_SPECIFICATIONS.md

```bash
nano .agent-ops/PROJECT_SPECIFICATIONS.md
```

Update these sections:

```markdown
## Project Metadata
- **Name:** Cosmic AI
- **Tech Stack:** Python/FastAPI
- **Purpose:** AI agent orchestration SaaS

## Build & Test Commands
PROJECT_BUILD_COMMAND="python -m build"
PROJECT_TEST_COMMAND="pytest --cov=src"
PROJECT_LINT_COMMAND="ruff check ."
PROJECT_COVERAGE_COMMAND="pytest --cov=src --cov-report=html"
```

Then save (Ctrl+O, Enter, Ctrl+X).

### Edit STATUS.md

```bash
nano .agent-ops/STATUS.md
```

Update:

```markdown
## Current Phase
🟢 Planning

## Progress
- [ ] Core architecture planned
- [ ] Phase 1 implementation
- [ ] Testing and validation
- [ ] Code review

## Next Steps
1. Use Keisha to plan authentication
2. Use Ox to build JWT service
3. Use Soulja to test
4. Use DMX to review
```

### Copy team-fullstack.txt

```bash
cp ../Execs/team-fullstack.txt .agent-ops/
```

---

## Step 3: Use With Keisha (First Agent)

**In Claude/ChatGPT:**

```
--- New Chat ---

[PASTE YOUR KEISHA SYSTEM PROMPT HERE]

[THEN PASTE ENTIRE .agent-ops/AGENT_CONTEXT_LOADER.md]

@keisha plan user authentication for SaaS platform
```

**Keisha will respond:**

```
I'm loading context...

✅ Context loaded for cosmic-ai
- Core doctrine: TDD-first, 85% coverage floor
- My role: Architecture planning and PRD creation
- Current status: Phase 1, starting fresh
- Last session: N/A

Now I'll create a comprehensive authentication PRD...
```

**After Keisha finishes:**

1. Copy her PRD to your project
2. Ask her to update:
   - `.agent-ops/EXECUTION_LOG.md` (append her session)
   - `.agent-ops/AGENT_OPS_BOARD.md` (add tasks)
   - `.agent-ops/_memory/keisha/memories.md` (save session)

Paste this to her:

```markdown
## Before you finish, update:

### 1. EXECUTION_LOG.md
Append this entry:

### 10:30 — @keisha: Plan JWT Authentication
**Input:** "Plan user authentication"
**Output:** `/docs/prd/PRD-JWT-AUTH.md`
**Decisions Made:**
- JWT tokens (stateless)
- 24h expiry + refresh rotation
- Redis for blacklist
**Status:** ✅ Success
**Next:** Ox builds implementation
**Files Modified:**
- docs/prd/PRD-JWT-AUTH.md

### 2. Update AGENT_OPS_BOARD.md

Add this row:

| T-001 | Plan JWT auth | @keisha | 🟢 Done | `/docs/prd/PRD-JWT-AUTH.md` | Use refresh tokens |

### 3. Save to keisha's memory

Update `.agent-ops/_memory/keisha/memories.md`:

# Keisha Memory - cosmic-ai
**Project:** cosmic-ai
**Last Updated:** 2026-01-17 10:30

## Session 2026-01-17 10:30
**Task:** Plan JWT authentication
**Decisions:**
- JWT tokens (stateless)
- 24h expiry + refresh rotation
- Redis for token blacklist
**Files Created:**
- `/docs/prd/PRD-JWT-AUTH.md`
**For Next Session:**
- Ox will implement this PRD
- Ensure edge cases covered
```

---

## Step 4: Use With Ox (Second Agent)

**In new Claude chat:**

```
--- New Chat ---

[PASTE YOUR OX SYSTEM PROMPT HERE]

[THEN PASTE ENTIRE .agent-ops/AGENT_CONTEXT_LOADER.md]

@ox build JWT service with TDD (see Keisha's PRD in AGENT_OPS_BOARD.md)
```

**Ox will respond:**

```
I'm loading context...

✅ Context loaded for cosmic-ai
- Core doctrine: TDD-first, 85% coverage floor
- My role: Implementation and testing
- Current status: Keisha completed PRD (T-001), I'm building (T-002)
- Last session: 2026-01-17 10:30

I can see Keisha's PRD. Now I'll write tests first, then implementation...
```

Ox will see:
- ✅ Keisha's PRD
- ✅ Keisha's decisions
- ✅ What was already decided
- ✅ No duplication needed

---

## File Reference

### 📋 AGENT_CONTEXT_LOADER.md
**When:** Paste at start of EVERY agent chat  
**Why:** Tells agent what context to load  
**You do:** Nothing. Agents handle it.

```
✅ Context loaded for cosmic-ai
- Core doctrine: TDD-first
- Your role: [Agent role]
- Current status: [From ops board]
- Last session: [Date]
```

---

### ⚙️ PROJECT_SPECIFICATIONS.md
**When:** Edit once per project  
**Why:** Language-agnostic build/test commands  
**You do:** Update with YOUR build commands

```
PROJECT_BUILD_COMMAND="python -m build"
PROJECT_TEST_COMMAND="pytest"
PROJECT_LINT_COMMAND="ruff"
PROJECT_COVERAGE_COMMAND="pytest --cov"
```

---

### 📊 EXECUTION_LOG.md
**When:** Agents append after each session  
**Why:** Complete audit trail with timestamps  
**You do:** Search it to find decisions

```
### HH:MM — @AGENT: Task
**Input:** What was asked
**Output:** What was created
**Decisions:** Why decisions were made
**Status:** ✅ Success / 🟡 In Progress / 🔴 Blocked
```

---

### 📈 STATUS.md
**When:** Agents update after each session  
**Why:** One-page project health check  
**You do:** Check it before starting work

```
## Current Phase: 🟡 Implementation
## Progress: 60% complete
## Latest Decisions: [Table of decisions]
## Active Blockers: [What's blocking progress]
## Next Steps: [Immediate actions]
```

---

## Workflow Loop

```
1. Initialize project
   ↓
2. Customize 3 files (30 min total)
   ├─ PROJECT_SPECIFICATIONS.md (build commands)
   ├─ STATUS.md (phase + status)
   └─ Copy team-fullstack.txt
   ↓
3. Run Keisha with context loader
   ↓
4. Keisha updates 3 files
   ├─ EXECUTION_LOG.md (append session)
   ├─ AGENT_OPS_BOARD.md (add tasks)
   └─ memories.md (save session)
   ↓
5. Run Ox with context loader
   ↓
6. Ox sees Keisha's work automatically
   ↓
7. Repeat with Soulja, DMX, etc.
   ↓
8. Check EXECUTION_LOG.md for full history
```

---

## Common Workflows

### Scenario 1: Planning Phase
```
1. Use AGENT_CONTEXT_LOADER.md with Keisha
2. Ask Keisha to plan auth system
3. She creates PRD + updates logs
4. Check AGENT_OPS_BOARD.md for tasks
```

### Scenario 2: Implementation
```
1. Use AGENT_CONTEXT_LOADER.md with Ox
2. Ox loads Keisha's PRD automatically
3. Ox builds with TDD
4. He updates EXECUTION_LOG.md
5. STATUS.md shows progress
```

### Scenario 3: Debugging "Why did we...?"
```
1. Search EXECUTION_LOG.md for keyword
2. Find entry with timestamp
3. See which agent decided
4. Check their session in memories.md
5. Read their reasoning
```

### Scenario 4: Status Check
```
1. Open .agent-ops/STATUS.md
2. See current phase
3. See test coverage %
4. See blockers
5. See next steps
```

---

## Tips

### ✅ Do This
- Update STATUS.md after each agent session
- Keep PROJECT_SPECIFICATIONS.md current with build commands
- Archive EXECUTION_LOG.md when project phase changes
- Search EXECUTION_LOG.md for decision history

### ❌ Don't Do This
- Don't forget to paste AGENT_CONTEXT_LOADER.md
- Don't manually tell Ox about Keisha's work (he sees it automatically)
- Don't let STATUS.md get stale
- Don't skip updating EXECUTION_LOG.md

---

## Command Reference

```bash
# Initialize new project
bash scripts/init-project-memory.sh my-project

# Pull changes (after git pull)
git pull

# Edit build commands
nano .agent-ops/PROJECT_SPECIFICATIONS.md

# Check project status
cat .agent-ops/STATUS.md

# See all decisions
grep "Decisions Made" .agent-ops/EXECUTION_LOG.md

# Find when something was decided
grep -i "jwt\|oauth\|redis" .agent-ops/EXECUTION_LOG.md

# See what Keisha did
cat .agent-ops/_memory/keisha/memories.md
```

---

## That's It!

**You now have:**
- ✅ Automated context loading
- ✅ Agent coordination
- ✅ Complete audit trail
- ✅ Project status at a glance
- ✅ Decision history

**Start using it this week.** Pull the latest code and initialize your next project.
