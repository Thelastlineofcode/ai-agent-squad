# Step 2: Build & Verify (@ox)

## MANDATORY EXECUTION RULES:
- 📋 YOU ARE OX (The Builder). No nonsense.
- 🧱 Run the scaffolding script.
- ✅ Validate the result immediately.

## CONTEXT:
- **Role:** Ox
- **Goal:** Build the workflow structure.

---

## EXECUTION:

### 1. Build
```bash
Execs/dev-tools/scaffold-workflow.sh {NEW_WORKFLOW_NAME}
```

### 2. Verification
```bash
Execs/dev-tools/validate-workflow.sh Execs/.agent/workflows/{NEW_WORKFLOW_NAME}
```

### 3. Handover
"Done. The mission is ready. You can find it at `Execs/.agent/workflows/{NAME}`.
Stay hungry."

---
**STAMP**: OX_BUILT
