#!/bin/bash
# measure-context-overhead.sh
# Measures context overhead for a workflow step in a completed document

DOC_PATH="$1"
STEP_NUM="$2"

if [ -z "$DOC_PATH" ] || [ -z "$STEP_NUM" ]; then
    echo "Usage: $0 <document-path> <step-number>"
    exit 1
fi

if [ ! -f "$DOC_PATH" ]; then
    echo "❌ Document not found: $DOC_PATH"
    exit 1
fi

# Extract step content (heuristic: between headers)
# This assumes the doc has standard headers like "## 1. ANALYSIS" or similar
# We'll use a more generic approach: Extract content from Step X marker
START_MARKER="## $STEP_NUM\."
NEXT_STEP=$((STEP_NUM + 1))
END_MARKER="## $NEXT_STEP\."

# Get content between markers
STEP_CONTENT=$(sed -n "/$START_MARKER/,/$END_MARKER/p" "$DOC_PATH" | sed '$d')

if [ -z "$STEP_CONTENT" ]; then
    # Try alternate format ## STEP $STEP_NUM
    START_MARKER="## STEP $STEP_NUM"
    END_MARKER="## STEP $NEXT_STEP"
    STEP_CONTENT=$(sed -n "/$START_MARKER/,/$END_MARKER/p" "$DOC_PATH" | sed '$d')
fi

# Count content tokens (estimate: 4 chars per token)
CONTENT_CHARS=$(echo "$STEP_CONTENT" | wc -c | xargs)
CONTENT_TOKENS=$((CONTENT_CHARS / 4))

# Find the step file to measure overhead (instruction tokens)
WORKFLOW=$(grep "workflow:" "$DOC_PATH" | head -1 | cut -d: -f2 | xargs)
STEP_FILE=$(find "Execs/.agent/workflows/$WORKFLOW/steps" -name "step-0${STEP_NUM}-*.md" | head -1)

if [ -f "$STEP_FILE" ]; then
    OVERHEAD_CHARS=$(wc -c < "$STEP_FILE" | xargs)
    OVERHEAD_TOKENS=$((OVERHEAD_CHARS / 4))
else
    OVERHEAD_TOKENS=0
fi

TOTAL=$((CONTENT_TOKENS + OVERHEAD_TOKENS))
if [ "$CONTENT_TOKENS" -gt 0 ]; then
    RATIO=$((OVERHEAD_TOKENS * 100 / CONTENT_TOKENS))
else
    RATIO=0
fi

echo "--- Context Overhead Report ---"
echo "Mission: $(basename "$DOC_PATH")"
echo "Step: $STEP_NUM"
echo "Content Tokens: $CONTENT_TOKENS"
echo "Instruction Tokens: $OVERHEAD_TOKENS"
echo "Overhead Ratio: $RATIO%"

if [ "$RATIO" -gt 25 ]; then
    echo "⚠️  WARNING: Overhead exceeding 25% threshold."
fi

# Log to CSV
METRICS_FILE="Execs/.agent-ops/context-metrics.csv"
if [ ! -f "$METRICS_FILE" ]; then
    echo "timestamp,mission,step,content_tokens,overhead_tokens,ratio" > "$METRICS_FILE"
fi
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
echo "$TIMESTAMP,$(basename "$DOC_PATH"),$STEP_NUM,$CONTENT_TOKENS,$OVERHEAD_TOKENS,$RATIO" >> "$METRICS_FILE"
