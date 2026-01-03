# List Active Workflows

## GOAL:
Read-only view of the squad's active deployment status.

---

## EXECUTION:

### 1. Global Scan
Scans all subfolders in `Execs/_squad-output/`.

```bash
find Execs/_squad-output -name "*.md" -type f -exec grep -l 'status:' {} + | xargs grep -L 'status: "complete"'
```

### 2. Status Board

| Workflow | Session | Status | Active Agents |
|----------|---------|--------|---------------|
| {w1}     | {s1}    | {st1}  | {ag1}         |
| {w2}     | {s2}    | {st2}  | {ag2}         |

---
**Protocol**: Use `/resume` to take action on any item above.
