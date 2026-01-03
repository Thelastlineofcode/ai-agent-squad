#!/bin/bash
# checkpoint-workflow.sh
# Usage: ./checkpoint-workflow.sh path/to/doc.md

TARGET_FILE="$1"

if [ ! -f "$TARGET_FILE" ]; then
    echo "Error: File $TARGET_FILE not found."
    exit 1
fi

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Check if last_checkpoint already exists
if grep -q "last_checkpoint:" "$TARGET_FILE"; then
    # Update existing
    sed -i '' "s/last_checkpoint: .*/last_checkpoint: \"$TIMESTAMP\"/" "$TARGET_FILE"
else
    # Insert before final --- of frontmatter
    # Find the second instance of ---
    LINE_NUM=$(grep -n -- "^---$" "$TARGET_FILE" | sed -n '2p' | cut -d: -f1)
    if [ -n "$LINE_NUM" ]; then
        sed -i '' "${LINE_NUM}i\\
last_checkpoint: \"$TIMESTAMP\"
" "$TARGET_FILE"
    fi
fi

echo "✅ Checkpoint saved: $TIMESTAMP"
