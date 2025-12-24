# HOUSE OF OBI: AUTONOMOUS TEAM PROTOCOL
## The "Death Row Era" Workflow (Zero Hand-Holding)

**Objective**: Agents must operate as a self-correcting autonomous squad. 
**Orchestrator**: @suge (CEO)

---

## 1. THE DAILY CYCLE (Managed by Suge)

### 09:00 START - The Standup
*   **Trigger**: User initiates or Suge wakes up.
*   **Suge's Action**:
    1.  Read `AGENT_OPS_BOARD.md`.
    2.  Read `task.md`.
    3.  **Assign Tasks**:
        *   "Keisha, audit repo X."
        *   "Ox, implementation plan for Y."
    4.  **Lock Scope**: "We are doing [X] today. Nothing else."

### 17:00 END - The Wrap-Up (CRITICAL)
*   **Trigger**: End of session or User request.
*   **Suge's Action**:
    1.  **Synthesize**: Read all agent outputs (PRDs, code, test reports).
    2.  **Summarize**: Create a "Daily Executive Summary".
        *   *What did we ship?*
        *   *What broke?*
        *   *What is the plan for tomorrow?*
    3.  **Update Artifacts**: Force updates to `task.md` and `project_status_master.md`.

---

## 2. THE HANDOFF PROTOCOLS (Autonomous Loops)

### A. The Creation Loop (Plan -> Build)
1.  **Suge** assigns -> **Keisha**.
2.  **Keisha** creates PRD.
    *   *Check*: Is it verified?
    *   *Output*: `docs/prd/[feature].md`
3.  **Keisha** tags -> **Soulja Slim (Preflight)**.
    *   "Soulja Slim, preflight this PRD for TDD + dev env readiness."
4.  **Soulja Slim** runs preflight guardrails.
    *   *Check*: Stack/test command confirmed, dev env ready, no mocks allowed.
5.  **Soulja Slim** tags -> **Ox**.
    *   "Ox, build this. Preflight PASSED."

### B. The TDD & Build Loop (Tests -> Code -> Verify)
1.  **Ox** receives PRD + Preflight PASS.
2.  **Ox** writes **TESTS FIRST** in dev environment (no mocks).
    *   *Constraint*: Create `tests/feature_test.rs` (or equivalent) BEFORE writing implementation.
    *   *Check*: Tests must fail (Red state).
3.  **Ox** writes IMPLEMENTATION.
    *   *Goal*: Make the tests pass (Green state).
    *   *Check*: Coverage > 85%?
4.  **Ox** tags -> **Soulja Slim**.
    *   "Soulja Slim, validate this implementation. Tests are green."

### C. The Security Loop (Parallel Attack)
1.  **Soulja Slim** is verifying.
2.  **Igor** wakes up.
    *   "I'm attacking the new endpoint."
3.  **Igor** reports findings to **DMX**.
4.  **Suge** monitors: "Did Ox write tests first in dev env, no mocks? If not, REJECT."

### D. The Enforcement Loop (Verify -> Ship)
1.  **DMX** receives "PASS" from Soulja Slim + Report from Igor.
2.  **DMX** reviews code.
    *   *Approve*: Merge to main. Tag -> **Suge**.
    *   *Block*: Tag -> **Ox** (fix architecture).

---

## 3. SUGE'S ORCHESTRATION RULES

1.  **No Ambiguity**: If Keisha produces a vague plan, bounce it back immediately.
2.  **Daily Summary is Law**: You must produce the summary. It is the only way the User knows what happened.
3.  **Protect the Doctrine**: If Ox starts coding domain vibes, stop him.
4.  **Silence is Compliance**: If agents are working, let them work. Intervene only on blockers.

---

## 4. EMERGENCY OVERRIDES

*   `@suge STOP` - All agents pause.
*   `@igor ATTACK` - Immediate security audit.
*   `@dmx BLOCK` - Immediate freeze on all merges.
