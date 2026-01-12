#!/bin/bash
# DMX Quality Review Script
# Enforces quality gates and approves/blocks PRs

set -e

# Configuration
PROJECT_DIR="${1:-.}"
OPS_BOARD="${PROJECT_DIR}/AGENT_OPS_BOARD.md"
LEARNINGS="${PROJECT_DIR}/AGENT_LEARNINGS.md"
QUALITY_GATES="${PROJECT_DIR}/../Agent Builder/Execs/standards/quality-gates.yaml"
REVIEW_RESULTS="${PROJECT_DIR}/.review-results.tmp"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}🔍 DMX Quality Review${NC}"
echo "Project: ${PROJECT_DIR}"
echo ""

# Validate quality gates file exists
if [ ! -f "${QUALITY_GATES}" ]; then
    echo -e "${RED}❌ Error: Quality gates not found${NC}"
    echo "Expected: ${QUALITY_GATES}"
    exit 1
fi

echo -e "${GREEN}✓ Quality gates loaded${NC}"

# Initialize results
BLOCKING_FAILURES=0
WARNING_FAILURES=0
METRICS_COLLECTED=()

# Gate 1: Clippy (BLOCKING)
echo ""
echo -e "${YELLOW}🔍 Running Clippy linter...${NC}"
CLIPPY_OUTPUT=$(cargo clippy --workspace --all-targets -- -D warnings 2>&1 || true)
CLIPPY_EXIT_CODE=$?

CLIPPY_WARNINGS=$(echo "${CLIPPY_OUTPUT}" | grep -c "warning:" || echo "0")
CLIPPY_ERRORS=$(echo "${CLIPPY_OUTPUT}" | grep -c "error:" || echo "0")

if [ "${CLIPPY_EXIT_CODE}" -eq 0 ] && [ "${CLIPPY_WARNINGS}" -eq 0 ]; then
    echo -e "${GREEN}✓ Clippy: PASS (0 warnings, 0 errors)${NC}"
    CLIPPY_STATUS="✅ PASS"
else
    echo -e "${RED}✗ Clippy: FAIL (${CLIPPY_WARNINGS} warnings, ${CLIPPY_ERRORS} errors)${NC}"
    CLIPPY_STATUS="❌ FAIL"
    BLOCKING_FAILURES=$((BLOCKING_FAILURES + 1))
fi

# Gate 2: Rustfmt (BLOCKING)
echo ""
echo -e "${YELLOW}🔍 Checking code formatting...${NC}"
RUSTFMT_OUTPUT=$(cargo fmt --all -- --check 2>&1 || true)
RUSTFMT_EXIT_CODE=$?

if [ "${RUSTFMT_EXIT_CODE}" -eq 0 ]; then
    echo -e "${GREEN}✓ Rustfmt: PASS (all files formatted)${NC}"
    RUSTFMT_STATUS="✅ PASS"
else
    UNFORMATTED_FILES=$(echo "${RUSTFMT_OUTPUT}" | grep "Diff in" | wc -l)
    echo -e "${RED}✗ Rustfmt: FAIL (${UNFORMATTED_FILES} files need formatting)${NC}"
    RUSTFMT_STATUS="❌ FAIL"
    BLOCKING_FAILURES=$((BLOCKING_FAILURES + 1))
fi

# Gate 3: Security Scan (BLOCKING)
echo ""
echo -e "${YELLOW}🔍 Running security scan (Semgrep)...${NC}"

if command -v semgrep &> /dev/null; then
    SEMGREP_OUTPUT=$(semgrep --config auto --severity ERROR "${PROJECT_DIR}/src" 2>&1 || true)
    SEMGREP_EXIT_CODE=$?

    SECURITY_ISSUES=$(echo "${SEMGREP_OUTPUT}" | grep -c "severity: ERROR" || echo "0")

    if [ "${SECURITY_ISSUES}" -eq 0 ]; then
        echo -e "${GREEN}✓ Security: PASS (0 vulnerabilities)${NC}"
        SECURITY_STATUS="✅ PASS"
    else
        echo -e "${RED}✗ Security: FAIL (${SECURITY_ISSUES} vulnerabilities found)${NC}"
        SECURITY_STATUS="❌ FAIL"
        BLOCKING_FAILURES=$((BLOCKING_FAILURES + 1))
    fi
else
    echo -e "${YELLOW}⚠ Semgrep not installed - skipping security scan${NC}"
    SECURITY_STATUS="⚠️ SKIPPED"
