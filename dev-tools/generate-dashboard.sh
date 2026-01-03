#!/bin/bash
# generate-dashboard.sh
# Generates a SQUAD OS Dashboard in Markdown format.

DASHBOARD="Execs/DASHBOARD.md"

echo "# SQUAD OS: DEPLOYMENT DASHBOARD" > "$DASHBOARD"
echo "**Generated:** $(date)" >> "$DASHBOARD"
echo "" >> "$DASHBOARD"

## 1. Active Missions
echo "## 1. Active Missions" >> "$DASHBOARD"
echo "| Workflow | Artifact | Status | Last Checkpoint |" >> "$DASHBOARD"
echo "|----------|----------|--------|-----------------|" >> "$DASHBOARD"

# Find active missions
find Execs/_squad-output -name "*.md" -type f | while read -r FILE; do
    STATUS=$(grep "status:" "$FILE" | head -1 | cut -d: -f2 | xargs | tr -d '"')
    if [[ ! "$STATUS" =~ ^(complete|fixed|certified)$ ]]; then
        WORKFLOW=$(grep "workflow:" "$FILE" | head -1 | cut -d: -f2 | xargs | tr -d '"')
        CHECKPOINT=$(grep "last_checkpoint:" "$FILE" | head -1 | cut -d: -f2- | xargs | tr -d '"')
        echo "| $WORKFLOW | [$(basename "$FILE")](file://$(pwd)/$FILE) | $STATUS | $CHECKPOINT |" >> "$DASHBOARD"
    fi
done

echo "" >> "$DASHBOARD"

## 2. Squad Metrics
echo "## 2. Squad Metrics" >> "$DASHBOARD"
METRICS_FILE="Execs/.agent-ops/context-metrics.csv"
if [ -f "$METRICS_FILE" ]; then
    AVG_RATIO=$(awk -F, 'NR>1 {sum+=$6; count++} END {if (count>0) print sum/count; else print 0}' "$METRICS_FILE")
    echo "**Average Context Overhead:** $AVG_RATIO%" >> "$DASHBOARD"
else
    echo "**Average Context Overhead:** N/A" >> "$DASHBOARD"
fi

echo "" >> "$DASHBOARD"

## 3. Intelligence Library
echo "## 3. Intelligence Library" >> "$DASHBOARD"
TECHNIQUE_COUNT=$(wc -l < Execs/data/elicitation-techniques.csv | xargs)
echo "**Known Techniques:** $((TECHNIQUE_COUNT - 1))" >> "$DASHBOARD"

echo "---" >> "$DASHBOARD"
echo "**AUTHORITY:** SUGE KNIGHT" >> "$DASHBOARD"

echo "✅ Dashboard generated: $DASHBOARD"
