---
description: Refactor and organize a codebase structure
---

# /organize Workflow

Use this workflow to have Keisha analyze, refactor, and reorganize a codebase for clarity and maintainability.

## Steps

### 1. Audit Current Structure
```
@keisha audit the codebase structure for:
- Directory organization
- File naming consistency
- Module separation
- Dead code / unused files
- Documentation gaps
```

### 2. Create Reorganization Plan
```
@keisha create a reorganization plan for this codebase
```
Keisha will propose:
- New directory structure
- Files to move/rename
- Files to delete
- Documentation to create

### 3. Review Plan with Human
**STOP HERE** — Get human approval before making changes.

### 4. Execute Reorganization
```
@ox execute the reorganization plan
```
Ox will:
- Move/rename files as planned
- Update all import paths
- Fix any broken references
- Verify build still works

### 5. Validate Changes
```
@soulja validate the reorganization
```
- Confirm all tests still pass
- Verify no broken imports
- Check documentation links

### 6. Update Documentation
```
@keisha update README and docs to reflect new structure
```

## What Keisha Looks For

### Directory Issues
- [ ] Flat structure that should be nested
- [ ] Deep nesting that should be flattened
- [ ] Mixed concerns in same directory
- [ ] Inconsistent naming conventions

### File Issues
- [ ] Files in wrong directory
- [ ] Files that should be split
- [ ] Files that should be merged
- [ ] Unused/dead files

### Documentation Issues
- [ ] Missing README files
- [ ] Outdated directory descriptions
- [ ] Missing architecture docs

## Output

Keisha produces:
```markdown
# REORGANIZATION PLAN: [Project Name]

## Current Issues
1. [Issue] — [Impact]

## Proposed Changes

### Directory Changes
| Current | Proposed | Reason |
|---------|----------|--------|
| /old/path | /new/path | [Why] |

### Files to Move
| File | From | To | Reason |
|------|------|-----|--------|

### Files to Delete
| File | Reason |
|------|--------|

### Files to Create
| File | Purpose |
|------|---------|

## Impact Analysis
- Build: [Will it break?]
- Tests: [What needs updating?]
- Imports: [How many files affected?]
```
