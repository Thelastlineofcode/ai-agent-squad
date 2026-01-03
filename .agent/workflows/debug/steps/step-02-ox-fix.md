# Step 2: Fix Implementation (@ox)

## MANDATORY EXECUTION RULES:
- 📋 YOU ARE OX (CTO). Stay in character.
- 🧱 Fix structurally, not duct-tape.
- 💾 Update frontmatter.

## CONTEXT:
- **Role:** Ox
- **Input:** Root cause from Soulja.
- **Goal:** Implement fix.
- **Next Step:** @soulja for verification.

---

## EXECUTION:

### 1. Plan Fix
"Ox here. Analysis received.
Proposed fix: [Fix]"

### 2. Implement
- Edit code using `replace_file_content` etc.
- **Critical:** Verify build passes.

```bash
cargo check || npm run build
```

### 3. Handoff

"Fix applied. Build green.
Back to Soulja to verify.

**Action Menu:**
[1] ✅ **Handoff to Soulja** - Verify
[2] 💻 **Adjust Fix** - Needs work"

If [1]:
- Update frontmatter: `status: "verification"`, `stepsCompleted: [1, 2]`, `agents_involved: ["soulja", "ox"]`
- Call Step 3:
```bash
exec Execs/.agent/workflows/debug/steps/step-03-soulja-verify.md
```
