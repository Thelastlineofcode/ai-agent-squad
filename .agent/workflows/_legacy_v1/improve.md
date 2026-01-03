---
description: Improve the product and codebase without adding new features
---

# /improve Workflow

Use this workflow to refine, harden, and optimize the existing system without introducing new functional requirements. Focus on quality, DX, performance, and stability.

## Steps

### 1. Audit for Refinement Targets
```
@keisha audit the codebase specifically for:
- Dead code / bloat
- Overly complex logic (complexity > 8)
- Inconsistent patterns
- Document/prompt quality gaps
```

### 2. Brainstorm Optimization
```
@keisha brainstorm non-feature improvements for [TARGET_AREA]
```
Focus on:
- **DX**: Standardizing paths, better error messages.
- **Stability**: Hardening prompts, guardrails.
- **Performance**: Optimizing tool snippets, reducing prompt tokens.
- **Security**: Hardening "exclusive tool" definitions.

### 3. Plan Refinement
```
@keisha create a refinement plan for [TARGET_AREA]
```
- Must NOT add new features.
- Must show measurable improvement (e.g., complexity reduced from X to Y).
- Must show impact on DX or Stability.

### 4. Execute Refinement
```
@ox execute the refinement plan
```
- Refactor the code/docs.
- Provide evidence (before/after metrics).
- Ensure no behavior regressions.

### 5. Validate Refinement 
```
@soulja validate refinement. Focus on:
- No regression in existing functionality.
- Improvement in security/performance/stability.
- Passes all 5 validation layers.
```

### 6. Review & Enforce
```
@dmx final review of refinement.
```
- Ensure changes didn't introduce complexity.
- Verify consistency.

## Refinement Principles
- **Simplify**: If it can be done with less code/text, do it.
- **Harden**: Make it harder to break or misuse.
- **Clarify**: Make it easier for others (and AI) to understand.
- **Trim**: Remove what doesn't add value.

## Difficult Decisions
If a refinement requires a trade-off that affects existing developers:
```
@dmx I need human input on [REFINEMENT_TRADE_OFF]
```
