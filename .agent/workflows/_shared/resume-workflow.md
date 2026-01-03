# Resume Workflow

## MANDATORY RULES:
- Scan `Execs/_squad-output/` for incomplete workflows.
- Parse frontmatter `status` field.
- Present menu of resumable workflows.
- Detect "Ambiguity" in state (multiple active files).

---

## EXECUTION:

### 1. Scan for Active Workflows
Searching for files with `status` not in `complete`, `fixed`, or `certified`.

```bash
# Find all potentially active workflows
grep -rE 'status: "(analyzing|planning|implementing|verifying|fixing|scanning|remediating|certifying|mapping|moving|checking)"' Execs/_squad-output --include="*.md"
```

### 2. Parse Results
For each file found:
- Extract `workflow` (e.g., new-feature)
- Extract `stepsCompleted` (e.g., [1, 2])
- Determine current `status`

### 3. Selection Menu

"You have the following in-progress missions:

{LIST_OF_FILES}

**Pick your mission:**
[1] Resume {File_1}
[2] Resume {File_2}
[E] Exit"

### 4. Handoff
Once selected:
- Identify `next_step` = `max(stepsCompleted) + 1`
- Load `Execs/.agent/workflows/{workflow}/steps/step-0{next_step}-*.md` (or Step 1b Resume if exists)

---
**GOAL**: Never leave a mission behind.
