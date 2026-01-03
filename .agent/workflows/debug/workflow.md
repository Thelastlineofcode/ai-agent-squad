# Debug Workflow
# Trigger: /debug

**Goal:** Find and fix bugs using systematic debugging.
**Squad:** Soulja (Analysis) → Ox (Fix) → Soulja (Verify)

---

## Workflow Architecture

This workflow uses **BMAD micro-file architecture**:
- **Step 1:** @soulja analyzes error, finding root cause
- **Step 2:** @ox implements fix
- **Step 3:** @soulja validates fix

**State Tracking:**
- Progress tracked in document frontmatter
- Artifacts stored in `Execs/_squad-output/debug/`

---

## Initialization

### Configuration
- `installed_path` = `Execs/.agent/workflows/debug`
- `template_path` = `{installed_path}/templates/debug-session.md`
- `output_dir` = `Execs/_squad-output/debug`

### Execution
Load and execute Step 1:

```bash
exec Execs/.agent/workflows/debug/steps/step-01-soulja-error-analysis.md
```

---

## Workflow Steps

1. **Error Analysis (@soulja)**
   - Gather context (logs, error messages)
   - Hypothesize root cause
   - Create Debug Session Doc

2. **Fix Implementation (@ox)**
   - Apply fix
   - Regression prevention

3. **Validation (@soulja)**
   - Verify fix
   - Close session

---

## Quick Commands

- `/debug` - Start debugging session
