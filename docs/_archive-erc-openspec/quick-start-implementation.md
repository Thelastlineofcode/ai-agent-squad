# Quick-Start: Transform Your AI Agent Squad (Week 1 - 30 mins)

**Goal**: Make your framework cross-platform compatible AND spec-driven in minimal time.

---

## The Three Files You Need RIGHT NOW

### File 1: Create `agents/Keisha/AGENTS.md`

Copy this exactly to `agents/Keisha/AGENTS.md`:

```markdown
# Agent: Keisha (Planner & Analyst)

## Role Identity
**Title**: Strategic Planner & Requirements Analyst  
**Specialty**: PRD creation, market research, scope definition  
**Input**: Feature description (1-3 sentences)  
**Output**: Product Requirements Document (PRD)  
**Time Budget**: 2 hours per feature  

## Core Instructions

### Task: Create a PRD
When asked to plan a feature, you MUST:

1. **Research** (15 mins)
   - Check `/specs/system-architecture.md` for tech stack constraints
   - Check `/specs/testing-standards.md` for quality gates
   - Check `/changes/` folder for similar past features

2. **Interview** (15 mins)
   - Ask clarifying questions if unclear
   - Validate assumptions with stakeholder

3. **Structure the PRD** (60 mins) - Use this exact format:

   # PRD: [Feature Name]
   
   **Feature**: [1 sentence description]  
   **Owner**: Keisha  
   **Status**: Draft  
   **Date**: [today]
   
   ---
   
   ## 1. Problem Statement
   [Why this feature? Market need? User pain point?]
   
   ## 2. Functional Requirements
   - FR-001: [Specific, testable requirement]
   - FR-002: [Specific, testable requirement]
   - [... at least 5-10 total ...]
   
   ## 3. Non-Functional Requirements
   - NFR-001: Performance - API responses <200ms
   - NFR-002: Security - All data encrypted at rest
   - [... at least 3-5 total ...]
   
   ## 4. User Stories (Gherkin Format)
   
   ### US-001: User can [action]
   Given [initial state]
   When [user action]
   Then [expected result]
   
   ### US-002: ...
   [... at least 10 stories ...]
   
   ## 5. Acceptance Criteria
   - [ ] All user stories can be tested
   - [ ] No ambiguous language ("intuitive", "fast", "good")
   - [ ] Dependencies listed
   - [ ] Edge cases identified
   
   ## 6. MVP Scope
   **In MVP**:
   - Feature A
   - Feature B
   
   **NOT in MVP** (future phases):
   - Feature C
   - Feature D
   
   ## 7. Risks & Mitigations
   | Risk | Impact | Mitigation |
   |------|--------|-----------|
   | [Risk 1] | High | [How to mitigate] |
   
   ## 8. Dependencies
   - [ ] Database migration needed?
   - [ ] Third-party API key required?
   - [ ] Design approval?
   
   ## 9. Questions for Stakeholders
   - [ ] Question 1?
   - [ ] Question 2?

### Quality Gates - Your PRD is READY when:
- ✅ Has all 9 sections above
- ✅ Each FR/NFR/US is uniquely numbered
- ✅ No vague language
- ✅ MVP scope is explicit
- ✅ At least 10 user stories
- ✅ References `/specs/` constraints

### Deployment Instructions

#### For Claude Code
1. Create new project chat
2. Paste this entire AGENTS.md file
3. Set system instruction: 
   "You are Keisha, the Planner. Follow every instruction in the AGENTS.md file exactly."
4. User asks: "@keisha plan [feature description]"
5. You output PRD following the structure above

#### For Cursor
1. Add to .cursorrules file:
   "You are Keisha, the Planner AI.
   When planning features, follow the PRD structure in agents/Keisha/AGENTS.md
   Output Markdown with all 9 sections."
2. User provides feature description
3. You output complete PRD

#### For Gemini AI Studio
1. Create new Gem
2. Upload AGENTS.md as knowledge file
3. System instruction:
   "You are Keisha. Always output PRDs using the 9-section structure from AGENTS.md"
4. Test with: "Plan: add user authentication"

#### For ChatGPT Custom GPT
1. Create Custom GPT
2. Knowledge: Upload agents/Keisha/AGENTS.md
3. Instructions: [Paste full AGENTS.md]
4. Enable: Code Interpreter
5. Test request: "Plan: integrate Stripe payments"
```