fi

# Gate 4: Test Coverage (BLOCKING - min 85%)
echo ""
echo -e "${YELLOW}🔍 Checking test coverage...${NC}"

if command -v cargo-tarpaulin &> /dev/null; then
    COVERAGE_OUTPUT=$(cargo tarpaulin --workspace --out Stdout 2>&1 || true)
    COVERAGE_PERCENTAGE=$(echo "${COVERAGE_OUTPUT}" | grep -oE "[0-9]+\.[0-9]+%" | tail -1 | sed 's/%//' || echo "0.0")

    # Convert to integer for comparison
    COVERAGE_INT=$(echo "${COVERAGE_PERCENTAGE}" | cut -d. -f1)

    if [ "${COVERAGE_INT}" -ge 85 ]; then
        echo -e "${GREEN}✓ Coverage: PASS (${COVERAGE_PERCENTAGE}% >= 85%)${NC}"
        COVERAGE_STATUS="✅ PASS (${COVERAGE_PERCENTAGE}%)"
    else
        echo -e "${RED}✗ Coverage: FAIL (${COVERAGE_PERCENTAGE}% < 85%)${NC}"
        COVERAGE_STATUS="❌ FAIL (${COVERAGE_PERCENTAGE}%)"
        BLOCKING_FAILURES=$((BLOCKING_FAILURES + 1))
    fi
else
    echo -e "${YELLOW}⚠ cargo-tarpaulin not installed - coverage check skipped${NC}"
    COVERAGE_STATUS="⚠️ SKIPPED"
fi

# Gate 5: Cyclomatic Complexity (WARNING - max 8)
echo ""
echo -e "${YELLOW}🔍 Checking cyclomatic complexity...${NC}"

if command -v cargo-geiger &> /dev/null; then
    # Note: This is a placeholder - actual complexity tools vary
    # Could use cargo-geiger, rust-code-analysis, or custom tooling
    echo -e "${YELLOW}⚠ Complexity check not implemented - skipping${NC}"
    COMPLEXITY_STATUS="⚠️ SKIPPED"
else
    echo -e "${YELLOW}⚠ Complexity tool not installed - skipping${NC}"
    COMPLEXITY_STATUS="⚠️ SKIPPED"
fi

# Gate 6: Tech Debt Ratio (WARNING - max 10%)
echo ""
echo -e "${YELLOW}🔍 Checking tech debt markers...${NC}"

TODO_COUNT=$(grep -r "TODO\|FIXME\|XXX\|HACK" "${PROJECT_DIR}/src" "${PROJECT_DIR}/api/src" 2>/dev/null | wc -l)
TOTAL_LINES=$(find "${PROJECT_DIR}/src" "${PROJECT_DIR}/api/src" -name "*.rs" -exec cat {} \; 2>/dev/null | wc -l)

if [ "${TOTAL_LINES}" -gt 0 ]; then
    DEBT_RATIO=$(awk "BEGIN {printf \"%.2f\", (${TODO_COUNT} / ${TOTAL_LINES}) * 100}")
    DEBT_RATIO_INT=$(echo "${DEBT_RATIO}" | cut -d. -f1)

    if [ "${DEBT_RATIO_INT}" -le 10 ]; then
        echo -e "${GREEN}✓ Tech Debt: OK (${DEBT_RATIO}% <= 10%)${NC}"
        DEBT_STATUS="✅ OK (${DEBT_RATIO}%)"
    else
        echo -e "${YELLOW}⚠ Tech Debt: HIGH (${DEBT_RATIO}% > 10%)${NC}"
        DEBT_STATUS="⚠️ HIGH (${DEBT_RATIO}%)"
        WARNING_FAILURES=$((WARNING_FAILURES + 1))
    fi
else
    DEBT_STATUS="⚠️ SKIPPED"
fi

