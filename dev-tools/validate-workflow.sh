#!/bin/bash
# validate-workflow.sh
# Validates workflow structure against BMAD architecture

WORKFLOW_DIR="$1"

if [ -z "$WORKFLOW_DIR" ]; then
    echo "Usage: $0 <workflow-directory>"
    exit 1
fi

echo "🔍 Validating workflow: $WORKFLOW_DIR"

ERRORS=0

# Check 1: workflow.md exists
if [ ! -f "$WORKFLOW_DIR/workflow.md" ]; then
    echo "❌ Missing workflow.md"
    ERRORS=$((ERRORS + 1))
fi

# Check 2: templates/ directory exists
if [ ! -d "$WORKFLOW_DIR/templates" ]; then
    echo "⚠️  No templates/ directory"
fi

# Check 3: steps/ directory exists
if [ ! -d "$WORKFLOW_DIR/steps" ]; then
    echo "❌ Missing steps/ directory"
    ERRORS=$((ERRORS + 1))
fi

# Check 4: At least one step file
STEP_COUNT=$(find "$WORKFLOW_DIR/steps" -name "step-*.md" 2>/dev/null | wc -l | xargs)
if [ "$STEP_COUNT" -eq 0 ]; then
    echo "❌ No step files found"
    ERRORS=$((ERRORS + 1))
else
    echo "✅ Found $STEP_COUNT step files"
fi

# Check 5: Step files have required sections
for STEP_FILE in "$WORKFLOW_DIR/steps"/step-*.md; do
    if [ -f "$STEP_FILE" ]; then
        if ! grep -q "MANDATORY EXECUTION RULES" "$STEP_FILE"; then
            echo "❌ $(basename "$STEP_FILE"): Missing MANDATORY EXECUTION RULES section"
            ERRORS=$((ERRORS + 1))
        fi

        if ! grep -q "EXECUTION" "$STEP_FILE"; then
            echo "❌ $(basename "$STEP_FILE"): Missing EXECUTION section"
            ERRORS=$((ERRORS + 1))
        fi
    fi
done

# Check 6: Step sequence has no gaps (approx check)
# Collect all numeric prefixes
STEP_NUMBERS=$(find "$WORKFLOW_DIR/steps" -name "step-*.md" | sed 's/.*step-0*//' | sed 's/[a-z-].*//' | grep -v "1b" | sort -n | uniq)
EXPECTED=1
for NUM in $STEP_NUMBERS; do
    if [ "$NUM" != "$EXPECTED" ]; then
        echo "⚠️  Step sequence gap: expected step-0$EXPECTED, found step-0$NUM"
        # We don't increment ERRORS for gaps right now as some might be intentional 1b etc
    fi
    EXPECTED=$((NUM + 1))
done

# Summary
echo ""
echo "========================================="
if [ "$ERRORS" -eq 0 ]; then
    echo "✅ VALIDATION PASSED"
    exit 0
else
    echo "❌ VALIDATION FAILED (Found $ERRORS critical errors)"
    exit 1
fi
