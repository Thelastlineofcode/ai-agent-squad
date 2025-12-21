# Agent Productivity Suite

**Status:** ACTIVE ✅  
**Version:** 3.0  
**Stack:** Leptos (Rust/WASM) + Axum (Rust API)

---

## 🏗️ Project Structure

```bash
/                               # Monorepo root
├── api/                        # Rust/Axum backend
│   └── src/routes/             # API endpoints
├── levite-web/                 # Leptos source (Rust)
│   └── src/components/         # UI components
├── web/                        # Mirror/build output for Leptos
├── shared/                     # Shared Rust logic
└── docs/                       # PRDs and specifications
```

---

## 🛠️ Essential Commands

### Development
```bash
# Backend (api)
cd api && cargo run         # Run API server

# Frontend (levite-web)
cd levite-web && trunk serve # Run Leptos dev server
```

### Testing & Quality
```bash
cargo test                  # Run all Rust tests
npx playwright test         # Run E2E tests (from root)
cargo clippy                # Rust linting
```

### Git Workflow
```bash
git pull origin main --rebase
git add -A
git commit -m "prefix: description"
git push origin main
```

---

## 📝 PRD Templates

Always check `docs/prd/` before starting a feature. If missing, use this template:

```markdown
# PRD: [Feature Name]
**Sprint:** [Number] | **Priority:** [P0-P2]

## 1. Problem Statement
[What are we solving?]

## 2. Technical Constraints
- No JS/TS in UI (Leptos only)
- Sidereal calculations only
- Tier-specific gating (Starter/Core/Pro/Cosmic)

## 3. Implementation Details
- Routes to add
- Components to create
- Database changes

## 4. Acceptance Criteria
- [ ] List specific items
```

---

## 🔮 Astrological Logic Standard

- **Zodiac:** Sidereal (Krishnamurti Ayanamsa)
- **Engine:** `sweph` (Swiss Ephemeris)
- **Resolution:** Weighted threshold resolution for 5-posture timing
- **Glossary:**
  - GO: High momentum, favorable
  - GROW: Foundation building, expansion
  - GLOW: Connection, high visibility
  - GROUND: Stabilization, consolidation
  - RESET: Reflection, pivot, pause

---

*@keisha standing by.*
