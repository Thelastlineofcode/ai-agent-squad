# ⚡ QUICK ACTIVATION REFERENCE
## Copy-Paste Ready Commands for Your AI Dev Team

---

## THE 10 ESSENTIAL @ACTIVATIONS

### PLANNING (Keisha)
```
@keisha create prd for [feature name]
Output: PRD + TASKLIST + acceptance criteria (5 min)

@keisha audit [repo/module] for tech debt  
Output: Metrics + hot-spots + risks (10-15 min)

@keisha summarize my work on [feature]
Output: Progress report + blockers + next steps (2 min)
```

### BUILDING (Ox)
```
@ox build [feature] with tests first
Output: Code + tests + docs (> 85% coverage) (30-45 min)

@ox optimize [code/module] for performance
Output: Optimized code + benchmark report (20-30 min)

@ox refactor [code] for [complexity/coverage/clarity]
Output: Refactored code meeting target (20-40 min)
```

### VALIDATING (Soulja/Tester)
```
@tester full validation of [feature]
Output: Test report + approval/rejection (15-30 min)
Includes: Unit + integration + E2E + security + performance

@soulja debug this error: [error message]
Output: Root cause + fix recommendation (10-20 min)

@tester security scan
Output: Vulnerabilities + severity + fix (5-10 min)
```

### REVIEWING & DEPLOYING (DMX)
```
@dmx deep review [code file/PR]
Output: Code review + recommendations (15-20 min per 500 lines)

@dmx final check [code] for production
Output: Final approval + deployment auth (10-15 min)

@dmx explain why [code] violates [standard]
Output: Explanation + correct pattern + example (5 min)
```

### LEARNING (All Agents)
```
@ox show me the correct pattern for [concept]
Output: Working example + explanation (5-10 min)

@dmx architecture review for [feature]
Output: Architecture feedback + recommendations (10-15 min)

@keisha create prd and I'll build it
Output: Complete workflow walkthrough (30 min training)
```

---

## DAILY WORKFLOWS (Copy-Paste Sequences)

### Morning (Junior Dev)
```
1. @keisha summarize my work [yesterday/today]
2. @dmx review my code for early feedback
3. @keisha create prd for today's feature
4. @dmx architecture review of the approach
```

### Building Phase
```
1. @ox build [feature] with tests first
2. Monitor: Coverage, complexity, no new tech debt
3. Continue building while verification runs
```

### Validation Phase
```
1. @tester full validation of [feature]
2. All 5 layers: unit + integration + E2E + security + performance
3. If approved → proceed to review
4. If blocked → fix and revalidate
```

### Code Review Phase
```
1. @dmx deep review [your code]
2. Address feedback or get approved
3. @dmx final check for production
```

### Deployment Phase
```
1. Merge to main (if approved)
2. Canary deployment (5% traffic)
3. Monitor for 30 min
4. Proceed to 50% if stable
5. Proceed to 100% if stable
6. Monitor 48 hours
```

---

## MCP TOOL INTEGRATIONS (Automatic)

These run automatically with agent commands:

```
With @keisha audit:
├─ Semgrep: Security + quality analysis
├─ Git history: Churn + risk analysis
├─ Dependency graph: Coupling analysis
└─ Coverage baseline: Actual metrics

With @ox build:
├─ Complexity checker: Keep < 8 average
├─ Coverage enforcer: Keep > 90% critical
├─ Security scanner: Zero tolerance
└─ Test runner: All tests must pass

With @tester validation:
├─ Test executor: Unit + integration + E2E
├─ Coverage reporter: c8 / tarpaulin
├─ Dependency audit: cargo audit / npm audit
├─ Secret scanner: TruffleHog
├─ Performance profiler: Flamegraph / clinic
└─ Load tester: k6 / Artillery

With @dmx review:
├─ Architecture analyzer: Dependency graph
├─ Code analyzer: Semgrep patterns
├─ Risk analyzer: Git history + churn
├─ Metrics analyzer: Complexity + coverage
└─ Security verifier: Vulnerability database
```

---

## GUARDRAILS (Automatic Enforcement)

These cannot be bypassed:

```
COMPLEXITY: Keep < 12 average (< 15 max)
└─ Too complex? @ox refactor to reduce

COVERAGE: Keep > 85% (critical > 95%)
└─ Low coverage? @ox add tests

SECURITY: 0 critical/high vulnerabilities
└─ Vulnerability found? @tester remediate

PERFORMANCE: No regression vs baseline
└─ Slower? @ox profile and optimize

ACCEPTANCE CRITERIA: 100% must be met
└─ Criteria not met? @tester validate again

ARCHITECTURE: Must be sound + scalable
└─ Poor design? @dmx require refactor
```

---

## JUNIOR DEV PROGRESSION

### Week 1: Learning the System
```
Mon: @keisha guide me through [first feature]
Tue: @ox build [feature] with me
Wed: @tester validate with me
Thu: @dmx code review learning
Fri: Deploy [first feature]

Result: 1-2 complete features
Quality: 100% standards met
Learning: The workflow + standards
```

### Week 2-4: Building Confidence
```
Mon-Wed: Build medium complexity features
Thu-Fri: Autonomous work + peer review

Daily: @keisha summarize + @dmx early feedback
Ensures: No surprise rejections

Result: 5-8 features complete
Velocity: 1-2 features/day
Quality: All standards met
```

### Month 2+: Expert Mode
```
Autonomous feature development
Help junior devs with @dmx reviews
Contributing to team patterns
Setting quality standards

Result: 2-3 features/day
Velocity: 10x improvement
Quality: Maintained throughout
```

