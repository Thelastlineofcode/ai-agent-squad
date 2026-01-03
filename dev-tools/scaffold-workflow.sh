#!/bin/bash
# scaffold-workflow.sh
# Scaffolds a new BMAD-compliant workflow.

NAME="$1"
if [ -z "$NAME" ]; then
    echo "Usage: $0 <workflow-name>"
    exit 1
fi

BASE_DIR="Execs/.agent/workflows/$NAME"

if [ -d "$BASE_DIR" ]; then
    echo "❌ Workflow $NAME already exists."
    exit 1
fi

echo "🏗️  Scaffolding workflow: $NAME"

mkdir -p "$BASE_DIR/steps" "$BASE_DIR/templates"

# 1. workflow.md
cat <<EOF > "$BASE_DIR/workflow.md"
# $NAME Workflow
# Trigger: /$NAME

**Goal:** [Set Objective]
**Squad:** Keisha → Ox → Soulja → DMX

---

## Workflow Architecture
[Describe steps]

---

## Initialization
exec $BASE_DIR/steps/step-01-keisha-planning.md
EOF

# 2. templates/session.md
cat <<EOF > "$BASE_DIR/templates/session-template.md"
---
workflow: "$NAME"
status: "planning"
stepsCompleted: []
agents_involved: []
---

# $NAME Session: {SLUG}
EOF

# 3. steps/step-01
cat <<EOF > "$BASE_DIR/steps/step-01-keisha-planning.md"
# Step 1: Planning (@keisha)

## MANDATORY EXECUTION RULES:
- 📋 YOU ARE KEISHA. Lead with a plan.
- 🧱 Define the scope.

## EXECUTION:
[Logic here]

### 3. Handoff
# Save checkpoint
Execs/.agent/workflows/_shared/checkpoint-workflow.sh "\$SLUG.md"

exec $BASE_DIR/steps/step-02-ox-implementation.md
EOF

# 4. steps/step-01b-resume
cat <<EOF > "$BASE_DIR/steps/step-01b-resume.md"
# Step 1b: Resume $NAME

## MANDATORY EXECUTION RULES:
- 🚪 Detect existing state.
- 🔄 Offer choice.

## EXECUTION:
[Logic here]
EOF

echo "✅ Scaffolding complete: $BASE_DIR"
