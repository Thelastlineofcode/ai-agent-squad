#!/bin/bash
# Ox → Soulja Handoff Script
# Transfers completed implementation to Soulja for testing

set -e

# Configuration
PROJECT_DIR="${1:-.}"
OPS_BOARD="${PROJECT_DIR}/AGENT_OPS_BOARD.md"
LEARNINGS="${PROJECT_DIR}/AGENT_LEARNINGS.md"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🔄 Ox → Soulja Handoff${NC}"
echo "Project: ${PROJECT_DIR}"
echo ""

# Validate ops board exists
if [ ! -f "${OPS_BOARD}" ]; then
    echo -e "${RED}❌ Error: Ops board not found${NC}"
    echo "Expected: ${OPS_BOARD}"
    exit 1
fi

# Extract completed implementation files from git status
echo -e "${YELLOW}📋 Checking implementation status...${NC}"

# Get modified files
MODIFIED_FILES=$(git -C "${PROJECT_DIR}" status --short | grep -E '^\s*M|^\s*A' | awk '{print $2}')

if [ -z "${MODIFIED_FILES}" ]; then
    echo -e "${RED}❌ Error: No modified files found${NC}"
    echo "Expected implementation changes from Ox"
    exit 1
fi

echo -e "${GREEN}✓ Found $(echo \"${MODIFIED_FILES}\" | wc -l | xargs) modified files${NC}"
echo "${MODIFIED_FILES}"
echo ""

# Find Ox tasks in ops board
echo -e "${YELLOW}📝 Extracting Ox tasks from ops board...${NC}"

# Extract tasks assigned to @ox
OX_TASKS=$(grep -E "\| T-[0-9]+ \|.*\| @ox \|" "${OPS_BOARD}" || true)

if [ -z "${OX_TASKS}" ]; then
    echo -e "${RED}❌ Error: No Ox tasks found in ops board${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Found $(echo \"${OX_TASKS}\" | wc -l | xargs) Ox tasks${NC}"

# Update ops board - mark Ox tasks as done
echo ""
echo -e "${YELLOW}✅ Marking Ox tasks as complete...${NC}"

TIMESTAMP=$(date +"%Y-%m-%d %H:%M")

# Create temp file with updated statuses
{
    while IFS= read -r line; do
        # Check if line contains an @ox task
        if echo "${line}" | grep -q "\| @ox \|"; then
            # Replace status with ✅ Done
            echo "${line}" | sed 's/| 🟢 Ready |/| ✅ Done |/g' | sed 's/| 🟡 In Progress |/| ✅ Done |/g'
        else
            echo "${line}"
        fi
    done < "${OPS_BOARD}"
} > "${OPS_BOARD}.tmp"

mv "${OPS_BOARD}.tmp" "${OPS_BOARD}"

echo -e "${GREEN}✓ Ops board updated${NC}"

# Identify test files that need coverage
echo ""
echo -e "${YELLOW}🧪 Identifying test requirements...${NC}"

# Extract Rust source files
RUST_FILES=$(echo "${MODIFIED_FILES}" | grep -E '\.rs$' | grep -v 'tests/' | grep -v 'test\.rs$' || true)

if [ -z "${RUST_FILES}" ]; then
    echo -e "${YELLOW}⚠ Warning: No Rust source files to test${NC}"
    TEST_FILES="General integration tests"
else
    # Map source files to test files
    TEST_FILES=""
    while IFS= read -r src_file; do
        # Determine test file path
        if echo "${src_file}" | grep -q "^src/"; then
            # src/foo/bar.rs → tests/foo_bar_test.rs
            test_file=$(echo "${src_file}" | sed 's|^src/||' | sed 's|/|_|g' | sed 's|\.rs$|_test.rs|')
            TEST_FILES="${TEST_FILES}\n  - tests/${test_file}"
        elif echo "${src_file}" | grep -q "api/src/"; then
            # api/src/handlers/payment.rs → api/tests/handlers_payment_test.rs
            test_file=$(echo "${src_file}" | sed 's|api/src/||' | sed 's|/|_|g' | sed 's|\.rs$|_test.rs|')
            TEST_FILES="${TEST_FILES}\n  - api/tests/${test_file}"
        fi
    done <<< "${RUST_FILES}"
fi