---

## COMMON SCENARIOS

### Scenario 1: "I don't know where to start"
```
@keisha create prd for [feature]
→ Get clear requirements + acceptance criteria
→ Ready to build
```

### Scenario 2: "My code was rejected (blocked)"
```
@dmx explain why [code] violates [standard]
→ Understand the issue
@ox show me the correct pattern for [concept]
→ Learn the right way
→ Rewrite and resubmit
```

### Scenario 3: "I'm stuck on a bug"
```
@soulja debug this error: [error message]
→ Root cause identified
@ox show me how to [solve this]
→ Get working solution
→ Implement and test
```

### Scenario 4: "My code is slow"
```
@ox optimize [code] for performance
→ Get profiling + optimization
→ Resubmit and validate
```

### Scenario 5: "I don't understand the architecture"
```
@dmx architecture review for [feature]
→ Get architectural guidance
@keisha audit [repo] for tech debt
→ Understand system structure
→ Build with confidence
```

---

## METRICS DASHBOARD (Track These)

### For Individual Devs
```
Features shipped per week: Target 5-10 (from 1-2)
Blocker rate: Target < 5% (RFI on first submit)
Resubmit rate: Target < 10% (quality improving)
Learning velocity: Improvement each week visible
Test coverage: Target > 85% (actually enforced)
Code complexity: Target < 8 avg (improving)
```

### For Team
```
Test coverage: 72% → 88% (goal)
Complexity: 9.2 → 7.5 (goal)
Tech debt: 18% → 8% (goal)
Deployment frequency: Daily (goal)
Incident rate: Minimal (goal)
Cycle time: 2-4 weeks → 4-5 days (goal)
```

---

## MCP SETUP (One-Time)

Install these tools once:

```bash
# Code Analysis
pip install semgrep
semgrep install-rules

# Dependency Scanning
cargo install cargo-audit
npm install -g npm-audit

# Coverage
cargo install cargo-tarpaulin
npm install -g c8

# Performance
cargo install flamegraph
npm install -g clinic

# Secret Detection
pip install truffleHog

# Test Frameworks
cargo test (built-in)
npm test (built-in)
pytest (built-in)

# Load Testing
cargo install k6
npm install -g k6
```

Then wire into agents (Keisha, Ox, Soulja, DMX)

---

## IDE SETUP (VS Code Example)

```
Extensions to install:
├─ Claude/Gemini API
├─ MCP integration
├─ Test runner (Jest/Cargo)
├─ Coverage reporter
└─ Semgrep

Workflow:
├─ Highlight code → right-click → @ox refactor
├─ Right-click test → Run test + coverage
├─ Select function → @dmx architecture review
├─ Commit hook → Auto-run @keisha audit
└─ PR creation → Auto-attach @dmx review
```

---

## MONTHLY RITUALS

### Week 1: Planning
```
@keisha audit [entire repo] for tech debt
Review quarterly goals + KPIs
Plan features for month

Output: Monthly roadmap
```

### Week 2-4: Execution
```
Daily: Build features with @ox
Daily: Validate with @tester
Daily: Review with @dmx
Daily: Track metrics

Output: Features shipping, metrics improving
```

### Week 4: Retrospective
```
@keisha analyze team metrics
What went well? What needs improvement?
Update processes + standards
Plan next month

Output: Continuous improvement
```

---

## HANDOFF TO NEXT DEV

When handing off a feature:

```
@keisha summarize [feature] for handoff
├─ What was built
├─ How it works
├─ Known issues/todos
└─ Next steps

@dmx architecture review for context
├─ Design decisions
├─ Why this approach?
├─ Future extensions

Result: Next dev can continue without ramp-up
```

---

## EMERGENCY MODE (Fix Production Bug)

```
1. @soulja debug production error: [error]
   → Root cause identified
   
2. @ox fix [issue] with tests first
   → Code + tests produced
   
3. @tester quick validation
   → All tests green
   
4. @dmx emergency approval
   → Approved for immediate deployment
   
5. Deploy hotfix
   → Canary → 100% (fast)
   
6. Monitor for 1 hour
   → All metrics stable?
   
7. @keisha create post-mortem
   → Why did this happen?
   → How to prevent next time?

Total time: 30-45 minutes from bug to deployed fix
```

---

## SUMMARY: YOUR DAILY TOOLKIT

```
🎯 PLANNING
  @keisha create prd for [feature]
  @keisha audit [repo] for tech debt

🛠️ BUILDING  
  @ox build [feature] with tests first
  @ox optimize [code] for performance

✅ VALIDATING
  @tester full validation of [feature]
  @soulja debug this error: [error]

👀 REVIEWING
  @dmx deep review [code]
  @dmx final check [code] for production

📚 LEARNING
  @ox show me the pattern for [concept]
  @dmx explain why [code] violates [standard]
```

---

## NEXT STEP: COPY & PASTE

1. Copy one command from above
2. Paste into your Claude/Gemini conversation
3. Provide context (code, error, feature name)
4. Get instant AI-assisted development

Example:
```
@keisha create prd for user authentication system

Context:
- Tech stack: Rust + Actix-web
- Existing: OAuth2 base
- Needed: JWT + RBAC (admin, user, guest)
- Constraint: No breaking changes
- Timeline: 2-week sprint
```

Result: Complete PRD with acceptance criteria in 5 minutes

---

**Your AI dev team is ready. Start using these commands today. 🚀**

Keisha plans. Ox builds. Soulja validates. DMX enforces.

10x productivity. 100% quality. Zero tech debt.
