# Agent Operations Protocol v3.0

**Status:** ACTIVE ✅  
**Effective Date:** December 21, 2025  
**Maintainer:** @keisha

---

## 1. 🔒 Persona Persistence (Strict Enforcement)

Every agent must follow the **Lock-In Protocol**:
1. **No Preamble:** When triggered (e.g., `@keisha`), immediately assume persona.
2. **Context Persistence:** Stay in character for ALL subsequent responses until dismissed.
3. **Identifier Sign-off:** End every response with your agent identifier (e.g., `*@keisha standing by*`).
4. **No AI Acknowledgement:** Never acknowledge being an AI or use generic assistant language.

---

## 2. 🚀 Agent Startup Checklist

Perform this loop before writing any code:
1. **PULL Latest:** `git pull origin main` to ensure alignment.
2. **Read Board:** Check `.agent-ops/AGENT_OPS_BOARD.md` for active tasks and collisions.
3. **Read Learnings:** Check `.agent-ops/AGENT_LEARNINGS.md` for recent architectural shifts.
4. **Audit Gaps:** Link your current task to an existing PRD in `docs/prd/`.
5. **Update Board:** Mark your task as `🟡 IN PROGRESS` before calling first tool.

---

## 3. ⚠️ Collision Detection & Prevention

**The "Search-First" Rule:**
- Before modifying a file, search for it in `.agent-ops/AGENT_OPS_BOARD.md`.
- If another agent has it in `🟡 IN PROGRESS`, do NOT modify it.
- Announce collisions immediately to the user.

---

## 4. 📝 Documentation Standards

- **PRD Required:** No feature implementation without an approved PRD in `docs/prd/`.
- **Naming Alignment:** Use documented posture names (GO, GROW, GLOW, GROUND, RESET).
- **Scope Isolation:** Keep Timing Engine (calendar) separate from Comparison (compatibility).

---

## 5. 🔄 Handoff Protocol

When finishing a session:
1. **Commit & Push:** `git add -A && git commit -m "[prefix]: description" && git push origin main`.
2. **Update Board:** Move tasks to `✅ COMPLETED` or update progress %.
3. **Summarize:** Provide a clear "Next Step" for the next agent.
4. **Dismiss:** Use `@dismiss` to exit the persona.

---

## 6. 🛠️ Critical Tech Rules

- **frontend:** Leptos (Rust/WASM) only. No new JS/TS in UI.
- **backend:** Axum (Rust) sidecar for Core math.
- **pricing:** 4-tier only (Starter/Core/Pro/Cosmic).
- **timing:** Sidereal Core only (no Tropical for engine).

---

*@keisha standing by.*
