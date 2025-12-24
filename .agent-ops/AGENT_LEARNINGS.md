# Agent Learnings

**Purpose:** Durable insights for agents working on this codebase.

---

## Project Context

- **Product:** Project A — Comparison + Timing domain app
- **Stack:** Leptos (Rust/WASM) frontend, Rust/Axum backend, PostgreSQL + Database
- **Pricing:** 4-tier subscription (Starter/Core/Pro/Cosmic)

---

## Critical Rules

### 1. Sidereal System Standard
- **Zodiac:** Sidereal (Krishnamurti 23.8° ayanamsa)
- **Houses:** Koch (Core System)
- **Never use Tropical for calculations** — only as reference layer

### 2. Timing vs Comparison Scope
- **Timing (5-posture):** GO/GROW/GLOW/GROUND/RESET — for calendar only
- **Comparison:** Full compatibility analysis — unchanged

### 3. Stripe SKU Format
- Format: `levite_[tier]_[billing]`
- Example: `levite_core_monthly`, `levite_pro_annual`

### 4. No Hardcoded Secrets
- All API keys in `.env`
- Never commit `.env` files

---

## Architectural Decisions

| Decision | Rationale |
|----------|-----------|
| Leptos over React | Rust end-to-end, WASM performance |
| Hybrid backend | Node gateway + Rust engine sidecar |
| Redis caching | 6-hour TTL for timing signals |
| Swiss Ephemeris | Required for Core accuracy |

---

## Common Pitfalls

| Pitfall | Solution |
|---------|----------|
| Moon sign drift | Always use sidereal, not tropical |
| Timezone errors | Store all times as UTC, convert on display |
| Stripe webhook missing | Check `STRIPE_WEBHOOK_SECRET` in .env |
| Leptos hydration errors | Ensure SSR and CSR match |

---

## Recent Learnings

| Date | Learning |
|------|----------|
| 2025-12-21 | 5-posture system is timing-only, doesn't replace comparison |
| 2025-12-21 | White-label B2B is $99-299/mo per seat |
| 2025-12-21 | Translation Engine uses weighted threshold resolution |

---

## File Locations

| What | Where |
|------|-------|
| Product brief | `docs/levite-product-brief.md` |
| Feature matrix | `docs/prd/FEATURE_MATRIX.md` |
| User stories | `docs/prd/USER_STORIES.md` |
| API backend | `api/src/` |
| Frontend | `levite-web/src/` |
| Shared types | `shared/src/` |