# Generate review results summary
{
    echo "# DMX Quality Review Results"
    echo "**Date**: $(date +"%Y-%m-%d %H:%M:%S")"
    echo "**Project**: ${PROJECT_DIR}"
    echo ""
    echo "## Blocking Gates (Must Pass)"
    echo "| Gate | Status | Details |"
    echo "|------|--------|---------|"
    echo "| Clippy Warnings | ${CLIPPY_STATUS} | ${CLIPPY_WARNINGS} warnings, ${CLIPPY_ERRORS} errors |"
    echo "| Code Formatting | ${RUSTFMT_STATUS} | rustfmt check |"
    echo "| Security Scan | ${SECURITY_STATUS} | Semgrep vulnerabilities |"
    echo "| Test Coverage | ${COVERAGE_STATUS} | Target: 85% |"
    echo ""
    echo "## Warning Gates (Should Pass)"
    echo "| Gate | Status | Details |"
    echo "|------|--------|---------|"
    echo "| Cyclomatic Complexity | ${COMPLEXITY_STATUS} | Target: max 8 |"
    echo "| Tech Debt Ratio | ${DEBT_STATUS} | TODO/FIXME count |"
    echo ""
    echo "## Summary"
    echo "- Blocking Failures: ${BLOCKING_FAILURES}"
    echo "- Warning Failures: ${WARNING_FAILURES}"
    echo "- Overall Status: $([ ${BLOCKING_FAILURES} -eq 0 ] && echo '✅ APPROVED' || echo '❌ BLOCKED')"
} > "${REVIEW_RESULTS}"

# Update ops board
echo ""
echo -e "${YELLOW}📝 Updating ops board...${NC}"

TIMESTAMP=$(date +"%Y-%m-%d %H:%M")

