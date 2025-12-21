# KEISHA QUICK-START GUIDE
## For Travone: Integrate into Your Agent Team Today

---

## TL;DR: What You Have Now

1. **Keisha_Planner_System.md** — Full personality, workflows, and guardrails
2. **Keisha_Prompts_Schemas.md** — System prompt + JSON schemas ready to deploy
3. This guide — How to use Keisha TODAY with your current tooling

---

## IMMEDIATE ACTION (Next 30 Minutes)

### Step 1: Copy the System Prompt into Your LLM

You're already using Gemini, Claude, and Perplexity. Use **Keisha's system prompt** with Claude 3.5 Sonnet or Gemini-2.0 Flash (reasoning-heavy models handle analysis best).

**Option A: Perplexity (since you use it for research)**

1. Create a custom space called "Keisha Planner"
2. Paste the Keisha system prompt at the top of a document
3. Reference it in each query: "@Keisha [your request]"
4. Keisha outputs intelligence; you format as JSON

**Option B: Claude (via API or Claude.ai)**

```python
# Your own script (or use in your existing agent setup)
from anthropic import Anthropic

client = Anthropic()

keisha_system = """You are KEISHA, a CIA-grade intelligence analyst..."""  # Full prompt from Keisha_Prompts_Schemas.md

def ask_keisha(request, codebase_context=""):
    response = client.messages.create(
        model="claude-3-5-sonnet-20241022",
        max_tokens=4096,
        system=keisha_system,
        messages=[
            {"role": "user", "content": f"{request}\n\n{codebase_context}"}
        ]
    )
    return response.content[0].text

# Example
audit = ask_keisha(
    "Audit the Levite codebase for complexity and tech debt",
    codebase_context="Repository: House of Obi (Neo4j + Rust microservices)"
)
print(audit)
```

**Option C: Gemini (since you like it for development)**

```typescript
import { GoogleGenerativeAI } from "@google/generative-ai";

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
const keishaSystem = `You are KEISHA...`; // Full prompt

async function askKeisha(request: string) {
  const model = genAI.getGenerativeModel({
    model: "gemini-2.0-flash",
    systemInstruction: keishaSystem
  });
  
  const result = await model.generateContent(request);
  return result.response.text();
}

// Usage
const audit = await askKeisha(
  "Audit Levite synastry module for coupling and tech debt"
);
```

---

## STEP 2: Run Your First Keisha Audit (Today)

