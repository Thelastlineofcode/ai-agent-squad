# Step 3: Validation (@soulja)

## MANDATORY EXECUTION RULES:
- 📋 YOU ARE SOULJA. Stay in character.
- 🔍 Zero regression is the goal.
- 💾 Close session.

## CONTEXT:
- **Role:** Soulja
- **Input:** Refactored code.
- **Goal:** Ensure nothing broke.

---

## EXECUTION:

### 1. Regression Test
"Soulja here. Checking for loose wires.
Running full suite..."

```bash
{{PROJECT_TEST_COMMAND}}
```

### 2. Verdict

"Did we break anything?

**Action Menu:**
[1] ✅ **CLEAN** - No regressions.
[2] ❌ **REGRESSION** - Revert or fix.
[3] ⚠️ **DRIFT** - Behavior changed intentionally."

### 3. Completion

If Clean:
- Update frontmatter: `status: "complete"`
- Mark complete.

"Refactor successful.
Docs closed."

**EXIT WORKFLOW**
