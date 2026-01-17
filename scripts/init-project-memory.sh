#!/bin/bash
# Initialize Agent Memory System for a Project
# Usage: bash init-project-memory.sh [project-root]
# If no project-root provided, uses current directory

set -e

PROJECT_ROOT="${1:-.}"
MEMORY_DIR="$PROJECT_ROOT/.agent-ops"
PROJECT_NAME=$(basename "$PROJECT_ROOT")

echo "🧠 Initializing Agent Memory System..."
echo "📁 Project Root: $PROJECT_ROOT"
echo "🏷️  Project Name: $PROJECT_NAME"
echo ""

# Create .agent-ops directory structure
mkdir -p "$MEMORY_DIR/_memory/keisha"
mkdir -p "$MEMORY_DIR/_memory/ox"
mkdir -p "$MEMORY_DIR/_memory/soulja"
mkdir -p "$MEMORY_DIR/_memory/dmx"
mkdir -p "$MEMORY_DIR/_memory/igor"
mkdir -p "$MEMORY_DIR/_memory/masterp"
mkdir -p "$MEMORY_DIR/_memory/suge"

# Get the script directory to find templates
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$(dirname "$SCRIPT_DIR")/templates"

# Copy templates if they don't exist
if [ ! -f "$MEMORY_DIR/AGENT_OPS_BOARD.md" ]; then
    echo "📋 Creating Operations Board..."
    cp "$TEMPLATES_DIR/ops-board-template.md" "$MEMORY_DIR/AGENT_OPS_BOARD.md"
fi

if [ ! -f "$MEMORY_DIR/AGENT_LEARNINGS.md" ]; then
    echo "📚 Creating Learnings File..."
    cp "$TEMPLATES_DIR/learnings-template.md" "$MEMORY_DIR/AGENT_LEARNINGS.md"
fi

# Create individual agent memory files from templates
echo "🤖 Creating agent memory files..."

for agent in keisha ox soulja dmx igor masterp suge; do
    AGENT_MEMORY="$MEMORY_DIR/_memory/$agent/memories.md"
    AGENT_INSTRUCTIONS="$MEMORY_DIR/_memory/$agent/instructions.md"

    if [ ! -f "$AGENT_MEMORY" ]; then
        cp "$TEMPLATES_DIR/agent-memory-template.md" "$AGENT_MEMORY"
        sed -i.bak "s/\[AGENT_NAME\]/$agent/g" "$AGENT_MEMORY"
        rm "$AGENT_MEMORY.bak" 2>/dev/null || true
    fi

    if [ ! -f "$AGENT_INSTRUCTIONS" ]; then
        cp "$TEMPLATES_DIR/agent-instructions-template.md" "$AGENT_INSTRUCTIONS"
        sed -i.bak "s/\[AGENT_NAME\]/$agent/g" "$AGENT_INSTRUCTIONS"
        rm "$AGENT_INSTRUCTIONS.bak" 2>/dev/null || true
    fi
done

# Create .gitignore for memory files (optional - user can choose to commit or not)
if [ ! -f "$MEMORY_DIR/.gitignore" ]; then
    cat > "$MEMORY_DIR/.gitignore" << 'EOF'
# Agent memory files - uncomment to keep memories private
# _memory/

# Metrics - generally don't commit
*.csv

# Keep these files in repo
!AGENT_OPS_BOARD.md
!AGENT_LEARNINGS.md
!AGENT_OPERATIONS_PROTOCOL.md
!AGENT_CONTEXT_LOADER.md
!PROJECT_SPECIFICATIONS.md
!EXECUTION_LOG.md
!STATUS.md
EOF
fi

# Create CONTRIBUTING.md file if it doesn't exist
if [ ! -f "$PROJECT_ROOT/CONTRIBUTING.md" ]; then
    echo "📝 Creating CONTRIBUTING.md (project context)..."
    cp "$TEMPLATES_DIR/contributing-template.md" "$PROJECT_ROOT/CONTRIBUTING.md"
fi

# ==========================================
# FRAMEWORK IMPROVEMENTS - NEW FILES
# ==========================================

# Create AGENT_CONTEXT_LOADER.md (standardized preamble)
if [ ! -f "$MEMORY_DIR/AGENT_CONTEXT_LOADER.md" ]; then
    echo "🔄 Creating Agent Context Loader..."
    cat > "$MEMORY_DIR/AGENT_CONTEXT_LOADER.md" << 'EOF'
