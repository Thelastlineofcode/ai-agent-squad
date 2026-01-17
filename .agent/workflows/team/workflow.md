# Team Workflow - TDD/BDD Recursive Automation
# Trigger: /team

**Goal:** Recursive TDD/BDD automation workflow (tests → code → verify → review)
**Squad:** Keisha? (Optional) → Soulja (Tests) → Ox (Code) → Soulja (Verify) → DMX (Review)

---

## Workflow Architecture

This workflow uses **TDD/BDD micro-file architecture with recursive automation**:
- **Step 0 (Optional):** @keisha analyzes requirements if no story exists
- **Step 1 (RED):** @soulja writes failing tests from acceptance criteria
- **Step 2 (GREEN):** @ox implements code to make tests pass
- **Step 3 (VERIFY):** @soulja runs full test suite, validates coverage >80%
- **Step 4 (REFACTOR):** @dmx reviews quality, may loop back to Ox

**State Tracking:**
- Progress tracked in document frontmatter
- Iteration count to prevent infinite loops (max 10)
- Task completion status for each phase

---

## Initialization

### Configuration
- `installed_path` = `Execs/.agent/workflows/team`
- `max_iterations` = `10`
- `min_coverage` = `80`
- `story_path` = user-provided or auto-detected

### Execution
Load and execute Step 0 (Story Check):

```bash
exec Execs/.agent/workflows/team/steps/step-00-story-check.md
```

---

## Workflow Loop

```
┌──────────────────────────────────────────────────────────────────────┐
│                     /team AUTOMATION LOOP (TDD/BDD)                  │
│                                                                      │
│  ┌─────────┐      ┌─────────┐      ┌────────┐      ┌─────────┐     │
│  │ Keisha? │─────>│ Soulja  │─────>│   Ox   │─────>│ Soulja  │──┐  │
│  │(Optional)│      │Write    │      │ (Code) │      │ Verify  │  │  │
│  │ Story   │      │ Tests   │      │        │      │ Tests   │  │  │
│  └────┬────┘      └────┬────┘      └────┬───┘      └────┬────┘  │  │
│       │                │                │               │       │  │
│       v                v                v               v       │  │
│  If no story     Write Failing    Make Tests Pass   Full Test  │  │
│  exists,          Tests (RED)       (GREEN)          Suite     │  │
│  create                                               Pass      │  │
│  breakdown                                                      │  │
│                                                                 │  │
│                                                                 v  │
│  ┌──────┐<────────────────────────────────────────────────────────┤
│  │ DMX  │  ✅ Approved → Exit                                     │
│  │(Gate)│  🔴 Rejected → Loop back to Ox                          │
│  └──────┘  ❌ Blocked → Report to user                            │
│             Max iterations: 10                                    │
└──────────────────────────────────────────────────────────────────────┘
```

---

## Workflow Steps

### Step 0: Story Check (Optional - Keisha)
- Check if story/PRD exists
- If exists → skip to Step 1
- If not → invoke @keisha to analyze requirements and create story breakdown

### Step 1: Write Tests - RED (Soulja)
- Load story acceptance criteria
- Write failing tests based on requirements
- Ensure tests fail for right reasons
- Document test coverage expectations

### Step 2: Implement Code - GREEN (Ox)
- Read failing tests
- Implement minimal code to make tests pass
- Follow project patterns and standards
- Loop until tests pass

### Step 3: Verify - TEST SUITE (Soulja)
- Run full test suite
- Validate coverage >80%
- Check for edge cases
- Report pass/fail status

### Step 4: Review - REFACTOR (DMX)
- Review code quality
- Check CORE DOCTRINE compliance
- Security scan
- **If approved:** Exit with ✅
- **If rejected:** Loop back to Ox with feedback
- **If blocked:** Report to user

---

## Exit Conditions

**Success Exit:**
- All tests passing ✅
- Coverage >80% ✅
- DMX approved ✅

**Loop Back:**
- DMX rejected code quality 🔴
- Tests failing after Ox implementation 🔴
- Increment iteration counter
- Max 10 iterations before manual intervention required

**Blocked Exit:**
- External dependency missing ❌
- Ambiguous requirements ❌
- User intervention needed ❌

---

## Usage Examples

### With Existing Story (Most Common)
```bash
/team implement docs/features/journey-ux/epic6/sprint5/story1.md
```

### Without Story (Keisha Creates First)
```bash
/team implement new feature: user profile settings with avatar upload
```

### Add Tests to Existing Code
```bash
/team add tests for src/components/client/journeys/journey-tabs.tsx
```

---

## Quick Commands

- `/team implement [story-path]` - Start TDD/BDD workflow with existing story
- `/team implement feature: [description]` - Start workflow, Keisha creates story first
- `/team add tests for [file-path]` - Add tests to existing code

---

## Agent Builder Integration

All agents load:
- **CORE DOCTRINE**: `Execs/team-fullstack.txt`
- **Agent Configs**: `Execs/agents/{agent}.yaml`
- **Shared Tools**: `Skills/agent-skills/core-dev-tools/scripts/`
- **Project Memory**: `.agent-ops/_memory/{agent}/memories.md`
- **Ops Board**: `.agent-ops/AGENT_OPS_BOARD.md`
