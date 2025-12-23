# Auto Workflow Mode
## PRD-in → Shipped-out (No Manual Activation)

This system runs end-to-end once a PRD is dropped in. No naming drift. No manual babysitting.

---

## Entry Condition

Required files in `tasks/`:
- `prd-<feature>.md`
- `tasks-<feature>.md`
- `tdd-<feature>.md` (use `Execs/dev-tools/guardrails/tdd-evidence.template.md`)

PRD template:
- `tasks/prd-template.md`

---

## Auto Pipeline (Default)

1. **Keisha** reads PRD/TASKLIST and confirms acceptance criteria.
2. **Soulja (Preflight)** runs:
   - `python Execs/dev-tools/guardrails/guardrails.py --voice soulja --feature <feature> --stage preflight`
   - Confirms stack + test command + dev env readiness.
3. **Ox (Executor)** writes tests first (dev env, no mocks), then code.
4. **Soulja (Validate)** runs full 5-layer validation + `--stage post` guardrails.
5. **DMX (Approve)** reviews, blocks if any gate fails, signs off when clean.

## Auto Runner (CLI)

```
python Execs/dev-tools/auto-runner.py --feature <feature> --phase preflight
python Execs/dev-tools/auto-runner.py --feature <feature> --phase post
```

## CI Guardrails

- `.github/workflows/guardrails.yml` enforces preflight guardrails on PRD changes.

---

## Naming Guardrail (No Drift)

Source of truth:
- `Execs/docs/branding.md`
- `Execs/team-fullstack.txt`

Rules:
- Use canonical agent names only (Suge, Keisha, Ox, Soulja Slim, DMX, Igor, Master P).
- Do not introduce alternate names or titles in outputs.
- If a mismatch appears, DMX blocks and Keisha updates docs before proceeding.

---

## Dev-First Enforcement

- No mocks/stubs/fakes. Dev environment only.
- Failure + edge cases are mandatory.
- Deployment validation is blocked until dev runs are green.

---

## Ops Board Updates (Automatic)

- Start: mark Working.
- Preflight: record PASS/BLOCKED.
- Handoff: record Pending Handoffs.
- Done: record Completed This Sprint.

---

## Exit Condition

Ship only when:
- Guardrails pass
- Validation report is PASS
- DMX approves release
