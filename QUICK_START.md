# Agent Squad Quick Start

## Initialize a New Project

```bash
# From project root
bash /path/to/Execs/scripts/init-project-memory.sh

# Or specify project path
bash /path/to/Execs/scripts/init-project-memory.sh /path/to/project
```

---

## What Gets Created

```
your-project/
├── .agent-ops/
│   ├── AGENT_OPS_BOARD.md         # Shared task board
│   ├── AGENT_LEARNINGS.md         # Shared project insights
│   └── _memory/                   # Agent-specific memories
│       ├── keisha/                # Keisha's session history
│       ├── ox/                    # Ox's session history
│       ├── soulja/                # Soulja's session history
│       ├── dmx/                   # DMX's session history
│       ├── igor/                  # Igor's session history
│       ├── masterp/               # Master P's session history
│       └── suge/                  # Suge's session history
└── project-context.md             # Your project standards
```

---

## First Steps After Init

### 1. Fill In Project Context
```bash
vim project-context.md
```

Add:
- Tech stack (languages, frameworks)
- Code standards (formatting, naming)
- Critical rules (what to do/avoid)
- File organization

### 2. Trigger Your First Agent

**Planning:**
```
@keisha create a PRD for [feature description]
```

**Building:**
```
@ox implement [feature] from [PRD reference]
```

**Testing:**
```
@soulja validate [feature]
```

**Review:**
```
@dmx review [code/PR]
```

---

## How Memory Works

### Automatic at Session Start
Each agent loads:
1. Their personal memories (`_memory/[agent]/memories.md`)
2. Task board (`AGENT_OPS_BOARD.md`)
3. Project insights (`AGENT_LEARNINGS.md`)
4. Project standards (`project-context.md`)

### During Session
Agents update:
- Task board (when starting/finishing tasks)
- Their memories (decisions, patterns noticed)

### At Session End
Agents append:
- Session summary to their memories
- New insights to `AGENT_LEARNINGS.md`

---

## Memory Locations

| What | Where |
|------|-------|
| Keisha's memories | `{project}/.agent-ops/_memory/keisha/memories.md` |
| Ox's memories | `{project}/.agent-ops/_memory/ox/memories.md` |
| Soulja's memories | `{project}/.agent-ops/_memory/soulja/memories.md` |
| DMX's memories | `{project}/.agent-ops/_memory/dmx/memories.md` |
| Igor's memories | `{project}/.agent-ops/_memory/igor/memories.md` |
| Master P's memories | `{project}/.agent-ops/_memory/masterp/memories.md` |
| Suge's memories | `{project}/.agent-ops/_memory/suge/memories.md` |
| Shared task board | `{project}/.agent-ops/AGENT_OPS_BOARD.md` |
| Shared learnings | `{project}/.agent-ops/AGENT_LEARNINGS.md` |

**Key Point:** All memories live in **the project**, not in Execs folder.

---

## Multi-Project Support

Use the same agent squad across multiple projects:

```
~/Projects/
├── app-a/
│   └── .agent-ops/_memory/...     # App A's context
├── app-b/
│   └── .agent-ops/_memory/...     # App B's context
└── ~/Execs/                       # Shared agents
```

Each project has isolated memories.

---

## Example Workflow

```bash
# 1. Init project
cd ~/Projects/my-app
bash ~/Execs/scripts/init-project-memory.sh

# 2. Configure project
vim project-context.md
# Fill in: Tech stack, standards, critical rules

# 3. Plan feature
# In Claude: "@keisha create PRD for user authentication"

# 4. Keisha creates PRD → updates ops board → saves to her memories

# 5. Build feature
# In Claude: "@ox implement auth from PRD-001"

# 6. Ox codes → runs tests → updates ops board → saves to his memories

# 7. Validate
# In Claude: "@soulja validate auth feature"

# 8. Soulja tests → updates ops board → saves to his memories

# 9. Review
# In Claude: "@dmx review auth implementation"

# 10. DMX reviews → approves/blocks → updates ops board → saves to his memories
```

---

## Troubleshooting

**Agents not remembering?**
```bash
# Check structure exists
ls -la .agent-ops/_memory/

# Re-initialize if needed
bash ~/Execs/scripts/init-project-memory.sh
```

**Want to reset an agent's memory?**
```bash
# Clear specific agent
rm .agent-ops/_memory/keisha/memories.md
cp ~/Execs/templates/agent-memory-template.md .agent-ops/_memory/keisha/memories.md
sed -i '' 's/\[AGENT_NAME\]/keisha/g' .agent-ops/_memory/keisha/memories.md
```

**Git integration:**
```bash
# Option 1: Share memories with team
git add .agent-ops/
git commit -m "chore: update agent context"

# Option 2: Keep memories private
echo ".agent-ops/_memory/" >> .gitignore
```

---

## Full Documentation

- [PROJECT_SETUP.md](PROJECT_SETUP.md) - Detailed setup guide
- [team-fullstack.txt](team-fullstack.txt) - Complete agent doctrine
- [Execs/README.md](README.md) - Squad overview

---

**Template Version:** 1.0
**Last Updated:** 2026-01-15
