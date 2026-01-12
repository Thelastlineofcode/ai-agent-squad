#!/bin/bash
# Agent Learnings Update Script
# Captures architectural decisions, patterns, and anti-patterns

set -e

# Configuration
PROJECT_DIR="${1:-.}"
LEARNINGS="${PROJECT_DIR}/AGENT_LEARNINGS.md"
ENTRY_TYPE="${2:-info}"  # info, decision, pattern, anti-pattern, bug

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}📚 Updating Agent Learnings${NC}"
echo "Project: ${PROJECT_DIR}"
echo "Entry Type: ${ENTRY_TYPE}"
echo ""

# Check if learnings file exists, create if not
if [ ! -f "${LEARNINGS}" ]; then
    echo -e "${YELLOW}⚠ Learnings file not found, creating from template...${NC}"

    # Create basic learnings structure
    cat > "${LEARNINGS}" << 'EOF'
# Agent Learnings
**Project**: [Project Name]
**Last Updated**: [Date]

This file captures knowledge from agent work sessions to prevent regression and improve future decisions.

---

## Architecture Decisions

| Date | Decision | Context | Agent | Reference |
|------|----------|---------|-------|-----------|
| - | No decisions yet | - | - | - |

---

## Implementation Patterns

| Date | Pattern | Context | Agent | Reference |
|------|---------|---------|-------|-----------|
| - | No patterns yet | - | - | - |

---

## Anti-Patterns Discovered

| Pattern | How it appears | Why it's bad | What to do instead | Discoverer | Location |
|---------|----------------|--------------|-------------------|------------|----------|
| - | No anti-patterns yet | - | - | - | - |

---

## Testing Results

| Date | Result | Details | Agent | Reference |
|------|--------|---------|-------|-----------|
| - | No test results yet | - | - | - |

---

## Quality Reviews

| Date | Review | Details | Agent | Reference |
|------|--------|---------|-------|-----------|
| - | No reviews yet | - | - | - |

---

## Bugs Fixed

| Date | Bug | Root Cause | Fix | Agent | Commit |
|------|-----|------------|-----|-------|--------|
| - | No bugs yet | - | - | - | - |

---

## Performance Optimizations

| Date | Optimization | Before | After | Agent | Commit |
|------|--------------|--------|-------|-------|--------|
| - | No optimizations yet | - | - | - | - |

---

## Dependencies

| Package | Version | Purpose | Notes |
|---------|---------|---------|-------|
| - | - | - | - |

---

## Current Dependencies (Latest Update)

**⚠️ CRITICAL: Always use workspace versions from root Cargo.toml**

[Populated by agents during dependency updates]

---

## Deployment History

| Date | Version | Changes | Deployed By | Status |
|------|---------|---------|-------------|--------|
| - | - | - | - | - |

EOF

    echo -e "${GREEN}✓ Learnings file created${NC}"
fi

# Function to add entry to a specific section
add_entry() {
    local section="$1"
    local entry="$2"

    if grep -q "## ${section}" "${LEARNINGS}"; then
        # Find line number of section header
        LINE_NUM=$(grep -n "## ${section}" "${LEARNINGS}" | head -1 | cut -d: -f1)
        # Skip header and table header (3 lines)
        TABLE_START=$((LINE_NUM + 3))

        # Insert entry
        sed -i.bak "${TABLE_START}i\\
${entry}
" "${LEARNINGS}"
        rm "${LEARNINGS}.bak"

        echo -e "${GREEN}✓ Entry added to ${section}${NC}"
        return 0
    else
        echo -e "${RED}✗ Section '${section}' not found in learnings file${NC}"
        return 1
    fi
}

# Get current timestamp
TIMESTAMP=$(date +"%Y-%m-%d %H:%M")

