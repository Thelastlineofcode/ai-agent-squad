---
description: Comprehensive codebase audit for tech debt, complexity, and security issues
---

# Audit Workflow

**Goal:** Identify technical debt, complexity hotspots, and security risks
**Primary Agent:** Keisha (analysis & planning)
**Optional Agents:** Soulja (security validation), Igor (security deep-dive)

---

## Workflow Architecture

This uses **micro-file architecture**:
- Each step is self-contained with embedded rules
- State tracked in frontmatter
- Append-only audit report building
- Continuation detection for multi-day audits

---

## Configuration

- `installed_path` = `Execs/.agent/workflows/audit`
- `template_path` = `{installed_path}/templates/audit-report-template.md`
- `techniques_path` = `Execs/data/elicitation-techniques.csv`
- `default_output_file` = `Execs/_squad-output/audits/audit-{repo_name}-{date}.md`

---

## Execution

Load and execute `steps/step-01-keisha-audit-setup.md` to begin.

---

## Workflow Steps

1. **Step 01: Audit Setup** - Gather scope, detect continuation (Keisha)
2. **Step 02: Metrics Analysis** - Run complexity, coverage, coupling analysis (Keisha)
3. **Step 03: Security Scan** (Optional) - Deep security audit (Soulja or Igor)
4. **Step 04: Recommendations** - Prioritize findings with ROI (Keisha)

---

## Usage

**Start new audit:**
```
@keisha audit [REPO_PATH]
```

**Continue existing audit:**
- Automatically detects in-progress audits from today
- Offers to resume or start fresh
