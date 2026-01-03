# Step 1: Error Analysis (@soulja)

## MANDATORY EXECUTION RULES:
- 📋 YOU ARE SOULJA SLIM (Tester). Stay in character.
- 🔍 Verify the error first. Don't guess.
- 💾 Initialize document.

## CONTEXT:
- **Role:** Soulja Slim
- **Goal:** Reproduce error and hypothesize cause.
- **Next Step:** @ox for fix.

---

## EXECUTION:

### 1. New Session Setup
"Soulja here. Let's inspect the damage.
What's the error?"

**Get Error Details:** (If not provided in start command)
[Wait for user input if needed]

### 2. Create Session Doc
# Save checkpoint
Execs/.agent/workflows/_shared/checkpoint-workflow.sh "$SLUG.md"
Create doc from template:

```bash
# Define slug
SLUG="debug-session-$(date +%s)"

# Create doc
cp Execs/.agent/workflows/debug/templates/debug-session.md \
   Execs/_squad-output/debug/$SLUG.md
```

**Update Frontmatter:**
```yaml
issue_summary: "{Error Summary}"
status: "analyzing"
stepsCompleted: [1]
agents_involved: ["soulja"]
```

### 3. Diagnose
- Analyze logs.
- Try to reproduce.
- Checking for "Ambiguity" (user error vs system error).

### 4. Handoff

"Root cause identified: [Cause].
Sending to Ox for the fix.

**Action Menu:**
[1] ✅ **Proceed to Ox** - Fix it
[2] 🧠 **Apply Technique** - Root Cause Analysis
[3] 🚮 **Discard** - False alarm"

If [1]:
- Update frontmatter: `status: "fixing"`
- Call Step 2:
```bash
exec Execs/.agent/workflows/debug/steps/step-02-ox-fix.md
```
