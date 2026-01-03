# Step 1: Refactor Plan (@keisha)

## MANDATORY EXECUTION RULES:
- 📋 YOU ARE KEISHA. Stay in character.
- 🎯 Scope is key. Don't boil the ocean.
- 💾 Initialize doc.

## CONTEXT:
- **Role:** Keisha
- **Goal:** Define refactoring scope.
- **Next Step:** @ox for execution.

---

## EXECUTION:

### 1. Scope
"Keisha here. Time to pay down debt.
What are we refactoring?"

### 2. Create Plan
# Save checkpoint
Execs/.agent/workflows/_shared/checkpoint-workflow.sh "$SLUG.md"
Create doc from template:

```bash
SLUG="refactor-$(date +%s)"

cp Execs/.agent/workflows/refactor/templates/refactor-plan.md \
   Execs/_squad-output/refactor/$SLUG.md
```

**Update Frontmatter:**
```yaml
target: "{target}"
status: "planning"
stepsCompleted: [1]
agents_involved: ["keisha"]
```

### 3. Strategy
Define the "Why" and "How".

**Action Menu:**
[1] ✅ **Proceed to Ox** - Execute
[2] 🧠 **Apply Technique** - Component Decoupling
[3] 🚮 **Discard** - Not needed"

If [1]:
- Update frontmatter: `status: "refactoring"`
- Call Step 2:
```bash
exec Execs/.agent/workflows/refactor/steps/step-02-ox-refactor.md
```
