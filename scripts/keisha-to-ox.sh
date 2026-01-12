#!/bin/bash
# Keisha → Ox Handoff Script
# Transfers PRD to Ox for implementation

set -e

# Configuration
PROJECT_DIR="${1:-.}"
OPS_BOARD="${PROJECT_DIR}/AGENT_OPS_BOARD.md"
LEARNINGS="${PROJECT_DIR}/AGENT_LEARNINGS.md"
PRD_DIR="${PROJECT_DIR}/docs/prds"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🔄 Keisha → Ox Handoff${NC}"
echo "Project: ${PROJECT_DIR}"
echo ""

# Validate PRD exists
if [ ! -d "${PRD_DIR}" ]; then
    echo -e "${RED}❌ Error: PRD directory not found${NC}"
    echo "Expected: ${PRD_DIR}"
    exit 1
fi

# Find latest PRD
LATEST_PRD=$(ls -t "${PRD_DIR}"/*.md 2>/dev/null | head -1)
if [ -z "${LATEST_PRD}" ]; then
    echo -e "${RED}❌ Error: No PRD found in ${PRD_DIR}${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Found PRD: $(basename ${LATEST_PRD})${NC}"

# Extract tasks from PRD (assuming markdown table format)
echo ""
echo -e "${YELLOW}📋 Extracting tasks from PRD...${NC}"

# Parse PRD for task table
TASKS=$(grep -A 100 "| Task ID |" "${LATEST_PRD}" | grep "| T-" | head -10)

if [ -z "${TASKS}" ]; then
    echo -e "${RED}❌ Error: No tasks found in PRD${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Found $(echo "${TASKS}" | wc -l | xargs) tasks${NC}"

# Update Ops Board
echo ""
echo -e "${YELLOW}📝 Updating Ops Board...${NC}"

if [ ! -f "${OPS_BOARD}" ]; then
    echo -e "${RED}❌ Error: Ops board not found${NC}"
    echo "Expected: ${OPS_BOARD}"
    exit 1
fi

# Extract feature name from PRD
FEATURE_NAME=$(grep -m 1 "^# " "${LATEST_PRD}" | sed 's/^# //' | sed 's/Product Requirements Document (PRD)//' | xargs)

# Add tasks to ops board (after "## Active Tasks" section)
TIMESTAMP=$(date +"%Y-%m-%d")

# Create temp file with updated ops board
{
    # Copy everything before Active Tasks section
    sed '/## Active Tasks/q' "${OPS_BOARD}"

    # Add new tasks
    echo ""
    echo "### ${FEATURE_NAME} (Added ${TIMESTAMP})"
    echo ""
    echo "| Task ID | Task | Assigned | Priority | Status | Files |"
    echo "|---------|------|----------|----------|--------|-------|"

    # Parse and add each task
    echo "${TASKS}" | while IFS='|' read -r _ task_id task owner estimate deps _; do
        task_id=$(echo $task_id | xargs)
        task=$(echo $task | xargs)
        owner=$(echo $owner | xargs)

        # Determine priority from PRD context
        priority="🟡 High"
        if echo "${task}" | grep -qi "critical\|migration\|security"; then
            priority="🔴 Critical"
        fi

        echo "| ${task_id} | ${task} | ${owner} | ${priority} | 🟢 Ready | See PRD |"
    done

    echo ""

    # Copy rest of ops board
    sed -n '/## Active Tasks/,$ {/## Active Tasks/!p}' "${OPS_BOARD}"
} > "${OPS_BOARD}.tmp"

mv "${OPS_BOARD}.tmp" "${OPS_BOARD}"

echo -e "${GREEN}✓ Ops Board updated${NC}"

# Update Agent Learnings with PRD context
echo ""
echo -e "${YELLOW}📚 Updating Agent Learnings...${NC}"

# Extract key decisions from PRD
DECISIONS=$(grep -A 5 "## Architecture & Design\|## Decision" "${LATEST_PRD}" | head -20)

# Append to learnings (in Architecture Decisions section)
LEARNING_ENTRY="| ${TIMESTAMP} | ${FEATURE_NAME} implementation | Extracted from PRD: $(basename ${LATEST_PRD}) | @keisha | ${LATEST_PRD} |"

# Add to learnings file (after Architecture Decisions header)
if grep -q "## Architecture Decisions" "${LEARNINGS}"; then
    # Find line number of table, add after it
    LINE_NUM=$(grep -n "## Architecture Decisions" "${LEARNINGS}" | head -1 | cut -d: -f1)
    TABLE_START=$((LINE_NUM + 3)) # Skip header and separator

    sed -i.bak "${TABLE_START}i\\
${LEARNING_ENTRY}
" "${LEARNINGS}"
    rm "${LEARNINGS}.bak"

    echo -e "${GREEN}✓ Agent Learnings updated${NC}"
else
    echo -e "${YELLOW}⚠ Warning: Could not find Architecture Decisions section in learnings${NC}"
fi

# Notify Ox
echo ""
echo -e "${GREEN}✅ Handoff Complete${NC}"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${YELLOW}@ox${NC} has been assigned tasks for:"
echo -e "  ${GREEN}${FEATURE_NAME}${NC}"
echo ""
echo "Next steps for Ox:"
echo "  1. Review PRD: ${LATEST_PRD}"
echo "  2. Check Ops Board: ${OPS_BOARD}"
echo "  3. Review Learnings: ${LEARNINGS}"
echo "  4. Begin implementation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Summary
echo "Summary:"
echo "  PRD: $(basename ${LATEST_PRD})"
echo "  Tasks Added: $(echo "${TASKS}" | wc -l | xargs)"
echo "  Ops Board: Updated"
echo "  Learnings: Updated"
echo ""
echo -e "${GREEN}Ready for Ox to begin implementation 🚀${NC}"
