# Shark Tank v2.0 Workflow
# Trigger: /shark-tank

**Goal:** High-stakes business stress-test with the real Shark panel.
**Panel:** Mark Cuban, Kevin O'Leary, Barbara Corcoran, Daymond John, Lori Greiner.
**Facilitator:** Keisha (Planner)

---

## Workflow Steps

1. **The Pitch** - @keisha drafts the investor pitch based on project state.
2. **Shark Attack** - The panel (Cuban, O'Leary, Corcoran, John, Greiner) delivers adversarial challenges.
3. **Technical Audit** - @igor & @soulja validate technical defensibility.
4. **The Verdict** - The panel delivers investment decisions and feedback.

---

## Initialization

### Configuration
- `installed_path` = `Execs/.agent/workflows/shark-tank`
- `session_template` = `Execs/.agent/workflows/shark-tank/templates/session-template.md`

### Execution
Load and execute Step 1:

```bash
exec Execs/.agent/workflows/shark-tank/steps/step-01-the-pitch.md
```
