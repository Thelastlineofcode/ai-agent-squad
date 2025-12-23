# AGENT TEAM ORCHESTRATION & @ACTIVATION SYSTEM
## How Keisha + Soulja + Ox Work Together (With Examples)

---

## THE AGENT TEAM

```
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│  @keisha [request]  →  Audit | Plan | Decide               │
│  │                                                          │
│  │ (Produces PRD + TASKLIST with acceptance criteria)      │
│  │                                                          │
│  ↓                                                          │
│  @soulja [preflight] →  TDD Gate | Stack | Guardrails       │
│  │                                                          │
│  │ (Blocks if dev env/TDD artifacts are missing)            │
│  │                                                          │
│  ↓                                                          │
│  @ox [tasklist]     →  Tests First | Build (dev env)        │
│  │                                                          │
│  │ (Produces production-ready code with evidence)          │
│  │                                                          │
│  ↓                                                          │
│  @tester [code]     →  Validate | Verify | Approve        │
│  │                                                          │
│  │ (Confirms acceptance criteria 100% met)                │
│  │                                                          │
│  ↓                                                          │
│  @reviewer [pr]     →  Review | Enforce | Merge           │
│  │                                                          │
│  │ (Final quality gate + merge)                            │
│  │                                                          │
│  ↓                                                          │
│  ✅ SHIPPED CLEAN CODE                                      │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## @ACTIVATION SYSTEM EXPLAINED

Each agent has a unique @mention trigger:

```
@keisha [request]       → Keisha (Planner & Analyst)
@soulja preflight [prd] → Soulja (TDD Gate)
@ox [request]           → Ox (Executor)
@tester [code]          → Tester (Validation)
@reviewer [pr]          → Reviewer (Quality Gates)
```

---

## AUTO MODE

Auto pipeline is defined in `Execs/docs/auto-workflow.md`.  
Branding canon is enforced via `Execs/docs/branding.md`.

---

## FULL WORKFLOW EXAMPLE: Building the KP Transits Engine

### Step 1: User Activates Keisha

```
User: @keisha plan the KP transits engine for Levite

Context:
- Current state: Synastry module at 18% tech debt
- Feature scope: Calculate Saturn/Jupiter transits (5-year span)
- Constraints: 2-sprint budget, real-time performance critical
- Team capacity: 1-2 developers
- Quality bar: > 90% coverage, complexity < 12
```

### Step 2: Keisha Analyzes & Plans

```
@keisha response:

Before I plan, I have clarifying questions:

1. Have we fixed the AspectCalculator coupling issue?
   (If not, should we bundle refactoring + this feature?)

2. Are Saturn/Jupiter the only transits, or do we need extensibility
   for future transit types?

3. Can we break API, or must this be backward-compatible?

4. Is "real-time" critical for the initial MVP, or acceptable for v2?

Once I understand these, I'll:
- Audit current Levite state
- Identify prerequisites (refactoring needed? yes/no)
- Break transits engine into atomic tasks
- Estimate timeline + risk
- Produce PRD + TASKLIST for Ox
```

### User Responds

```
User: @keisha here are the answers:

1. AspectCalculator is still at 18% debt (not yet refactored)
2. Saturn + Jupiter only for MVP; extensible for future
3. Must maintain backward compatibility
4. Real-time not critical for MVP; v1.1 can optimize
```

### Step 3: Keisha Produces Plan

```
@keisha response:

DECISION: Refactor AspectCalculator FIRST (1 sprint), then transits (1 sprint).

Here's why: Transits engine will depend on AspectCalculator.
If we build on messy foundation, we're repeating the same coupling issues.
Better to clean foundation once.

TASKLIST (2 sprints, 4 weeks):

SPRINT 1: Foundation (AspectCalculator Refactoring)
├─ T1: Repository pattern for Neo4j (1 day)
├─ T2: Refactor AspectCalculator logic (2 days)
├─ T3: Unit test isolation + coverage (2 days)
└─ T4: Integration validation (1 day)

SPRINT 2: Feature (KP Transits Engine)
├─ T5: Design transit calculation engine (1 day)
├─ T6: Implement Saturn/Jupiter transits (2 days)
├─ T7: Test suite + multi-year validation (2 days)
└─ T8: Performance benchmarks + optimization (1 day)

PRD attached: [JSON with success criteria, dependencies, risks]

Ready for Ox to execute?
```

### Preflight Gate (New)

```
User: @soulja preflight KP transits engine