# Agent Context Loader

**Use this at the START of every agent conversation**

## Step 1: Load Core Context
You are operating on this project. Load these files in order:

1. `team-fullstack.txt` - Core doctrine and standards
2. `.agent-ops/PROJECT_SPECIFICATIONS.md` - Build/test/lint commands for THIS project
3. `.agent-ops/AGENT_OPS_BOARD.md` - Current tasks and status
4. `.agent-ops/AGENT_LEARNINGS.md` - Collective knowledge

## Step 2: Load Your Personal Memory
Load your agent-specific memory:

`[YOUR_AGENT_NAME]` — see `.agent-ops/_memory/[YOUR_AGENT_NAME]/`
- `memories.md` - Your session history in this project
- `instructions.md` - Custom rules for how you work

## Step 3: Confirm You're Ready
Respond with:
✅ **Context loaded for [PROJECT_NAME]**
- Core doctrine: [1 sentence]
- Your role: [1 sentence]
- Current status: [1 sentence from ops board]
- Last session: [Date of your last work here]

---

Then proceed with the task.
EOF
    echo "   ✅ AGENT_CONTEXT_LOADER.md created"
fi

# Create PROJECT_SPECIFICATIONS.md (language-agnostic setup)
if [ ! -f "$MEMORY_DIR/PROJECT_SPECIFICATIONS.md" ]; then
    echo "⚙️  Creating Project Specifications..."
    cat > "$MEMORY_DIR/PROJECT_SPECIFICATIONS.md" << 'EOF'
# Project Specifications

## Project Metadata
- **Name:** [PROJECT_NAME]
- **Tech Stack:** [e.g., Python/FastAPI, Rust/Axum, TypeScript/Next.js, Go/Gin]
- **Purpose:** [BRIEF DESCRIPTION]
- **Owner:** [Your Name]

## Build & Test Commands

### Build Command
```bash
PROJECT_BUILD_COMMAND="[e.g., cargo check, npm run build, python -m build, go build]"
```

### Test Command
```bash
PROJECT_TEST_COMMAND="[e.g., cargo test, npm test, pytest, go test ./...]"
```

### Lint Command
```bash
PROJECT_LINT_COMMAND="[e.g., cargo clippy, eslint, ruff, golangci-lint]"
```

### Coverage Command
```bash
PROJECT_COVERAGE_COMMAND="[e.g., cargo tarpaulin, vitest --coverage, pytest --cov, go tool cover]"
```

## Quality Standards
- **Minimum Coverage:** 85%
- **Test Strategy:** TDD first, no mocks where possible
- **Code Review:** Required before merge
- **Documentation:** Update README for major changes

## Architecture Patterns Used
- Example: async/await for all I/O operations
- Example: Type hints everywhere (mypy --strict / TypeScript strict mode)
- Example: Tests in tests/ directory, not inline
- Example: Fixtures in conftest.py or test setup files
- Example: [Your project-specific patterns]

## CI/CD Pipeline
- [ ] GitHub Actions configured
- [ ] Tests run on every PR
- [ ] Coverage reports automated
- [ ] Linting enforced

---

**Last Updated:** [Date]
**Updated By:** [Agent Name]
EOF
    echo "   ✅ PROJECT_SPECIFICATIONS.md created"
fi

# Create EXECUTION_LOG.md (audit trail)
if [ ! -f "$MEMORY_DIR/EXECUTION_LOG.md" ]; then
    echo "📋 Creating Execution Log..."
    cat > "$MEMORY_DIR/EXECUTION_LOG.md" << 'EOF'
# Execution Log

**Project:** [PROJECT_NAME]  
**Created:** $(date)

## Purpose
This log tracks every agent execution, the decisions made, and the impact. Use this to understand project history and avoid repeated mistakes.

---

## Execution Format

```
### HH:MM — @AGENT_NAME: Task Title
**Input:** "What the user asked"
**Output:** "What was created/changed"
**Decisions Made:**
- Decision 1
- Decision 2
**Status:** ✅ Success | 🟡 In Progress | 🔴 Blocked
**Next:** What comes next
**Files Modified:**
- file1.ts
- file2.md

---
```

## Sessions

(Agents append sessions here with timestamps, decisions, and outputs)

---

