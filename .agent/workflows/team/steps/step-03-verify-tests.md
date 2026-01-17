---
step: 3
agent: soulja
phase: VERIFY
status: pending
---

# Step 3: Verify Tests - VERIFY Phase (Soulja)

**Goal:** Run full test suite and validate coverage meets requirements
**Agent:** @soulja (COO/Frontend Specialist & Test Engineer)
**TDD Phase:** VERIFY (Ensure all tests pass and coverage is adequate)
**Next Step:** step-04-review-refactor.md

---

## Task

### 1. Run Full Test Suite

**Execute complete test suite:**
```bash
npm test
```

**Not just the new tests - run ALL tests:**
- New tests from Step 1
- Existing regression tests
- Integration tests
- E2E tests (if applicable)

**Verify:**
- ✅ All tests pass (including existing tests)
- ✅ No flaky tests
- ✅ No skipped tests
- ✅ Fast execution (no unnecessary delays)

### 2. Check Code Coverage

**Run coverage report:**
```bash
npm test -- --coverage
```

**Analyze coverage:**
- Line coverage: Should be ≥80%
- Branch coverage: Should be ≥80%
- Function coverage: Should be ≥80%
- Statement coverage: Should be ≥80%

**Review uncovered code:**
- Are uncovered lines edge cases?
- Should additional tests be added?
- Or are they acceptable gaps (logging, etc.)?

### 3. Validate Against Acceptance Criteria

**For each AC in story:**
- [ ] AC1: Tests exist and pass ✅
- [ ] AC2: Tests exist and pass ✅
- [ ] AC3: Tests exist and pass ✅
- [ ] etc.

**Check edge cases:**
- Null/undefined handling
- Empty arrays/objects
- Error scenarios
- Loading states
- Boundary conditions

### 4. Test Quality Review

**Review test code:**
- Tests are readable and maintainable
- No duplicated test logic
- Proper use of mocks/stubs
- Tests are isolated (no interdependencies)
- Descriptive test names
- Clear assertions

**Performance check:**
- Tests run in reasonable time (<30s total)
- No unnecessary async delays
- Efficient test setup/teardown

---

## Verification Results

### Pass Criteria

**All green if:**
- ✅ All tests pass (100%)
- ✅ Coverage ≥80% (all metrics)
- ✅ All ACs have passing tests
- ✅ No flaky or skipped tests
- ✅ Test suite runs in <30s

**Frontmatter update:**
```yaml
---
stepsCompleted: [0, 1, 2, 3]
phase: VERIFY_COMPLETE
all_tests_passing: true
coverage_percentage: 85
coverage_meets_target: true
acs_validated: true
---
```

**Proceed to Step 4** (DMX Review)

### Fail Criteria

**Issues found:**
- ❌ Tests failing
- ❌ Coverage <80%
- ❌ Missing AC coverage
- ❌ Flaky tests
- ❌ Performance issues

**Frontmatter update:**
```yaml
---
stepsCompleted: [0, 1, 2, 3]
phase: VERIFY_FAILED
all_tests_passing: false
coverage_percentage: 65
coverage_meets_target: false
current_iteration: {{current_iteration + 1}}
retry_reason: "Coverage below 80%, missing edge case tests"
---
```

**Loop back to:**
- If coverage low: Loop to Step 1 (Soulja adds tests)
- If tests failing: Loop to Step 2 (Ox fixes implementation)
- If iteration >= 10: Exit with error

---

## Loop Logic

### Decision Tree

```
Run full test suite
    │
    ├─> All tests pass?
    │   │
    │   ├─> YES → Check coverage
    │   │   │
    │   │   ├─> Coverage ≥80%?
    │   │   │   │
    │   │   │   ├─> YES → Check ACs
    │   │   │   │   │
    │   │   │   │   ├─> All ACs covered?
    │   │   │   │   │   │
    │   │   │   │   │   ├─> YES → ✅ Proceed to Step 4 (DMX)
    │   │   │   │   │   │
    │   │   │   │   │   └─> NO → 🔄 Loop to Step 1 (add tests)
    │   │   │   │
    │   │   │   └─> NO → 🔄 Loop to Step 1 (add tests)
    │   │
    │   └─> NO → 🔄 Loop to Step 2 (fix implementation)
    │
    └─> Iteration >= 10? → ❌ Exit with error
```

---

## Coverage Analysis

### Example Coverage Report

