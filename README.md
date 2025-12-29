# The Streets Never Gave Us Nothing: It’s Time the Streets Gave Back 🧱
## Keisha + Soulja Slim + Ox (Executor) + DMX

Master entry point for the AI-augmented development team. This repository defines a 4-stage pipeline for automated, production-ready software development.

---

## 🏗️ Repository Architecture

Following Bounded Context (DDD) principles, this codebase is organized into three distinct tiers:

### 1. `/agents/` — The Core Squad
Contains the system prompts, kernel configurations, and exclusive toolsets for each specialized agent.
- `agents/Keisha/` — Planner & Analyst (Architecture, PRDs, Audits)
- `agents/Ox/` — Executor (TDD, Implementation, Scalability)
- `agents/Soulja-Slim/` — Validator (5-Layer Testing, Security, Debugging)
- `agents/DMX/` — Enforcer (Code Review, Governance, Deployment)

### 2. `/docs/` — The Library
Comprehensive guides and reference materials for human and AI collaborators.
- `docs/orchestration.md` — The @Activation system protocol.
- `docs/agent-ops-board.md` — Live status dashboard.
- `docs/agent-learnings.md` — Consolidated knowledge.
- `docs/session-summaries/` — End-of-session handoffs.
- `docs/audits/` — Audit templates, classifications, and reports.
- `docs/limiters.md` — Tech debt and bloat gates.
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
@keisha (Plan) → @soulja (Preflight) → @ox (Tests + Code) → @soulja (Validate) → @dmx (Approve)
```

1. **Plan**: `@keisha create prd for [feature]`
2. **Preflight**: `@soulja preflight [feature]` (stack/test cmd/guardrails)
3. **Build**: `@ox build [feature] with tests first (dev env)`
4. **Test**: `@soulja validate [feature]`
5. **Merge**: `@dmx review and approve for production`

Auto mode: drop a PRD into `tasks/` and run the pipeline from `Execs/docs/auto-workflow.md`.

---

## 🛡️ Dec 2025 Engineering Standards
- **Zero Tool Overlap**: Exclusive kernels per agent for maximum isolation.
- **TDD First**: Tests before code, no mocks, dev env only.
- **85% Coverage Floor**: Non-negotiable quality gate.
- **Security-in-Depth**: Integrated scanning (Secret detection, AST analysis, Dep audit).
- **Freshness Rule**: Always fetch up-to-date docs before decisions.
- **Simplicity over "Cirque du Soleil Coding"**: We build for 10x scalability, not 10x complexity.

Brand guardrails live in `Execs/docs/branding.md`.
Audit templates live in `Execs/docs/audits/`.

---

**Welcome to your AI-augmented development team. Plan with precision. Build with confidence.**
