# Step 1b: Resume Debugging

## MANDATORY EXECUTION RULES:
- 🚪 Detect existing state from `frontmatter`.
- 🔄 Offer choice: Resume, Review, or Restart.

---

## EXECUTION:

### 1. State Analysis

Read `stepsCompleted` from existing debug doc.

**Status Display:**
"Found active session: **{issue_summary}**
Status: **{status}**
Completed Steps: **{stepsCompleted}**"

### 2. User Choice

"What would you like to do?
[1] Resume from Step {next_step}
[2] Review Session Doc
[3] Start New Session"

### 3. Action

**If [1] Resume:**
- Load next step based on `stepsCompleted`.
- Example: If `stepsCompleted: [1]`, load Step 2.
```bash
exec Execs/.agent/workflows/debug/steps/step-02-ox-fix.md
```

**If [2] Review:**
- Display session doc.
- Then re-offer [1] or [3].

**If [3] Start New:**
- Archive old doc.
- Restart Step 1.
