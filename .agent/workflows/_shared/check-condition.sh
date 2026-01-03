#!/bin/bash
# check-condition.sh
# Usage: ./check-condition.sh doc.md key operator value
# Example: ./check-condition.sh prd.md risk_level gt 5

DOC="$1"
KEY="$2"
OP="$3"
VAL="$4"

if [ ! -f "$DOC" ]; then exit 1; fi

# Extract value from frontmatter
ACTUAL=$(grep "^$KEY:" "$DOC" | head -1 | cut -d: -f2 | xargs | tr -d '"')

if [ -z "$ACTUAL" ]; then exit 1; fi

case "$OP" in
    eq) [ "$ACTUAL" == "$VAL" ] ;;
    neq) [ "$ACTUAL" != "$VAL" ] ;;
    gt) [ "$ACTUAL" -gt "$VAL" ] ;;
    lt) [ "$ACTUAL" -lt "$VAL" ] ;;
    contains) echo "$ACTUAL" | grep -q "$VAL" ;;
    *) exit 1 ;;
esac

exit $?
