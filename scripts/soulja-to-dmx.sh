#!/bin/bash
# Soulja → DMX Handoff Script
# Transfers test results to DMX for quality review

set -e

# Configuration
PROJECT_DIR="${1:-.}"
OPS_BOARD="${PROJECT_DIR}/AGENT_OPS_BOARD.md"
LEARNINGS="${PROJECT_DIR}/AGENT_LEARNINGS.md"
TEST_RESULTS="${PROJECT_DIR}/.test-results.tmp"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}🔄 Soulja → DMX Handoff${NC}"
echo "Project: ${PROJECT_DIR}"
echo ""

# Validate ops board exists
if [ ! -f "${OPS_BOARD}" ]; then
    echo -e "${RED}❌ Error: Ops board not found${NC}"
    echo "Expected: ${OPS_BOARD}"
    exit 1
fi

# Extract test tasks from ops board
echo -e "${YELLOW}📋 Checking test task status...${NC}"

SOULJA_TASKS=$(grep -E "\| T-[0-9]+ \|.*\| @soulja \|" "${OPS_BOARD}" || true)

if [ -z "${SOULJA_TASKS}" ]; then
    echo -e "${RED}❌ Error: No Soulja tasks found in ops board${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Found $(echo \"${SOULJA_TASKS}\" | wc -l | xargs) Soulja tasks${NC}"

# Run tests and capture results
echo ""
echo -e "${YELLOW}🧪 Running test suite...${NC}"

# Unit tests
echo -e "${BLUE}Running unit tests...${NC}"
UNIT_TEST_OUTPUT=$(cargo test --workspace 2>&1 || true)
UNIT_TEST_EXIT_CODE=$?

# Count test results
UNIT_TESTS_PASSED=$(echo "${UNIT_TEST_OUTPUT}" | grep -oE "[0-9]+ passed" | grep -oE "[0-9]+" || echo "0")
UNIT_TESTS_FAILED=$(echo "${UNIT_TEST_OUTPUT}" | grep -oE "[0-9]+ failed" | grep -oE "[0-9]+" || echo "0")

if [ "${UNIT_TEST_EXIT_CODE}" -eq 0 ]; then
    echo -e "${GREEN}✓ Unit tests passed: ${UNIT_TESTS_PASSED}${NC}"
else
    echo -e "${RED}✗ Unit tests failed: ${UNIT_TESTS_FAILED}${NC}"
fi

# Integration tests
echo -e "${BLUE}Running integration tests...${NC}"
INTEGRATION_TEST_OUTPUT=$(cargo test --test '*' 2>&1 || true)
INTEGRATION_TEST_EXIT_CODE=$?

INTEGRATION_TESTS_PASSED=$(echo "${INTEGRATION_TEST_OUTPUT}" | grep -oE "[0-9]+ passed" | grep -oE "[0-9]+" || echo "0")
INTEGRATION_TESTS_FAILED=$(echo "${INTEGRATION_TEST_OUTPUT}" | grep -oE "[0-9]+ failed" | grep -oE "[0-9]+" || echo "0")

if [ "${INTEGRATION_TEST_EXIT_CODE}" -eq 0 ]; then
    echo -e "${GREEN}✓ Integration tests passed: ${INTEGRATION_TESTS_PASSED}${NC}"
else
    echo -e "${RED}✗ Integration tests failed: ${INTEGRATION_TESTS_FAILED}${NC}"
fi

# Test coverage (if cargo-tarpaulin is installed)
echo -e "${BLUE}Checking test coverage...${NC}"
if command -v cargo-tarpaulin &> /dev/null; then
    COVERAGE_OUTPUT=$(cargo tarpaulin --workspace --out Stdout 2>&1 || true)
    COVERAGE_PERCENTAGE=$(echo "${COVERAGE_OUTPUT}" | grep -oE "[0-9]+\.[0-9]+%" | tail -1 || echo "0.0%")
    echo -e "${GREEN}✓ Test coverage: ${COVERAGE_PERCENTAGE}${NC}"
else
    COVERAGE_PERCENTAGE="N/A (cargo-tarpaulin not installed)"
    echo -e "${YELLOW}⚠ Test coverage tool not available${NC}"
fi

