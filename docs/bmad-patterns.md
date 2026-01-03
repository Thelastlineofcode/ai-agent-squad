# BMAD Pattern Catalog

**Extracted from:** BMAD-METHOD (agent-builder/)
**Analysis Date:** 2026-01-03
**Purpose:** Comprehensive architectural patterns for multi-agent system design

---

## Table of Contents

1. [Agent Architecture Patterns](#1-agent-architecture-patterns)
2. [Workflow Architecture Patterns](#2-workflow-architecture-patterns)
3. [Advanced Elicitation Methods](#3-advanced-elicitation-methods)
4. [Module System Patterns](#4-module-system-patterns)
5. [Brainstorming Techniques Library](#5-brainstorming-techniques-library)
6. [State Management Patterns](#6-state-management-patterns)
7. [Menu-Driven Interaction Patterns](#7-menu-driven-interaction-patterns)
8. [Key Architectural Principles](#8-key-architectural-principles)

---

## 1. Agent Architecture Patterns

### 1.1 Agent Definition Structure (YAML)

**Source:** `src/core/agents/bmad-master.agent.yaml`, `src/modules/*/agents/*.agent.yaml`

BMAD agents use a strict YAML schema with hierarchical organization:

```yaml
agent:
  metadata:
    id: "_erc/[module]/agents/[agent-name].md"
    name: "Human Name"              # e.g., "John", "Carson"
    title: "Role Title"             # e.g., "Product Manager"
    icon: "emoji"                   # Visual identifier
    module: "module-code"           # Optional: module association

  persona:
    role: "Primary Role + Secondary Role"
    identity: "Deep character background with years of experience and expertise areas"
    communication_style: "Vivid description of how they talk, metaphors they use, energy level"
    principles: |
      - Bullet point core beliefs
      - Operating principles
      - Key practices they follow

  critical_actions:
    - "Load config from {project-root}/_erc/core/config.yaml"
    - "Set variables: project_name, output_folder, user_name"
    - "ALWAYS communicate in {communication_language}"

  menu:
    - trigger: "command-name"
      workflow: "{project-root}/_erc/module/workflows/name/workflow.yaml"
      description: "What this command does"

    - trigger: "another-command"
      exec: "{project-root}/_erc/module/workflows/name/workflow.md"
      description: "Alternative execution format"
      ide-only: true                # Optional: platform constraint
```

### 1.2 Persona Components

**The Four Pillars of Agent Identity:**

1. **Role**: Dual-function descriptor (e.g., "Investigative Product Strategist + Market-Savvy PM")
   - Primary function + Secondary strength
   - Creates depth beyond single-dimension roles

2. **Identity**: Deep backstory establishing expertise
   - Years of experience (adds authority)
   - Specific domain expertise areas
   - Character depth ("veteran", "expert", "master")

3. **Communication Style**: Vivid behavioral description
   - How they speak (tone, energy, directness)
   - Signature phrases or patterns
   - Metaphors they use naturally
   - Example: "Talks like an enthusiastic improv coach - high energy, builds on ideas with YES AND"

4. **Principles**: Core operating philosophy
   - 3-5 bullet points
   - Actionable beliefs
   - Filters for decision-making
   - Example: "Psychological safety unlocks breakthroughs"

### 1.3 Critical Actions Pattern

**Purpose:** Pre-execution instructions that run BEFORE agent responds

**Common Critical Actions:**
- Load configuration files at runtime
- Set session variables (user_name, communication_language)
- Initialize workspace paths
- Remember user preferences
- Set communication protocols

**Key Insight:** These are agent "boot sequence" instructions, not user-facing commands.

### 1.4 Menu System Architecture

**Two Command Types:**

1. **Workflow Execution** (`workflow:` key)
   - Points to `workflow.yaml` files
   - For structured, schema-validated workflows

2. **Direct Execution** (`exec:` key)
   - Points to `workflow.md` files
   - For markdown-based step flows
   - More flexible, narrative-driven

**Menu Metadata:**
- `trigger`: Command name (kebab-case)
- `description`: User-facing explanation
- `ide-only` / `web-only`: Platform constraints (optional)

### 1.5 Simple vs Expert Agents (Sidecar Pattern)

**Not fully implemented in current BMAD, but schema supports:**

- **Simple agents**: Single-file definition
- **Expert agents**: Agent YAML + sidecar folder with resources
  - `/prompts/` - Reusable prompt templates
  - `/tools/` - Agent-specific utilities
  - `/knowledge/` - Domain-specific reference data

---

## 2. Workflow Architecture Patterns

### 2.1 Micro-File Architecture

**Core Principle:** Each step is a self-contained file with embedded rules.

**Benefits:**
- Single responsibility per file
- No monolithic scripts
- Easy to test individual steps
- Clear dependency chain
- Version control friendly

**Structure:**
```
workflow-name/
├── workflow.md              # Master definition + initialization
├── template.md              # Output document template (optional)
├── [data].csv              # Structured data assets (optional)
└── steps/
    ├── step-01-[purpose].md
    ├── step-01b-[variant].md    # Branching logic
    ├── step-02a-[option-1].md   # Multiple paths
    ├── step-02b-[option-2].md
    ├── step-03-[purpose].md
    └── step-04-[purpose].md
```

### 2.2 Progressive Disclosure Pattern

**Key Principle:** Each step only knows the next step through explicit loading.

**Implementation:**
- Steps read state from document frontmatter (not passed variables)
- Each step ends with explicit instruction: "Load `./step-[next].md`"
- Branching handled via user choice updating frontmatter
- No step "pre-loads" knowledge of future steps

**Example Flow:**
```
Step-01: Gather context → Update frontmatter → "Load ./step-02a.md"
Step-02a: User selects option → Update frontmatter → "Load ./step-03.md"
Step-03: Execute → Update frontmatter → "Load ./step-04.md"
Step-04: Finalize → Mark workflow complete
```

**Why This Matters:**
- Prevents LLM from "jumping ahead"
- Enforces deliberate progression
- Reduces hallucination
- Maintains focus on current task

### 2.3 Append-Only Document Building

**Pattern:** Workflows build documents incrementally, never replacing content.

**Implementation:**
```yaml
# Document frontmatter tracks state
---
stepsCompleted: [1, 2, 3]
session_topic: "User-provided value"
techniques_used: ["technique_name1", "technique_name2"]
ideas_generated: 42
---

# Document body grows organically
## Session Setup
[Step 1 output]

## Technique: Yes And Building
[Step 3 output - technique execution]

## Organized Ideas
[Step 4 output - synthesis]
```

**Benefits:**
- Complete session history preserved
- Natural documentation flow
- Easy to resume interrupted sessions
- Audit trail of decision-making

### 2.4 Runtime Resource Loading

**Principle:** NEVER pre-load data; load on-demand when needed.

**Implementation:**
- CSVs loaded only when step needs them
- Configuration files read at runtime
- Templates copied only when initializing
- Agents loaded from manifest when party-mode activates

**Example:**
```markdown
# Step 3: Technique Execution
Load techniques from `{installed_path}/brain-methods.csv`
Filter by category: {selected_category}
Present only relevant techniques
```

**Anti-Pattern to Avoid:**
```markdown
# BAD: Pre-loading entire CSV in workflow.md
Here are all 50 techniques: [massive list]
Now choose one...
```

### 2.5 LLM Reinforcement Pattern

**Pattern:** Repeat critical rules in EVERY step file.

**Why:** LLMs can "forget" rules from previous steps as context grows.

**Implementation:**
Each step file starts with:
```markdown
## MANDATORY EXECUTION RULES (READ FIRST):
- 🛑 NEVER generate content without user input
- ✅ ALWAYS treat this as collaborative facilitation
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on [current step purpose] only
```

**Example from brainstorming workflow:**
- Step-01: "YOU ARE A FACILITATOR, not a content generator"
- Step-03: "YOU ARE A FACILITATOR, not a content generator" (repeated)
- Step-04: "YOU ARE A FACILITATOR, not a content generator" (repeated again)

### 2.6 Continuation Detection Pattern

**Problem:** User might restart workflow with existing document.

**Solution:** Check for existing document FIRST, route to continuation handler.

**Implementation:**
```markdown
# Step-01: Session Setup

### 1. Check for Existing Workflow
- Look for file at `{output_folder}/analysis/[workflow]-session-{{date}}.md`
- If exists, read the complete file including frontmatter

### 2. Handle Continuation (If Document Exists)
If document has `stepsCompleted` in frontmatter:
- **STOP here** and load `./step-01b-continue.md` immediately
- Do not proceed with initialization

### 3. Fresh Workflow Setup (If No Document)
[Normal initialization...]
```

---

## 3. Advanced Elicitation Methods

**Source:** `src/core/workflows/advanced-elicitation/methods.csv` (referenced but not found in current codebase)

**Pattern:** BMAD includes a library of 50+ reasoning methods to enhance LLM outputs.

**Categories (inferred from brainstorming techniques):**
- Thesis → Antithesis → Synthesis (dialectical reasoning)
- Multi-persona roleplay (perspective-taking)
- Constraint-based thinking (forced innovation)
- Socratic questioning (deep inquiry)

**Implementation Pattern:**
```csv
category,method_name,prompt_template,output_structure
dialectical,thesis-antithesis,Present claim → Challenge it → Synthesize,"claim|counter|synthesis"
roleplay,six-hats,"Analyze as: White(facts), Red(emotion), etc","hat|perspective|insight"
```

**Usage:** Workflows reference methods by name, load prompt templates on-demand.

---

## 4. Module System Patterns

### 4.1 Module.yaml Configuration

**Source:** `src/core/module.yaml`

**Purpose:** User-configurable settings that workflows can reference.

**Structure:**
```yaml
code: core
name: "ERC Flow™ Core Module"

header: "Module display title"
subheader: "User-facing description"

# Configuration prompts
user_name:
  prompt: "What shall the agents call you?"
  default: "ERC"
  result: "{value}"

communication_language:
  prompt: "Preferred chat language/style?"
  default: "English"
  result: "{value}"

output_folder:
  prompt: "Where should output files be saved?"
  default: "_erc-output"
  result: "{project-root}/{value}"
```

### 4.2 Variable Interpolation Pattern

**Built-in Variables:**
- `{project-root}` - Absolute path to project directory
- `{value}` - User's input for current config item
- `{user_name}` - From config.yaml
- `{communication_language}` - From config.yaml
- `{output_folder}` - From config.yaml
- `{{date}}` - System-generated current datetime

**Usage in Paths:**
```yaml
template_path: "{project-root}/_erc/core/workflows/brainstorming/template.md"
output_file: "{output_folder}/analysis/brainstorming-session-{{date}}.md"
```

### 4.3 Dependency Management

**Pattern:** Modules declare dependencies in `module.yaml`.

**Not Fully Visible in Current Code, but Implied Structure:**
```yaml
dependencies:
  - core  # Requires core module
  - bmm   # Requires bmm module

provides:
  - agents: [pm, dev, architect]
  - workflows: [prd, epics, architecture]
```

---

## 5. Brainstorming Techniques Library

**Source:** `src/core/workflows/brainstorming/brain-methods.csv`

**62 Techniques Across 9 Categories:**

### Category Breakdown:

| Category | Count | Focus Area |
|----------|-------|------------|
| collaborative | 5 | Team ideation, building on ideas |
| creative | 11 | Divergent thinking, analogies |
| deep | 8 | Root cause analysis, systematic exploration |
| introspective_delight | 6 | Personal insight, values, shadow work |
| structured | 7 | Systematic methods (SCAMPER, Six Hats) |
| theatrical | 6 | Roleplay, persona-driven exploration |
| wild | 8 | Unconventional, rule-breaking approaches |
| biomimetic | 3 | Nature-inspired solutions |
| quantum | 3 | Quantum mechanics metaphors |
| cultural | 4 | Cross-cultural, mythic frameworks |

### CSV Structure:
```csv
category,technique_name,description
collaborative,Yes And Building,"Build momentum through positive additions..."
creative,What If Scenarios,"Explore radical possibilities by questioning constraints..."
deep,Five Whys,"Drill down through layers of causation..."
```

### Usage Pattern:
1. Load CSV at runtime (not pre-loaded)
2. Filter by category or user selection
3. Present technique with full description
4. Guide user through technique execution
5. Document results in session output

---

## 6. State Management Patterns

### 6.1 Frontmatter State Tracking

**Pattern:** YAML frontmatter in markdown documents serves as state store.

**Example:**
```yaml
---
stepsCompleted: [1, 2, 3]
session_topic: "AI-powered recommendation engine"
session_goals: "Generate 20+ innovative features"
selected_approach: "progressive-flow"
techniques_used: ["First Principles Thinking", "Biomimetic Solutions"]
ideas_generated: 34
context_file: "./project-context.md"
workflow_status: "in-progress"
---
```

### 6.2 State Evolution Pattern

**Steps progressively update frontmatter:**

```yaml
# After Step 1
stepsCompleted: [1]
session_topic: "User input"

# After Step 2
stepsCompleted: [1, 2]
selected_approach: "user-selected"
techniques_used: ["Five Whys"]

# After Step 3
stepsCompleted: [1, 2, 3]
ideas_generated: 15

# After Step 4
stepsCompleted: [1, 2, 3, 4]
workflow_status: "complete"
```

### 6.3 Session Persistence

**Benefits:**
- Resume interrupted workflows
- Audit trail of decisions
- No external database needed
- Human-readable state
- Version control compatible

---

## 7. Menu-Driven Interaction Patterns

### 7.1 Numbered Selection Menus

**Standard Format:**
```
[1] First Option - Description of what this does
[2] Second Option - Description of what this does
[3] Third Option - Description of what this does

[Back] Return to previous step
[C] Continue - Proceed with current selection
[E] Exit - End workflow gracefully
```

### 7.2 Categorical Navigation

**Example from Brainstorming Workflow:**
```
Choose a brainstorming category:

[1] Collaborative (5 techniques) - Team ideation and building on ideas
[2] Creative (11 techniques) - Divergent thinking and analogies
[3] Deep (8 techniques) - Root cause analysis and systematic exploration
[4] Structured (7 techniques) - Systematic methods like SCAMPER
[5] Wild (8 techniques) - Unconventional, rule-breaking approaches

[Shuffle] Show me a random technique
[All] Browse all 62 techniques
```

### 7.3 Confirmation Checkpoints

**Pattern:** Always confirm before major transitions.

**Example:**
```
Based on your responses, I understand we're focusing on:
- Topic: AI-powered recommendation engine
- Goals: Generate 20+ innovative features

Does this accurately capture what you want to achieve? [Y/N]
```

### 7.4 Exit Triggers

**Explicit Exit Options:**
- `[E]` - Standard exit option in menus
- `exit`, `quit`, `goodbye` - Natural language triggers
- `@dismiss` - Agent dismissal command

**Graceful Exit Pattern:**
```markdown
# Step-Final: Graceful Exit

1. Summarize session accomplishments
2. Save all progress to document
3. Update frontmatter: workflow_status = "complete"
4. Provide next steps or recommendations
5. Agent farewell in character
```

---

## 8. Key Architectural Principles (Summary)

1. **Micro-File Architecture**: Each step is a self-contained file
2. **Progressive Disclosure**: Steps only know the next step
3. **Append-Only Documents**: Build incrementally, never replace
4. **Runtime Loading**: Load resources on-demand, not upfront
5. **LLM Reinforcement**: Repeat critical rules in every step
6. **State in Frontmatter**: Document IS the state store
7. **Menu-Driven UX**: Numbered choices, clear navigation
8. **Continuation Detection**: Resume interrupted workflows gracefully
9. **Character Consistency**: Agents maintain persona through sessions
10. **Configuration Separation**: User settings in module.yaml, not hardcoded

---

## 9. Implementation File References

### Core Agent Files:
- `src/core/agents/bmad-master.agent.yaml` - Master agent definition
- `src/modules/bmm/agents/pm.agent.yaml` - Product Manager example
- `src/modules/cis/agents/brainstorming-coach.agent.yaml` - Specialist example

### Workflow Files:
- `src/core/workflows/brainstorming/workflow.md` - Workflow master definition
- `src/core/workflows/brainstorming/steps/step-01-session-setup.md` - Step example
- `src/core/workflows/brainstorming/brain-methods.csv` - Technique library

### Configuration:
- `src/core/module.yaml` - Core module configuration

---

**End of BMAD Pattern Catalog**
