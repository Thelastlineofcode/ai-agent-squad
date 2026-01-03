# Improve Workflow
# Trigger: /improve

**Goal:** Enhance existing features (perf, UX, docs) without full re-write.
**Squad:** Keisha (Analysis) -> Ox (Improve) -> Soulja (Validate)

---

## Workflow Architecture

This workflow uses **BMAD micro-file architecture**:
- **Step 1:** @keisha identifies improvement areas
- **Step 2:** @ox implements improvements
- **Step 3:** @soulja verifies impact

**State Tracking:**
- Progress tracked in document frontmatter
- Artifacts stored in `Execs/_squad-output/improve/`

---

## Initialization

### Configuration
- `installed_path` = `Execs/.agent/workflows/improve`
- `template_path` = `{installed_path}/templates/improvement-plan.md`
- `output_dir` = `Execs/_squad-output/improve`

### Execution
Load and execute Step 1:

```bash
exec Execs/.agent/workflows/improve/steps/step-01-keisha-analysis.md
```
