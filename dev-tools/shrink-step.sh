#!/bin/bash
# shrink-step.sh
# Minifies a SQUAD OS step file for "Lite Mode."

INPUT="$1"
OUTPUT="${INPUT%.md}.lite.md"

if [ -z "$INPUT" ]; then
    echo "Usage: $0 <step-file.md>"
    exit 1
fi

echo "🪄  Shrinking $INPUT -> $OUTPUT"

# 1. Start with the header
grep "^#" "$INPUT" | head -1 > "$OUTPUT"

# 2. Add Global Rule Reference (Under existing header)
echo "" >> "$OUTPUT"
echo "## MANDATORY EXECUTION RULES:" >> "$OUTPUT"
echo "- ⚡ LITE MODE ACTIVE: Adhere to **OS-GLOBAL-01** (Execs/docs/GLOBAL_RULES.md)." >> "$OUTPUT"

# 3. Extract the core EXECUTION logic (shrunken)
echo "" >> "$OUTPUT"
echo "## EXECUTION:" >> "$OUTPUT"
sed -n '/## EXECUTION:/,/###/p' "$INPUT" | grep -v "## EXECUTION:" | grep -v "###" | \
    sed '/^[[:space:]]*$/d' | \
    sed 's/^[[:space:]]*//' >> "$OUTPUT"

# 4. Extract the Handoff (Absolute minimum)
echo "" >> "$OUTPUT"
echo "### HANDOFF:" >> "$OUTPUT"
tail -n 10 "$INPUT" | grep -E "checkpoint|exec" >> "$OUTPUT"

echo "✅ Optimization complete."
