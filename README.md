# The Streets Never Gave Us Nothing: It’s Time the Streets Gave Back 🧱
## Keisha + Ox + Soulja Slim + DMX

Master entry point for the AI-augmented development team. This repository defines a 4-stage pipeline for automated, production-ready software development.

---

## 🏗️ Repository Architecture

Following Bounded Context (DDD) principles, this codebase is organized into three distinct tiers:

### 1. `/agents/` — The Core Squad
Contains the system prompts, kernel configurations, and exclusive toolsets for each specialized agent.
- `agents/Keisha/` — Planner & Analyst (Architecture, PRDs, Audits)
- `agents/Ox/` — Master Coder (TDD, Implementation, Scalability)
- `agents/Soulja-Slim/` — Validator (5-Layer Testing, Security, Debugging)
- `agents/DMX/` — Enforcer (Code Review, Governance, Deployment)

### 2. `/docs/` — The Library
Comprehensive guides and reference materials for human and AI collaborators.
- `docs/orchestration.md` — The @Activation system protocol.
- `docs/agent-ops-board.md` — Live status dashboard.
- `docs/agent-learnings.md` — Consolidated knowledge.
- `docs/mcp/` — MCP tool setup and agent distribution.
- `docs/slash-commands.md` — Reference for IDE-level automation.

### 3. `.agent/` — IDE Automation
Slash command workflows (`/new-feature`, `/code-review`, etc.) for seamless IDE integration.

---

## 🚀 Getting Started

### 1. Senior Engineer Entry Point
Read **[AGENT_QUICKSTART.md](file:///Users/houseofobi/Documents/Agent%20Builder/Execs/AGENT_QUICKSTART.md)** for a technical deep dive into the architecture, quality gates, and contribution guidelines.

### 2. Deploying Agents
Each agent has a platform-agnostic setup guide. Navigate to `agents/[AgentName]/README.md` to deploy to:
- Antigravity (Local IDE)
- Claude Projects / Chat
- ChatGPT Custom GPTs
- Gemini AI Studio
- Perplexity Spaces

### 3. Master Reference
Use **[team-fullstack.txt](file:///Users/houseofobi/Documents/Agent%20Builder/Execs/team-fullstack.txt)** as your day-to-day command card.

---

## 🛠️ The Workflow Pipeline

```
@keisha (Plan) → @ox (Code) → @soulja (Validate) → @dmx (Approve)
```

1. **Plan**: `@keisha create prd for [feature]`
2. **Build**: `@ox build [feature] with tests first`
3. **Test**: `@soulja validate [feature]`
4. **Merge**: `@dmx review and approve for production`

---

## 🛡️ Dec 2025 Engineering Standards
- **Zero Tool Overlap**: Exclusive kernels per agent for maximum isolation.
- **TDD First**: Implementation follows tests.
- **85% Coverage Floor**: Non-negotiable quality gate.
- **Security-in-Depth**: Integrated scanning (Secret detection, AST analysis, Dep audit).
- **Simplicity over "Cirque du Soleil Coding"**: We build for 10x scalability, not 10x complexity.

---

**Welcome to your AI-augmented development team. Plan with precision. Build with confidence.**
