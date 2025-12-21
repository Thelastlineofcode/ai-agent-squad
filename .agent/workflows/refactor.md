---
description: Refactor code for improved quality
---

# /refactor Workflow

Use Ox to refactor code for clarity, performance, or maintainability.

## Steps

### 1. Identify Refactoring Target
```
@keisha analyze [MODULE/FILE] for refactoring opportunities
```

Keisha identifies:
- Complexity hotspots
- Coverage gaps
- Coupling issues
- Code smells

### 2. Plan Refactoring
```
@keisha plan refactoring for [TARGET]
```

Output:
- Specific changes needed
- Expected improvements (complexity, coverage)
- Risk assessment
- Acceptance criteria

### 3. Execute Refactoring
```
@ox refactor [TARGET] following this plan:

[PASTE KEISHA'S PLAN]
```

Ox provides:
- Refactored code with tests
- Before/after metrics
- No behavior changes (unless specified)

### 4. Validate Refactoring
```
@soulja validate refactoring of [TARGET]
```

Soulja verifies:
- [ ] All existing tests pass
- [ ] No behavior regression
- [ ] Coverage maintained or improved
- [ ] Complexity reduced

### 5. Review Refactoring
```
@dmx review refactoring for [TARGET]
```

## Success Criteria
- [ ] Complexity reduced (target < 8 avg)
- [ ] Coverage maintained (> 85%)
- [ ] All tests pass
- [ ] No behavior changes
- [ ] DMX approved
