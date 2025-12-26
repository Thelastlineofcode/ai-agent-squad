# AI Agent Squad - White Label

This is a **white-label** AI agent squad framework. Clone it, customize it, ship it.

---

## Quick Start

```bash
# 1. Clone into your project
git clone <this-repo> ./agents

# 2. Create your project overlay
cp project-overlay.template.txt project-overlay.txt

# 3. Customize team-fullstack.txt for your stack
```

---

## Structure

| Path | Purpose | Customize? |
|------|---------|------------|
| `team-fullstack.txt` | Master agent reference | ✅ Add project tools |
| `agents/` | Agent system prompts (markdown) | ⚠️ Extend, don't modify |
| `config/agents/` | Agent YAMLs with state + MCPs | ✅ Add project MCPs |
| `.agent/workflows/` | Slash command workflows | ✅ Add project workflows |
| `docs/` | Generic documentation | ✅ Add project docs |

---

## Agent Capabilities

All agents include:

### 🔧 Troubleshooting Principles
- Environment checks, error reading, systematic debugging
- Role-specific guidance (build issues, test failures, review feedback)

### 🛠️ MCP Tool Arsenal
| Category | Tools |
|----------|-------|
| Core Analysis | semgrep, code-analysis, rust-analyzer, clippy, eslint |
| Metrics | cargo-tarpaulin, c8, radon |
| Git Intelligence | git-analysis, git-history |
| Architecture | cargo-tree, depcruise, database-query |
| Security | owasp-check, cargo-audit, trufflehog |

### 📚 Documentation Fork & Learning
- `docs-fork` - Access official docs (Rust, Leptos, Axum, etc.)
- `youtube-mcp` - Tech stack tutorials and innovation videos
- `web-search` - Research latest patterns
- `changelog-watch` - Track dependency updates
- `github-trending` - Trending repos for inspiration

---

## Feature Development Lifecycle

The squad follows a **Plan → Build → Verify → Approve** cycle:

1. **PLAN** (@keisha) - Discovery, PRD, and Task Breakdown
2. **ARCHITECT** (@keisha) - Technical Design and Trade-offs
3. **BUILD** (@ox) - TDD, Implementation, and Coverage
4. **VERIFY** (@soulja) - Pre-flight checks and 7-layer validation
5. **APPROVE** (@dmx) - Code Review and Release Authorization

Strict phase gates ensure quality at every step.

---

## Agents

| Agent | Role | Trigger | Specialty |
|-------|------|---------|-----------|
| **Keisha** | Planner & Analyst | `@keisha` | Audits, PRDs, architecture |
| **Ox** | Master Coder | `@ox` | Implementation, TDD, Rust/TS |
| **Soulja Slim** | Validator | `@soulja` | 7-layer validation |
| **DMX** | Enforcer | `@dmx` | Code review, final approval |

---



---

## Project-Specific Files (NOT in this repo)

Create these in your **target project**, not here:

- `docs/agent-ops-board.md` - Sprint/task tracking
- `docs/agent-learnings.md` - Project lessons learned  
- `project-overlay.txt` - Your tool additions & customizations

---

## Syncing Updates

To pull generic updates from this white-label into your project:

```bash
cd your-project/agents
git remote add upstream <white-label-url>
git fetch upstream
git merge upstream/main --no-commit
# Review changes, keep your customizations
```

---

See `team-fullstack.txt` for full details.
