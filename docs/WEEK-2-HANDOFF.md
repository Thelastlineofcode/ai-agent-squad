# Week 2 Completion - Agent Handoff Document

**Status:** Week 2 Days 1-5 Complete (Foundation)
**Date:** 2026-01-03
**Remaining Work:** Complete step files for 5 workflows

---

## ✅ What's Been Completed

### Core Infrastructure
- ✅ **Elicitation Techniques Library** - `Execs/data/elicitation-techniques.csv` (20 techniques)
- ✅ **Menu-Driven Navigation** - Pattern established in /new-feature and /code-review
- ✅ **Micro-File Architecture** - Pattern established, all workflows have foundation

### Fully Complete Workflows (Reference These!)

1. **[/new-feature](../.agent/workflows/new-feature/)** - 5 steps, fully functional
   - Step 01: Keisha planning with technique selection
   - Step 01b: Continuation detection
   - Step 02: Ox implementation
   - Step 03: Soulja validation
   - Step 04: DMX review
   - Template: PRD template with frontmatter

2. **[/code-review](../.agent/workflows/code-review/)** - 3 steps, fully functional
   - Step 01: Keisha context loading
   - Step 02: Igor security analysis
   - Step 03: DMX final verdict
   - Template: Review report template

3. **[/audit](../.agent/workflows/audit/)** - 4 steps, fully functional
   - Step 01: Keisha audit setup
   - Step 02: Keisha metrics analysis
   - Step 03: Security scan (optional)
   - Step 04: Keisha recommendations
   - Template: Audit report template

---

## ⏳ What Needs Completion

### Workflows Needing Step Files

5 workflows have `workflow.md` foundation but need detailed step files:

1. **[/debug](../.agent/workflows/debug/)**
2. **[/improve](../.agent/workflows/improve/)**
3. **[/organize](../.agent/workflows/organize/)**
4. **[/refactor](../.agent/workflows/refactor/)**
5. **[/security-scan](../.agent/workflows/security-scan/)**

---

## 📋 Task Breakdown by Workflow

### 1. /debug Workflow

**Goal:** Debug issues with root cause analysis

**Agent Assignment:** @soulja (primary), @ox (fixes)

**Steps Needed:**
- ✅ `step-01-soulja-error-analysis.md` (EXISTS - review and enhance)
- ⏳ `step-02-ox-fix-implementation.md` (CREATE)
- ⏳ `step-03-soulja-validation.md` (CREATE)

**Template Needed:**
- ⏳ `templates/debug-report-template.md`

**Pattern to Follow:** Similar to /new-feature but shorter (3 steps)

**Key Requirements:**
- Use "Rubber Duck Debugging" or "Root Cause Analysis" technique from CSV
- Include error trace, root cause, recommended fix, regression test
- Frontmatter: `error_message`, `root_cause_identified`, `fix_implemented`, `validated`

---

### 2. /improve Workflow

**Goal:** Improve code quality without adding features

**Agent Assignment:** @keisha (planning), @ox (execution), @soulja (validation), @dmx (review)

**Steps Needed:**
- ⏳ `step-01-keisha-identify-targets.md` (CREATE)
- ⏳ `step-02-keisha-plan-improvements.md` (CREATE)
- ⏳ `step-03-ox-execute-refinement.md` (CREATE)
- ⏳ `step-04-validation-and-review.md` (CREATE - Soulja + DMX combined)

**Template Needed:**
- ⏳ `templates/improvement-plan-template.md`

**Pattern to Follow:** Similar to /audit (4 steps)

**Key Requirements:**
- Focus on: DX, stability, performance, security (NO new features)
- Must show before/after metrics (complexity, lines of code, etc.)
- Use "Pre-Mortem Analysis" or "Constraint Mapping" technique
- Frontmatter: `target_area`, `baseline_metrics`, `improvement_metrics`, `validation_passed`

---

### 3. /organize Workflow

**Goal:** Reorganize codebase structure

**Agent Assignment:** @keisha (planning), @ox (execution), @soulja (validation)

**Steps Needed:**
- ⏳ `step-01-keisha-audit-structure.md` (CREATE)
- ⏳ `step-02-keisha-reorganization-plan.md` (CREATE)
- ⏳ `step-03-human-approval-gate.md` (CREATE - requires explicit approval)
- ⏳ `step-04-ox-execute-changes.md` (CREATE)
- ⏳ `step-05-soulja-validate.md` (CREATE)

**Template Needed:**
- ⏳ `templates/reorganization-plan-template.md`

**Pattern to Follow:** Similar to /audit but with approval gate (5 steps)

