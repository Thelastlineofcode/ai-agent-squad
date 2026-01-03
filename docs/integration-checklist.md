# BMAD Integration Checklist

**Project:** Agent Squad Enhancement
**Goal:** Integrate BMAD patterns while preserving squad identity
**Timeline:** 3 weeks
**Status:** Not Started

---

## Pre-Flight Checks

- [ ] **Backup current system**
  ```bash
  cd /Users/houseofobi/Documents/Agent\ Builder/Execs
  git add . && git commit -m "Backup before BMAD integration"
  git tag pre-bmad-integration
  ```

- [ ] **Create new branch for integration work**
  ```bash
  git checkout -b feature/bmad-integration
  ```

- [ ] **Document current workflow token costs** (baseline for comparison)
  - [ ] Run `/new-feature` and measure tokens per step
  - [ ] Run `/code-review` and measure tokens per step
  - [ ] Record in `.agent-ops/AGENT_LEARNINGS.md`

---

## Week 1: Foundation (P0 - Critical)

### Day 1: Setup Agent Infrastructure

- [ ] **Create agents directory**
  ```bash
  mkdir -p Execs/agents
  ```

- [ ] **Create first agent YAML (Keisha as prototype)**
  - [ ] Create `Execs/agents/keisha.yaml`
  - [ ] Copy persona from team-fullstack.txt lines 22-26
  - [ ] Add metadata (name, title, role, trigger)
  - [ ] Add critical_actions (load team-fullstack.txt, load MCPs)
  - [ ] Add menu (create-prd, audit)
  - [ ] Test: `@keisha` trigger still works

- [ ] **Validate Keisha YAML works correctly**
  - [ ] Agent responds in character
  - [ ] Critical actions execute before response
  - [ ] Menu commands are accessible

### Day 2: Complete Agent YAML Definitions

- [ ] **Create remaining agent YAMLs**
  - [ ] `Execs/agents/suge.yaml` (lines 16-20)
  - [ ] `Execs/agents/ox.yaml` (lines 28-32)
  - [ ] `Execs/agents/soulja.yaml` (lines 34-38)
  - [ ] `Execs/agents/dmx.yaml` (lines 40-44)
  - [ ] `Execs/agents/igor.yaml` (lines 46-51)
  - [ ] `Execs/agents/masterp.yaml` (lines 53-57)

