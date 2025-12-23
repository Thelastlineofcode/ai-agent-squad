# Learnings: auto workflow

Date: 2025-12-23 15:37:19
Docs root: /Users/houseofobi/Documents/Agent-Builder/Execs/docs
Learnings dir: /Users/houseofobi/Documents/Agent-Builder/Execs/docs/learnings

Keywords:
- auto workflow
- branding
- guardrails

Matched docs:
- Execs/docs/quick-commands.md
- Execs/docs/slash-commands.md
- Execs/docs/orchestration.md
- Execs/docs/auto-workflow.md
- Execs/docs/branding.md
- Execs/docs/learnings/2025-12-23_tdd-guardrails.md

Key excerpts:
- Execs/docs/quick-commands.md
  - L33: ### GUARDRAILS (Scripts)
  - L35: python Execs/dev-tools/guardrails/guardrails.py --voice ox --feature [slug]
  - L39: python Execs/dev-tools/guardrails/guardrails.py --voice ox --feature [slug] --stack [stack] --test-cmd "[cmd]"
  - L42: python Execs/dev-tools/guardrails/guardrails.py --voice soulja --feature [slug] --stage preflight
  - L48: Output: Stack/test command verification + guardrails PASS/BLOCKED (5-10 min)
- Execs/docs/slash-commands.md
  - L29: | | `/guardrails` | `/guardrails [slug]` | Feature slug | PASS/BLOCKED report | TDD + artifact enforcement |
  - L57: - @soulja preflight (guardrails --stage preflight)
  - L59: - @soulja validate (guardrails --stage post)
  - L63: - Naming must match `Execs/docs/branding.md`
  - L362: #### `/guardrails`
- Execs/docs/orchestration.md
  - L16: │  @soulja [preflight] →  TDD Gate | Stack | Guardrails       │
  - L60: Branding canon is enforced via `Execs/docs/branding.md`.
  - L151: - Runs guardrails: `python Execs/dev-tools/guardrails/guardrails.py --voice soulja --feature kp-transits --stage preflight`
  - L490: Soulja preflights stack/test command + guardrails.
- Execs/docs/auto-workflow.md
  - L1: # Auto Workflow Mode
  - L13: - `tdd-<feature>.md` (use `Execs/dev-tools/guardrails/tdd-evidence.template.md`)
  - L21: - `python Execs/dev-tools/guardrails/guardrails.py --voice soulja --feature <feature> --stage preflight`
  - L24: 4. **Soulja (Validate)** runs full 5-layer validation + `--stage post` guardrails.
  - L32: - `Execs/docs/branding.md`
- Execs/docs/branding.md
  - L1: # Urban Branding Strategy
- Execs/docs/learnings/2025-12-23_tdd-guardrails.md
  - L1: # Learnings: tdd guardrails
  - L8: - tdd guardrails

Summary:
- 

Open questions:
- 