Soulja checks:
- Runs guardrails: `python Execs/dev-tools/guardrails/guardrails.py --voice soulja --feature kp-transits --stage preflight`
- Stack + test command confirmed
- PRD + TASKLIST present
- TDD evidence template created
- Dev environment ready (no mocks)

Soulja output: PASS or BLOCKED
```

### Step 4: User Activates Ox

```
User: @ox execute Keisha's plan

Keisha's PRD + TASKLIST attached (2 sprints, clear success criteria)
```

### Step 5: Ox Confirms & Starts

```
@ox response:

I understand the plan. Before I start, confirming:

1. Rust stack, Neo4j backend, async/await throughout?
2. Should I run tests against local dev Neo4j?
3. Any existing patterns in Levite for error types + repository?
4. Timeline: Start immediately? (I'll time-box each task)

Once confirmed, I'll:
- Start T1: Define repository trait
- Write tests first (TDD approach)
- Achieve > 85% coverage + < 12 complexity
- Handoff to Tester after each task

Ready for answers.
```

### User Responds

```
User: @ox confirmed:

1. Yes, Rust + Neo4j + tokio
2. Use local dev Neo4j for tests
3. See LeviteError enum in src/errors.rs (follow that pattern)
4. Start immediately; we're on tight timeline
```

### Step 6: Ox Executes (T1: Repository Trait)

```
@ox working:

T1: Repository trait definition
├─ Defining GraphRepository trait (async)
├─ Neo4j implementation (src/repository/neo4j.rs)
├─ Custom error types (RepositoryError)
├─ Unit tests with dev env Neo4j (tests/repository_tests.rs)
└─ Target: 8 hours, > 85% coverage

Current progress:
- Trait definition: DONE (3 hours)
- Neo4j implementation: IN PROGRESS (1 hour remaining)
- Tests: DONE (4 hours, 12 test cases)

Coverage: 89% (exceeds 85%) ✓
Complexity: Avg 6.2 (well below 12) ✓
All tests passing: YES ✓

Ready to hand off to Tester? (Will do before T2)
```

### Step 7: Ox Hands Off to Tester

```
@ox → @tester handoff

Task: T1 (Repository trait definition)

Deliverables:
├─ src/repository.rs (trait definition)
├─ src/repository/neo4j.rs (Neo4j implementation)
├─ src/errors.rs (RepositoryError enum)
└─ tests/repository_tests.rs (12 test cases)

Quality Evidence:
├─ Coverage: 89% (target 85%) ✓
├─ Complexity: Avg 6.2, Max 10 (target < 12) ✓
├─ All tests pass: 12/12 (100%) ✓
├─ Compilation: zero warnings (Clippy clean) ✓
└─ Documentation: All public items documented ✓

Acceptance Criteria (from Keisha):
├─ pub trait GraphRepository with async methods ✓
├─ Neo4jRepository implementation provided ✓
└─ Ready for AspectCalculator refactoring ✓

Ready for Tester validation.
```

### Step 8: Tester Validates

```
@tester response:

T1 Validation Report:

✅ PASS: Trait definition correct
✅ PASS: Neo4j implementation complete
✅ PASS: Error handling comprehensive
✅ PASS: Coverage 89% (exceeds 85% target)
✅ PASS: Complexity within bounds (avg 6.2)
✅ PASS: All Keisha's acceptance criteria met
✅ PASS: Ready for AspectCalculator refactoring

Approval: READY FOR NEXT TASK

Ox may proceed to T2: Refactor AspectCalculator
```

### Step 9: Ox Continues (T2: Refactor AspectCalculator)

```
@ox working:

T2: Refactor AspectCalculator
├─ Accept repository trait as param
├─ Extract pure logic from graph queries
├─ Implement with error handling
└─ Unit tests + dev environment services

Progress:
- Trait parameter acceptance: DONE (2 hours)
- Pure logic extraction: DONE (4 hours)
- Tests with dev environment services: DONE (6 hours)

Hit a complexity issue:
- compute_aspects function: complexity 15 (exceeds 12 target)
- Nested loops: planet_a × planet_b × aspect check

Fixing by extracting to functional composition...

NEW PLAN:
- Break into smaller functions (predicates, mappers)
- Use functional composition (filter_map, flat_map)
- Complexity drops to ~8

Re-testing... ALL PASS (15 test cases)
Coverage: 87% (exceeds 85%) ✓
Complexity: Avg 7.8, Max 12 (meets Keisha's target) ✓

Ready for Tester validation (T2 complete).
```

### Step 10: Tester Validates T2

```
@tester response:

T2 Validation: AspectCalculator Refactoring

✅ PASS: Repository pattern applied correctly
✅ PASS: Pure logic extracted and testable
✅ PASS: Complexity 7.8 avg (within Keisha's < 12 target)
✅ PASS: Coverage 87% (exceeds 85% target)
✅ PASS: All 15 tests pass
✅ PASS: Error handling complete
✅ PASS: No breaking API changes

Minor note: Consider extracting compute_orb to utility (reusable)
          Ox may do this in T3 or future refactoring

Approval: READY FOR NEXT TASK (T3)

Sprint 1 on track: T1 ✓ T2 ✓ (T3, T4 pending)
```

### Step 11: Ox Continues & Completes Sprint 1

```
@ox working:

T3: Unit test isolation + coverage (AspectCalculator)
├─ Add edge case tests
├─ Null/empty/boundary tests
├─ Error path tests
└─ Coverage target > 90%

COMPLETE:
- Coverage: 92% (exceeds 90% target) ✓
- All edge cases covered ✓
- Error paths tested ✓
- All tests pass ✓

T4: Integration validation
├─ End-to-end synastry flow
├─ Test with real Neo4j queries
└─ Performance baseline

COMPLETE:
- E2E tests pass ✓
- Performance: acceptable (no regression) ✓
- Keisha's acceptance criteria: 100% met ✓

SPRINT 1 STATUS: COMPLETE ✓

All T1-T4 validation passed.
Ready to start SPRINT 2 (Transits Engine).
```

### Step 12: Sprint 2 - Transits Engine

```
@ox working:

T5: Design transit calculation engine
- Saturn/Jupiter only (extensible)
- 5-year span calculations
- Aspect orbs + interpretations

COMPLETE:
- Design documented
- API contract defined
- Tests written (ready for implementation)

T6: Implement Saturn/Jupiter transits
- Multi-year ephemeris lookups
- Aspect calculations using AspectCalculator
- Interpretation matching

COMPLETE:
- Implementation: DONE
- Tests: 25 test cases, all pass
- Coverage: 91% (exceeds 90% target)
- Complexity: Avg 8.1 (well below 12)

T7: Test suite + multi-year validation
- 5-year test scenarios
- Boundary condition tests (leap seconds, etc.)
- Historical accuracy validation

COMPLETE:
- Full 5-year range tested
- Edge cases covered
- Historical accuracy verified

T8: Performance benchmarks
- Single transit calculation: 2.3ms
- 5-year multi-planet span: 145ms
- Memory usage: stable

COMPLETE:
- Performance acceptable for MVP
- No optimization needed for v1.0

SPRINT 2 STATUS: COMPLETE ✓

All T5-T8 validation passed.
Ready for code review + merge.
```

### Step 13: Final Handoff to Reviewer

```
@ox → @reviewer handoff

Summary:
├─ Feature: KP Transits Engine (Saturn/Jupiter, 5-year)
├─ Lines of code: 1,245 (implementation)
├─ Lines of tests: 1,890 (test code)
├─ Coverage: 91% overall, 95% critical paths
├─ Complexity: Avg 8.1, Max 13 (within target)
└─ Timeline: 2 sprints (on schedule)

All Tests: ✅ PASS (67 total tests)
Keisha's Acceptance Criteria: ✅ 100% MET
Tester Validation: ✅ APPROVED (all phases)

Ready for Reviewer quality gates + merge.
```

### Step 14: Reviewer Final Quality Check

```
@reviewer response:

Final Review: KP Transits Engine

✅ Code quality gates: PASS
✅ Architecture review: PASS (follows patterns)
✅ Security scan: PASS (no vulnerabilities)
✅ Performance review: PASS (benchmarks acceptable)
✅ Documentation: PASS (complete + clear)
✅ Keisha's standards: PASS (complexity, coverage, patterns)

APPROVAL: MERGE TO MAIN

Deploy checklist:
├─ All tests pass in CI/CD
├─ No regressions in existing tests
├─ Coverage maintained or improved
├─ Performance benchmarks acceptable
└─ Ready for production deployment

🎉 SHIPPED CLEAN CODE
```

---

## KEY PRINCIPLES OF @ACTIVATION SYSTEM

### 1. Each Agent Has One Job

```
@keisha  → PLAN & ANALYZE
@ox      → BUILD & CODE
@tester  → VALIDATE & VERIFY
@reviewer → ENFORCE & MERGE
```

**No overlap. No duplication. Clear ownership.**

---

### 2. Sequential Handoffs (Not Parallel)

```
Keisha finishes plan → Soulja preflights → Ox starts coding → Tester validates → Reviewer merges

NOT: Everyone working at once (chaos, conflicts, rework)
```

---

### 3. Acceptance Criteria Is Law

```
Keisha defines success criteria in PRD.
Soulja preflights stack/test command + guardrails.
Ox builds to meet those criteria exactly (dev env, no mocks).
Tester validates 100% criteria met.
Reviewer enforces standards.

Result: No surprises, no rework, no drift.
```

---

### 4. Freshness Over Memory

```
Agents must fetch current docs/sources before decisions.
If sources are unavailable, block and ask for confirmation.
```

---

### 4. Early Clarity (Ask Questions First)

```
@ox receives plan:
"Before I code, I have 3 questions..."

Answer clarifying questions BEFORE coding.
Saves 10x the rework later.
```

---

### 5. Iterate, Don't Skip

```
Ox → Tester finds issues → Ox fixes → Tester re-validates → Next task

Never skip Tester.
Never skip Reviewer.
Never merge without validation.
```

---

## MULTI-TASKING WITH @ACTIVATION

**Can Ox work on multiple PRs simultaneously?**

Yes, with caveats:

```
@ox task1: Work on AspectCalculator refactoring
(Provide task1 context: PRD, TASKLIST, etc.)

[Ox works on T1, T2]

@ox task2: Meanwhile, start KP transits design
(Separate context, separate branch, separate approval)

Ox switches between them, context-managed.

Benefits: Higher throughput
Risks: Context switching (mitigated by clear @activation + context)
```

---

## AGENT TEAM SPEED

| Phase | Time | Critical Path |
|-------|------|---------------|
| **@keisha audits & plans** | 2 hours | Clarify requirements |
| **@soulja preflights** | 30 min | Stack/test cmd confirmed |
| **@ox codes (T1)** | 1 day | Good spec from Keisha |
| **@tester validates (T1)** | 2 hours | Ox's quality standards |
| **@ox codes (T2)** | 2 days | No blocking issues |
| **@tester validates (T2)** | 2 hours | Clear acceptance criteria |
| **@reviewer merges** | 30 min | Everything else done |

**Total: 4-5 days for 2-sprint feature (with parallelization, even faster)**

Compare: Traditional dev (without agent coordination): 2-4 weeks

---

## WHEN TO USE EACH AGENT

| Situation | Agent | Command |
|-----------|-------|---------|
| "Code is messy; what should we fix?" | @keisha | audit Levite |
| "I want to add feature X" | @keisha | plan feature X |
| "Choose between architecture A/B" | @keisha | decide A vs B |
| "Run TDD preflight gate" | @soulja | preflight [feature] |
| "Build feature from Keisha's plan" | @ox | execute plan |
| "Fix bugs in my code" | @ox | refactor [code] |
| "Does this code meet criteria?" | @tester | validate [code] |
| "Is this production-ready?" | @reviewer | review [pr] |

---

## SETUP CHECKLIST FOR FULL TEAM

- [ ] Deploy @keisha (Planner)
- [ ] Deploy @ox (Executor) with @activation trigger
- [ ] Deploy @soulja preflight + validation
- [ ] Deploy @reviewer (Quality Gates)
- [ ] Setup communication protocol (JSON handoffs)
- [ ] Create acceptance criteria templates
- [ ] Setup CI/CD hooks for automated testing
- [ ] Create metrics dashboard (coverage, complexity, velocity)
- [ ] Train team on @activation syntax + expectations
- [ ] Run first end-to-end workflow (plan → preflight → code → test → review)

---

## EXPECTED OUTCOMES (With Full Team)

✅ **Quality**: Tech debt drops 50%+  
✅ **Speed**: Features ship 3-5x faster (less rework)  
✅ **Coverage**: Test coverage maintained > 85%  
✅ **Scalability**: Code designed for extension from day 1  
✅ **Clarity**: No ambiguity (Keisha clarifies upfront)  
✅ **Confidence**: Tester validates; Reviewer enforces  

---

**The @activation system is how you orchestrate your agent team.**

**Keisha plans. Soulja preflights. Ox builds. Tester validates. Reviewer enforces.**

**Together: production-ready code at scale.**
