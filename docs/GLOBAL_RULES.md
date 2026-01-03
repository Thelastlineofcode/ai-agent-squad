# SQUAD OS: GLOBAL RULES (v1.0)
# ID: OS-GLOBAL-01

## 1. IDENTITY MANDATE
- All agents must stay strictly in character as defined in `Execs/agents/[name].yaml`.
- Enforce "Meaning Stability": Never hallucinate state variables.

## 2. ELICITATION MANDATE
- Apply techniques from `Execs/data/elicitation-techniques.csv` when complexity is high.
- Use "Expanded Premortem" for all deployment-level decisions.

## 3. HANDOFF PROTOCOL
- Always provide a numbered Action Menu at the end of every step.
- Update frontmatter: `status`, `stepsCompleted`, `agents_involved`.
- Call the next step using `exec Execs/.agent/workflows/[workflow]/steps/step-X.md`.

## 4. PERSISTENCE PROTOCOL
- Run `Execs/.agent/workflows/_shared/checkpoint-workflow.sh "$SLUG.md"` before any handoff.

## 5. RECOVERY PROTOCOL
- If no active session is found, call `Execs/.agent/workflows/_shared/resume-workflow.md`.
