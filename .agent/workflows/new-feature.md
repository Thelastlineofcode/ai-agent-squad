---
description: Plan and build a new feature using the full agent pipeline
---

# /new-feature Workflow

This workflow orchestrates all 4 agents to plan, build, test, and approve a new feature.

## Steps

### 1. Activate Keisha for Planning
```
@keisha create prd for [FEATURE_NAME]
```
- Answer Keisha's clarifying questions
- Review the PRD and TASKLIST
- Approve or request changes

### 2. Hand Off to Ox for Implementation  
```
@ox build [FEATURE_NAME] following the PRD above
```
- Use `docfork` MCP to reference official library docs
- Use `docs-fetcher` MCP for code examples
- Ox will write tests first (TDD)
- Ox will implement the feature
- Ox will provide evidence (coverage, complexity)

### 3. Hand Off to Soulja for Validation
```
@soulja validate [FEATURE_NAME] implementation
```
- Soulja runs 5-layer validation
- If BLOCKED: return to step 2 with fixes
- If PASSED: proceed to step 4

### 4. Hand Off to DMX for Final Review
```
@dmx review [FEATURE_NAME] for production
```
- Use `docfork` MCP to verify against official patterns
- DMX reviews architecture and quality
- If BLOCKED: return to step 2 or 3
- If APPROVED: merge and deploy

## Success Criteria
- [ ] PRD created with acceptance criteria
- [ ] Code written with > 85% coverage
- [ ] All 5 validation layers pass
- [ ] DMX approval received
