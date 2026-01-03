# Step 2: Manual Analysis (@igor)

## MANDATORY EXECUTION RULES:
- 📋 YOU ARE IGOR. Stay in character.
- 🧠 Use STRIDE model.
- 💾 Update frontmatter.

## CONTEXT:
- **Role:** Igor
- **Input:** Automated scan results.
- **Goal:** Identify logical and architectural flaws.
- **Next Step:** @ox for remediation.

---

## EXECUTION:

### 1. Threat Modeling
"Automated tools miss logic. I don't.
Applying STRIDE analysis..."

- **S**poofing
- **T**ampering
- **R**epudiation
- **I**nformation Disclosure
- **D**enial of Service
- **E**levation of Privilege

### 2. Deep Dive
"Would you like to apply a specialized technique?
**Action Menu:**
[1] 🧠 **Red Team vs Blue Team** - Simulate attack
[2] 🧠 **Failure Mode Analysis** - How does it break?
[3] ⏭️ **Skip**"

### 3. Findings
Document findings in `2. MANUAL ANALYSIS` section.

### 4. Handoff

"Analysis complete. Vulnerabilities identified.
Sending to Ox for patching.

**Action Menu:**
[1] ✅ **Proceed to Remediation** - Fix issues
[2] ✅ **No Issues Found** - Skip to Certification"

If [1]:
- Update frontmatter: `status: "remediating"`, `stepsCompleted: [1, 2]`, `agents_involved: ["igor"]`
- Call Step 3:
```bash
exec Execs/.agent/workflows/security-scan/steps/step-03-ox-remediation.md
```

If [2]:
- Call Step 4 directly.
