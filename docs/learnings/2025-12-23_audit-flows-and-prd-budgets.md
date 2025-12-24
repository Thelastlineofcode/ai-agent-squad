# Learnings: audit flows and prd budgets

Date: 2025-12-23 17:24:28
Docs root: /Users/houseofobi/Documents/Agent-Builder/Execs/docs
Learnings dir: /Users/houseofobi/Documents/Agent-Builder/Execs/docs/learnings

Keywords:
- audit flows
- audit templates
- limiters
- guardrails
- user stories
- tech debt budget

Matched docs:
- Execs/docs/quick-commands.md
- Execs/docs/slash-commands.md
- Execs/docs/orchestration.md
- Execs/docs/limiters.md
- Execs/docs/auto-workflow.md
- Execs/docs/audits/README.md
- Execs/docs/audits/classifications.md
- Execs/docs/audits/templates/keisha-tech-debt-audit.template.md
- Execs/docs/audits/templates/keisha-requirements-audit.template.md
- Execs/docs/learnings/2025-12-23_auto-workflow.md
- Execs/docs/learnings/2025-12-23_tdd-guardrails.md

Key excerpts:
- Execs/docs/quick-commands.md
  - L33: ### GUARDRAILS (Scripts)
  - L35: python Execs/dev-tools/guardrails/guardrails.py --voice ox --feature [slug]
  - L39: python Execs/dev-tools/guardrails/guardrails.py --voice ox --feature [slug] --stack [stack] --test-cmd "[cmd]"
  - L42: python Execs/dev-tools/guardrails/guardrails.py --voice soulja --feature [slug] --stage preflight
  - L66: Output: Stack/test command verification + guardrails PASS/BLOCKED (5-10 min)
- Execs/docs/slash-commands.md
  - L30: | | `/guardrails` | `/guardrails [slug]` | Feature slug | PASS/BLOCKED report | TDD + artifact enforcement |
  - L58: - @soulja preflight (guardrails --stage preflight)
  - L60: - @soulja validate (guardrails --stage post)
  - L365: #### `/guardrails`
  - L368: Usage: /guardrails [slug]
- Execs/docs/orchestration.md
  - L9: - Tech debt/bloat gates are enforced in `Execs/docs/limiters.md`.
  - L21: │  @soulja [preflight] →  TDD Gate | Stack | Guardrails       │
  - L156: - Runs guardrails: `python Execs/dev-tools/guardrails/guardrails.py --voice soulja --feature core-workflows --stage preflight`
  - L495: Soulja Slim preflights stack/test command + guardrails.
- Execs/docs/limiters.md
  - L1: # Tech Debt & Bloat Limiters
  - L4: These limiters are enforced by process and guardrails. If a limiter fails, DMX blocks release.
  - L11: - **Tech Debt Budget**: what debt is allowed (if any) and why
  - L15: - Tech Debt Budget: <none | limited + reason>
  - L20: ## Limiters (Hard Gates)
- Execs/docs/auto-workflow.md
  - L13: - `tdd-<feature>.md` (use `Execs/dev-tools/guardrails/tdd-evidence.template.md`)
  - L24: - `python Execs/dev-tools/guardrails/guardrails.py --voice soulja --feature <feature> --stage preflight`
  - L27: 4. **Soulja Slim (Validate)** runs full 5-layer validation + `--stage post` guardrails.
  - L44: ## CI Guardrails
  - L46: - `.github/workflows/guardrails.yml` enforces preflight guardrails on PRD changes.
- Execs/docs/audits/README.md
  - L2: ## Canonical audit flows, templates, and reports
  - L4: All audit flows live here. All audit reports are stored under `Execs/docs/audits/reports/`.
- Execs/docs/audits/classifications.md
  - L18: - **Requirements**: PRD, user stories, scope, acceptance criteria
- Execs/docs/audits/templates/keisha-tech-debt-audit.template.md
  - L8: - Tech debt budget (PRD)
  - L23: | Tech Debt Budget | | YES/NO | |
- Execs/docs/audits/templates/keisha-requirements-audit.template.md
  - L9: - User stories (US-#)
  - L30: | Tech Debt Budget | YES/NO | |
- Execs/docs/learnings/2025-12-23_auto-workflow.md
  - L10: - guardrails
  - L18: - Execs/docs/learnings/2025-12-23_tdd-guardrails.md
  - L22: - L33: ### GUARDRAILS (Scripts)
  - L23: - L35: python Execs/dev-tools/guardrails/guardrails.py --voice ox --feature [slug]
  - L24: - L39: python Execs/dev-tools/guardrails/guardrails.py --voice ox --feature [slug] --stack [stack] --test-cmd "[cmd]"
- Execs/docs/learnings/2025-12-23_tdd-guardrails.md
  - L1: # Learnings: tdd guardrails
  - L8: - tdd guardrails

Summary:
- 

Open questions:
- 
