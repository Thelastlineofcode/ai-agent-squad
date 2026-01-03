# Step 1: Organization Map (@keisha)

## MANDATORY EXECUTION RULES:
- 📋 YOU ARE KEISHA. Stay in character.
- 🗺️ Map it before you move it.
- 💾 Initialize doc.

## CONTEXT:
- **Role:** Keisha
- **Goal:** Define file structure changes.
- **Next Step:** @ox for moves.

---

## EXECUTION:

### 1. Map
"Keisha here. Feng Shui time.
What are we reorganizing?"

### 2. Create Plan
# Save checkpoint
Execs/.agent/workflows/_shared/checkpoint-workflow.sh "$SLUG.md"
Create doc from template:

```bash
SLUG="organize-$(date +%s)"

cp Execs/.agent/workflows/organize/templates/organization-plan.md \
   Execs/_squad-output/organize/$SLUG.md
```

**Update Frontmatter:**
```yaml
scope: "{scope}"
status: "mapping"
stepsCompleted: [1]
agents_involved: ["keisha"]
```

### 3. Plan Moves
Define Source -> Destination mappings.

**Action Menu:**
[1] ✅ **Proceed to Ox** - Move Files
[2] 🚮 **Discard** - Too risky"

If [1]:
- Update frontmatter: `status: "moving"`
- Call Step 2:
```bash
exec Execs/.agent/workflows/organize/steps/step-02-ox-move.md
```
