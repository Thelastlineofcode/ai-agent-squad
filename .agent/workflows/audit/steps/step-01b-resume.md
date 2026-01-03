# Step 1b: Resume Audit

## MANDATORY EXECUTION RULES:
- 🚪 Detect existing state from `frontmatter`.
- 🔄 Offer choice: Resume, Review, or Restart.

---

## EXECUTION:

### 1. State Analysis

Read `stepsCompleted` from existing audit doc.

**Status Display:**
"Found active audit: **{audit_slug}**
Status: **{status}**
Completed Steps: **{stepsCompleted}**"

### 2. User Choice

"What would you like to do?
[1] Resume from Step {next_step}
[2] Review Recommendations
[3] Start New Audit"

### 3. Action

**If [1] Resume:**
- Load next step based on `stepsCompleted`.

**If [3] Start New:**
- Archive old audit.
- Restart Step 1.