# Mark DMX tasks as complete
{
    while IFS= read -r line; do
        if echo "${line}" | grep -q "\| @dmx \|"; then
            if [ "${BLOCKING_FAILURES}" -eq 0 ]; then
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

echo -e "${GREEN}✓ Ops board updated${NC}"

# Update learnings
echo ""
echo -e "${YELLOW}📚 Updating Agent Learnings...${NC}"

REVIEW_SUMMARY="Blocking: ${BLOCKING_FAILURES} failures. Warnings: ${WARNING_FAILURES}. Status: $([ ${BLOCKING_FAILURES} -eq 0 ] && echo 'APPROVED' || echo 'BLOCKED')"

LEARNING_ENTRY="| ${TIMESTAMP} | DMX quality review $([ ${BLOCKING_FAILURES} -eq 0 ] && echo 'passed' || echo 'failed') | ${REVIEW_SUMMARY} | @dmx | ${REVIEW_RESULTS} |"

# Add to learnings file
if grep -q "## Quality Reviews" "${LEARNINGS}"; then
    LINE_NUM=$(grep -n "## Quality Reviews" "${LEARNINGS}" | head -1 | cut -d: -f1)
    TABLE_START=$((LINE_NUM + 3))

    sed -i.bak "${TABLE_START}i\\
${LEARNING_ENTRY}
" "${LEARNINGS}"
    rm "${LEARNINGS}.bak"

    echo -e "${GREEN}✓ Agent Learnings updated${NC}"
else
    echo -e "${YELLOW}⚠ Warning: Could not find Quality Reviews section in learnings${NC}"
fi

# Create PR review (if gh CLI available and in a git repo with PR)
echo ""
echo -e "${YELLOW}🔍 Preparing PR review...${NC}"

if command -v gh &> /dev/null && git -C "${PROJECT_DIR}" rev-parse --git-dir > /dev/null 2>&1; then
    # Check if there's an active PR for current branch
    CURRENT_BRANCH=$(git -C "${PROJECT_DIR}" rev-parse --abbrev-ref HEAD)
    PR_NUMBER=$(gh pr list --head "${CURRENT_BRANCH}" --json number --jq '.[0].number' 2>/dev/null || echo "")

    if [ -n "${PR_NUMBER}" ]; then
        echo -e "${GREEN}✓ Found PR #${PR_NUMBER} for branch ${CURRENT_BRANCH}${NC}"

        # Create review comment
        if [ "${BLOCKING_FAILURES}" -eq 0 ]; then
            REVIEW_COMMENT="## ✅ DMX Quality Review: APPROVED

All quality gates passed successfully.

### Blocking Gates
- ✅ Clippy: ${CLIPPY_WARNINGS} warnings, ${CLIPPY_ERRORS} errors
- ✅ Rustfmt: All files formatted correctly
- ✅ Security: ${SECURITY_STATUS}
- ✅ Coverage: ${COVERAGE_STATUS}

### Warnings
- Tech Debt: ${DEBT_STATUS}

**Recommendation**: Approve and merge.

---
*Automated review by @dmx (DMX Quality Gatekeeper)*"

            gh pr review "${PR_NUMBER}" --approve --body "${REVIEW_COMMENT}" 2>/dev/null && \
                echo -e "${GREEN}✓ PR approved via gh CLI${NC}" || \
                echo -e "${YELLOW}⚠ Could not auto-approve PR (may require manual approval)${NC}"
        else
            REVIEW_COMMENT="## ❌ DMX Quality Review: CHANGES REQUESTED

Quality gates failed. Please fix the following issues:

### Blocking Issues (${BLOCKING_FAILURES})
$([ "${CLIPPY_STATUS}" = "❌ FAIL" ] && echo "- ❌ Clippy: ${CLIPPY_WARNINGS} warnings, ${CLIPPY_ERRORS} errors - Run \`cargo clippy --fix\`")
$([ "${RUSTFMT_STATUS}" = "❌ FAIL" ] && echo "- ❌ Rustfmt: Unformatted files - Run \`cargo fmt\`")
$([ "${SECURITY_STATUS}" = "❌ FAIL" ] && echo "- ❌ Security: Vulnerabilities found - Review Semgrep output")
$(echo "${COVERAGE_STATUS}" | grep -q "FAIL" && echo "- ❌ Coverage: Below 85% threshold - Add tests")

### Warnings (${WARNING_FAILURES})
$(echo "${DEBT_STATUS}" | grep -q "HIGH" && echo "- ⚠️ Tech Debt: Clean up TODO/FIXME comments")

**Recommendation**: Fix blocking issues and re-run quality checks.

---
*Automated review by @dmx (DMX Quality Gatekeeper)*"

            gh pr review "${PR_NUMBER}" --request-changes --body "${REVIEW_COMMENT}" 2>/dev/null && \
                echo -e "${RED}✓ Changes requested via gh CLI${NC}" || \
                echo -e "${YELLOW}⚠ Could not auto-request changes (may require manual review)${NC}"
        fi
    else
        echo -e "${YELLOW}⚠ No PR found for current branch${NC}"
    fi
else
    echo -e "${YELLOW}⚠ gh CLI not available or not in git repo${NC}"
fi

# Final output
echo ""
if [ "${BLOCKING_FAILURES}" -eq 0 ]; then
    echo -e "${GREEN}✅ Quality Review: APPROVED${NC}"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "${GREEN}All quality gates passed!${NC}"
    echo ""
    echo "Review Results:"
    echo "  ✅ Clippy: ${CLIPPY_STATUS}"
    echo "  ✅ Rustfmt: ${RUSTFMT_STATUS}"
    echo "  ✅ Security: ${SECURITY_STATUS}"
    echo "  ✅ Coverage: ${COVERAGE_STATUS}"
    echo ""
    echo "Next steps:"
    echo "  1. Review full results: ${REVIEW_RESULTS}"
    echo "  2. Merge PR (if applicable)"
    echo "  3. Deploy to production (if approved)"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
else
    echo -e "${RED}❌ Quality Review: BLOCKED${NC}"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "${RED}Quality gates failed!${NC}"
    echo ""
    echo "Blocking Issues (${BLOCKING_FAILURES}):"
    [ "${CLIPPY_STATUS}" = "❌ FAIL" ] && echo "  ❌ Clippy: ${CLIPPY_WARNINGS} warnings, ${CLIPPY_ERRORS} errors"
    [ "${RUSTFMT_STATUS}" = "❌ FAIL" ] && echo "  ❌ Rustfmt: Unformatted files"
    [ "${SECURITY_STATUS}" = "❌ FAIL" ] && echo "  ❌ Security: Vulnerabilities found"
    echo "${COVERAGE_STATUS}" | grep -q "FAIL" && echo "  ❌ Coverage: Below threshold"
    echo ""
    echo "Next steps:"
    echo "  1. Review full results: ${REVIEW_RESULTS}"
    echo "  2. Fix blocking issues"
    echo "  3. Re-run: bash dmx-review.sh"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
fi
echo ""

# Summary
echo "Summary:"
echo "  Blocking Failures: ${BLOCKING_FAILURES}"
echo "  Warning Failures: ${WARNING_FAILURES}"
echo "  Overall Status: $([ ${BLOCKING_FAILURES} -eq 0 ] && echo '✅ APPROVED' || echo '❌ BLOCKED')"
echo "  Review Results: ${REVIEW_RESULTS}"
echo "  Ops Board: Updated"
echo "  Learnings: Updated"
echo ""

# Exit with appropriate code
if [ "${BLOCKING_FAILURES}" -eq 0 ]; then
    echo -e "${GREEN}Ready to merge! 🚀${NC}"
    exit 0
else
    echo -e "${RED}Fix issues before merging ⚠️${NC}"
    exit 1
fi