**Key Requirements:**
- **CRITICAL:** Step-03 must get human approval before any file moves
- Document: files to move, files to delete, files to create
- Track: directory changes, import updates, broken references
- Frontmatter: `plan_approved`, `files_moved`, `imports_updated`, `tests_passed`

---

### 4. /refactor Workflow

**Goal:** Refactor code to reduce complexity

**Agent Assignment:** @ox (primary), @soulja (validation)

**Steps Needed:**
- ⏳ `step-01-ox-identify-target.md` (CREATE)
- ⏳ `step-02-ox-plan-refactor.md` (CREATE)
- ⏳ `step-03-ox-execute-refactor.md` (CREATE)
- ⏳ `step-04-soulja-validate.md` (CREATE)

**Template Needed:**
- ⏳ `templates/refactor-plan-template.md`

**Pattern to Follow:** Similar to /code-review (4 steps)

**Key Requirements:**
- Ensure tests exist BEFORE refactoring
- Measure complexity before/after
- Use "Component Decoupling" or "Data Flow Diagramming" technique
- Incremental changes with test runs after each change
- Frontmatter: `complexity_before`, `complexity_after`, `tests_passed`, `behavior_unchanged`

---

### 5. /security-scan Workflow

**Goal:** Deep security audit and penetration testing

**Agent Assignment:** @igor (primary), @soulja (automated scans)

**Steps Needed:**
- ⏳ `step-01-igor-threat-modeling.md` (CREATE)
- ⏳ `step-02-automated-scans.md` (CREATE - Igor/Soulja)
- ⏳ `step-03-igor-manual-review.md` (CREATE)
- ⏳ `step-04-remediation-plan.md` (CREATE - Igor + Ox)

**Template Needed:**
- ⏳ `templates/security-scan-report-template.md`

**Pattern to Follow:** Similar to /audit step-03 (security scan) but expanded (4 steps)

**Key Requirements:**
- Apply "Threat Modeling (STRIDE)" technique from CSV
- Run: trufflehog, cargo audit, safety check (based on tech stack)
- Document: Spoofing, Tampering, Repudiation, Info Disclosure, DoS, Elevation risks
- Prioritize findings: Critical/High/Medium/Low
- Frontmatter: `threats_identified`, `vulnerabilities_found`, `secrets_detected`, `remediation_plan_ready`

---

## 🎨 Step File Template (Copy This Structure)

Use this as a starting point for each step file:

```markdown
# Step [N]: [Step Name]

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER [anti-pattern for this step]
- ✅ ALWAYS [required behavior]
- 📋 YOU ARE A [role], not a [what to avoid]
- 💬 FOCUS on [this step's purpose] only

## EXECUTION PROTOCOLS:

- 🎯 Show analysis before action
- 💾 Update frontmatter before loading next step
- 📖 Set `stepsCompleted: [1, 2, ...]`
- 🚫 FORBIDDEN to load next step until current complete

---

## YOUR TASK:

[One sentence: what this step accomplishes]

---

## EXECUTION SEQUENCE:

### A. Load Context from Frontmatter

Read from document:
- `{key_1}` - [what it contains]
- `{key_2}` - [what it contains]
- `stepsCompleted: [...]` - [confirms previous steps done]

### B. [Main Action]

[Instructions for primary work of this step]

### C. Offer Technique (Optional)

Load techniques from `Execs/data/elicitation-techniques.csv`:

[1] **[Technique 1]** - [When to use]
[2] **[Technique 2]** - [When to use]
[3] **Skip technique** - [Continue without]

### D. Document Results

Append to workflow document:

\`\`\`markdown
## [Section Name]

[Template for what this step adds to document]
\`\`\`

Update frontmatter:
\`\`\`yaml
{step_specific_field}: true
stepsCompleted: [1, 2, ..., N]
\`\`\`

### E. Present Next Step

"[Summary of what was accomplished]

**Next Step:** [What happens next]

[C] Continue to [Next Step Name]
[E] Exit (save progress)

Your choice:"

---

## STEP COMPLETION:

When user chooses [C]:

**Update frontmatter:**
\`\`\`yaml
stepsCompleted: [1, 2, ..., N]
\`\`\`

**Load next step:**
"Loading Step [N+1]: [Next Step Name]..."

\`\`\`
exec ./step-[N+1]-[agent]-[purpose].md
\`\`\`

---

## CONTEXT HANDOFF TO STEP [N+1]:

Step [N+1] will read:
- `{key}` - [what it needs]
- `stepsCompleted: [1, ..., N]` - [confirms this step done]
- Document contains: [what this step added]
```

