# AI Agent Team: Architecture & Quick Reference
## For Engineers & Contributors

---

## What Is This?

This repository contains a **multi-agent AI system** for software development. Specialized agents work together in a sequential pipeline:

```
┌─────────────────────────────────────────────────────────────────┐
│                    DEVELOPMENT PIPELINE                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  @keisha (Planner)  →  @soulja (Preflight) → @ox (Executor) → @soulja (Validate) → @dmx (Reviewer) │
│       │                    │                     │                  │                  │ │
│       ▼                    ▼                     ▼                  ▼                  ▼ │
│   PRD + Tasks         TDD Gate              Tests + Code        Validation         Approval │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

Each agent is an **LLM system prompt** designed to specialize in one phase of the development lifecycle. Agents are stateless and can run on any LLM platform (Claude, GPT-4, Gemini, Perplexity).

Auto workflow: `Execs/docs/auto-workflow.md`  
Branding canon: `Execs/docs/branding.md`

---

## Architecture Overview

### Agent Responsibilities

| Agent | Domain | Input | Output |
|-------|--------|-------|--------|
| **Keisha** | Planning | Feature request | PRD + TASKLIST |
| **Ox (Executor)** | Implementation | PRD/TASKLIST | Code + Tests |
| **Soulja** | Preflight + Validation | PRD/Tasks + Code | Pass/Fail Report |
| **DMX** | Governance | Validation Report | Approval/Rejection |

### Design Principles

1. **Bounded Contexts (DDD)**: Each agent owns a distinct domain—no overlap
2. **Single Responsibility**: One agent, one job
3. **Tool Isolation**: No shared tools between agents (prevents blast radius)
4. **Sequential Handoffs**: Clear input/output contracts between stages
5. **Quality Gates**: Non-negotiable thresholds enforced at each stage
6. **Freshness Rule**: Always fetch current docs before decisions

### Tool Distribution (No Overlap)

```
┌──────────────┬────────────────────────────────────────────────┐
│ Agent        │ Exclusive Tools                                │
├──────────────┼────────────────────────────────────────────────┤
│ Keisha       │ radon, gitpython, ast, graphviz, pygments      │
│ Ox (Executor)│ rustc, cargo, tsc, esbuild, go, black, ruff    │
│ Soulja       │ pytest, vitest, bandit, trufflehog, cargo-audit│
│ DMX          │ difflib, git-diff, json-diff, deploy scripts   │
└──────────────┴────────────────────────────────────────────────┘
```

---

## @ Command Reference

### Planning Commands (@keisha)

| Command | Description |
|---------|-------------|
| `@keisha audit [repo]` | Analyze codebase for tech debt, complexity, coverage gaps |
| `@keisha create prd for [feature]` | Generate PRD with acceptance criteria |
| `@keisha plan [feature]` | Break feature into atomic tasks with estimates |
| `@keisha decide [A vs B]` | Architecture decision with trade-off analysis |

### Coding Commands (@ox)

| Command | Description |
|---------|-------------|
| `@ox build [feature]` | TDD in dev env, no mocks, failure + edge cases required |
| `@ox refactor [code]` | Improve code quality (complexity, clarity) |
| `@ox optimize [code]` | Performance optimization with benchmarks |
| `@ox fix [issue]` | Debug and fix with regression test |

### Testing Commands (@tester, @soulja)

| Command | Description |
|---------|-------------|
| `@tester validate [feature]` | Run full 5-layer validation |
| `@soulja preflight [feature]` | Stack/test command + guardrails gate |
| `@soulja run security scan` | Dependency + secret + code security scan |
| `@tester debug [error]` | Root cause analysis |
| `@soulja check coverage` | Coverage analysis and gaps |

### Review Commands (@dmx, @reviewer)

| Command | Description |
|---------|-------------|
| `@dmx review [code]` | Full architecture + quality review |
| `@reviewer approve` | Final approval for production |
| `@dmx check deployment` | Verify deployment readiness |

### Control Commands (All Agents)

| Command | Description |
|---------|-------------|
| `@dismiss` | Exit current agent, return to base LLM |
| `exit [agent]` | Exit specific agent |
| `switch to [agent]` | Change to different agent |

---

## Quality Standards

### Metrics Thresholds

| Metric | Target | Hard Limit | Enforced By |
|--------|--------|------------|-------------|
| Cyclomatic Complexity | < 8 avg | < 12 max | Keisha, DMX |
| Test Coverage | > 85% | > 95% critical | Soulja |
| Function Length | < 30 lines | < 50 max | Ox |
| Security Vulnerabilities | 0 critical | 0 high | Soulja |
| Response Time (P95) | < 1 sec | < 2 sec | Soulja |

### Security Standards (December 2025)

All agents enforce:
- ❌ No `dangerouslySetInnerHTML` (XSS)
- ❌ No hardcoded secrets
- ❌ No deprecated crypto (MD5, SHA1)
- ✅ Parameterized queries only
- ✅ Input validation on all user input
- ✅ CSP headers required
- ✅ Rate limiting on public APIs
- ✅ Dependency scanning
- ✅ Resilience testing (circuit breakers, graceful degradation)
- ✅ Penetration testing (fuzzing, auth bypass, IDOR)

### TDD Enforcement (No Mocks)
- Tests run in the dev environment (no mocks/stubs/fakes)
- Failure and edge cases are mandatory (happy-path-only is blocked)
- Dev environment must be green before any deployment validation

### Freshness Rule
- Agents must fetch current docs (MCPs or repo docs) before decisions
- If sources are unavailable, block and request confirmation

---

## Directory Structure

```
Execs/
├── README.md                        # Master entry point
├── AGENT_QUICKSTART.md              # Senior Engineer entry point
├── team-fullstack.txt               # Quick reference card
│
├── agents/                          # THE SQUAD
│   ├── Keisha/                      # Planner
│   ├── Ox/                          # Executor
│   ├── Soulja-Slim/                 # Validator
│   └── DMX/                         # Reviewer
│
├── docs/                            # THE LIBRARY
│   ├── orchestration.md             # Activation rules
│   ├── mcp-integration.md           # Guide
│   ├── quick-commands.md            # Command list
│   └── slash-commands.md            # Reference
│
├── .agent/                          # IDE Workflows
└── dev-tools/                       # Global scripts
```

---

## Deployment Options

| Platform | Method | Code Execution |
|----------|--------|----------------|
| **Antigravity** | Built-in | ✅ Native |
| **Claude Projects** | Add to Knowledge | ✅ Artifacts |
| **Claude Chat** | Paste prompt | ✅ Artifacts |
| **ChatGPT Custom GPT** | Instructions field | ✅ Code Interpreter |
| **ChatGPT Chat** | Paste prompt | ✅ Code Interpreter |
| **Gemini AI Studio** | System Instructions | ✅ Code Execution |
| **Perplexity Spaces** | Space Instructions | ⚠️ Limited |

---

## Contributing

### Adding a New Agent

1. Create folder: `Execs/[AgentName]/`
2. Create `[AgentName]_Space_Prompt.md` with:
   - Character identity and voice
   - Persistence rules
   - Core responsibilities
   - Exclusive tools (no overlap with existing agents)
   - Quality standards
   - Handoff protocols
3. Create `README.md` with setup instructions
4. Update `team-fullstack.txt` with new agent
5. Update this file's command reference

### Modifying an Agent

1. Edit the `*_Space_Prompt.md` file
2. Test in at least 2 platforms (Claude + one other)
3. Update README if commands changed
4. Document changes

### Adding Tools to an Agent

1. Check tool doesn't exist in another agent (no overlap rule)
2. Add to agent's "Exclusive Tools" section
3. Add usage examples
4. Update `team-fullstack.txt` tool distribution table

### Code Style for Prompts

- Use Markdown headers for sections
- Use tables for structured data
- Use code blocks for examples
- Include both DO and DON'T examples for critical rules
- End with character reinforcement statement

---

## Workflow Examples

### New Feature (Full Pipeline)

```
1. @keisha create prd for user authentication
   → Keisha asks clarifying questions
   → Keisha produces PRD + TASKLIST

