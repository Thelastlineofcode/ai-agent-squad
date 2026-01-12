# Agent Learnings
## Consolidated Knowledge & Patterns

Insights gathered by agents during development. Updated after each sprint.

---

## Architecture Decisions

| Date | Decision | Rationale | Agent |
|------|----------|-----------|-------|
| 2026-01-10 | Use Ops Board + Learnings for agent coordination | Claude should review/plan/steer, not spawn sub-agents. Ops board tracks tasks, learnings sync knowledge across sessions. | @claude |
| 2026-01-10 | Webhook Dead Letter Queue (DLQ) pattern | Failed webhooks logged to `webhook_failures` table with retry logic (1min, 5min, 15min exponential backoff). Prevents payment processing data loss. | @keisha |
| 2026-01-10 | Tier-based access control middleware | Reusable `check_tier()` function returns structured error with upgrade URL. Cleaner than inline checks. | @keisha |
| 2026-01-10 | Payment audit logging in separate table | `payment_logs` table separate from users table for compliance and audit trail. Stripe payment_id unique constraint. | @keisha |

---

## Patterns That Worked

| Pattern | Context | Why It Worked | Agent |
|---------|---------|---------------|-------|
| Stripe metadata for tier upgrades | Payment webhook handler extracts `user_id` and `tier` from `payment_intent.metadata` | Clean separation between payment provider and app logic. Metadata is flexible and Stripe-native. | @keisha |
| Decimal for currency storage | Convert Stripe cents (i64) to Decimal before DB insert: `Decimal::from_f64(amount as f64 / 100.0)` | Prevents floating point precision issues with money. PostgreSQL DECIMAL(10,2) matches. | @keisha |
| Leptos 0.7 NodeRef dereference | Use `(*node_ref)` instead of `.deref()` for HtmlElement extraction | Type inference works correctly, avoids E0282 errors. Pattern: `let el: HtmlCanvasElement = (*canvas_ref).clone();` | @ide |
| Flexible date parsing in validation | `parse_flexible_date()` from shared crate supports ISO, US, EU, full month formats | Better UX - users can input dates naturally. Already exists at `api/src/models/validation.rs:110` | @keisha |

---

## Anti-Patterns Discovered

| Anti-Pattern | Context | Why It Failed | Fix | Agent |
|--------------|---------|---------------|-----|-------|
| Using `.deref()` on NodeRef in Leptos 0.7 | Leptos frontend components | Causes type inference errors (E0282) in Leptos 0.7 | Use dereference operator: `(*node_ref)` | @ide |
| Missing `use leptos::html;` import | Leptos 0.7 components using HTML elements | Causes E0433 "cannot find html in crate leptos" | Always import: `use leptos::html;` when using typed HTML elements | @ide |
| Forgetting `.forget()` on UnmountHandle | Leptos mount in main.rs | Generates warnings about unused UnmountHandle | Add `.forget()` to mount call: `leptos::mount::mount_to_body(App).forget();` | @ide |
| Jules PR using Leptos 0.6 patterns | Jules PR #35 mixed old/new Leptos syntax | 42 compilation errors from outdated patterns | Always verify Jules work against current dependencies before merge | @claude |

---

## Security Findings

| Finding | Severity | Fix Applied | Date | Agent |
|---------|----------|-------------|------|-------|
| - | - | - | - | - |

---

## Performance Insights

| Insight | Before | After | Improvement | Agent |
|---------|--------|-------|-------------|-------|
| - | - | - | - | - |

---

## Tech Debt Logged

| Item | Priority | Effort | Assigned To | Status |
|------|----------|--------|-------------|--------|
| - | - | - | - | - |

---

## How to Update

Agents add learnings when:
1. **@keisha**: New architecture decisions, patterns discovered during audits
2. **@ox**: Patterns that worked, anti-patterns discovered during implementation
3. **@soulja**: Security findings, performance insights, anti-patterns in tests
4. **@dmx**: Quality insights, tech debt identified during review
