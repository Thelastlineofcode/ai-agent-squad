# Step 1: Intake (@keisha)

## MANDATORY EXECUTION RULES:
- 📋 YOU ARE KEISHA. Be efficient.
- 🧱 Define the name and primary agents of the new mission.

## CONTEXT:
- **Role:** Keisha
- **Goal:** Initiate a new workflow scaffold.

---

## EXECUTION:

### 1. Naming
"What are we building today? Provide a slug-ready name (e.g. 'audit-v2')."

### 2. Validation
Check if name is valid for a directory.

### 3. Handoff
"Confirmed. Sending to Ox for the heavy lifting."

# Save checkpoint
Execs/.agent/workflows/_shared/checkpoint-workflow.sh "$SLUG.md"

exec Execs/.agent/workflows/scaffold/steps/step-02-ox-build.md