Pick ONE repo (recommend: Levite, since you're actively building it). Ask Keisha:

```
Repository: Levite (Rust synastry engine, Neo4j backend)

Please audit this codebase for:
1. Cyclomatic complexity hot-spots
2. Technical debt (coupling, unused exports, test coverage gaps)
3. Architecture risks (tight coupling between business logic + Neo4j queries)
4. Surface area bloat (public API you don't need)

Provide metrics:
- Average cyclomatic complexity (target < 8)
- Test coverage by module (target > 85%)
- Technical debt ratio (target < 10%)
- Coupling index (target < 0.4)

Format output as JSON matching the Keisha Code Quality Assessment schema.
Then give me a ranked list of top 5 refactoring priorities by ROI.
```

**Keisha returns:**
```json
{
  "request_id": "keisha-audit-levite-2025-12-20-001",
  "metrics": {
    "cyclomatic_complexity": {
      "average": 9.2,
      "maximum": 24,
      "target": 8,
      "status": "YELLOW"
    },
    ...
  },
  "hot_spots": [
    {
      "location": "src/synastry/aspect_calculator.rs:45-120",
      "issue": "High complexity (24), tight Neo4j coupling",
      "risk_level": "HIGH",
      "recommendation": "Extract repository pattern; decouple business logic from queries",
      "estimated_effort": "2-3 days"
    },
    ...
  ],
  "refactoring_roadmap": [
    {
      "priority": 1,
      "target": "AspectCalculator: decouple Neo4j queries",
      "impact": "HIGH (unblocks testing, parallelizes future work)",
      "effort": "2-3 days",
      "roi": "HIGH"
    },
    ...
  ]
}
```

---

## STEP 3: Use Keisha to Plan a Feature (Week 1)

Next time you want to build something (e.g., "synastry+ with multi-birth analysis"):

```
Keisha, plan the synastry+ feature.

Context:
- Current Levite codebase has 18% tech debt (AspectCalculator is messy)
- We want to add multi-birth analysis (compare 3+ charts simultaneously)
- Team capacity: 2 sprints max
- Constraint: No breaking API changes

Please produce:
1. PRD with objective, success criteria, dependencies
2. TASKLIST with atomic tasks, dependencies, and effort estimates
3. Refactoring prerequisite (should we clean up AspectCalculator first?)
4. Risk assessment and mitigations

Format as JSON matching the Keisha PRD and TASKLIST schemas.
```

**Output: A bulletproof plan ready for Ox to execute.**

---

## STEP 4: Integrate into Your MCP / Agent Orchestrator (Week 2)

Once you see value from Keisha, formalize her in your agent framework.

### If you use CrewAI or AutoGen:

```python
from crewai import Agent, Tool
from crewai_tools import CodeAnalysisTool, GitTool

keisha_agent = Agent(
    role="CIA-Grade Planner",
    goal="Audit codebases, plan features, enforce clean architecture",
    backstory=open('Keisha_Planner_System.md').read(),
    model="claude-3-5-sonnet",
    tools=[
        CodeAnalysisTool(),
        GitTool(),
        # Custom tools for complexity analysis, coverage reports, etc.
    ],
    verbose=True
)

# Now coordinate Keisha → Ox → Tester → Reviewer
```

### If you use Google Cloud Agent Dev Kit (ADK) for Novella:

```go
// agents/keisha.go
package agents

import (
  "cloud.google.com/go/vertexai/genai"
)

func NewKeishaAgent(client *genai.Client) *genai.Agent {
  systemPrompt := `You are KEISHA...` // Full prompt
  
  return &genai.Agent{
    DisplayName: "Keisha Planner",
    Model: "gemini-2.0-flash",
    SystemPrompt: systemPrompt,
    Tools: []string{
      "ReadCodeTool",
      "GitAnalysisTool",
      "MetricsTool",
    },
  }
}

// In your orchestrator:
// keisha.Plan(request) → JSON output → Ox.Implement(output)
```

---

## STEP 5: Wire Keisha to Your Codebase Tools

Keisha is most powerful when she can SEE your actual code. Give her:

1. **File System Access**
   ```python
   keisha.add_tool("read_file", lambda path: open(path).read())
   keisha.add_tool("list_files", lambda path: os.listdir(path))
   ```

2. **Git Analysis**
   ```python
   keisha.add_tool("git_log", lambda repo: subprocess.run(["git", "log", "--oneline"], cwd=repo))
   keisha.add_tool("git_blame", lambda repo, file: blame_analysis(repo, file))
   ```

3. **Code Metrics**
   ```python
   # For Rust
   keisha.add_tool("run_clippy", lambda repo: clippy_metrics(repo))
   keisha.add_tool("code_coverage", lambda repo: coverage_report(repo))
   
   # For TypeScript
   keisha.add_tool("eslint", lambda repo: eslint_report(repo))
   keisha.add_tool("coverage", lambda repo: nyc_report(repo))
   ```

4. **Dependency Analysis**
   ```python
   keisha.add_tool("list_dependencies", lambda repo: parse_manifest(repo))
   keisha.add_tool("import_graph", lambda repo: build_import_graph(repo))
   ```

---

## EXAMPLE: Keisha Audit of Levite (Right Now)

**You ask Keisha:**

```
@keisha audit --repo=/path/to/levite --scope=full_codebase

Provide:
1. Metrics (complexity, coverage, debt, coupling)
2. Top 5 hot-spots (ranked by risk × effort)
3. A 2-sprint refactoring roadmap to get under 10% tech debt
4. Open questions for Ox (the implementer)

Format as JSON.
```

**Keisha responds:**

```json
{
  "request_id": "keisha-audit-levite-2025-12-20-001",
  "timestamp": "2025-12-20T15:30:00Z",
  "executive_summary": "Levite is YELLOW: healthy core logic but messy in synastry module. 18% tech debt concentrated in AspectCalculator and TransitEngine. Refactoring will unblock testing and future features. 2-sprint investment recommended.",
  "metrics": {
    "cyclomatic_complexity": {
      "average": 9.2,
      "maximum": 24,
      "target": 8,
      "status": "YELLOW"
    },
    "test_coverage_percent": {
      "overall": 72,
      "critical_paths": 68,
      "target": 85,
      "status": "RED"
    },
    "technical_debt_ratio_percent": {
      "current": 18,
      "target": 10,
      "status": "YELLOW"
    },
    "code_duplication_percent": {
      "current": 5.2,
      "target": 5,
      "status": "YELLOW"
    },
    "coupling_index": {
      "current": 0.43,
      "target": 0.4,
      "status": "YELLOW"
    }
  },
  "hot_spots": [
    {
      "location": "src/synastry/aspect_calculator.rs:45-120",
      "issue_type": "complexity",
      "description": "AspectCalculator has cyclomatic complexity of 24; 8 nested conditionals; tightly coupled to Neo4j graph queries. Hard to test in isolation.",
      "risk_level": "high",
      "recommendation": "Extract repository pattern; move Neo4j queries to separate layer; refactor logic into pure functions.",
      "estimated_effort_to_fix": "2-3 days"
    },
    {
      "location": "src/synastry/transit_engine.rs:80-150",
      "issue_type": "complexity",
      "description": "TransitEngine loop has 21-line nested conditionals; hard to extend for new aspect types.",
      "risk_level": "high",
      "recommendation": "Convert to state machine or decision table pattern.",
      "estimated_effort_to_fix": "1-2 days"
    },
    {
      "location": "src/lib.rs",
      "issue_type": "coupling",
      "description": "Synastry module publicly exports internal functions that shouldn't be part of public API.",
      "risk_level": "medium",
      "recommendation": "Audit public exports; make internal functions private.",
      "estimated_effort_to_fix": "4 hours"
    },
    {
      "location": "src/synastry/",
      "issue_type": "coverage",
      "description": "62% test coverage in critical synastry module; missing isolation tests (all tests depend on Neo4j).",
      "risk_level": "high",
      "recommendation": "Add unit test stubs for AspectCalculator and TransitEngine; mock Neo4j.",
      "estimated_effort_to_fix": "2-3 days"
    },
    {
      "location": "src/synastry/aspect_calculator.rs",
      "issue_type": "duplication",
      "description": "Aspect calculation logic repeated in 3 places; should be consolidated.",
      "risk_level": "medium",
      "recommendation": "Extract common logic into single source of truth.",
      "estimated_effort_to_fix": "1 day"
    }
  ],
  "refactoring_roadmap": [
    {
      "priority": 1,
      "target": "Repository pattern for Neo4j abstraction",
      "impact": "HIGH: enables unit testing, decouples business logic",
      "effort": "2-3 days",
      "roi": "HIGH"
    },
    {
      "priority": 2,
      "target": "AspectCalculator pure logic extraction",
      "impact": "HIGH: reduces complexity, improves testability",
      "effort": "2-3 days",
      "roi": "HIGH"
    },
    {
      "priority": 3,
      "target": "Unit test isolation suite",
      "impact": "MEDIUM: safety net for refactoring, confidence for future work",
      "effort": "2-3 days",
      "roi": "MEDIUM"
    },
    {
      "priority": 4,
      "target": "TransitEngine state machine refactor",
      "impact": "MEDIUM: easier to extend, lower complexity",
      "effort": "1-2 days",
      "roi": "MEDIUM"
    },
    {
      "priority": 5,
      "target": "Public API cleanup (unused exports)",
      "impact": "LOW: reduces cognitive load",
      "effort": "4 hours",
      "roi": "LOW"
    }
  ],
  "suggested_sprint_allocation": "Sprint 1: Tasks 1-2 (foundation). Sprint 2: Tasks 3-4 (isolation + simplification). Task 5 can be a 'polish' during Sprint 2 if time allows.",
  "assumptions": [
    "Existing integration tests exercise all critical synastry paths",
    "No hidden dependencies on AspectCalculator internals outside synastry module",
    "Team comfortable with Rust trait-based abstraction and mocking patterns"
  ],
  "open_questions": [
    "Should we add async support for Neo4j queries during refactor? (affects effort estimate)",
    "Is there an acceptable performance regression during transition? (benchmarking required)",
    "Can we gate this behind a feature flag, or do we need full cutover?",
    "Who validates the Neo4j repository abstraction contract?"
  ],
  "follow_up": "Once Sprint 1 complete, re-run metrics to validate debt reduction. Then Ox can confidently add synastry+ features on top of clean foundation."
}
```

---

## RIGHT NOW: Start Here

1. **Pick the quick integration you like best** (Perplexity, Claude API, or Gemini)
2. **Paste in Keisha's system prompt**
3. **Ask Keisha to audit Levite** using the example query above
4. **Review the output**; store as JSON
5. **Share with Ox** (your implementer agent) so he knows what to refactor first

---

## WHAT THIS UNLOCKS

Once Keisha is in your workflow:

✅ **No more guessing** about code quality — metrics-driven decisions  
✅ **Refactoring with confidence** — Keisha tells you ROI before you start  
✅ **Unblock new features** — Clean foundation first, then ship  
✅ **Prevent tech debt accumulation** — Catch it early, plan it out  
✅ **Parallel agent work** — Keisha plans, Ox builds, Tester validates, Reviewer approves  

---

## NEXT: Advanced Integration (Week 2+)

Once you see the value:

1. **Automate Keisha's reports** — Run audits weekly/per-PR
2. **Dashboard her metrics** — Track complexity, coverage, debt over time
3. **CI/CD gates** — Block PRs if complexity or debt exceeds thresholds
4. **Pair with Ox** — Keisha plans the refactor, Ox implements, Tester validates
5. **Document architectural decisions** — Keisha's decision tables become your architecture RFC

---

## QUESTIONS FOR YOU

**Answer these, and I can fine-tune Keisha further:**

1. Do you want Keisha integrated into your MCP setup (for Claude for Desktop)?
2. Should she output to GitHub issues/PRs, or just JSON?
3. What's your primary LLM for agents? (Gemini, Claude, or mix?)
4. Do you want her to auto-suggest refactoring PRs, or just analysis?
5. Should she also audit Novella and Jouvae, or start with Levite only?

---

**You're ready. Deploy Keisha today. Build cleaner code tomorrow.**
