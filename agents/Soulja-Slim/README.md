# SOULJA SLIM: Setup Guide
## Validator Agent

---

## Quick Reference

| Attribute | Value |
|-----------|-------|
| **Role** | Validator |
| **Triggers** | `@tester`, `@soulja` |
| **Kernel** | Shell / Python |
| **Specialty** | Testing, Security Scanning, Validation, Debugging |

---

## Setup by Platform

### 🚀 Antigravity (This IDE)

**Already configured!** Just use:
```
@tester validate [feature]
@soulja run security scan
```

If you want enhanced capabilities, add to your user rules:
```
When I say @tester or @soulja, use the SouljaSlim_Space_Prompt.md as your system instruction.
```

---

### 🤖 Claude (claude.ai)

**Option 1: Projects**
1. Create new Project
2. Add `SouljaSlim_Space_Prompt.md` to Project Knowledge
3. In chat, type `@tester [request]`

**Option 2: Direct Paste**
1. Start new chat
2. Paste contents of `SouljaSlim_Space_Prompt.md` at top
3. Continue conversation as Soulja

---

### 💻 VS Code (with Continue/Cline)

**For Continue:**
1. Open `.continue/config.json`
2. Add custom slash command:
```json
{
  "customCommands": [
    {
      "name": "tester",
      "description": "Activate Soulja tester",
      "prompt": "[paste SouljaSlim_Space_Prompt.md content]"
    }
  ]
}
```
3. Use: `/tester validate this code`

**For Cline:**
1. Create `.cline/prompts/soulja.md`
2. Paste `SouljaSlim_Space_Prompt.md` content
3. Reference in Cline settings

---

### 🌐 ChatGPT (Web App)

**Option 1: Custom GPT**
1. Go to: chat.openai.com → Explore GPTs → Create
2. Name: "Soulja Slim - AI Test Architect"
3. Instructions: Paste `SouljaSlim_Space_Prompt.md` content
4. Enable: Code Interpreter
5. Save and use

**Option 2: Direct Chat**
1. Start new chat
2. Paste Soulja prompt at start
3. Say: "You are now Soulja Slim. Stay in character."

---

### 🔮 Gemini (Google AI Studio)

1. Go to: aistudio.google.com
2. Create new chat
3. Click "System Instructions"
4. Paste `SouljaSlim_Space_Prompt.md` content
5. Enable code execution
6. Chat as Soulja

---

### 🌊 Perplexity Spaces

1. Create new Space
2. Name: "Soulja Slim - AI Test Architect"
3. Description: "Validator and security guardian"
4. Instructions: Paste `SouljaSlim_Space_Prompt.md` content
5. Save and use Space

---

## Commands

| Command | Description | Output |
|---------|-------------|--------|
| `@tester validate [feature]` | Full 5-layer validation | Pass/Fail report |
| `@soulja run security scan` | Security analysis | Vulnerability report |
| `@tester debug [error]` | Root cause analysis | Fix recommendation |
| `@soulja check coverage` | Coverage analysis | Coverage report |
| `@tester run performance test` | Load/stress testing | Performance metrics |

---

## 5-Layer Validation

| Layer | What | Tools |
|-------|------|-------|
| 1. Unit | Isolated logic tests | pytest, cargo test, vitest |
| 2. Integration | Module interactions | Real dependencies |
| 3. E2E | Full workflows | API/browser tests |
| 4. Security | Vulnerabilities | bandit, trufflehog, cargo-audit |
| 5. Performance | Load/stress | k6, memory profilers |
| 6. Resilience | Circuit breakers, degradation | Custom tests |
| 7. Penetration | Fuzzing, auth bypass, IDOR | Security tests |

---

## Exclusive Tools (Shell/Python)

| Category | Tools |
|----------|-------|
| **Python Tests** | `pytest`, `coverage` |
| **Rust Tests** | `cargo test`, `cargo-audit` |
| **JS/TS Tests** | `vitest`, `jest` |
| **Security** | `bandit`, `trufflehog`, `pip-audit` |
| **Performance** | `k6`, `memory_profiler` |

---

## Handoff

When validation passes:
```
@dmx take it from here
```

When validation fails:
```
@ox fix these issues: [list]
```

---

## Exit Character

To dismiss Soulja:
```
@dismiss
exit soulja
switch to [other agent]
```

---

## Files in This Folder

| File | Purpose |
|------|---------|
| `SouljaSlim_Space_Prompt.md` | Full system prompt (copy this) |
| `Soulja_Slim_Validator_System.md` | Detailed role documentation |
| `Soulja_Slim_System_Prompt.md` | Legacy prompt |
| `README.md` | This file |
