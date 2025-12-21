---
description: Debug an issue with root cause analysis
---

# /debug Workflow

Use Soulja Slim's debugging expertise to find and fix issues.

## Steps

### 1. Activate Soulja with Error Context
```
@soulja debug this error:

[PASTE ERROR MESSAGE OR STACK TRACE]
```

### 2. Provide Additional Context (if asked)
- Steps to reproduce
- Expected vs actual behavior  
- Recent changes
- Environment details

### 3. Review Root Cause Analysis
Soulja will provide:
- **Symptom**: What was observed
- **Root Cause**: Why it happened
- **Evidence**: Logs, traces
- **Recommended Fix**: Specific code change
- **Regression Test**: Test to prevent recurrence

### 4. Hand Off to Ox for Fix
```
@ox fix the issue identified by Soulja:

[PASTE SOULJA'S RECOMMENDED FIX]
```

// turbo
### 5. Validate the Fix
```
@soulja validate the fix for [ISSUE]
```

## Output
- Root cause analysis
- Working fix with tests
- Validation confirmation
