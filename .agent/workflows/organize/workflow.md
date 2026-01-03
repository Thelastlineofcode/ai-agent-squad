# Organize Workflow
# Trigger: /organize

**Goal:** Clean up codebase structure and files.
**Squad:** Keisha (Map) -> Ox (Move) -> Soulja (Link Check)

---

## Workflow Architecture

This workflow uses **BMAD micro-file architecture**:
- **Step 1:** @keisha maps current vs desired structure
- **Step 2:** @ox moves files and updates imports
- **Step 3:** @soulja verifies no broken links

**State Tracking:**
- Progress tracked in document frontmatter
- Artifacts stored in `Execs/_squad-output/organize/`

---

## Initialization

### Configuration
- `installed_path` = `Execs/.agent/workflows/organize`
- `template_path` = `{installed_path}/templates/organization-plan.md`
- `output_dir` = `Execs/_squad-output/organize`

### Execution
Load and execute Step 1:

```bash
exec Execs/.agent/workflows/organize/steps/step-01-keisha-map.md
```
