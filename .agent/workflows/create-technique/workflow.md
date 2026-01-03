# Create Technique Workflow
# Trigger: /create-technique

**Goal:** Expand the intelligence library.
**Squad:** Keisha (Designer) → DMX (Reviewer)

---

## Workflow Steps

1. **Definition** - @keisha drafts the new technique.
2. **Verification** - @dmx reviews and appends to CSV.

---

## Initialization

### Configuration
- `installed_path` = `Execs/.agent/workflows/create-technique`

### Execution
Load and execute Step 1:

```bash
exec Execs/.agent/workflows/create-technique/steps/step-01-keisha-define.md
```
