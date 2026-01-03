# Claude Prompt: Advanced BMAD Pattern Extraction & Squad Integration

Use this prompt with a fresh Claude session, attaching the BMAD-METHOD folder and your team-fullstack.txt:

---

## PROMPT

You are a **multi-agent systems architect** specializing in AI orchestration frameworks. I'm providing you with two codebases:

1. **BMAD-METHOD** - A sophisticated open-source multi-agent framework with 21 agents, 50+ workflows, and a modular architecture (Core → Method → Builder)
2. **My agent squad** (`team-fullstack.txt`) - My custom 7-agent system with ERC Flow (Empathize → Realize → Conceptualize)

### Your Mission

Perform a **comprehensive architectural audit** of BMAD-METHOD and extract patterns that can be integrated into my squad. Specifically:

---

### Phase 1: Deep Pattern Extraction

Analyze these BMAD structural patterns:

1. **Agent Architecture**
   - Simple vs Expert agents (sidecar folders)
   - Persona structure (role/identity/communication_style/principles)
   - Critical actions (pre-execution instructions)
   - Menu-driven interaction patterns

2. **Workflow Architecture**
   - Micro-file architecture (step files)
   - Progressive disclosure (each step knows only the next)
   - Append-only document building
   - Runtime resource loading (never pre-load)
   - LLM reinforcement (rules repeated in each step)

3. **Advanced Elicitation Methods** (`src/core/workflows/advanced-elicitation/methods.csv`)
   - All 50+ reasoning methods categorized
   - Output patterns (e.g., `thesis → antithesis → synthesis`)
   - Multi-persona roleplay techniques

4. **Module System**
   - Module.yaml configuration
   - Dependency management
   - Config variable interpolation (`{project-root}`, `{value}`)

5. **Brainstorming Techniques** (`src/core/workflows/brainstorming/brain-methods.csv`)
   - Creative ideation patterns
   - Technique execution flow

---

### Phase 2: Gap Analysis

Compare BMAD patterns against my squad's current structure:

| My Squad | BMAD Equivalent | Gap |
|----------|-----------------|-----|
| Character persistence | Persona + critical_actions | ? |
| ERC Flow | 4-Phase methodology | ? |
| Tool distribution | Agent capabilities | ? |
| Workflow commands | Menu-driven interaction | ? |

Identify what my squad is MISSING that BMAD does well.

---

### Phase 3: Integration Recommendations

For each gap, provide:

1. **Pattern name** and BMAD source file reference
2. **Why it matters** for my squad
3. **Implementation approach** (what to add/modify)
4. **Priority** (P0 = critical, P1 = high, P2 = nice-to-have)

---

### Phase 4: Deliverables

Create these artifacts:

1. **`bmad-patterns.md`** - Comprehensive pattern catalog extracted from BMAD
2. **`squad-upgrades.md`** - Specific changes to team-fullstack.txt
3. **`new-workflows/`** - 3-5 new workflows adapted from BMAD for my squad
4. **`integration-checklist.md`** - Step-by-step migration plan

---

### Constraints

- Preserve my squad's unique identity (Suge, Keisha, Ox, Soulja, DMX, Igor, Master P)
- Maintain compatibility with ERC Flow
- Focus on patterns, not copy-paste (adapt, don't clone)


---

### Files to Focus On

**BMAD Core Patterns:**
- `src/core/module.yaml`
- `src/core/agents/bmad-master.agent.yaml`
- `src/core/workflows/advanced-elicitation/methods.csv`
- `src/core/workflows/advanced-elicitation/workflow.xml`
- `src/core/workflows/brainstorming/workflow.md`
- `src/core/workflows/brainstorming/steps/*.md`
- `src/core/tasks/workflow.xml`

**BMAD Documentation:**
- `docs/bmad-core-concepts/agents.md`
- `docs/bmad-core-concepts/workflows.md`
- `docs/bmad-core-concepts/modules.md`

**My Squad:**
- `Execs/team-fullstack.txt` (source of truth)
- `.agent/workflows/*.md` (existing workflows)

---

Begin with Phase 1 and work systematically through each phase. Ask clarifying questions before proceeding if the scope is ambiguous.