# Add testing tasks to ops board for Soulja
echo ""
echo -e "${YELLOW}📋 Creating testing tasks for Soulja...${NC}"

# Generate task IDs based on existing tasks
LAST_TASK_ID=$(grep -oE "T-[0-9]+" "${OPS_BOARD}" | sed 's/T-//' | sort -n | tail -1)
NEXT_TASK_ID=$((LAST_TASK_ID + 1))

# Create testing tasks
TESTING_SECTION="
### Testing Phase (Added ${TIMESTAMP})

| Task ID | Task | Assigned | Priority | Status | Files |
|---------|------|----------|----------|--------|-------|
| T-${NEXT_TASK_ID} | Run unit tests for modified files | @soulja | 🔴 Critical | 🟢 Ready | ${MODIFIED_FILES} |
| T-$((NEXT_TASK_ID + 1)) | Run integration tests | @soulja | 🔴 Critical | 🟢 Ready | See test files below |
| T-$((NEXT_TASK_ID + 2)) | Verify test coverage >85% | @soulja | 🟡 High | 🟢 Ready | cargo tarpaulin |
| T-$((NEXT_TASK_ID + 3)) | Run WASM tests (if applicable) | @soulja | 🟡 High | 🟢 Ready | wasm-pack test |

**Test Files Required**:${TEST_FILES}
"

# Append to ops board (after Active Tasks section)
{
    # Copy everything before the first ## section after Active Tasks
    sed '/## Active Tasks/,/^## / {/^## Active Tasks/p; /^## /!d; /^## Active Tasks/d}' "${OPS_BOARD}"

    echo "${TESTING_SECTION}"
    echo ""

    # Copy rest of ops board
    sed -n '/## Active Tasks/,$ {/## Active Tasks/d; p}' "${OPS_BOARD}"
} > "${OPS_BOARD}.tmp"

mv "${OPS_BOARD}.tmp" "${OPS_BOARD}"

echo -e "${GREEN}✓ Testing tasks added to ops board${NC}"

# Update learnings with implementation notes
echo ""
echo -e "${YELLOW}📚 Updating Agent Learnings...${NC}"

# Extract key implementation decisions from git log
RECENT_COMMITS=$(git -C "${PROJECT_DIR}" log --oneline -3 --pretty=format:"%h %s")

LEARNING_ENTRY="| ${TIMESTAMP} | Implementation complete - ready for testing | Modified files: $(echo \"${MODIFIED_FILES}\" | wc -l | xargs) files. Commits: ${RECENT_COMMITS} | @ox | Ops Board |"

# Add to learnings file (after Implementation Patterns header if exists)
if grep -q "## Implementation Patterns" "${LEARNINGS}"; then
    LINE_NUM=$(grep -n "## Implementation Patterns" "${LEARNINGS}" | head -1 | cut -d: -f1)
    TABLE_START=$((LINE_NUM + 3))

    sed -i.bak "${TABLE_START}i\\
${LEARNING_ENTRY}
" "${LEARNINGS}"
    rm "${LEARNINGS}.bak"

    echo -e "${GREEN}✓ Agent Learnings updated${NC}"
else
    echo -e "${YELLOW}⚠ Warning: Could not find Implementation Patterns section in learnings${NC}"
fi

# Notify Soulja
echo ""
echo -e "${GREEN}✅ Handoff Complete${NC}"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${YELLOW}@soulja${NC} has been assigned testing tasks:"
echo ""
echo "Next steps for Soulja:"
echo "  1. Review modified files:"
while IFS= read -r file; do
    echo "     - ${file}"
done <<< "${MODIFIED_FILES}"
echo ""
echo "  2. Run unit tests: cargo test -p <package>"
echo "  3. Run integration tests: cargo test --test '*'"
echo "  4. Verify coverage: cargo tarpaulin --out Html"
echo "  5. Update ops board with test results"
echo "  6. If all tests pass → handoff to DMX for review"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Summary
echo "Summary:"
echo "  Ox Tasks Completed: $(echo \"${OX_TASKS}\" | wc -l | xargs)"
echo "  Modified Files: $(echo \"${MODIFIED_FILES}\" | wc -l | xargs)"
echo "  Testing Tasks Created: 4"
echo "  Ops Board: Updated"
echo "  Learnings: Updated"
echo ""
echo -e "${GREEN}Ready for Soulja to begin testing 🧪${NC}"
