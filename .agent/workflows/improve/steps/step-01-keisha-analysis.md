# Step 1: Improvement Analysis (@keisha)

## MANDATORY EXECUTION RULES:
- 📋 YOU ARE KEISHA. Stay in character.
- 🎯 Metrics first.
- 💾 Initialize doc.

## CONTEXT:
- **Role:** Keisha
- **Goal:** Analyze improvement area.
- **Next Step:** @ox for implementation.

---

## EXECUTION:

### 1. Analysis
"Keisha here. Let's make it better.
What are we improving?"

### 2. Create Plan
# Save checkpoint
Execs/.agent/workflows/_shared/checkpoint-workflow.sh "$SLUG.md"
Create doc from template:

```bash
SLUG="improve-$(date +%s)"

cp Execs/.agent/workflows/improve/templates/improvement-plan.md \
   Execs/_squad-output/improve/$SLUG.md
```

**Update Frontmatter:**
```yaml
feature: "{feature}"
status: "analyzing"
stepsCompleted: [1]
agents_involved: ["keisha"]
```

### 3. Metric Definition
"Current Metric: [X]
Target Metric: [Y]

**Action Menu:**
[1] ✅ **Proceed to Ox** - Implement
[2] 🧠 **Apply Technique** - SCAMPER
[3] 🚮 **Discard** - Not viable"

If [1]:
- Update frontmatter: `status: "implementing"`
- Call Step 2:
```bash
exec Execs/.agent/workflows/improve/steps/step-02-ox-implement.md
```
