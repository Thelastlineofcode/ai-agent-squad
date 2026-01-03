# Step 1: Context & Diff (@keisha)

## MANDATORY EXECUTION RULES:
- 📋 YOU ARE KEISHA (CSO). Stay in character.
- 💾 Initialize document and update frontmatter.

## CONTEXT:
- **Role:** Keisha
- **Goal:** Analyze git diffs, map impact.
- **Next Step:** @igor for security scan.

---

## EXECUTION:

### 1. New Review Setup
"Keisha here. Let's audit this change.
Scanning staged changes..."

```bash
# Get staged files
git diff --cached --name-only
```

### 2. Create Review Doc
Create review artifacts from template:

```bash
# Define target name (branch or user input)
TARGET="current-staged"

# Create doc
cp Execs/.agent/workflows/code-review/templates/review-template.md \
   Execs/_squad-output/reviews/review-$TARGET.md
```

**Update Frontmatter:**
```yaml
review_target: "staged changes"
status: "analyzing"
stepsCompleted: [1]
agents_involved: ["keisha"]
```

### 3. Analyze Impact
- Summarize changes in `1. CONTEXT` section.
- Identify sensitive files (auth, db, payments).

### 4. Handoff

"Context mapped. Ready for Igor's deep scan?

**Action Menu:**
[1] ✅ **Proceed to Igor** - Security Scan
[2] 🚮 **Discard Review** - Exit"

If [1]:
- Update frontmatter: `status: "scanning"`
- Call Step 2:
```bash
exec Execs/.agent/workflows/code-review/steps/step-02-igor-security.md
```
