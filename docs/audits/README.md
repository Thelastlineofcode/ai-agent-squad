# Audit Folder
## Canonical audit flows, templates, and reports

All audit flows live here. All audit reports are stored under `Execs/docs/audits/reports/`.

---

## Structure

- `Execs/docs/audits/classifications.md` — strict classifications and severity levels
- `Execs/docs/audits/audit-flow-matrix.md` — which agent audits what
- `Execs/docs/audits/templates/` — report templates per agent
- `Execs/docs/audits/reports/<agent>/` — audit outputs (one per feature)

---

## Naming

Report filename format:
`audit-<feature>-<type>-<date>.md` (date: YYYY-MM-DD)

Example:
`audit-auth-security-2025-12-23.md`

---

## Scaffold Reports

```
python Execs/dev-tools/audits/scaffold_audits.py --feature <slug>
```

CI will scaffold audits on PRD changes and block until the reports are committed.

---

## Templates

Use only the templates below:
- `keisha-requirements-audit.template.md`
- `keisha-architecture-audit.template.md`
- `keisha-tech-debt-audit.template.md`
- `soulja-validation-audit.template.md`
- `soulja-flow-coverage-audit.template.md`
- `ox-implementation-audit.template.md`
- `igor-security-audit.template.md`
- `master-p-ux-audit.template.md`
- `dmx-release-audit.template.md`
- `suge-ops-audit.template.md`