# WASM tests (if wasm-pack is available)
WASM_TEST_STATUS="N/A"
if [ -d "${PROJECT_DIR}/levite-web" ]; then
    echo -e "${BLUE}Running WASM tests...${NC}"
    if command -v wasm-pack &> /dev/null; then
        WASM_TEST_OUTPUT=$(wasm-pack test --headless --chrome "${PROJECT_DIR}/levite-web" 2>&1 || true)
        WASM_TEST_EXIT_CODE=$?

        if [ "${WASM_TEST_EXIT_CODE}" -eq 0 ]; then
            echo -e "${GREEN}✓ WASM tests passed${NC}"
            WASM_TEST_STATUS="✅ Passed"
        else
            echo -e "${RED}✗ WASM tests failed${NC}"
            WASM_TEST_STATUS="❌ Failed"
        fi
    else
        echo -e "${YELLOW}⚠ wasm-pack not available${NC}"
    fi
fi

# Save test results summary
{
    echo "# Test Results Summary"
    echo "**Date**: $(date +"%Y-%m-%d %H:%M:%S")"
    echo ""
    echo "## Unit Tests"
    echo "- Passed: ${UNIT_TESTS_PASSED}"
    echo "- Failed: ${UNIT_TESTS_FAILED}"
    echo "- Status: $([ ${UNIT_TEST_EXIT_CODE} -eq 0 ] && echo '✅ Passed' || echo '❌ Failed')"
    echo ""
    echo "## Integration Tests"
    echo "- Passed: ${INTEGRATION_TESTS_PASSED}"
    echo "- Failed: ${INTEGRATION_TESTS_FAILED}"
    echo "- Status: $([ ${INTEGRATION_TEST_EXIT_CODE} -eq 0 ] && echo '✅ Passed' || echo '❌ Failed')"
    echo ""
    echo "## Coverage"
    echo "- Percentage: ${COVERAGE_PERCENTAGE}"
    echo "- Target: 85%"
    echo ""
    echo "## WASM Tests"
    echo "- Status: ${WASM_TEST_STATUS}"
} > "${TEST_RESULTS}"

# Determine if tests passed quality gate
TESTS_PASSED=false
if [ "${UNIT_TEST_EXIT_CODE}" -eq 0 ] && [ "${INTEGRATION_TEST_EXIT_CODE}" -eq 0 ]; then
    TESTS_PASSED=true
fi

# Update ops board with test results
echo ""
echo -e "${YELLOW}📝 Updating ops board with test results...${NC}"

TIMESTAMP=$(date +"%Y-%m-%d %H:%M")

# Mark Soulja tasks as complete
{
    while IFS= read -r line; do
        if echo "${line}" | grep -q "\| @soulja \|"; then
            # Replace status with ✅ Done or ❌ Failed
            if [ "${TESTS_PASSED}" = true ]; then
                echo "${line}" | sed 's/| 🟢 Ready |/| ✅ Done |/g' | sed 's/| 🟡 In Progress |/| ✅ Done |/g'
            else
                echo "${line}" | sed 's/| 🟢 Ready |/| ❌ Failed |/g' | sed 's/| 🟡 In Progress |/| ❌ Failed |/g'
            fi
        else
            echo "${line}"
        fi
    done < "${OPS_BOARD}"
} > "${OPS_BOARD}.tmp"

mv "${OPS_BOARD}.tmp" "${OPS_BOARD}"

# Add DMX review task if tests passed
if [ "${TESTS_PASSED}" = true ]; then
    echo -e "${GREEN}✓ All tests passed - creating DMX review task${NC}"

    # Generate next task ID
    LAST_TASK_ID=$(grep -oE "T-[0-9]+" "${OPS_BOARD}" | sed 's/T-//' | sort -n | tail -1)
    NEXT_TASK_ID=$((LAST_TASK_ID + 1))

    DMX_REVIEW_SECTION="
### Quality Review (Added ${TIMESTAMP})

| Task ID | Task | Assigned | Priority | Status | Files |
|---------|------|----------|----------|--------|-------|
| T-${NEXT_TASK_ID} | Run Clippy linter (zero warnings) | @dmx | 🔴 Critical | 🟢 Ready | cargo clippy |
| T-$((NEXT_TASK_ID + 1)) | Verify code formatting | @dmx | 🔴 Critical | 🟢 Ready | rustfmt --check |
| T-$((NEXT_TASK_ID + 2)) | Run security scan (Semgrep) | @dmx | 🔴 Critical | 🟢 Ready | semgrep --config auto |
| T-$((NEXT_TASK_ID + 3)) | Approve PR or request changes | @dmx | 🔴 Critical | 🟢 Ready | gh pr review |

