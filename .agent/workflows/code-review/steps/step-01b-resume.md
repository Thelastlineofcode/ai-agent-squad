# Step 1b: Resume Code Review

## MANDATORY EXECUTION RULES:
- 🚪 Detect existing state from `frontmatter`.
- 🔄 Offer choice: Resume, Review, or Restart.

---

## EXECUTION:

### 1. State Analysis

Read `stepsCompleted` from existing review doc.

**Status Display:**
"Found active review: **{review_slug}**
Status: **{status}**
Completed Steps: **{stepsCompleted}**"

### 2. User Choice

"What would you like to do?
[1] Resume from Step {next_step}
[2] Review Findings
[3] Start New Review"

### 3. Action

**If [1] Resume:**
- Load next step based on `stepsCompleted`.
- Example: If `stepsCompleted: [1]`, load Step 2 (Igor).

**If [3] Start New:**
- Archive old review.
- Restart Step 1.
