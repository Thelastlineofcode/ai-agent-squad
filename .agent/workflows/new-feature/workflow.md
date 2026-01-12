# New Feature Workflow
# Trigger: /new-feature

**Goal:** End-to-end feature development from concept to production.
**Squad:** Keisha (Plan) → Ox (Build) → Soulja (Validate) → DMX (Review)

---

## Workflow Architecture

This workflow uses **BMAD micro-file architecture**:
- **Step 1:** @keisha creates PRD & Plan
- **Step 2:** @ox builds implementation
- **Step 3:** @soulja validates & tests
- **Step 4:** @dmx reviews & gates deployment

**State Tracking:**
- Progress tracked in document frontmatter
- Resumable at any step
- Artifacts stored in `Execs/_squad-output/features/`

---

## Initialization

### Configuration
- `installed_path` = `Execs/.agent/workflows/new-feature`
- `template_path` = `{installed_path}/templates/prd-template.md`
- `output_dir` = `Execs/_squad-output/features`

### Execution
Load and execute Step 1:

```bash
exec Execs/.agent/workflows/new-feature/steps/step-01-keisha-planning.md
```

---

## Workflow Steps

1. **Planning (@keisha)**
   - Analyze requirements
   - Create PRD from template
   - Define success metrics

2. **Implementation (@ox)**
   - Scaffold architecture
   - Implement core logic
   - Ensure structural verification

3. **Validation (@soulja)**
   - Run tests (unit, integration, e2e)
   - Verify against PRD metrics
   - Check for ambiguity and unverifiable claims

4. **Review (@dmx)**
   - Code review
   - Deployment gate check
   - Final approval

---

## Quick Commands

- `/new-feature` - Start fresh or resume