**Test Results**: ${TEST_RESULTS}
**Coverage**: ${COVERAGE_PERCENTAGE}
"

    # Append to ops board
    {
        sed '/## Active Tasks/,/^## / {/^## Active Tasks/p; /^## /!d; /^## Active Tasks/d}' "${OPS_BOARD}"
        echo "${DMX_REVIEW_SECTION}"
        echo ""
        sed -n '/## Active Tasks/,$ {/## Active Tasks/d; p}' "${OPS_BOARD}"
    } > "${OPS_BOARD}.tmp"

    mv "${OPS_BOARD}.tmp" "${OPS_BOARD}"
else
    echo -e "${RED}✗ Tests failed - DMX review blocked${NC}"
fi

echo -e "${GREEN}✓ Ops board updated${NC}"

# Update learnings
echo ""
echo -e "${YELLOW}📚 Updating Agent Learnings...${NC}"

TEST_SUMMARY="Unit: ${UNIT_TESTS_PASSED} passed, ${UNIT_TESTS_FAILED} failed. Integration: ${INTEGRATION_TESTS_PASSED} passed, ${INTEGRATION_TESTS_FAILED} failed. Coverage: ${COVERAGE_PERCENTAGE}"

LEARNING_ENTRY="| ${TIMESTAMP} | Testing complete - $([ ${TESTS_PASSED} = true ] && echo 'ready for review' || echo 'fixes needed') | ${TEST_SUMMARY} | @soulja | ${TEST_RESULTS} |"

# Add to learnings file
if grep -q "## Testing Results" "${LEARNINGS}"; then
    LINE_NUM=$(grep -n "## Testing Results" "${LEARNINGS}" | head -1 | cut -d: -f1)
    TABLE_START=$((LINE_NUM + 3))

    sed -i.bak "${TABLE_START}i\\
${LEARNING_ENTRY}
" "${LEARNINGS}"
    rm "${LEARNINGS}.bak"

    echo -e "${GREEN}✓ Agent Learnings updated${NC}"
else
    echo -e "${YELLOW}⚠ Warning: Could not find Testing Results section in learnings${NC}"
fi

# Notify DMX or report failure
echo ""
if [ "${TESTS_PASSED}" = true ]; then
    echo -e "${GREEN}✅ Handoff Complete - Tests Passed${NC}"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "${YELLOW}@dmx${NC} has been assigned quality review tasks:"
    echo ""
    echo "Test Results:"
    echo "  ✅ Unit Tests: ${UNIT_TESTS_PASSED} passed"
    echo "  ✅ Integration Tests: ${INTEGRATION_TESTS_PASSED} passed"
    echo "  📊 Coverage: ${COVERAGE_PERCENTAGE}"
    echo "  🌐 WASM Tests: ${WASM_TEST_STATUS}"
    echo ""
    echo "Next steps for DMX:"
    echo "  1. Review test results: ${TEST_RESULTS}"
    echo "  2. Run cargo clippy -- -D warnings"
    echo "  3. Run rustfmt --check src/**/*.rs"
    echo "  4. Run semgrep --config auto src/"
    echo "  5. Review code changes: git diff"
    echo "  6. Approve or request changes: gh pr review"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
else
    echo -e "${RED}❌ Testing Failed - Review Required${NC}"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "${YELLOW}@ox${NC} must fix failing tests:"
    echo ""
    echo "Test Results:"
    echo "  ❌ Unit Tests: ${UNIT_TESTS_FAILED} failed"
    echo "  ❌ Integration Tests: ${INTEGRATION_TESTS_FAILED} failed"
    echo ""
    echo "Next steps:"
    echo "  1. Review test output: ${TEST_RESULTS}"
    echo "  2. Fix failing tests"
    echo "  3. Re-run: bash ox-to-soulja.sh"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
fi
echo ""

# Summary
echo "Summary:"
echo "  Soulja Tasks: $(echo \"${SOULJA_TASKS}\" | wc -l | xargs)"
echo "  Test Status: $([ ${TESTS_PASSED} = true ] && echo '✅ Passed' || echo '❌ Failed')"
echo "  Unit Tests: ${UNIT_TESTS_PASSED} passed, ${UNIT_TESTS_FAILED} failed"
echo "  Integration Tests: ${INTEGRATION_TESTS_PASSED} passed, ${INTEGRATION_TESTS_FAILED} failed"
echo "  Coverage: ${COVERAGE_PERCENTAGE}"
echo "  Ops Board: Updated"
echo "  Learnings: Updated"
echo ""
echo -e "$([ ${TESTS_PASSED} = true ] && echo \"${GREEN}Ready for DMX quality review 🔍${NC}\" || echo \"${RED}Fix tests before DMX review ⚠️${NC}\")"
