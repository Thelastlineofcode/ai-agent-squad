#!/bin/bash
# validate-all-workflows.sh
# Validate all workflows in .agent/workflows/

WORKFLOWS_DIR="Execs/.agent/workflows"
VALIDATOR="Execs/dev-tools/validate-workflow.sh"

PASSED=0
FAILED=0
TOTAL=0

# Exclude internal directories
EXCLUDE="_shared|_legacy_v1|node_modules"

for WORKFLOW in "$WORKFLOWS_DIR"/*; do
    if [ -d "$WORKFLOW" ]; then
        BNAME=$(basename "$WORKFLOW")
        if [[ ! "$BNAME" =~ ^($EXCLUDE)$ ]]; then
            TOTAL=$((TOTAL + 1))
            if bash "$VALIDATOR" "$WORKFLOW"; then
                PASSED=$((PASSED + 1))
            else
                FAILED=$((FAILED + 1))
            fi
            echo "-----------------------------------------"
        fi
    fi
done

echo ""
echo "VALIDATION SUMMARY"
echo "Total Audited: $TOTAL"
echo "Passed: $PASSED"
echo "Failed: $FAILED"
echo "========================================="

if [ "$FAILED" -eq 0 ]; then
    exit 0
else
    exit 1
fi
