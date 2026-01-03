#!/bin/bash
# analyze-agent-performance.sh
# Analyzes agent involvement and mission success.

LOG="Execs/.agent-ops/agent-performance.csv"
if [ ! -f "$LOG" ]; then
    echo "agent,missions_involved,missions_completed" > "$LOG"
fi

# Temp file for counting
TMP_COUNT="/tmp/agent_stats.tmp"
rm -f "$TMP_COUNT"

# Scan all md files in _squad-output
find Execs/_squad-output -name "*.md" -type f | while read -r FILE; do
    AGENTS=$(grep "agents_involved:" "$FILE" | cut -d: -f2- | tr -d '[]" ' | tr ',' '\n')
    STATUS=$(grep "status:" "$FILE" | head -1 | cut -d: -f2 | xargs | tr -d '"')
    
    for AGENT in $AGENTS; do
        if [ "$STATUS" == "complete" ] || [ "$STATUS" == "fixed" ] || [ "$STATUS" == "certified" ]; then
            echo "$AGENT,1,1" >> "$TMP_COUNT"
        else
            echo "$AGENT,1,0" >> "$TMP_COUNT"
        fi
    done
done

# Aggregate results
echo "agent,missions_involved,missions_completed" > "$LOG"
awk -F, '{inv[$1]+=$2; comp[$1]+=$3} END {for (a in inv) print a","inv[a]","comp[a]}' "$TMP_COUNT" >> "$LOG"

echo "✅ Performance stats updated in $LOG"
awk -F, 'NR>1 {print "Agent: "$1" | Missions: "$2" | Completed: "$3}' "$LOG"
