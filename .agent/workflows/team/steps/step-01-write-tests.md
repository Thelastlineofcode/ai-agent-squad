---
step: 1
agent: soulja
phase: RED
status: pending
---

# Step 1: Write Failing Tests - RED Phase (Soulja)

**Goal:** Write comprehensive failing tests from acceptance criteria
**Agent:** @soulja (COO/Frontend Specialist & Test Engineer)
**TDD Phase:** RED (Write failing tests first)
**Next Step:** step-02-implement-code.md

---

## Task

### 1. Load Story Acceptance Criteria

Read story from `{{story_path}}` (set in Step 0):
- Extract all acceptance criteria
- Identify testable requirements
- Note edge cases and error conditions
- Understand expected behavior

### 2. Analyze Existing Test Structure

Check project for test patterns:
- Test framework (Jest, Vitest, etc.)
- Test file naming conventions
- Mock/stub patterns
- Coverage tools configuration

### 3. Write Failing Tests

**Test-Driven Development Protocol:**

```typescript
// Example test structure
describe('Feature from Story', () => {
  describe('Acceptance Criterion 1', () => {
    it('should handle happy path', () => {
      // Arrange: Set up test data
      // Act: Execute feature code
      // Assert: Verify expected behavior
      expect(result).toBe(expected); // ❌ SHOULD FAIL (code doesn't exist yet)
    });

    it('should handle edge case', () => {
      // Test edge case from story
      expect(result).toThrow(ExpectedError); // ❌ SHOULD FAIL
    });

    it('should handle error case', () => {
      // Test error handling from story
      expect(result).toBe(fallback); // ❌ SHOULD FAIL
    });
  });
});
```

**Coverage Goals:**
- Unit tests for all functions/methods
- Integration tests for component interactions
- E2E tests for critical user flows (if applicable)
- Minimum 80% code coverage target

### 4. Verify Tests Fail Correctly

Run test suite:
```bash
npm test -- [test-file-path]
```

**Expected Result:**
- ✅ Tests run without syntax errors
- ❌ Tests fail because feature not implemented
- ✅ Failure messages are clear and helpful

**If tests pass unexpectedly:**
- Re-examine test logic
- Ensure testing new behavior, not existing code
- Update tests to properly fail

### 5. Document Test Plan

Create test summary:
- Number of tests written
- Acceptance criteria coverage
- Edge cases covered
- Dependencies/mocks needed
- Expected coverage percentage

---

## Frontmatter Update

```yaml
---
stepsCompleted: [0, 1]
phase: RED_COMPLETE
tests_written: true
test_files: ["path/to/test1.spec.ts", "path/to/test2.spec.ts"]
tests_failing: true
tests_count: 15
coverage_target: 80
---
```

---

## Transition to Step 2

**Update ops board:**
```markdown
## Current Task Status
- [x] Story loaded/created (Step 0)
- [x] Failing tests written (Step 1 - RED)
- [ ] Code implementation (Step 2 - GREEN) ← NEXT
- [ ] Test verification (Step 3 - VERIFY)
- [ ] Code review (Step 4 - REFACTOR)
```

**Load next step:**
```bash
exec Execs/.agent/workflows/team/steps/step-02-implement-code.md
```

---

## Test Writing Checklist

- [ ] All acceptance criteria have corresponding tests
- [ ] Happy path scenarios covered
- [ ] Edge cases identified and tested
- [ ] Error handling tested
- [ ] Integration points tested
- [ ] Tests fail for the RIGHT reasons
- [ ] Test names clearly describe expected behavior
- [ ] Mocks/stubs properly configured
- [ ] Coverage target achievable (80%+)

---

## Example Output

### Test Summary
```
Tests Written: 15
Test Files:
  - src/__tests__/components/journey-tabs.spec.tsx (8 tests)
  - src/__tests__/hooks/use-journey-tabs.spec.ts (7 tests)

Acceptance Criteria Coverage:
  ✅ AC1: Display journey tabs with correct labels
  ✅ AC2: Handle tab switching interactions
  ✅ AC3: Persist selected tab in URL params
  ✅ AC4: Show loading state during data fetch
  ✅ AC5: Display error message on API failure

Test Status:
  ❌ All tests failing (expected - no implementation yet)
  ✅ Tests run without errors
  ✅ Failure messages clear

Expected Coverage: 85%
```

---

## RED Phase Exit Criteria

**Can proceed to GREEN phase if:**
- ✅ All acceptance criteria have tests
- ✅ Tests fail correctly (not due to syntax errors)
- ✅ Test coverage plan meets 80% minimum
- ✅ Edge cases and error scenarios included
- ✅ Test file structure follows project conventions

**Cannot proceed if:**
- ❌ Tests have syntax errors
- ❌ Tests pass (shouldn't pass yet!)
- ❌ Missing critical acceptance criteria
- ❌ No edge case coverage
- ❌ Coverage target unachievable

---

## TDD Best Practices

1. **Write minimal tests first** - Don't over-test, focus on requirements
2. **One assertion per test** - Keep tests focused and debuggable
3. **Arrange-Act-Assert pattern** - Clear test structure
4. **Descriptive test names** - Should read like documentation
5. **Test behavior, not implementation** - Tests should survive refactoring
6. **Mock external dependencies** - Keep tests fast and isolated
7. **Test edge cases** - Null, undefined, empty arrays, etc.
8. **Test error conditions** - What happens when things go wrong?

---

**Next:** Step 2 - Implement Code (GREEN Phase)
