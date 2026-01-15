#!/bin/bash
# Initialize Agent Memory System for a Project
# Usage: bash init-project-memory.sh [project-root]
# If no project-root provided, uses current directory

set -e

PROJECT_ROOT="${1:-.}"
MEMORY_DIR="$PROJECT_ROOT/.agent-ops"

echo "🧠 Initializing Agent Memory System..."
echo "📁 Project Root: $PROJECT_ROOT"
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
EOF
fi

# Create CONTRIBUTING.md file if it doesn't exist
if [ ! -f "$PROJECT_ROOT/CONTRIBUTING.md" ]; then
    echo "📝 Creating CONTRIBUTING.md (project context)..."
    cp "$TEMPLATES_DIR/contributing-template.md" "$PROJECT_ROOT/CONTRIBUTING.md"
fi

echo ""
echo "✅ Agent Memory System Initialized!"
echo ""
echo "📂 Created structure:"
echo "   $MEMORY_DIR/"
echo "   ├── AGENT_OPS_BOARD.md      (Task tracking)"
echo "   ├── AGENT_LEARNINGS.md      (Project insights)"
echo "   └── _memory/"
echo "       ├── keisha/             (Keisha's memories)"
echo "       ├── ox/                 (Ox's memories)"
echo "       ├── soulja/             (Soulja's memories)"
echo "       ├── dmx/                (DMX's memories)"
echo "       ├── igor/               (Igor's memories)"
echo "       ├── masterp/            (Master P's memories)"
echo "       └── suge/               (Suge's memories)"
echo ""
echo "📋 Next steps:"
echo "   1. Edit $PROJECT_ROOT/CONTRIBUTING.md with project details"
echo "   2. Update $MEMORY_DIR/AGENT_LEARNINGS.md with critical project info"
echo "   3. Trigger agents with @keisha, @ox, etc."
echo ""
