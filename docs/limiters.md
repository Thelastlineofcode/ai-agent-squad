# Tech Debt & Bloat Limiters
## Non-negotiable controls to prevent drift

These limiters are enforced by process and guardrails. If a limiter fails, DMX blocks release.

---

## Required PRD Fields

Every PRD must include:
- **Tech Debt Budget**: what debt is allowed (if any) and why
- **Bloat Budget**: limits for dependencies/LOC/complexity creep

Format (minimum):
- Tech Debt Budget: <none | limited + reason>
- Bloat Budget: <no new deps | 1 new dep | max LOC delta>

---

## Limiters (Hard Gates)

1. **No new dependencies without ROI** (Keisha + DMX)
2. **Complexity limits** (avg < 12, max < 15)
3. **Coverage limits** (> 85%, critical > 95%)
4. **No mocks** (dev env only)
5. **User story coverage** (each story must map to a test)
6. **Naming canon** (Feature/Codename/Owner required)
7. **Audit compliance** (all required audit reports PASS)

---

## Documentation Hygiene (Mandatory)

If an agent uses a document as a source:
- Update that document if new information changes it.
- Delete stale or off-scope content.
- If information is valuable but not docs-worthy, write it to learnings.

Learnings locations:
- Project learnings: `Execs/docs/learnings/`
- Ops learnings (if used): `.agent-ops/AGENT_LEARNINGS.md`

---

## Ops Board Rule (Parallel Work)

Agents must update the ops board before handoff:
- Start → Working
- Preflight → PASS/BLOCKED
- Handoff → Pending
- Done → Completed

Failing to update ops board is a block.
