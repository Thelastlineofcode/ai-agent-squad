# Agent Squad Project Setup Guide

This guide shows you how to initialize the Agent Squad memory system in any project.

---

## Quick Start

### 1. Initialize Memory System

From your project root, run:

```bash
bash /path/to/Execs/scripts/init-project-memory.sh
```

Or from the Execs directory:

```bash
cd /path/to/Execs
bash scripts/init-project-memory.sh /path/to/your/project
```

This creates:
```
your-project/
├── .agent-ops/
│   ├── AGENT_OPS_BOARD.md         # Task tracking
│   ├── AGENT_LEARNINGS.md         # Project insights
│   └── _memory/                   # Agent-specific memories
│       ├── keisha/
│       │   ├── memories.md
│       │   └── instructions.md
│       ├── ox/
│       ├── soulja/
│       ├── dmx/
│       ├── igor/
│       ├── masterp/
│       └── suge/
└── CONTRIBUTING.md             # Project standards & context
```

---

## 2. Configure Project Specifications

**CRITICAL:** Create `.agent-ops/PROJECT_SPECIFICATIONS.md` in your project root.

Use the template:
```bash
cp /path/to/Execs/templates/PROJECT_SPECIFICATIONS.template.md .agent-ops/PROJECT_SPECIFICATIONS.md
```

Fill in:
- **Build/Test Commands**: Replaces `{{PROJECT_BUILD_COMMAND}}`, `{{PROJECT_TEST_COMMAND}}`, etc.
- **Code Quality Standards**: Coverage targets, complexity limits
- **Architecture Patterns**: How dependencies are injected, error handling
- **Development Environment**: Prerequisites, setup commands

**This file is REQUIRED** - agents will read it to understand your project's language, tooling, and conventions.

### Optional: CONTRIBUTING.md

You can also create `CONTRIBUTING.md` for human-focused documentation:
- Team workflows
- Git conventions
- PR process
- Style guides

The agents will read this too, but `PROJECT_SPECIFICATIONS.md` takes precedence for technical specs.

---

## 3. Trigger Your First Agent

### Planning a Feature (@keisha)
```
@keisha create a PRD for [feature description]
```

Keisha will:
1. Load her memories from `.agent-ops/_memory/keisha/`
2. Read the ops board and learnings
3. Load `CONTRIBUTING.md` for standards
4. Create a PRD
5. Update her memories with session notes

### Building a Feature (@ox)
```
@ox implement [feature] based on [PRD reference]
```

Ox will:
1. Load his memories
2. Read the PRD created by Keisha
3. Follow coding standards from `CONTRIBUTING.md`
4. Update ops board as he works
5. Log decisions in his memories

### Testing (@soulja)
```
@soulja validate [feature]
```

### Review & Gate (@dmx)
```
@dmx review [PR or code]
```

---

## Memory System Behavior

### What Gets Remembered

Each agent maintains:
- **Session History**: What they did, when, and why
- **Persistent Knowledge**: Architecture insights, patterns, gotchas
- **Preferences**: Tools, commands, collaboration notes

### Where Memories Live

All memory files live in **the project directory**, not in the Execs folder:
- `{project-root}/.agent-ops/_memory/[agent-name]/memories.md`
- `{project-root}/.agent-ops/_memory/[agent-name]/instructions.md`

This ensures:
- Execs folder stays project-agnostic
- Each project has its own context
- Agents remember project-specific details

### Memory Persistence

Agents automatically:
1. **Load memories** at session start
2. **Update memories** during work
3. **Append session summary** at session end

---

## Agent Workflow Example

```bash
# 1. Initialize project
bash /path/to/Execs/scripts/init-project-memory.sh

# 2. Fill in project context
vim CONTRIBUTING.md

# 3. Plan feature
# Trigger: @keisha create PRD for user authentication

# 4. Implement
# Trigger: @ox build auth feature from PRD-001

# 5. Test
# Trigger: @soulja validate auth feature

# 6. Review
# Trigger: @dmx review auth implementation

# 7. Deploy (if gates pass)
```

