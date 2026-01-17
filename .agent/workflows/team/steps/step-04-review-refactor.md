---
step: 4
agent: dmx
phase: REFACTOR
status: pending
---

# Step 4: Review & Refactor - REFACTOR Phase (DMX)

**Goal:** Final code quality review, approve or request improvements
**Agent:** @dmx (Enforcer/Quality Gatekeeper)
**TDD Phase:** REFACTOR (Review and improve code quality)
**Exit:** Workflow complete OR loop back to Ox

---

## Task

### 1. Load Context

**Read from frontmatter:**
- `files_modified` - Files changed during implementation
- `test_files` - Test files created
- `story_path` - Original requirements
- `current_iteration` - Loop counter
- `coverage_percentage` - Test coverage achieved

### 2. Code Quality Review

**Review implementation against CORE DOCTRINE:**
- [ ] Follows validation layers
- [ ] Type safety (TypeScript strict mode)
- [ ] Error handling
- [ ] Security (no XSS, injection, etc.)
- [ ] Performance (no obvious bottlenecks)
- [ ] Accessibility (WCAG 2.1 AA)

**Review against project standards:**
- [ ] Follows CLAUDE.md conventions
- [ ] Follows CONTRIBUTING.md guidelines
- [ ] Consistent with codebase patterns
- [ ] Proper file organization
- [ ] Appropriate abstractions (not over/under-engineered)

### 3. Code Smell Detection

**Check for common issues:**
- [ ] No code duplication (DRY principle)
- [ ] No magic numbers/strings
- [ ] Clear variable/function names
- [ ] Reasonable function complexity
- [ ] No commented-out code
- [ ] No console.logs in production code
- [ ] No TODOs without tickets
- [ ] No hardcoded credentials/secrets

### 4. Architecture Review

**Evaluate design decisions:**
- [ ] Component boundaries make sense
- [ ] Data flow is clear
- [ ] State management appropriate
- [ ] API interactions correct
- [ ] Error boundaries in place
- [ ] Loading states handled
- [ ] Edge cases covered

### 5. Test Quality Review

**Review test code:**
- [ ] Tests are maintainable
- [ ] No brittle tests
- [ ] Proper test isolation
- [ ] Good coverage of edge cases
- [ ] Integration tests where needed
- [ ] Performance tests if applicable

### 6. Security Review

**Security checklist:**
- [ ] Input validation
- [ ] Output sanitization (XSS prevention)
- [ ] Authentication/authorization checks
- [ ] No SQL injection vectors
- [ ] No exposed secrets
- [ ] CORS configured correctly
- [ ] Rate limiting considered

---

## Review Verdict

### Approve (✅)

**Criteria for approval:**
- Code quality meets standards
- All CORE DOCTRINE principles followed
- No critical security issues
- Architecture is sound
- Tests are comprehensive
- No major code smells

**Frontmatter update:**
```yaml
---
stepsCompleted: [0, 1, 2, 3, 4]
phase: COMPLETE
dmx_verdict: APPROVED
dmx_feedback: "Code quality excellent, all standards met"
workflow_status: SUCCESS
final_iteration: {{current_iteration}}
---
```

**Update ops board:**
```markdown
## Workflow Complete ✅

### Summary
- Story: {{story_path}}
- Tests: {{total_tests}} (all passing)
- Coverage: {{coverage_percentage}}%
- Files Modified: {{files_modified.length}}
- Iterations: {{final_iteration}}
- DMX Verdict: APPROVED ✅

### Deliverables
- Implemented: [list ACs]
- Tests: [list test files]
- Coverage: {{coverage_percentage}}% (target: 80%)
- Quality: CORE DOCTRINE compliant
```

**Exit workflow** - SUCCESS

---

### Request Changes (🔴)

**Criteria for requesting changes:**
- Code quality issues
- Security vulnerabilities
- Architecture concerns
- Missing error handling
- Performance problems
- Accessibility issues

**Frontmatter update:**
```yaml
---
stepsCompleted: [0, 1, 2, 3, 4]
phase: REFACTOR_REQUESTED
dmx_verdict: CHANGES_REQUESTED
dmx_feedback: "Security issue: missing input validation on line 42"
current_iteration: {{current_iteration + 1}}
loop_back_to: step-02
---
```

**Provide specific feedback:**
```markdown
## DMX Review - Changes Requested 🔴

### Critical Issues (Must Fix)
1. **Security:** Missing input validation in `handleSubmit` (journey-tabs.tsx:42)
   - Validate user input before API call
   - Sanitize before displaying

2. **Performance:** Unnecessary re-renders in `JourneyDetail` component
   - Memoize expensive calculations
   - Use React.memo for child components

### Recommendations (Should Fix)
1. **Code Quality:** Extract duplicated logic in `useJourneyTabs`
   - Create shared utility function
   - Reduce code duplication

2. **Testing:** Add integration test for error scenario
   - Test API failure handling
   - Verify error message display

### Iteration: {{current_iteration}} / 10
```

**Loop back to Step 2** (Ox fixes issues)

---

### Block/Escalate (❌)

