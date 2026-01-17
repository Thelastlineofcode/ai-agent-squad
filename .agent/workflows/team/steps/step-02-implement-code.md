---
step: 2
agent: ox
phase: GREEN
status: pending
---

# Step 2: Implement Code - GREEN Phase (Ox)

**Goal:** Write minimal code to make all tests pass
**Agent:** @ox (CTO/Master Coder)
**TDD Phase:** GREEN (Make tests pass)
**Next Step:** step-03-verify-tests.md

---

## Task

### 1. Load Context

**Read from frontmatter:**
- `story_path` - Original requirements
- `test_files` - Tests written in Step 1
- `current_iteration` - Loop counter

**Read test files:**
- Understand what tests expect
- Identify components/functions needed
- Note mock/stub interfaces

### 2. Analyze Test Requirements

For each failing test:
- What behavior is being tested?
- What interfaces are expected?
- What data structures are needed?
- What edge cases must be handled?

### 3. Implement Minimal Code

**TDD Protocol:**
```typescript
// Implement ONLY what's needed to pass tests
// No gold-plating, no extra features
// Focus on making tests green

// Example:
export function calculateTotal(items: Item[]): number {
  // Simple implementation to pass tests
  if (!items || items.length === 0) return 0; // Edge case from tests
  return items.reduce((sum, item) => sum + item.price, 0);
}
```

**Implementation Checklist:**
- [ ] Read ALL failing tests first
- [ ] Implement simplest solution that passes tests
- [ ] Follow project patterns and conventions
- [ ] Handle edge cases identified in tests
- [ ] Add type safety (TypeScript)
- [ ] Follow CORE DOCTRINE principles

### 4. Run Tests Incrementally

After each implementation chunk:
```bash
npm test -- [test-file-path]
```

**Monitor progress:**
- Tests passing: X / Y
- Update implementation based on failures
- Loop until all tests green

### 5. Verify All Tests Pass

**Final test run:**
```bash
npm test
```

**Expected Result:**
- ✅ All tests pass
- ✅ No TypeScript errors
- ✅ No ESLint warnings
- ✅ Code follows project conventions

---

## Loop Logic

### If Tests Still Failing

**After implementation, if tests fail:**

```yaml
---
stepsCompleted: [0, 1, 2]
phase: GREEN_RETRY
tests_passing: false
current_iteration: {{current_iteration + 1}}
---
```

**Actions:**
1. Analyze test failures
2. Fix implementation
3. Re-run tests
4. If `current_iteration < max_iterations` (10):
   - Loop back to Step 2
5. If `current_iteration >= max_iterations`:
   - Exit with error
   - Report to user for manual intervention

### If Tests Pass

```yaml
---
stepsCompleted: [0, 1, 2]
phase: GREEN_COMPLETE
tests_passing: true
implementation_complete: true
files_modified: ["src/components/journey-tabs.tsx", "src/hooks/use-journey-tabs.ts"]
---
```

**Proceed to Step 3** (Verify)

---

## Implementation Guidelines

### Code Quality Standards

**Must follow:**
- Project coding conventions (CLAUDE.md, CONTRIBUTING.md)
- CORE DOCTRINE validation layers
- TypeScript strict mode
- ESLint rules
- Security best practices (no XSS, SQL injection, etc.)

### Avoid Over-Engineering

**Don't:**
- ❌ Add features not in tests
- ❌ Premature optimization
- ❌ Unnecessary abstractions
- ❌ Gold-plating
- ❌ Breaking existing functionality

**Do:**
- ✅ Simplest solution that passes tests
- ✅ Clear, readable code
- ✅ Proper error handling
- ✅ Edge case coverage
- ✅ Type safety

### File Organization

```
Implementation should create/modify:
- Source files (components, hooks, utils)
- Type definitions (if needed)
- Barrel exports (if needed)

Do NOT modify:
- Test files (written in Step 1)
- Config files (unless required by story)
- Unrelated files
```

---

## Frontmatter Update

### Success Path
```yaml
---
stepsCompleted: [0, 1, 2]
phase: GREEN_COMPLETE
tests_passing: true
implementation_complete: true
files_modified: ["list", "of", "files"]
current_iteration: 1
---
```

### Retry Path
```yaml
---
stepsCompleted: [0, 1, 2]
phase: GREEN_RETRY
tests_passing: false
current_iteration: 2
retry_reason: "Test failure: expected X, got Y"
---
```

---

## Transition

### To Step 3 (Tests Pass)

**Update ops board:**
```markdown
## Current Task Status
- [x] Story loaded/created (Step 0)
- [x] Failing tests written (Step 1 - RED)
- [x] Code implementation (Step 2 - GREEN)
- [ ] Test verification (Step 3 - VERIFY) ← NEXT
- [ ] Code review (Step 4 - REFACTOR)
```

**Load next step:**
```bash
exec Execs/.agent/workflows/team/steps/step-03-verify-tests.md
```

### Loop Back (Tests Failing)

**If iteration < max (10):**
- Analyze failures
- Fix implementation
- Re-run Step 2

**If iteration >= max:**
- Exit workflow
- Report to user:
  - "⚠️ Max iterations reached (10)"
  - "Tests still failing after 10 attempts"
  - "Manual intervention required"

---

## Example Implementation

### Before (Tests Failing)
```typescript
// No implementation exists
```

### After (Tests Passing)
```typescript
// src/hooks/use-journey-tabs.ts
export function useJourneyTabs() {
  const [activeTab, setActiveTab] = useState<string>('overview');
  const searchParams = useSearchParams();

  // Handle tab from URL (AC3: Persist selected tab in URL)
  useEffect(() => {
    const tabParam = searchParams.get('tab');
    if (tabParam) setActiveTab(tabParam);
  }, [searchParams]);

  // Handle tab switching (AC2: Handle tab switching)
  const handleTabChange = (tab: string) => {
    setActiveTab(tab);
    const newParams = new URLSearchParams(searchParams);
    newParams.set('tab', tab);
    window.history.pushState({}, '', `?${newParams.toString()}`);
  };

  return { activeTab, handleTabChange };
}

// Passes all tests in use-journey-tabs.spec.ts ✅
```

---

## GREEN Phase Exit Criteria

**Can proceed to VERIFY if:**
- ✅ All tests pass
- ✅ No TypeScript errors
- ✅ No ESLint warnings
- ✅ Code follows conventions
- ✅ All acceptance criteria implemented

**Must loop back if:**
- ❌ Tests still failing
- ❌ TypeScript errors
- ❌ Implementation incomplete
- ❌ And iteration < 10

**Must exit with error if:**
- ❌ Tests failing AND iteration >= 10
- ❌ Blocked by external dependency
- ❌ Requirements ambiguous

---

**Next:** Step 3 - Verify Tests (VERIFY Phase) OR Loop back to Step 2