---

## Memory Updates Protocol

### Session Start (Automatic)
Each agent:
1. Loads `{project-root}/.agent-ops/_memory/[agent]/memories.md`
2. Loads `{project-root}/.agent-ops/AGENT_OPS_BOARD.md`
3. Loads `{project-root}/.agent-ops/AGENT_LEARNINGS.md`
4. Loads `{project-root}/CONTRIBUTING.md` (if exists)

### During Session
Agents update:
- Ops board when starting/completing tasks
- Their memories when making decisions

### Session End
Agents:
1. Append session summary to their `memories.md`
2. Update `AGENT_LEARNINGS.md` if architectural insights emerged
3. Update ops board with final status

---

## File Responsibilities

| File | Who Updates | When |
|------|-------------|------|
| `CONTRIBUTING.md` | User/Keisha | Project setup, major changes |
| `AGENT_OPS_BOARD.md` | All agents | Task start/completion |
| `AGENT_LEARNINGS.md` | All agents | Architectural decisions, patterns |
| `_memory/[agent]/memories.md` | Individual agent | Every session |
| `_memory/[agent]/instructions.md` | User/First session | Project-specific protocols |

---

## Troubleshooting

### Agents Not Remembering

**Check:**
1. Did you run `init-project-memory.sh`?
2. Is `.agent-ops/` directory present in project root?
3. Are memory files populated?

**Fix:**
```bash
# Re-initialize
bash /path/to/Execs/scripts/init-project-memory.sh

# Verify structure
ls -la .agent-ops/_memory/
```

### Agents Using Wrong Context

Agents should ONLY work in `{project-root}/`, not the Execs folder.

**Verify:**
- Agent YAML critical_actions include: `ONLY read/write project files in {project-root}/`
- Memory paths use `{project-root}/.agent-ops/_memory/`

---

## Multi-Project Usage

The same Execs agent configurations can manage **multiple projects** simultaneously:

```
Projects/
├── project-a/
│   ├── .agent-ops/_memory/...  # Project A's memories
│   └── CONTRIBUTING.md
├── project-b/
│   ├── .agent-ops/_memory/...  # Project B's memories
│   └── CONTRIBUTING.md
└── Execs/                      # Shared, project-agnostic
    ├── agents/
    ├── scripts/
    └── templates/
```

Each project gets its own isolated memory system.

---

## Advanced: Custom Agent Instructions

You can customize agent behavior per-project by editing:
```
.agent-ops/_memory/[agent]/instructions.md
```

Example for Ox in a Rust project:
```markdown
# Ox Session Instructions

## Project-Specific Guidelines

### Critical Rules
- Always run `cargo clippy` before commits
- Use `thiserror` for error types, not `anyhow`
- Database migrations must be reversible

### Workflow Notes
- Run `trunk serve` for frontend dev server
- Backend runs on port 3000, frontend on 8080
```

---

## Git Integration

### Option 1: Commit Memories (Recommended for Teams)
```bash
# Track all memory files
git add .agent-ops/
git commit -m "chore: update agent memories"
```

Benefits:
- Team shares agent context
- New team members get full history

### Option 2: Keep Memories Private
```bash
# Add to .gitignore
echo ".agent-ops/_memory/" >> .gitignore
```

Benefits:
- Personal agent notes stay private
- Smaller repo size

**Note:** Always commit `AGENT_OPS_BOARD.md` and `AGENT_LEARNINGS.md` for team coordination.

---

## Template Customization

Templates are in `Execs/templates/`:
- `ops-board-template.md`
- `learnings-template.md`
- `agent-memory-template.md`
- `agent-instructions-template.md`
- `project-context-template.md`

Customize these to match your workflow before running `init-project-memory.sh`.

---

## Next Steps

1. Run `init-project-memory.sh` in your project
2. Fill in `CONTRIBUTING.md`
3. Trigger `@keisha` to plan your first feature
4. Watch agents coordinate via the ops board

For questions about the agent squad system, see [team-fullstack.txt](team-fullstack.txt).