---

## 📄 Template File Template (Copy This Structure)

Use this for `templates/[workflow]-template.md`:

```yaml
---
workflow: "[workflow-name]"
stepsCompleted: []
[workflow_specific_field_1]: ""
[workflow_specific_field_2]: false
status: "not-started"
started: ""
completed: ""
---

# [Workflow Name]: {identifier}

**Agent:** {agent_name}
**Date:** {date}
**Status:** {status}

---

## [Section 1 - Setup Info]

[Step 1 fills this]

---

## [Section 2 - Main Work]

[Step 2-3 fills this]

---

## [Section 3 - Results]

[Final step fills this]

---

## Action Plan

[Final checklist or next steps]
```

---

## ✅ Definition of Done (Each Workflow)

A workflow is complete when:

- [ ] All step files created (step-01 through step-0N)
- [ ] Template file created in `templates/`
- [ ] Continuation detection added (step-01b-continue.md if needed)
- [ ] Frontmatter tracks all workflow state
- [ ] At least 1 elicitation technique offered in planning step
- [ ] Menu-driven navigation in all steps ([C] Continue, [E] Exit)
- [ ] Clear "MANDATORY EXECUTION RULES" in every step
- [ ] Context handoff documented at end of each step
- [ ] Tested end-to-end (manually run through workflow)

---

## 🎯 Agent Assignment Recommendations

**@keisha** - Planning workflows:
- Complete: /improve step-01 and step-02
- Complete: /organize step-01 and step-02

**@ox** - Execution workflows:
- Complete: /debug step-02
- Complete: /refactor all steps (step-01 through step-04)
- Complete: /improve step-03

**@soulja** - Validation workflows:
- Complete: /debug step-01 and step-03
- Complete: /refactor step-04
- Complete: /organize step-05

**@igor** - Security workflows:
- Complete: /security-scan all steps (step-01 through step-04)

**@dmx** - Review workflows:
- Complete: /improve step-04 (combined with Soulja)

---

## 📚 Reference Files

**Working Examples:**
- `/new-feature/steps/step-01-keisha-planning.md` - Great example of technique integration
- `/code-review/steps/step-02-igor-security.md` - Security analysis pattern
- `/audit/steps/step-04-keisha-recommendations.md` - Prioritization with ROI

**Data Files:**
- `Execs/data/elicitation-techniques.csv` - All 20 techniques
- Filter by `agent` column to see techniques per agent

**Documentation:**
- `Execs/docs/bmad-patterns.md` - Full BMAD pattern reference
- `Execs/docs/integration-checklist.md` - Week-by-week plan

---

## 📊 Progress Tracking

Create a checklist as you complete workflows:

```markdown
## Workflow Completion Status

- [x] /new-feature (5 steps) - COMPLETE
- [x] /code-review (3 steps) - COMPLETE
- [x] /audit (4 steps) - COMPLETE
- [ ] /debug (3 steps)
  - [x] Step 01
  - [ ] Step 02
  - [ ] Step 03
  - [ ] Template
- [ ] /improve (4 steps)
  - [ ] Step 01
  - [ ] Step 02
  - [ ] Step 03
  - [ ] Step 04
  - [ ] Template
- [ ] /organize (5 steps)
  - [ ] Step 01
  - [ ] Step 02
  - [ ] Step 03 (approval gate)
  - [ ] Step 04
  - [ ] Step 05
  - [ ] Template
- [ ] /refactor (4 steps)
  - [ ] Step 01
  - [ ] Step 02
  - [ ] Step 03
  - [ ] Step 04
  - [ ] Template
- [ ] /security-scan (4 steps)
  - [ ] Step 01
  - [ ] Step 02
  - [ ] Step 03
  - [ ] Step 04
  - [ ] Template
```

---

## 🚀 Ready to Start?

1. **Pick a workflow** from the 5 incomplete ones
2. **Read the workflow.md** to understand the goal
3. **Copy the step file template** above
4. **Review a complete workflow** (/new-feature or /audit) for reference
5. **Create step files** following the pattern
6. **Test the workflow** by running it manually
7. **Mark as complete** and move to next workflow

---

## ❓ Questions?

If you encounter issues:
- Reference the complete workflows (/new-feature, /code-review, /audit)
- Check `bmad-patterns.md` for architecture patterns
- Ensure frontmatter updates before loading next step
- Test continuation detection with step-01b files

---

**Week 2 Status:** Foundation Complete ✅
**Remaining Work:** ~5-8 hours (1-2 hours per workflow)
**Target Completion:** End of Week 2 or early Week 3

Good luck, squad! 🎯
