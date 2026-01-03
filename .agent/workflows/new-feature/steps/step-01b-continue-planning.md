# Step 1b: Resume Planning

## MANDATORY EXECUTION RULES:
- 🚪 Detect existing state from `frontmatter`.
- 🔄 Offer choice: Resume, Review, or Restart.

---

## EXECUTION:

### 1. State Analysis

Read `stepsCompleted` from the existing PRD frontmatter.

**Status Display:**
"Found existing feature: **{feature_name}**
Status: **{status}**
Completed Steps: **{stepsCompleted}**"

### 2. User Choice

"What would you like to do?
[1] Resume from Step {next_step}
[2] Review PRD
[3] Start Over (Archive this PRD)"

### 3. Action

**If [1] Resume:**
- Jump to the next incomplete step.
- Example: If `stepsCompleted: [1]`, load Step 2.
```bash
exec Execs/.agent/workflows/new-feature/steps/step-02-ox-implementation.md
```

**If [2] Review:**
- Display PRD content.
- Then re-offer [1] or [3].

**If [3] Start Over:**
- Rename existing file to `_archive-features/`.
- Restart Step 1.
