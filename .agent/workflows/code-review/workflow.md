# Code Review Workflow
# Trigger: /code-review

**Goal:** Comprehensive code quality, security, and architectural review.
**Squad:** Keisha (Context) → Igor (Security) → DMX (Verdict)

---

## Workflow Architecture

This workflow uses **BMAD micro-file architecture**:
- **Step 1:** @keisha gathers context & diffs
- **Step 2:** @igor performs security & architecture scan
- **Step 3:** @dmx renders final verdict

**State Tracking:**
- Progress tracked in document frontmatter
- Artifacts stored in `Execs/_squad-output/reviews/`

---

## Initialization

### Configuration
- `installed_path` = `Execs/.agent/workflows/code-review`
- `template_path` = `{installed_path}/templates/review-template.md`
- `output_dir` = `Execs/_squad-output/reviews`

### Execution
Load and execute Step 1:

```bash
exec Execs/.agent/workflows/code-review/steps/step-01-keisha-context.md
```

---

## Workflow Steps

1. **Context (@keisha)**
   - Analyze git diffs
   - Identify touched files
   - Map dependencies

2. **Security Scan (@igor)**
   - Run security tools (cargo-audit, trufflehog)
   - Analyze logic gaps
   - Adversarial stress test

3. **Verdict (@dmx)**
   - Static analysis (clippy)
   - Doctrine compliance
   - Final Go/No-Go

---

## Quick Commands

- `/code-review` - Start review of current staged changes