---

### File 2: Create `specs/system-architecture.md`

**Save this to `specs/system-architecture.md`:**

```markdown
# System Architecture Specification

## Project: House of OBI Astrology Platform

### Technology Stack
- **Language**: Rust / Leptos (Frontend), Go (Backend)
- **Database**: PostgreSQL (primary), Redis (cache)
- **Auth**: JWT + OAuth2 (Google, Apple)
- **Deployment**: GCP Cloud Run
- **Frontend Hosting**: Vercel (optional) / GCP Storage + CDN

### Core Architectural Constraints
1. **API Response Time**: <200ms p95 (measured)
2. **Database Query Time**: <100ms p95 (no N+1 queries)
3. **Test Coverage**: Minimum 85% (excluding test utilities)
4. **Code Size Limit**: No single file >500 LOC
5. **Dependency Policy**: Approve new deps with tech lead first

### Layers & Responsibilities

**Layer 1: API Gateway**
- JWT validation
- Rate limiting (1000 req/min per user)
- Request logging
- Error response standardization

**Layer 2: Business Logic**
- Domain models (BirthChart, User, Synastry)
- Validation rules
- Calculation engines (vedic, western astrology)

**Layer 3: Data Access**
- PostgreSQL queries
- Cache invalidation strategy
- Migration version control

**Layer 4: External Integrations**
- Stripe API (payments)
- SendGrid (email)
- OAuth2 providers

### Security Requirements
- All passwords: bcrypt (cost 12+)
- All secrets: environment variables only
- No secrets in code, config files, or logs
- SQL injection prevention: Use parameterized queries
- CORS: Whitelist specific origins only

### Known Tech Debt
- [ ] User authentication needs refresh token rotation
- [ ] Email verification requires rate limiting
- [ ] Astrology calculations need ephemeris table updates (monthly)

### Rationale
- Rust: Type safety for astrology calculations (no null pointer errors)
- PostgreSQL: ACID guarantees for user data
- Redis: Fast cache for repeated birth chart lookups
- GCP: Easy integrations with APIs we use
```

### File 3: Create `docs/AGENT_INTEROP.md`

**Save this to `docs/AGENT_INTEROP.md`:**

```markdown
# Agent Interoperability Protocol (AIOP v1.0)

## Standard Handoff Format

All agents produce output with this header:

---
from_agent: [Keisha|Ox|Soulja-Slim|DMX|Igor|Suge]
to_agent: [next agent or "Archive"]
feature_id: [example: "astrology-compatibility-mvp"]
date: YYYY-MM-DD
stage: [Planning|Preflight|Building|Testing|Review]
status: [Draft|Ready|Approved|Blocked]
---

# [Artifact Content]

## The 5-Stage Pipeline

┌─────────────────────────────────────┐
│ 1. PLANNING (Keisha)                │
│ Input: Feature description          │
│ Output: PRD (9 sections)            │
│ Location: /changes/[feature]/prd.md │
└──────────────────┬──────────────────┘
                   │
                   ▼
┌─────────────────────────────────────┐
│ 2. PREFLIGHT (Soulja-Slim)          │
│ Input: PRD from Keisha              │
│ Output: Checklist (10-20 items)     │
│ Location: /changes/[feature]/...    │
└──────────────────┬──────────────────┘
                   │
                   ▼
┌─────────────────────────────────────┐
│ 3. BUILDING (Ox)                    │
│ Input: PRD + Checklist              │
│ Output: Code + Tests                │
│ Location: /changes/[feature]/code/  │
└──────────────────┬──────────────────┘
                   │
                   ▼
┌─────────────────────────────────────┐
│ 4. TESTING (Soulja-Slim)            │
│ Input: Code + Tests                 │
│ Output: QA Report                   │
│ Location: /changes/[feature]/qa/    │
└──────────────────┬──────────────────┘
                   │
                   ▼
┌─────────────────────────────────────┐
│ 5. REVIEW (DMX)                     │
│ Input: QA Report                    │
│ Output: Merge/No-Merge decision     │
│ Location: /changes/[feature]/review/│
└──────────────────┬──────────────────┘
                   │
                   ▼
        ✅ FEATURE MERGED

## Validation Checklist (Between Each Stage)

### After Keisha → Before Soulja-Slim
- [ ] PRD has all 9 sections
- [ ] FR-001 through FR-N are present
- [ ] User stories use Given/When/Then format
- [ ] MVP scope explicitly lists exclusions
- [ ] No technical decisions in PRD

### After Soulja-Slim → Before Ox
- [ ] Preflight checklist complete
- [ ] No architectural blockers
- [ ] Dependencies documented
- [ ] Test strategy defined

### After Ox → Before Soulja-Slim (QA)
- [ ] All tests passing locally
- [ ] Code coverage ≥85%
- [ ] No secrets in code
- [ ] Follows project conventions

### After Soulja-Slim → Before DMX
- [ ] Security scan clean
- [ ] Performance requirements met
- [ ] Database migrations ready
- [ ] Backwards compatible

## Failure Handling

If any stage BLOCKS (validation fails):

1. **Document** the issue in `/changes/[feature]/BLOCKERS.md`
2. **Notify** the previous agent with specific errors
3. **Fix** in that agent's stage, then re-run validation
4. **Do NOT proceed** to next stage until all checks pass

Example `/changes/[feature]/BLOCKERS.md`:

# Blockers for Astrology Compatibility

## Blocker #1: Missing Test Coverage
- Stage: After Ox
- Severity: Major
- Error: Code coverage is 72%, requires 85%
- Action: Ox must add tests for vedic calculation edge cases
- Assigned: Ox
- Status: In Progress

## Handoff Checklist

When moving from one agent to the next:

❌ Wrong way:
  - Copy text from PRD into Claude chat
  - Manually re-explain requirements
  - Hope agent understands context

✅ Right way:
  - Point agent to /changes/[feature]/ folder
  - Agent reads all artifacts in sequence
  - Agent validates checklist
  - Agent outputs next stage artifact
```

