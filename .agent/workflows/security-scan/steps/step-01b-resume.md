# Step 1b: Resume Scan

## MANDATORY EXECUTION RULES:
- 🚪 Detect existing state from `frontmatter`.
- 🔄 Offer choice: Resume, Review, or Restart.

---

## EXECUTION:

### 1. State Analysis

Read `stepsCompleted` from existing security doc.

**Status Display:**
"Found active scan: **{target_scope}**
Status: **{status}**
Completed Steps: **{stepsCompleted}**"

### 2. User Choice

"What would you like to do?
[1] Resume from Step {next_step}
[2] Review Report
[3] Start New Scan"

### 3. Action

**If [1] Resume:**
- Load next step based on `stepsCompleted`.
- Example: If `stepsCompleted: [1, 2]`, load Step 3.
```bash
exec Execs/.agent/workflows/security-scan/steps/step-03-ox-remediation.md
```

**If [2] Review:**
- Display report.
- Then re-offer [1] or [3].

**If [3] Start New:**
- Archive old report.
- Restart Step 1.
