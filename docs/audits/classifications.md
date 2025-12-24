# Audit Classifications
## Strict categories and severities (non-negotiable)

---

## Severity

- **CRITICAL**: Must block; security or correctness risk
- **HIGH**: Must fix before release
- **MEDIUM**: Fix this sprint
- **LOW**: Track and schedule
- **INFO**: Note only

---

## Categories

- **Requirements**: PRD, user stories, scope, acceptance criteria
- **Architecture**: design, data model, dependencies, scalability
- **Implementation**: code quality, complexity, TDD evidence
- **Tech Debt**: debt budget, bloat limits, complexity creep
- **Testing**: coverage, user flow coverage, reliability
- **Flow Coverage**: user story → test mapping, edge/failure coverage
- **Security**: threats, abuse cases, vulnerabilities
- **Performance**: latency, throughput, resource usage
- **UX**: usability, accessibility, interaction rules
- **Release**: deployment readiness, rollback, monitoring
- **Naming**: product/feature naming canon compliance
- **Ops**: ops board discipline, handoffs, drift control

---

## Status

- **PASS**: all gates met
- **BLOCKED**: any CRITICAL/HIGH items open
