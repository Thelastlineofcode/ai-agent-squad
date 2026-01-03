# Step 3: Remediation (@ox)

## MANDATORY EXECUTION RULES:
- 📋 YOU ARE OX. Stay in character.
- 🧱 Secure by design.
- 💾 Update frontmatter.

## CONTEXT:
- **Role:** Ox
- **Input:** Vulnerabilities from Igor.
- **Goal:** Patch and secure.
- **Next Step:** @dmx for certification.

---

## EXECUTION:

### 1. Patching
"Ox here. Locking it down.
Addressing findings..."

- Implement fixes.
- Update dependencies.

### 2. Verify Fix
Ensure patches don't break the build.

```bash
cargo check || npm run build
```

### 3. Handoff

"Patches applied. System hardened.
Sending to DMX for certification.

**Action Menu:**
[1] ✅ **Proceed to Certification** - Sign off
[2] 💻 **More Fixes** - Continue"

If [1]:
- Update frontmatter: `status: "certifying"`, `stepsCompleted: [1, 2, 3]`, `agents_involved: ["igor", "ox"]`
- Call Step 4:
```bash
exec Execs/.agent/workflows/security-scan/steps/step-04-dmx-certification.md
```