**Criteria for blocking:**
- Fundamental architecture problem
- Ambiguous requirements (can't be implemented as specified)
- External dependency missing
- Breaking changes required
- Scope too large for current iteration

**Frontmatter update:**
```yaml
---
stepsCompleted: [0, 1, 2, 3, 4]
phase: BLOCKED
dmx_verdict: BLOCKED
dmx_feedback: "Cannot proceed: backend API endpoint not available"
workflow_status: BLOCKED
---
```

**Report to user:**
```markdown
## Workflow Blocked ❌

### Blocker
{{dmx_feedback}}

### Context
- Story: {{story_path}}
- Current Iteration: {{current_iteration}}
- Tests Status: {{all_tests_passing ? 'Passing' : 'Failing'}}
- Coverage: {{coverage_percentage}}%

### Required Action
User intervention needed to resolve blocker before continuing.

### Recommendation
[Specific recommendation from DMX]
```

**Exit workflow** - BLOCKED

---

## Loop Logic

### Decision Tree

```
DMX Review Complete
    │
    ├─> Verdict: APPROVED?
    │   │
    │   └─> YES → ✅ Exit SUCCESS
    │
    ├─> Verdict: CHANGES_REQUESTED?
    │   │
    │   ├─> Iteration < 10?
    │   │   │
    │   │   ├─> YES → 🔄 Loop to Step 2 (Ox fixes)
    │   │   │
    │   │   └─> NO → ❌ Exit MAX_ITERATIONS
    │   │
    │   └─> ...
    │
    └─> Verdict: BLOCKED?
        │
        └─> ❌ Exit BLOCKED (user intervention)
```

---

## Frontmatter Updates

### Success (Approved)
```yaml
---
stepsCompleted: [0, 1, 2, 3, 4]
workflowType: 'team-tdd'
phase: COMPLETE
dmx_verdict: APPROVED
dmx_feedback: "Implementation excellent, meets all requirements"
workflow_status: SUCCESS
story_path: "{{story_path}}"
files_modified: ["list", "of", "files"]
test_files: ["list", "of", "test", "files"]
total_tests: 32
coverage_percentage: 85.2
final_iteration: 2
completion_time: "2026-01-15T18:30:00Z"
---
```

### Changes Requested (Loop Back)
```yaml
---
stepsCompleted: [0, 1, 2, 3, 4]
phase: REFACTOR_REQUESTED
dmx_verdict: CHANGES_REQUESTED
dmx_feedback: |
  Critical Issues:
  1. Security: Missing input validation (journey-tabs.tsx:42)
  2. Performance: Unnecessary re-renders in JourneyDetail

  Recommendations:
  1. Extract duplicated logic in useJourneyTabs
  2. Add integration test for error scenario
current_iteration: 3
max_iterations: 10
loop_back_to: step-02
---
```

### Blocked
```yaml
---
stepsCompleted: [0, 1, 2, 3, 4]
phase: BLOCKED
dmx_verdict: BLOCKED
dmx_feedback: "Backend API endpoint /api/journeys/:id not available, cannot complete implementation"
workflow_status: BLOCKED
blocker_type: EXTERNAL_DEPENDENCY
---
```

### Max Iterations Reached
```yaml
---
stepsCompleted: [0, 1, 2, 3, 4]
phase: MAX_ITERATIONS
dmx_verdict: CHANGES_REQUESTED
workflow_status: FAILED
failure_reason: "Max iterations (10) reached, still has quality issues"
current_iteration: 10
---
```

---

## DMX Review Checklist

### Code Quality (CORE DOCTRINE)
- [ ] Validation layers enforced
- [ ] Type safety (TypeScript strict)
- [ ] Error handling comprehensive
- [ ] Security vulnerabilities addressed
- [ ] Performance optimized
- [ ] Accessibility compliant (WCAG 2.1 AA)

### Project Standards
- [ ] CLAUDE.md conventions followed
- [ ] CONTRIBUTING.md guidelines met
- [ ] Consistent with codebase patterns
- [ ] Proper file organization
- [ ] Appropriate abstractions

### Code Smells
- [ ] No code duplication
- [ ] No magic values
- [ ] Clear naming
- [ ] Reasonable complexity
- [ ] No dead code
- [ ] No debug artifacts

### Architecture
- [ ] Component boundaries clear
- [ ] Data flow logical
- [ ] State management appropriate
- [ ] Error boundaries present
- [ ] Loading states handled

### Tests
- [ ] Coverage ≥80%
- [ ] Tests maintainable
- [ ] Edge cases covered
- [ ] Integration tests present

### Security
- [ ] Input validated
- [ ] Output sanitized
- [ ] Auth/authz correct
- [ ] No injection vectors
- [ ] No exposed secrets

---

## Exit Workflow

### Success Exit
```markdown
✅ /team Workflow Complete

Story: {{story_path}}
Iterations: {{final_iteration}}
Tests: {{total_tests}} (all passing)
Coverage: {{coverage_percentage}}%
DMX Verdict: APPROVED

All acceptance criteria met. Implementation ready for deployment.
```

### Loop Back Exit
```markdown
🔄 DMX Review - Changes Requested (Iteration {{current_iteration}}/10)

[Detailed feedback from DMX]

Looping back to Step 2 (Ox) to address issues...
```

### Blocked Exit
```markdown
❌ Workflow Blocked

{{dmx_feedback}}

User intervention required. Workflow cannot proceed until blocker resolved.
```

### Max Iterations Exit
```markdown
⚠️ Max Iterations Reached (10)

Quality issues persist after 10 iterations. Manual review required.

Last DMX Feedback:
{{dmx_feedback}}

Exiting workflow for manual intervention.
```

---

**Workflow Ends Here** (Success, Blocked, or Max Iterations)