# Interactive mode - prompt for details based on entry type
case "${ENTRY_TYPE}" in
    "decision")
        echo -e "${BLUE}Adding Architecture Decision...${NC}"
        echo -n "Decision made: "
        read -r DECISION
        echo -n "Context (why this decision): "
        read -r CONTEXT
        echo -n "Agent (@keisha, @ox, @dmx, etc.): "
        read -r AGENT
        echo -n "Reference (file path, PR number, etc.): "
        read -r REFERENCE

        ENTRY="| ${TIMESTAMP} | ${DECISION} | ${CONTEXT} | ${AGENT} | ${REFERENCE} |"
        add_entry "Architecture Decisions" "${ENTRY}"
        ;;

    "pattern")
        echo -e "${BLUE}Adding Implementation Pattern...${NC}"
        echo -n "Pattern name: "
        read -r PATTERN
        echo -n "Context (when to use): "
        read -r CONTEXT
        echo -n "Agent: "
        read -r AGENT
        echo -n "Reference: "
        read -r REFERENCE

        ENTRY="| ${TIMESTAMP} | ${PATTERN} | ${CONTEXT} | ${AGENT} | ${REFERENCE} |"
        add_entry "Implementation Patterns" "${ENTRY}"
        ;;

    "anti-pattern")
        echo -e "${BLUE}Adding Anti-Pattern...${NC}"
        echo -n "Anti-pattern name: "
        read -r ANTI_PATTERN
        echo -n "How it appears: "
        read -r HOW
        echo -n "Why it's bad: "
        read -r WHY
        echo -n "What to do instead: "
        read -r INSTEAD
        echo -n "Discoverer: "
        read -r DISCOVERER
        echo -n "Location (file:line): "
        read -r LOCATION

        ENTRY="| ${ANTI_PATTERN} | ${HOW} | ${WHY} | ${INSTEAD} | ${DISCOVERER} | ${LOCATION} |"
        add_entry "Anti-Patterns Discovered" "${ENTRY}"
        ;;

    "bug")
        echo -e "${BLUE}Adding Bug Fix...${NC}"
        echo -n "Bug description: "
        read -r BUG
        echo -n "Root cause: "
        read -r CAUSE
        echo -n "Fix applied: "
        read -r FIX
        echo -n "Agent: "
        read -r AGENT
        echo -n "Commit hash: "
        read -r COMMIT

        ENTRY="| ${TIMESTAMP} | ${BUG} | ${CAUSE} | ${FIX} | ${AGENT} | ${COMMIT} |"
        add_entry "Bugs Fixed" "${ENTRY}"
        ;;

    "performance")
        echo -e "${BLUE}Adding Performance Optimization...${NC}"
        echo -n "Optimization: "
        read -r OPTIMIZATION
        echo -n "Before (metric): "
        read -r BEFORE
        echo -n "After (metric): "
        read -r AFTER
        echo -n "Agent: "
        read -r AGENT
        echo -n "Commit hash: "
        read -r COMMIT

        ENTRY="| ${TIMESTAMP} | ${OPTIMIZATION} | ${BEFORE} | ${AFTER} | ${AGENT} | ${COMMIT} |"
        add_entry "Performance Optimizations" "${ENTRY}"
        ;;

    "test")
        echo -e "${BLUE}Adding Test Result...${NC}"
        echo -n "Result summary: "
        read -r RESULT
        echo -n "Details: "
        read -r DETAILS
        echo -n "Agent: "
        read -r AGENT
        echo -n "Reference: "
        read -r REFERENCE

        ENTRY="| ${TIMESTAMP} | ${RESULT} | ${DETAILS} | ${AGENT} | ${REFERENCE} |"
        add_entry "Testing Results" "${ENTRY}"
        ;;

    "review")
        echo -e "${BLUE}Adding Quality Review...${NC}"
        echo -n "Review summary: "
        read -r REVIEW
        echo -n "Details: "
        read -r DETAILS
        echo -n "Agent: "
        read -r AGENT
        echo -n "Reference: "
        read -r REFERENCE

        ENTRY="| ${TIMESTAMP} | ${REVIEW} | ${DETAILS} | ${AGENT} | ${REFERENCE} |"
        add_entry "Quality Reviews" "${ENTRY}"
        ;;

    "dependency")
        echo -e "${BLUE}Adding Dependency...${NC}"
        echo -n "Package name: "
        read -r PACKAGE
        echo -n "Version: "
        read -r VERSION
        echo -n "Purpose: "
        read -r PURPOSE
        echo -n "Notes: "
        read -r NOTES

        ENTRY="| ${PACKAGE} | ${VERSION} | ${PURPOSE} | ${NOTES} |"
        add_entry "Dependencies" "${ENTRY}"
        ;;

    "deployment")
        echo -e "${BLUE}Adding Deployment...${NC}"
        echo -n "Version: "
        read -r VERSION
        echo -n "Changes: "
        read -r CHANGES
        echo -n "Deployed by: "
        read -r DEPLOYER
        echo -n "Status (success/failed): "
        read -r STATUS

        ENTRY="| ${TIMESTAMP} | ${VERSION} | ${CHANGES} | ${DEPLOYER} | ${STATUS} |"
        add_entry "Deployment History" "${ENTRY}"
        ;;

    "info"|*)
        echo -e "${BLUE}Quick Info Entry (generic)${NC}"
        echo -n "Section name (e.g., 'Architecture Decisions'): "
        read -r SECTION
        echo -n "Entry content (pipe-separated table row): "
        read -r ENTRY

        add_entry "${SECTION}" "${ENTRY}"
        ;;
esac

# Update last modified timestamp in learnings file
sed -i.bak "s/\*\*Last Updated\*\*:.*/\*\*Last Updated\*\*: ${TIMESTAMP}/" "${LEARNINGS}"
rm "${LEARNINGS}.bak"

echo ""
echo -e "${GREEN}✅ Learnings Updated${NC}"
echo ""
echo "Summary:"
echo "  Type: ${ENTRY_TYPE}"
echo "  Timestamp: ${TIMESTAMP}"
echo "  File: ${LEARNINGS}"
echo ""

# Optional: Show recent entries
echo -e "${YELLOW}Recent entries (last 5):${NC}"
tail -20 "${LEARNINGS}" | grep -E "^\|" | tail -5

echo ""
echo -e "${GREEN}Knowledge captured for future sessions 📚${NC}"