---

## Now Test It (30 minutes)

### Test Scenario: Simple Feature

**Step 1**: Copy File 1 (AGENTS.md) → `agents/Keisha/AGENTS.md`  
**Step 2**: Copy File 2 (system-architecture.md) → `specs/system-architecture.md`  
**Step 3**: Copy File 3 (AGENT_INTEROP.md) → `docs/AGENT_INTEROP.md`

**Step 4**: Create `/changes/` directory:
```bash
mkdir -p changes
mkdir -p specs
mkdir -p docs
```

**Step 5**: Test with Claude Code:

1. Open Claude Code
2. Create new project
3. Drag-and-drop `agents/Keisha/AGENTS.md` into chat
4. Set system prompt:
   "You are Keisha, the Planner AI. Follow all instructions in the attached AGENTS.md file.
   When the user asks you to plan a feature, output a complete PRD with all 9 sections."
5. Ask: `@keisha plan "Add user profile page with birth chart display"`

**Expected Output**: 
- Keisha creates a properly formatted PRD
- All 9 sections present
- 10+ user stories
- Numbered FR/NFR/US

**Step 6**: Review + Iterate:
- If good → Save to `/changes/profile-page-feature/prd.md`
- If missing sections → Iterate with Keisha until perfect

---

## Next Steps (After Week 1)

- [ ] Create AGENTS.md for Ox, Soulja-Slim, DMX
- [ ] Test full 5-stage pipeline with real feature
- [ ] Create CLI (`squad plan`, `squad build`, etc.)
- [ ] Add other specs (`api-contracts.md`, `testing-standards.md`)
- [ ] Test on Cursor, Gemini, ChatGPT (platform expansion)

---

## Key Wins After Week 1

| Metric | Before | After |
|--------|--------|-------|
| **Cross-Platform** | Claude only | Any platform via AGENTS.md |
| **Spec Tracking** | Manual docs | Git-versioned `/specs/` + `/changes/` |
| **Agent Handoffs** | Chat copy-paste | Structured AIOP protocol |
| **Onboarding** | Hours | Minutes (just read AGENTS.md) |
| **Consistency** | Variable | Standard via checklists |

---

## Quick Troubleshooting

**Q**: Keisha's PRD missing sections?  
**A**: Check AGENTS.md file 1 - ensure system prompt includes "all 9 sections"

**Q**: Agent doesn't reference `/specs/`?  
**A**: Add to system prompt: "Always read /specs/system-architecture.md first"

**Q**: How do I test on multiple platforms?  
**A**: Each platform gets slightly different setup (see AGENTS.md deployment section)

---

**You're now spec-driven + cross-platform! 🚀**
