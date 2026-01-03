---
description: Comprehensive code review with quality checks
---

# /code-review Workflow

Use DMX for thorough code review before merge.

## Steps

### 1. Activate DMX with Code Context
```
@dmx review this code:

[PASTE CODE OR FILE PATH]
```

### 2. DMX Reviews For:

#### Architecture & Design
- [ ] Architecture is sound and scalable
- [ ] Patterns are consistent with team standards
- [ ] Dependencies are appropriate
- [ ] Will handle 10x load without rewrite

#### Code Quality Checklist
- [ ] **Duplicate code**: No unnecessary repetition
- [ ] **Dead code**: No unreachable or unused code
- [ ] **Type safety**: Properly typed, no implicit `any`
- [ ] **Gotchas/Footguns**: No rookie mistakes or traps
- [ ] **Bloat**: No unnecessary comments or code
- [ ] **Complexity**: Logic is as simple as possible
- [ ] **Consistency**: Patterns are intuitive and uniform

#### Security
- [ ] No hardcoded secrets
- [ ] Input validation present
- [ ] No SQL injection risks
- [ ] No XSS vulnerabilities

#### Maintainability
- [ ] Junior engineer can understand in 6 months
- [ ] Functions < 30 lines
- [ ] Complexity < 12
- [ ] Documentation complete

### 3. DMX Output Format

DMX will present issues as diffs:

```diff
# Issue: [Description]
# Severity: [HIGH/MEDIUM/LOW]
# Category: [duplicate|complexity|footgun|bloat|etc]

- [current problematic code]
+ [suggested improvement]
```

### 4. Review Decisions

For each issue:
- **MUST FIX**: Blocking issues (security, bugs)
- **SHOULD FIX**: Quality issues (complexity, patterns)
- **CONSIDER**: Style preferences (consult human)

### 5. Difficult Decisions
```
@dmx I need human input on [SPECIFIC ISSUE]
```

DMX will pause and ask human for direction on:
- Trade-offs with no clear winner
- Breaking changes
- Architecture decisions with long-term impact
- Style preferences

### 6. Final Decision
```
@dmx final verdict
```

Output: ✅ APPROVED | ❌ BLOCKED | ⚠️ APPROVED WITH WARNINGS

## Rules
- Only review new additions and current diff
- Present all suggestions as diffs
- Don't edit anything without human approval
- Consult human for difficult decisions