```
--------------------------------|---------|----------|---------|---------|
File                            | % Stmts | % Branch | % Funcs | % Lines |
--------------------------------|---------|----------|---------|---------|
All files                       |   85.2  |   82.1   |   88.5  |   85.2  |
 components/                    |   87.3  |   84.2   |   90.0  |   87.3  |
  journey-tabs.tsx              |   92.1  |   88.5   |   95.0  |   92.1  |
  journey-detail.tsx            |   82.5  |   80.0   |   85.0  |   82.5  |
 hooks/                         |   83.1  |   80.0   |   87.0  |   83.1  |
  use-journey-tabs.ts           |   90.0  |   85.0   |   92.0  |   90.0  |
  use-inspiration-vote.ts       |   76.2  |   75.0   |   82.0  |   76.2  | ⚠️
--------------------------------|---------|----------|---------|---------|

✅ Overall coverage: 85.2% (meets 80% target)
⚠️  use-inspiration-vote.ts below target (76.2%)
   - Missing error scenario tests
   - Uncovered: lines 42-45 (error handling)
```

### Action Items from Coverage

**If coverage gaps found:**
1. Identify uncovered lines/branches
2. Determine if coverage needed (not all code needs 100%)
3. Add tests for critical uncovered code
4. Re-run verification

---

## Frontmatter Updates

### Success Path
```yaml
---
stepsCompleted: [0, 1, 2, 3]
phase: VERIFY_COMPLETE
all_tests_passing: true
total_tests: 32
tests_added: 15
tests_existing: 17
coverage_percentage: 85.2
coverage_meets_target: true
acs_validated: [AC1, AC2, AC3, AC4, AC5]
test_duration: "12.4s"
---
```

### Retry Path - Low Coverage
```yaml
---
stepsCompleted: [0, 1, 2, 3]
phase: VERIFY_RETRY_COVERAGE
all_tests_passing: true
coverage_percentage: 76.2
coverage_meets_target: false
current_iteration: 2
loop_back_to: step-01
retry_reason: "Coverage 76.2% < 80%, need edge case tests for use-inspiration-vote.ts"
---
```

### Retry Path - Tests Failing
```yaml
---
stepsCompleted: [0, 1, 2, 3]
phase: VERIFY_RETRY_FAILING
all_tests_passing: false
tests_failing: ["journey-tabs.spec.tsx::should persist tab in URL"]
current_iteration: 2
loop_back_to: step-02
retry_reason: "1 test failing: URL persistence not working"
---
```

---

## Transition

### To Step 4 (Success)

**Update ops board:**
```markdown
## Current Task Status
- [x] Story loaded/created (Step 0)
- [x] Failing tests written (Step 1 - RED)
- [x] Code implementation (Step 2 - GREEN)
- [x] Test verification (Step 3 - VERIFY) ✅ 85% coverage, all tests pass
- [ ] Code review (Step 4 - REFACTOR) ← NEXT
```

**Load next step:**
```bash
exec Execs/.agent/workflows/team/steps/step-04-review-refactor.md
```

### Loop Back to Step 1 (Low Coverage)

**Update ops board:**
```markdown
## Current Task Status (Iteration 2)
- [x] Story loaded/created (Step 0)
- [~] Failing tests written (Step 1 - RED) ← LOOP BACK (add coverage)
- [x] Code implementation (Step 2 - GREEN)
- [!] Test verification (Step 3 - VERIFY) ⚠️ 76% coverage (need 80%)
```

**Loop back:**
```bash
exec Execs/.agent/workflows/team/steps/step-01-write-tests.md
```

### Loop Back to Step 2 (Tests Failing)

**Update ops board:**
```markdown
## Current Task Status (Iteration 2)
- [x] Story loaded/created (Step 0)
- [x] Failing tests written (Step 1 - RED)
- [~] Code implementation (Step 2 - GREEN) ← LOOP BACK (fix failing test)
- [!] Test verification (Step 3 - VERIFY) ❌ 1 test failing
```

**Loop back:**
```bash
exec Execs/.agent/workflows/team/steps/step-02-implement-code.md
```

---

## VERIFY Phase Exit Criteria

**Can proceed to REFACTOR if:**
- ✅ All tests pass (100%)
- ✅ Coverage ≥80% (all metrics)
- ✅ All acceptance criteria validated
- ✅ No flaky or skipped tests
- ✅ Performance acceptable (<30s)

**Must loop back if:**
- ❌ Tests failing → Step 2 (Ox fixes)
- ❌ Coverage <80% → Step 1 (Soulja adds tests)
- ❌ Missing AC coverage → Step 1 (Soulja adds tests)
- ❌ And iteration < 10

**Must exit with error if:**
- ❌ Issues persist AND iteration >= 10
- ❌ Blocked by external factors

---

**Next:** Step 4 - Review & Refactor (DMX) OR Loop back to Step 1/2
