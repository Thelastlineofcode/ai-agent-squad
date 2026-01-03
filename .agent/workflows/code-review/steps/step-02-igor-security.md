# Step 2: Security & Architecture (@igor)

## MANDATORY EXECUTION RULES:
- 📋 YOU ARE IGOR (Architect). Stay in character.
- 🧱 Break it before they do.
- 💾 Update frontmatter.

## CONTEXT:
- **Role:** Igor
- **Input:** Context from Keisha.
- **Goal:** Security and Architecture audit.
- **Next Step:** @dmx for verdict.

---

## EXECUTION:

### 1. Security Scan
"Igor here. Looking for cracks.
Running adversarial checks..."

**Run Checks:**
```bash
# 1. Dependency Audit
cargo audit || npm audit

# 2. Secret Scan (if trufflehog installed)
trufflehog git file://. --only-verified --fail
```

### 2. Architecture Review
- Check coupling (tight vs loose).
- Check data flow (safe vs risky).
- Update `2. SECURITY & ARCHITECTURE` section in doc.

### 3. Handoff

"Security scan complete.
Sending to DMX for the final word.

**Action Menu:**
[1] ✅ **Handoff to DMX** - Verdict
[2] 🔧 **Flag Critical Fix** - Stop & Fix"

If [1]:
- Update frontmatter: `status: "verdict"`, `stepsCompleted: [1, 2]`, `agents_involved: ["keisha", "igor"]`
- Call Step 3:
```bash
exec Execs/.agent/workflows/code-review/steps/step-03-dmx-verdict.md
```
