# Step 1b: Resume Improvement

## MANDATORY EXECUTION RULES:
- 🚪 Detect existing state from `frontmatter`.
- 🔄 Offer choice: Resume, Review, or Restart.

---

## EXECUTION:

### 1. State Analysis

Read `stepsCompleted` from existing improvement plan.

**Status Display:**
"Found active improvement: **{feature}**
Status: **{status}**
Completed Steps: **{stepsCompleted}**"

### 2. User Choice

"What would you like to do?
[1] Resume from Step {next_step}
[2] Review Plan
[3] Start New Improvement"

### 3. Action

**If [1] Resume:**
- Load next step based on `stepsCompleted`.

**If [3] Start New:**
- Archive old plan.
- Restart Step 1.
