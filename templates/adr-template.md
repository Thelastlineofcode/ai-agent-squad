# ADR-[Number]: [Title]
## Architectural Decision Record

**Date**: [YYYY-MM-DD]
**Status**: [Proposed | Accepted | Deprecated | Superseded]
**Deciders**: [@agent1, @agent2]
**Project**: [Project Name or "Cross-Project"]

---

## Context

**What is the issue we're facing?**

[Describe the architectural challenge, technical constraint, or decision point. Include relevant background information.]

**Current State**:
[Describe the existing architecture or approach]

**Why does this decision need to be made now?**
[What's forcing the decision? Performance issue? New requirement? Tech debt?]

---

## Decision Drivers

**What factors influence this decision?**

- Performance requirements: [e.g., "Must handle 10K req/sec"]
- Scalability: [e.g., "Must scale to 1M users"]
- Maintainability: [e.g., "Team size is 3 developers"]
- Cost: [e.g., "Budget constraint of $X/month"]
- Timeline: [e.g., "Must ship in 2 weeks"]
- Technology constraints: [e.g., "Must use Rust ecosystem"]
- Security: [e.g., "GDPR compliance required"]
- Team expertise: [e.g., "Team familiar with PostgreSQL, not MongoDB"]

---

## Considered Options

### Option 1: [Name]

**Description**: [Detailed description of this approach]

**Pros**:
- ✅ [Advantage 1]
- ✅ [Advantage 2]

**Cons**:
- ❌ [Disadvantage 1]
- ❌ [Disadvantage 2]

**Estimated Effort**: [Hours/Days]

---

### Option 2: [Name]

**Description**: [Detailed description of this approach]

**Pros**:
- ✅ [Advantage 1]
- ✅ [Advantage 2]

**Cons**:
- ❌ [Disadvantage 1]
- ❌ [Disadvantage 2]

**Estimated Effort**: [Hours/Days]

---

### Option 3: [Name] (if applicable)

**Description**: [Detailed description of this approach]

**Pros**:
- ✅ [Advantage 1]

**Cons**:
- ❌ [Disadvantage 1]

**Estimated Effort**: [Hours/Days]

---

## Decision

**We have decided to go with Option [X]: [Name]**

**Rationale**:
[Explain why this option was chosen over the alternatives. Reference decision drivers.]

Example:
> We chose Option 2 (Repository Pattern) because:
> - It improves testability (Driver: Maintainability)
> - Team is familiar with this pattern (Driver: Team Expertise)
> - Performance impact is negligible (Driver: Performance)
> - Can be implemented in 2 days (Driver: Timeline)

---

## Consequences

### Positive Consequences

- ✅ [Benefit 1, e.g., "Improved test coverage from 60% to 90%"]
- ✅ [Benefit 2, e.g., "Reduced coupling between modules"]
- ✅ [Benefit 3, e.g., "Easier to swap data sources in future"]

### Negative Consequences

- ❌ [Trade-off 1, e.g., "Additional abstraction layer adds complexity"]
- ❌ [Trade-off 2, e.g., "Requires refactoring existing code"]

### Neutral Consequences

- 🔶 [Neutral impact 1, e.g., "No performance change"]

---

## Implementation Plan

**Immediate Changes**:
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Future Enhancements** (if applicable):
- [Enhancement 1]
- [Enhancement 2]

**Migration Path** (if changing existing architecture):
- Phase 1: [Description]
- Phase 2: [Description]

---

## Validation & Success Metrics

**How will we know this decision was correct?**

- Metric 1: [e.g., "API response time < 200ms"]
- Metric 2: [e.g., "Test coverage > 85%"]
- Metric 3: [e.g., "Zero production incidents in first 30 days"]

**Review Date**: [Date to re-evaluate this decision]

---

## Compliance & Risks

**Risks**:
- Risk 1: [Description] → Mitigation: [Plan]
- Risk 2: [Description] → Mitigation: [Plan]

**Compliance** (if applicable):
- [ ] Security review completed
- [ ] GDPR compliance verified
- [ ] Performance benchmarked
- [ ] Documentation updated

---

## References

**Related ADRs**:
- ADR-XXX: [Title] ([Supersedes | Superseded by | Related to])

**External Resources**:
- [Link to documentation, blog post, paper, etc.]
- [Link to benchmark results]
- [Link to proof of concept]

**Code References**:
- [File path: Line numbers where this decision is implemented]

---

## Notes

**Open Questions**:
- [ ] Question 1: [Needs clarification]
- [ ] Question 2: [Needs decision]

**Assumptions**:
- Assumption 1: [e.g., "Database can handle 100 writes/sec"]
- Assumption 2: [e.g., "Third-party API has 99.9% uptime"]

---

**Approved By**:
- [ ] @keisha (Planner) - Architectural fit confirmed
- [ ] @ox (Implementer) - Technical feasibility confirmed
- [ ] @dmx (Gatekeeper) - Quality standards met
- [ ] [Tech Lead / Architect] - Final approval

---

## Changelog

| Date | Change | Reason | Updated By |
|------|--------|--------|------------|
| [YYYY-MM-DD] | Initial creation | [Reason] | [@agent] |
| [YYYY-MM-DD] | Status changed to Accepted | [Reason] | [@agent] |
