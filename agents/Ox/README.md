# OX: Setup Guide
## Master Coder & Architect Agent

---

## Quick Reference

| Attribute | Value |
|-----------|-------|
| **Role** | Executor (Implementation) |
| **Trigger** | `@ox` |
| **Kernel** | Multi-language (Rust, TypeScript, Go, Python) |
| **Specialty** | TDD, Production Code, Refactoring, Architecture |
| **Constraint** | Dev env only, no mocks |

---

## Setup by Platform

### 🚀 Antigravity (This IDE)

**Already configured!** Just use:
```
@ox build [feature] with tests first
@ox refactor [code] for clarity
```

If you want enhanced capabilities, add to your user rules:
```
When I say @ox, use the Ox_Space_Prompt.md as your system instruction.
```

---

### 🤖 Claude (claude.ai)

**Option 1: Projects**
1. Create new Project
2. Add `Ox_Space_Prompt.md` to Project Knowledge
3. In chat, type `@ox [request]`

**Option 2: Direct Paste**
1. Start new chat
2. Paste contents of `Ox_Space_Prompt.md` at top
3. Continue conversation as Ox

---

### 💻 VS Code (with Continue/Cline)

**For Continue:**
1. Open `.continue/config.json`
2. Add custom slash command:
```json
{
  "customCommands": [
    {
      "name": "ox",
      "description": "Activate Ox coder",
      "prompt": "[paste Ox_Space_Prompt.md content]"
    }
  ]
}
```
3. Use: `/ox build this feature`

**For Cline:**
1. Create `.cline/prompts/ox.md`
2. Paste `Ox_Space_Prompt.md` content
3. Reference in Cline settings

---

### 🌐 ChatGPT (Web App)

**Option 1: Custom GPT**
1. Go to: chat.openai.com → Explore GPTs → Create
2. Name: "Ox - AI Code Architect"
3. Instructions: Paste `Ox_Space_Prompt.md` content
4. Enable: Code Interpreter
5. Save and use

**Option 2: Direct Chat**
1. Start new chat
2. Paste Ox prompt at start
3. Say: "You are now Ox. Stay in character."

---

### 🔮 Gemini (Google AI Studio)

1. Go to: aistudio.google.com
2. Create new chat
3. Click "System Instructions"
4. Paste `Ox_Space_Prompt.md` content
5. Enable code execution
6. Chat as Ox

---

### 🌊 Perplexity Spaces

1. Create new Space
2. Name: "Ox - AI Code Architect"
3. Description: "Master coder with TDD, builds production-ready code"
4. Instructions: Paste `Ox_Space_Prompt.md` content
5. Save and use Space

---

## Commands

| Command | Description | Output |
|---------|-------------|--------|
| `@ox build [feature]` | Implement feature with TDD | Code + tests + docs |
| `@ox refactor [code]` | Improve existing code | Refactored code + evidence |
| `@ox optimize [code]` | Performance optimization | Optimized code + benchmarks |
| `@ox fix [issue]` | Debug and fix | Fix + regression test |
| `@ox show pattern for [X]` | Demonstrate pattern | Working example |

---

## Exclusive Tools (Multi-Language Kernels)

| Language | Tools |
|----------|-------|
| **Rust** | `rustc`, `cargo`, `cargo clippy`, `cargo fmt` |
| **TypeScript** | `tsc`, `esbuild`, `prettier`, `eslint` |
| **Go** | `go build`, `gofmt`, `go vet` |
| **Python** | `black`, `ruff`, `mypy` |
| **Dec 2025** | Edge Functions, WASM, Bun, Server Components, Streaming |

---

## TDD Workflow

```
1. RED:   Write failing test first
2. GREEN: Minimal code to pass
3. REFACTOR: Improve without breaking tests
```

Every output includes:
- Coverage: XX%
- Complexity: X.X
- Tests: XX/XX passing

---

## Handoff

When implementation is done:
```
@soulja validate this implementation
```

---

## Exit Character

To dismiss Ox:
```
@dismiss
exit ox
switch to [other agent]
```

---

## Files in This Folder

| File | Purpose |
|------|---------|
| `Ox_Space_Prompt.md` | Full system prompt (copy this) |
| `Ox_Master_Coder_System.md` | Detailed role documentation |
| `Ox_System_Prompt_Integration.md` | Integration examples |
| `README.md` | This file |
