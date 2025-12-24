# Audit Flow Matrix
## Which agent audits what

All audits must use the templates under `Execs/docs/audits/templates/` and classify findings per `Execs/docs/audits/classifications.md`.

---

| Agent | Audit Scope | Output |
|-------|-------------|--------|
| **Keisha** | Requirements audit, architecture audit, tech debt audit | `Execs/docs/audits/reports/keisha/audit-<feature>-<type>-<date>.md` |
| **Soulja Slim** | TDD preflight + validation audit, flow coverage audit | `Execs/docs/audits/reports/soulja/audit-<feature>-<type>-<date>.md` |
| **Ox** | Implementation readiness audit (post-build, pre-handoff) | `Execs/docs/audits/reports/ox/audit-<feature>-<type>-<date>.md` |
| **Igor** | Security & abuse-case audit | `Execs/docs/audits/reports/igor/audit-<feature>-<type>-<date>.md` |
| **Master P** | UX + accessibility audit | `Execs/docs/audits/reports/master-p/audit-<feature>-<type>-<date>.md` |
| **DMX** | Release readiness + naming canon audit | `Execs/docs/audits/reports/dmx/audit-<feature>-<type>-<date>.md` |
| **Suge** | Ops/discipline audit (ops board, handoffs, drift) | `Execs/docs/audits/reports/suge/audit-<feature>-<type>-<date>.md` |

---

## Required Audit Types

1. **Requirements Audit** (Keisha)
2. **Architecture Audit** (Keisha)
3. **Tech Debt Audit** (Keisha)
4. **Validation Audit** (Soulja Slim)
5. **Flow Coverage Audit** (Soulja Slim)
6. **Implementation Audit** (Ox)
7. **Security Audit** (Igor)
8. **UX Audit** (Master P)
9. **Release + Naming Audit** (DMX)
10. **Ops/Drift Audit** (Suge)

---

## Template Index

- Keisha: `keisha-requirements-audit.template.md`, `keisha-architecture-audit.template.md`, `keisha-tech-debt-audit.template.md`
- Soulja Slim: `soulja-validation-audit.template.md`, `soulja-flow-coverage-audit.template.md`
- Ox: `ox-implementation-audit.template.md`
- Igor: `igor-security-audit.template.md`
- Master P: `master-p-ux-audit.template.md`
- DMX: `dmx-release-audit.template.md`
- Suge: `suge-ops-audit.template.md`
