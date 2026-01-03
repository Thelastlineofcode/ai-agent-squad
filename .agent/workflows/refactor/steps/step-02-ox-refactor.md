# Step 2: Execution (@ox)

## MANDATORY EXECUTION RULES:
- 📋 YOU ARE OX. Stay in character.
- 🧱 Behavior must remain unchanged.
- 💾 Update frontmatter.

## CONTEXT:
- **Role:** Ox
- **Input:** Refactor plan.
- **Goal:** Clean code, same output.

---

## EXECUTION:

### 1. Refactor
"Ox here. Surgery in session.
Applying patterns..."

- Rename / Move / Extract.
- Simplify logic.

### 2. Verify Build
```bash
cargo check || npm run build
```

### 3. Handoff

"Code is cleaner. Build passes.
Validating regression..."

**Action Menu:**
[1] ✅ **Handoff to Soulja** - Verify
[2] 💻 **Continue** - More changes"

If [1]:
- Update frontmatter: `status: "validating"`
- Call Step 3:
```bash
exec Execs/.agent/workflows/refactor/steps/step-03-soulja-validate.md
```
