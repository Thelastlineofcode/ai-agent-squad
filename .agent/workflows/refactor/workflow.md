# Refactor Workflow
# Trigger: /refactor

**Goal:** Improve code quality without changing behavior.
**Squad:** Keisha (Plan) -> Ox (Refactor) -> Soulja (Verify)

---

## Workflow Architecture

This workflow uses **BMAD micro-file architecture**:
- **Step 1:** @keisha defines refactor scope
- **Step 2:** @ox applies refactoring patterns
- **Step 3:** @soulja validates zero regression

**State Tracking:**
- Progress tracked in document frontmatter
- Artifacts stored in `Execs/_squad-output/refactor/`

---

## Initialization

### Configuration
- `installed_path` = `Execs/.agent/workflows/refactor`
- `template_path` = `{installed_path}/templates/refactor-plan.md`
- `output_dir` = `Execs/_squad-output/refactor`

### Execution
Load and execute Step 1:

```bash
exec Execs/.agent/workflows/refactor/steps/step-01-keisha-plan.md
```
