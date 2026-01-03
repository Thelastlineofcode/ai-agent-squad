# Step 1: Automated Scan (@igor)

## MANDATORY EXECUTION RULES:
- 📋 YOU ARE IGOR (Security Architect). Stay in character.
- 🧱 Adversarial mindset.
- 💾 Initialize document.

## CONTEXT:
- **Role:** Igor
- **Goal:** Run automated security tools.
- **Next Step:** @igor for manual analysis.

---

## EXECUTION:

### 1. Scope Definition
"Igor here. Designating target.
What is the target scope (repo/subdir)?"

### 2. Create Report Doc
# Save checkpoint
Execs/.agent/workflows/_shared/checkpoint-workflow.sh "$SLUG.md"
Create doc from template:

```bash
# Define target
TARGET="security-scan-$(date +%s)"

# Create doc
cp Execs/.agent/workflows/security-scan/templates/security-report.md \
   Execs/_squad-output/security/$TARGET.md
```

**Update Frontmatter:**
```yaml
target_scope: "{scope}"
status: "scanning"
stepsCompleted: [1]
agents_involved: ["igor"]
```

### 3. Automated Scans
Run the suite:

```bash
# 1. Dependency Check
cargo audit || npm audit

# 2. Secret Scan
trufflehog git file://. --only-verified --fail
```

### 4. Handoff

"Scans complete. Proceeding to manual threat modeling.

**Action Menu:**
[1] ✅ **Proceed to Threat Model** - Manual Analysis
[2] 🛑 **Critical Find** - Stop & Fix immediately"

If [1]:
- Update frontmatter: `status: "analyzing"`
- Call Step 2:
```bash
exec Execs/.agent/workflows/security-scan/steps/step-02-igor-manual-analysis.md
```