- [ ] **Update team-fullstack.txt**
  - [ ] Add section at top: "Agent definitions in `Execs/agents/*.yaml`"
  - [ ] Keep prose descriptions (they're valuable context)
  - [ ] Add references to YAML files

- [ ] **Test all agent triggers**
  - [ ] `@suge` - responds with executive voice
  - [ ] `@keisha` - responds with strategic voice
  - [ ] `@ox` - responds with technical voice
  - [ ] `@soulja` - responds with validation voice
  - [ ] `@dmx` - responds with enforcer voice
  - [ ] `@igor` - responds with security/architect voice
  - [ ] `@masterp` - responds with design voice

### Day 3: Refactor First Workflow (/new-feature)

- [ ] **Create workflow directory structure**
  ```bash
  mkdir -p Execs/.agent/workflows/new-feature/steps
  mkdir -p Execs/.agent/workflows/new-feature/templates
  ```

- [ ] **Create template**
  - [ ] `Execs/.agent/workflows/new-feature/templates/prd-template.md`
  - [ ] Add YAML frontmatter with all state fields
  - [ ] Add sections for each agent to fill

- [ ] **Create workflow.md (master)**
  - [ ] Move description from current new-feature.md
  - [ ] Add initialization section
  - [ ] Add "Load step-01" instruction

- [ ] **Create step files**
  - [ ] `steps/step-01-keisha-planning.md`
    - [ ] Add "MANDATORY EXECUTION RULES" header
    - [ ] Add continuation detection logic
    - [ ] Add frontmatter initialization
    - [ ] Add "Load step-02" at end

  - [ ] `steps/step-01b-continue-planning.md`
    - [ ] Read existing document frontmatter
    - [ ] Show current status
    - [ ] Offer resume/review/restart options

  - [ ] `steps/step-02-ox-implementation.md`
    - [ ] Add "MANDATORY EXECUTION RULES" header
    - [ ] Add frontmatter update
    - [ ] Add "Load step-03" at end

  - [ ] `steps/step-03-soulja-validation.md`
    - [ ] Add "MANDATORY EXECUTION RULES" header
    - [ ] Add frontmatter update
    - [ ] Add "Load step-04" at end

  - [ ] `steps/step-04-dmx-review.md`
    - [ ] Add "MANDATORY EXECUTION RULES" header
    - [ ] Add final frontmatter update (status: complete)
    - [ ] Add workflow completion summary

### Day 4: Test & Refine First Workflow

- [ ] **Test complete workflow execution**
  - [ ] Run `/new-feature` for a small test feature
  - [ ] Verify step-01 (Keisha planning) works
  - [ ] Verify step-02 (Ox implementation) works
  - [ ] Verify step-03 (Soulja validation) works
  - [ ] Verify step-04 (DMX review) works

- [ ] **Test continuation detection**
  - [ ] Start workflow, complete step-01
  - [ ] Exit session
  - [ ] Re-run `/new-feature`
  - [ ] Verify step-01b detects existing work
  - [ ] Verify resume from step-02 works

- [ ] **Measure token usage**
  - [ ] Record tokens per step
  - [ ] Compare to baseline (should be <20% overhead)
  - [ ] Document in `.agent-ops/AGENT_LEARNINGS.md`

- [ ] **Fix any issues found**

### Day 5: Add Frontmatter State Tracking

- [ ] **Create output directory**
  ```bash
  mkdir -p Execs/_squad-output/features
  mkdir -p Execs/_squad-output/reviews
  ```

- [ ] **Update step-01 files to create documents**
  - [ ] Copy template to `_squad-output/features/{feature-name}-prd.md`
  - [ ] Initialize frontmatter with workflow metadata
  - [ ] Verify document created correctly

- [ ] **Update all step files to update frontmatter**
  - [ ] After step-01: `stepsCompleted: [1]`
  - [ ] After step-02: `stepsCompleted: [1, 2]`, `agents_involved: ["keisha", "ox"]`
  - [ ] After step-03: `stepsCompleted: [1, 2, 3]`, `tests_passed: true/false`
  - [ ] After step-04: `stepsCompleted: [1, 2, 3, 4]`, `status: "complete"`

- [ ] **Test state persistence**
  - [ ] Run workflow through step-02
  - [ ] Read document file
  - [ ] Verify frontmatter shows correct state
  - [ ] Resume workflow
  - [ ] Verify step-03 reads state correctly

---

## Week 2: Enhancement (P1 - High Value)

### Day 1: Add Menu-Driven Navigation

- [ ] **Update new-feature workflow steps with menus**
  - [ ] Step-01: Add options menu for PRD approach
  - [ ] Step-02: Add options menu for implementation approach
  - [ ] Step-03: Add options menu for validation layers
  - [ ] Step-04: Add options menu for review decisions

- [ ] **Test menu interactions**
  - [ ] Verify [1]/[2]/[3] selection works
  - [ ] Verify [C] Continue works
  - [ ] Verify [Back] navigation works
  - [ ] Verify [E] Exit works gracefully

### Day 2: Refactor Second Workflow (/code-review)

- [ ] **Create code-review directory structure**
  ```bash
  mkdir -p Execs/.agent/workflows/code-review/steps
  mkdir -p Execs/.agent/workflows/code-review/templates
  ```

- [ ] **Create workflow.md and steps**
  - [ ] `workflow.md` - Master definition
  - [ ] `templates/review-report-template.md` - Output template
  - [ ] `steps/step-01-context-loading.md`
  - [ ] `steps/step-02-quality-analysis.md`
  - [ ] `steps/step-03-security-scan.md`
  - [ ] `steps/step-04-verdict.md`

- [ ] **Add menus to all steps**
- [ ] **Add continuation detection**
- [ ] **Test complete workflow**

### Day 3: Create Elicitation Techniques Library

- [ ] **Create data directory**
  ```bash
  mkdir -p Execs/data
  ```

- [ ] **Create techniques CSV**
  - [ ] `Execs/data/elicitation-techniques.csv`
  - [ ] Add header: `category,technique_name,agent,description,use_case`
  - [ ] Add 15-20 techniques:
    - [ ] Five Whys (planning)
    - [ ] Pre-Mortem Analysis (planning)
    - [ ] First Principles (architecture)
    - [ ] SCAMPER (creative)
    - [ ] Six Thinking Hats (analysis)
    - [ ] Red Team vs Blue Team (security)
    - [ ] Failure Mode Analysis (resilience)
    - [ ] Socratic Questioning (deep dive)
    - [ ] Constraint Mapping (problem-solving)
    - [ ] Decision Tree Mapping (options)
    - [ ] Rubber Duck Debugging (implementation)
    - [ ] Root Cause Analysis (debugging)
    - [ ] Stakeholder Round Table (perspective)
    - [ ] What If Scenarios (creative)
    - [ ] Reverse Engineering (understanding)

- [ ] **Test CSV loads correctly**
  ```bash
  cat Execs/data/elicitation-techniques.csv
  ```

### Day 4: Integrate Techniques into Workflows

- [ ] **Update Keisha's planning step**
  - [ ] Load techniques CSV (filter: category = planning)
  - [ ] Present menu of techniques before PRD creation
  - [ ] Allow user to select or skip
  - [ ] If selected, guide through technique
  - [ ] Document technique used in PRD frontmatter

- [ ] **Update Igor's architecture workflow** (if exists)
  - [ ] Load techniques CSV (filter: category = architecture)
  - [ ] Present techniques for complex decisions
  - [ ] Document technique used

- [ ] **Test technique integration**
  - [ ] Run `/new-feature`
  - [ ] Select "Five Whys" technique
  - [ ] Verify Keisha guides through 5 layers
  - [ ] Verify insights documented in PRD

### Day 5: Add Continuation Detection to All Workflows

- [ ] **Refactor remaining workflows**
  - [ ] `/audit` → micro-files + continuation
  - [ ] `/debug` → micro-files + continuation
  - [ ] `/improve` → micro-files + continuation
  - [ ] `/organize` → micro-files + continuation
  - [ ] `/refactor` → micro-files + continuation
  - [ ] `/security-scan` → micro-files + continuation

- [ ] **Create step-01b-continue files for each**

- [ ] **Test interruption → resume for all workflows**

---

## Week 3: Polish & Validation (P2 - Nice to Have)

### Day 1: Create Output Templates

- [ ] **Create templates for common outputs**
  - [ ] `templates/architecture-doc-template.md`
  - [ ] `templates/test-report-template.md`
  - [ ] `templates/security-scan-report-template.md`
  - [ ] `templates/refactor-plan-template.md`
  - [ ] `templates/audit-report-template.md`

- [ ] **Add frontmatter to all templates**
- [ ] **Update workflows to use templates**

### Day 2: Measure Context Overhead

- [ ] **Run all workflows with token tracking**
  - [ ] `/new-feature` - record tokens per step
  - [ ] `/code-review` - record tokens per step
  - [ ] `/audit` - record tokens per step
  - [ ] Calculate overhead percentage

- [ ] **Compare to baseline (Week 1, Day 1)**
  - [ ] Target: <20% overhead per step
  - [ ] If higher, identify bottlenecks
  - [ ] Refactor heavy steps

- [ ] **Document results**
  - [ ] Update `.agent-ops/AGENT_LEARNINGS.md`
  - [ ] Add section: "Context Overhead After BMAD Integration"
  - [ ] Include before/after comparison
  - [ ] Note which patterns helped most

### Day 3: Create Sample Workflows (Examples)

- [ ] **Create 3 sample workflow executions**
  - [ ] Feature: "Add dark mode toggle" (complete /new-feature run)
  - [ ] Review: "Review auth middleware" (complete /code-review run)
  - [ ] Audit: "Tech debt audit" (complete /audit run)

- [ ] **Save as examples**
  ```bash
  mkdir -p Execs/examples
  cp _squad-output/features/dark-mode-prd.md examples/example-feature-prd.md
  cp _squad-output/reviews/auth-review.md examples/example-code-review.md
  cp _squad-output/audits/tech-debt.md examples/example-audit.md
  ```

- [ ] **Add annotations**
  - [ ] Highlight frontmatter state tracking
  - [ ] Highlight technique usage
  - [ ] Highlight multi-agent handoffs

### Day 4: Documentation & Training

- [ ] **Update team-fullstack.txt**
  - [ ] Add section: "Workflow Architecture" (reference bmad-patterns.md)
  - [ ] Add section: "Using Elicitation Techniques"
  - [ ] Add examples of menu navigation

- [ ] **Create quick reference guide**
  - [ ] `Execs/docs/workflow-quick-reference.md`
  - [ ] List all workflows with step breakdown
  - [ ] List all techniques with use cases
  - [ ] List all menu shortcuts

- [ ] **Create migration notes**
  - [ ] `Execs/docs/whats-new-after-bmad.md`
  - [ ] Explain what changed and why
  - [ ] Provide before/after examples
  - [ ] List new capabilities

### Day 5: Final Testing & Cleanup

- [ ] **Full integration test**
  - [ ] Run complete feature development cycle
    1. `@keisha create prd` (new-feature/step-01)
    2. `@ox build feature` (new-feature/step-02)
    3. `@soulja validate` (new-feature/step-03)
    4. `@dmx review` (new-feature/step-04)
  - [ ] Verify all handoffs work
  - [ ] Verify frontmatter tracks correctly
  - [ ] Verify continuation works
  - [ ] Verify techniques integrate smoothly

- [ ] **Clean up**
  - [ ] Remove old workflow files (back them up first)
  - [ ] Consolidate documentation
  - [ ] Remove any TODO comments
  - [ ] Format all YAML/Markdown consistently

- [ ] **Merge to main**
  ```bash
  git add .
  git commit -m "BMAD integration complete: micro-files, state tracking, techniques"
  git checkout main
  git merge feature/bmad-integration
  git tag bmad-integrated-v1.0
  ```

---

## Post-Integration Monitoring (Ongoing)

### Week 4-5: Observation Period

- [ ] **Track metrics**
  - [ ] Workflow completion rate (should be higher)
  - [ ] Workflow resume rate (new capability)
  - [ ] Context overhead (target: <20%)
  - [ ] Agent character consistency (should improve)

- [ ] **Gather feedback**
  - [ ] Which techniques get used most?
  - [ ] Which menu options get used?
  - [ ] Any confusion points?
  - [ ] Any performance issues?

- [ ] **Refine based on usage**
  - [ ] Add more techniques if needed
  - [ ] Adjust menus based on user choices
  - [ ] Optimize high-overhead steps

### Month 2: Expansion

- [ ] **Create new workflows using patterns**
  - [ ] Use micro-file template
  - [ ] Include techniques library
  - [ ] Include continuation detection

- [ ] **Expand technique library**
  - [ ] Add techniques discovered through use
  - [ ] Document in `.agent-ops/AGENT_LEARNINGS.md`
  - [ ] Share successes

- [ ] **Build tooling (optional)**
  - [ ] Script to create new workflow from template
  - [ ] Dashboard to show workflow status
  - [ ] Metrics tracker for context overhead

---

## Success Criteria

### Must Have (Required for "Done")
- [x] All agents have YAML definitions with critical_actions
- [x] `/new-feature` and `/code-review` use micro-file architecture
- [x] Frontmatter state tracking works (can resume workflows)
- [x] Context overhead reduced to <20% per step
- [x] Elicitation techniques library created and integrated
- [x] Continuation detection works for interrupted workflows

### Should Have (Highly Desirable)
- [ ] All 8 workflows refactored to micro-files
- [ ] Menu-driven navigation in all workflows
- [ ] Output templates for common document types
- [ ] Examples and documentation updated

### Nice to Have (If Time Permits)
- [ ] Advanced elicitation methods (50+ from BMAD)
- [ ] Squad dashboard (visual workflow status)
- [ ] Automated workflow creation scripts
- [ ] Technique usage analytics

---

## Rollback Plan (If Things Go Wrong)

If integration causes problems:

```bash
# Rollback to pre-integration state
git checkout main
git reset --hard pre-bmad-integration

# Or rollback specific workflow
git checkout pre-bmad-integration -- Execs/.agent/workflows/new-feature/
```

**When to rollback:**
- Context overhead increases (worse than baseline)
- Workflows break (agents don't respond correctly)
- Character consistency degrades
- User confusion increases

**Partial rollback options:**
- Keep agent YAMLs, revert workflows
- Keep micro-files, revert techniques
- Keep state tracking, revert menus

---

## Notes & Learnings

### What Worked Well
- (To be filled during integration)

### Challenges Encountered
- (To be filled during integration)

### Unexpected Benefits
- (To be filled during integration)

### Would Do Differently Next Time
- (To be filled during integration)

---

**Last Updated:** 2026-01-03
**Status:** Ready to Begin
**Next Action:** Week 1, Day 1 - Setup Agent Infrastructure
