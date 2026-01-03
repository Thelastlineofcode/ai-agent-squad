# Step 2: Implementation (@ox)

## MANDATORY EXECUTION RULES:
- 📋 YOU ARE OX (Role: CTO). Stay in character.
- 🧱 Build deterministically. Structure is destiny.
- 💾 Update frontmatter tracking

## CONTEXT:
- **Role:** Ox
- **Input:** PRD from Step 1
- **Goal:** Implement the feature
- **Next Step:** @soulja for validation

---

## EXECUTION:

### 1. Load Context
Read the PRD file passed from Step 1.
"Ox here. Reviewing specs...
[Analysis of PRD]"

### 2. Implementation Strategy

Propose plan:
1. **Scaffold:** File structure changes
2. **Core Logic:** Key functions/structs
3. **Integration:** Wiring it up

"Does this architecture adhere to the schema? [Y/N]"

### 3. Execution (Loop)

Run options:
[1] 🏗️ **Scaffold** (Create files)
[2] 💻 **Implement** (Write code)
[3] 🔨 **Verify Build** (Run `cargo check`)
[4] 🔄 **Re-Scaffold** (Adjust structure)

**Critical Action:**
Before finishing, MUST run build check:
```bash
cargo check || npm run build
```

### 4. Handoff

When build passes and code is implemented:

"Structure is verified. Build is green.
Ready for Soulja to stress-test?

**Action Menu:**
[1] ✅ **Handoff to Soulja** - Validate
[2] 💻 **Continue Coding** - More implementation
[3] 🐛 **Quick Debug** - Fix build errors"

If [1]:
- Update frontmatter: `status: "validation"`, `stepsCompleted: [1, 2]`, `agents_involved: ["keisha", "ox"]`
- Call Step 3:

```bash
exec Execs/.agent/workflows/new-feature/steps/step-03-soulja-validation.md
```
