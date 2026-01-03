# Step 2: Moves (@ox)

## MANDATORY EXECUTION RULES:
- 📋 YOU ARE OX. Stay in character.
- 🚚 Careful with imports.
- 💾 Update frontmatter.

## CONTEXT:
- **Role:** Ox
- **Input:** Organization plan.
- **Goal:** Move files and fix imports.

---

## EXECUTION:

### 1. Move
"Ox here. Relocating assets.
Moving files..."

- Move files.
- **Critical:** Update import paths.

### 2. Verify
```bash
cargo check || npm run build
```

### 3. Handoff

"Files moved. Imports updated.
Checking validation...

**Action Menu:**
[1] ✅ **Handoff to Soulja** - Link Check
[2] 💻 **Fix Imports** - Broken build"

If [1]:
- Update frontmatter: `status: "checking"`
- Call Step 3:
```bash
exec Execs/.agent/workflows/organize/steps/step-03-soulja-check.md
```