## Quick Reference
To find why a decision was made, search this log by date or agent name.
EOF
    echo "   ✅ EXECUTION_LOG.md created"
fi

# Create STATUS.md (project status dashboard)
if [ ! -f "$MEMORY_DIR/STATUS.md" ]; then
    echo "📊 Creating Status Dashboard..."
    cat > "$MEMORY_DIR/STATUS.md" << 'EOF'
# Project Status - $PROJECT_NAME

**Last Updated:** [Date]  
**Updated By:** [Agent Name]

## Current Phase
🟢 Planning / 🟡 Implementation / 🔴 Testing / ⚫ Review / ✅ Complete

## Progress
- [ ] Core architecture planned
- [ ] Phase 1 implementation
- [ ] Phase 2 implementation
- [ ] Testing and validation
- [ ] Code review and merge

## Key Metrics
- **Test Coverage:** [X]%
- **Open Issues:** [N]
- **Blockers:** [Count]
- **On Track:** Yes / No

## Latest Decisions
| Decision | Date | Agent | Status |
|----------|------|-------|--------|
| [Decision] | [YYYY-MM-DD] | [@agent] | ✅ |

## Active Blockers
| Blocker | Impact | Assigned | ETA |
|---------|--------|----------|-----|
| [Issue] | High/Medium/Low | [@agent] | [Date] |

## Next Steps
1. [Immediate action]
2. [Follow-up action]
3. [Future work]

## Team Notes
[Anything else the team should know]

---

**How to Use:**
- Agents update this after each session
- Review before starting new work
- Keep decisions up-to-date
- Use for status checks and handoffs
EOF
    echo "   ✅ STATUS.md created"
fi

# Create .gitignore for memory files (optional - user can choose to commit or not)
if [ ! -f "$MEMORY_DIR/.gitignore" ]; then
    cat > "$MEMORY_DIR/.gitignore" << 'EOF'
# Agent memory files - uncomment to keep memories private
# _memory/

# Metrics - generally don't commit
*.csv

# Keep these files in repo
!AGENT_OPS_BOARD.md
!AGENT_LEARNINGS.md
!AGENT_OPERATIONS_PROTOCOL.md
!AGENT_CONTEXT_LOADER.md
!PROJECT_SPECIFICATIONS.md
!EXECUTION_LOG.md
!STATUS.md
EOF
fi

echo ""
echo "✅ Agent Memory System Initialized!"
echo ""
echo "📂 Created structure:"
echo "   $MEMORY_DIR/"
echo "   ├── AGENT_OPS_BOARD.md         (Task tracking)"
echo "   ├── AGENT_LEARNINGS.md         (Project insights)"
echo "   ├── AGENT_CONTEXT_LOADER.md    ✨ (Standardized preamble)"
echo "   ├── PROJECT_SPECIFICATIONS.md  ✨ (Build/test commands)"
echo "   ├── EXECUTION_LOG.md           ✨ (Audit trail)"
echo "   ├── STATUS.md                  ✨ (Status dashboard)"
echo "   └── _memory/"
echo "       ├── keisha/                (Keisha's memories)"
echo "       ├── ox/                    (Ox's memories)"
echo "       ├── soulja/                (Soulja's memories)"
echo "       ├── dmx/                   (DMX's memories)"
echo "       ├── igor/                  (Igor's memories)"
echo "       ├── masterp/               (Master P's memories)"
echo "       └── suge/                  (Suge's memories)"
echo ""
echo "📋 Next steps:"
echo "   1. Edit $MEMORY_DIR/PROJECT_SPECIFICATIONS.md with build commands"
echo "   2. Edit $MEMORY_DIR/STATUS.md with current project phase"
echo "   3. Update $MEMORY_DIR/AGENT_LEARNINGS.md with critical project info"
echo "   4. Copy team-fullstack.txt → $MEMORY_DIR/"
echo "   5. Use AGENT_CONTEXT_LOADER.md as preamble for all agent chats"
echo ""
echo "🚀 Quick Start:"
echo "   1. In Claude/ChatGPT, paste: AGENT_CONTEXT_LOADER.md + agent system prompt"
echo "   2. Keisha loads context automatically"
echo "   3. Give task (e.g., 'plan authentication system')"
echo "   4. Keisha appends to EXECUTION_LOG.md + updates AGENT_OPS_BOARD.md"
echo "   5. Next agent sees everything. Coordination automatic."
echo ""
