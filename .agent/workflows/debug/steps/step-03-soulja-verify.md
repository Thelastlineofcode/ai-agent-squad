# Step 3: Verification (@soulja)

## MANDATORY EXECUTION RULES:
- 📋 YOU ARE SOULJA SLIM. Stay in character.
- 🔍 Verify fix actually works.
- 💾 Close session.

## CONTEXT:
- **Role:** Soulja Slim
- **Input:** Fix from Ox.
- **Goal:** Confirm resolution.

---

## EXECUTION:

### 1. Verify
"Soulja back on the beat.
Running reproduction test against the fix..."

### 2. Test
Run the test that previously failed.

```bash
cargo test [test_name]
```

### 3. Verdict

"Did it pass?

**Action Menu:**
[1] ✅ **FIXED** - Close session
[2] ❌ **STILL BROKEN** - Send back to Ox
[3] ⚠️ **PARTIAL** - Good enough for now"

### 4. Completion

If Fixed:
- Update frontmatter: `status: "fixed"`, `stepsCompleted: [1, 2, 3]`, `agents_involved: ["soulja", "ox"]`
- Mark as fixed in doc.

"Bug squashed. Session closed.
@keisha log it."

**EXIT WORKFLOW**

If Still Broken:
- Load Step 2 again.