2. @soulja preflight authentication
   → Soulja verifies stack/test command + guardrails
   → Blocks if TDD artifacts or dev env are missing

3. @ox build authentication following this PRD
   → Ox writes tests first (dev env, no mocks)
   → Ox implements feature
   → Ox provides evidence (coverage, complexity)

4. @soulja validate authentication implementation
   → Soulja runs 5-layer validation
   → Soulja produces Pass/Fail report

5. @dmx review for production
   → DMX reviews architecture, security, quality
   → DMX approves or blocks with specific feedback
```

### Refinement Workflow (Refine & Harden)

```
1. /improve
   → Keisha audits for bloat, complexity, and patterns
   → Keisha plans refinements (no new features)
   → Ox refactors and optimizes
   → Soulja validates stability and performance
   → DMX performs final review
```

### Codebase Organization

```
1. /organize
   → Keisha audits structure, naming, dead code
   → Keisha creates reorganization plan
   → Human approves changes
   → Ox executes moves and fixes imports
   → Soulja validates nothing broke
```

### Quick Fix

```
1. @soulja debug this error: [paste error]
   → Root cause analysis
   
2. @ox fix the issue identified by Soulja
   → Fix + regression test
   
3. @dmx quick review
   → Approval for hotfix
```

---

## FAQ

**Q: Why separate agents instead of one super-agent?**
A: Specialization improves quality. Each agent has focused expertise and doesn't drift into areas outside its domain.

**Q: Can I use agents in parallel?**
A: The pipeline is sequential by design (plan → code → test → review). However, you can run multiple features in parallel at different pipeline stages.

**Q: What if an agent gives wrong advice?**
A: Agents are advisory. The `@dismiss` command exits to base LLM. Final human judgment always applies.

**Q: How do I add custom quality standards?**
A: Edit the "Quality Standards" section in each agent's `*_Space_Prompt.md` file.

---

## References

- [InfoQ Architecture eMag Dec 2025](Architecture-Through-Different-Lenses-2025.pdf) - Holistic engineering principles
- [DEPOSITS Framework](#) - Design for failure, Observability first
- [Bounded Contexts (DDD)](#) - Domain separation principles
