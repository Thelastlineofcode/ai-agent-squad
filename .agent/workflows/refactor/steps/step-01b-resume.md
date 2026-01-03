# Step 1b: Resume Refactor

## MANDATORY EXECUTION RULES:
- 🚪 Detect existing state from `frontmatter`.
- 🔄 Offer choice: Resume, Review, or Restart.

---

## EXECUTION:

### 1. State Analysis

Read `stepsCompleted` from existing refactor plan.

**Status Display:**
"Found active refactor: **{target}**
Status: **{status}**
Completed Steps: **{stepsCompleted}**"

### 2. User Choice

"What would you like to do?
[1] Resume from Step {next_step}
[2] Review Plan
[3] Start New Refactor"

### 3. Action

**If [1] Resume:**
- Load next step based on `stepsCompleted`.

**If [2] Review:**
- Display plan.

**If [3] Start New:**
- Archive old plan.
- Restart Step 1.
