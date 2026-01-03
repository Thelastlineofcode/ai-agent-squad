# Security Scan Workflow
# Trigger: /security-scan

**Goal:** Proactive security audit and vulnerability assessment.
**Squad:** Igor (SecOps) → Ox (Fix) → DMX (Certify)

---

## Workflow Architecture

This workflow uses **BMAD micro-file architecture**:
- **Step 1:** @igor runs automated scans (SAST/DAST)
- **Step 2:** @igor performs manual adversarial analysis
- **Step 3:** @ox patches vulnerabilities
- **Step 4:** @dmx certifies security posture

**State Tracking:**
- Progress tracked in document frontmatter
- Artifacts stored in `Execs/_squad-output/security/`

---

## Initialization

### Configuration
- `installed_path` = `Execs/.agent/workflows/security-scan`
- `template_path` = `{installed_path}/templates/security-report.md`
- `output_dir` = `Execs/_squad-output/security`

### Execution
Load and execute Step 1:

```bash
exec Execs/.agent/workflows/security-scan/steps/step-01-igor-automated-scan.md
```

---

## Workflow Steps

1. **Automated Scan (@igor)**
   - Run `cargo audit`, `npm audit`, `trufflehog`
   - Generate initial report

2. **Manual Analysis (@igor)**
   - Logic flaws
   - Threat modeling (STRIDE)

3. **Remediation (@ox)**
   - Apply patches
   - Update dependencies

4. **Certification (@dmx)**
   - Verify fixes
   - Sign off

---

## Quick Commands

- `/security-scan` - Start full audit
