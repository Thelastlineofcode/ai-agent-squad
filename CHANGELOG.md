# Agent Memory System - Changelog

## [1.1.0] - 2026-01-15 - CONTRIBUTING.md Migration

### Changed
- **Project context file renamed**: `project-context.md` → `CONTRIBUTING.md`
  - More standard convention (aligns with open-source best practices)
  - Acts as both contributor guide and agent context
  - All 7 agents now reference `CONTRIBUTING.md` instead

### Updated Files
- `Execs/scripts/init-project-memory.sh` - Creates `CONTRIBUTING.md`
- `Execs/templates/contributing-template.md` (renamed from `project-context-template.md`)
- All agent YAMLs (`critical_actions` updated):
  - `agents/keisha.yaml`
  - `agents/ox.yaml`
  - `agents/soulja.yaml`
  - `agents/dmx.yaml`
  - `agents/igor.yaml`
  - `agents/masterp.yaml`
  - `agents/suge.yaml`
- Documentation:
  - `PROJECT_SETUP.md`
  - `QUICK_START.md`
  - `MEMORY_SYSTEM_SUMMARY.md`
  - `ARCHITECTURE.md`
  - `templates/agent-instructions-template.md`

### Migration Path
Existing projects using `project-context.md` will continue to work. To migrate:
```bash
cd your-project
mv project-context.md CONTRIBUTING.md
```

---

## [1.0.0] - 2026-01-15 - Initial Release

### Added
- Project-local memory system for all agents
- Initialization script: `scripts/init-project-memory.sh`
- Memory templates:
  - `agent-memory-template.md` - Session history format
  - `agent-instructions-template.md` - Agent protocols
  - `learnings-template.md` - Project insights structure
  - `ops-board-template.md` - Task tracking
  - `contributing-template.md` - Project standards (formerly project-context)
- Documentation:
  - `PROJECT_SETUP.md` - Complete setup guide
  - `QUICK_START.md` - Quick reference
  - `ARCHITECTURE.md` - System diagrams
  - `MEMORY_SYSTEM_SUMMARY.md` - Technical overview

### Changed
- All 7 agent YAMLs updated with memory loading in `critical_actions`
- `team-fullstack.txt` updated with memory protocols
- Agents now automatically load memories on session start

### Features
- ✅ Session persistence across agent invocations
- ✅ Multi-project support with isolated contexts
- ✅ Automatic memory loading (no manual management)
- ✅ Project-agnostic Execs folder
- ✅ Team-friendly (commit `.agent-ops/` to share context)
- ✅ Full audit trail in markdown files

---

## Version History

| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-01-15 | Migrated to CONTRIBUTING.md standard |
| 1.0.0 | 2026-01-15 | Initial memory system release |

---

**Maintained by:** Agent Builder Infrastructure
**Last Updated:** 2026-01-15
