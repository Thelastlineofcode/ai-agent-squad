# DMX: Setup Guide
## Enforcer & Release Manager Agent

---

## Quick Reference

| Attribute | Value |
|-----------|-------|
| **Role** | Enforcer & Release Manager |
| **Triggers** | `@dmx`, `@reviewer` |
| **Kernel** | Python / Shell |
| **Specialty** | Code Review, Quality Gates, Deployment Authorization |

---

## Setup by Platform

### 🚀 Antigravity (This IDE)

**Already configured!** Just use:
```
@dmx review [code]
@reviewer approve for production
```

If you want enhanced capabilities, add to your user rules:
```
When I say @dmx or @reviewer, use the DMX_Space_Prompt.md as your system instruction.
```

---

### 🤖 Claude (claude.ai)

**Option 1: Projects**
1. Create new Project
2. Add `DMX_Space_Prompt.md` to Project Knowledge
3. In chat, type `@dmx [request]`

**Option 2: Direct Paste**
1. Start new chat
2. Paste contents of `DMX_Space_Prompt.md` at top
3. Continue conversation as DMX

---

### 💻 VS Code (with Continue/Cline)

**For Continue:**
1. Open `.continue/config.json`
2. Add custom slash command:
```json
{
  "customCommands": [
    {
      "name": "dmx",
      "description": "Activate DMX reviewer",
      "prompt": "[paste DMX_Space_Prompt.md content]"
    }
  ]
}
```
3. Use: `/dmx review this PR`

**For Cline:**
1. Create `.cline/prompts/dmx.md`
2. Paste `DMX_Space_Prompt.md` content
3. Reference in Cline settings

---

### 🌐 ChatGPT (Web App)

**Option 1: Custom GPT**
1. Go to: chat.openai.com → Explore GPTs → Create
2. Name: "DMX - AI Release Manager"
3. Instructions: Paste `DMX_Space_Prompt.md` content
4. Enable: Code Interpreter
5. Save and use

**Option 2: Direct Chat**
1. Start new chat
2. Paste DMX prompt at start
3. Say: "You are now DMX. Stay in character."

---

### 🔮 Gemini (Google AI Studio)

1. Go to: aistudio.google.com
2. Create new chat
3. Click "System Instructions"
4. Paste `DMX_Space_Prompt.md` content
5. Enable code execution
6. Chat as DMX

---

### 🌊 Perplexity Spaces

1. Create new Space
2. Name: "DMX - AI Release Manager"
3. Description: "Final quality gate and deployment authority"
4. Instructions: Paste `DMX_Space_Prompt.md` content
5. Save and use Space

---

## Commands

| Command | Description | Output |
|---------|-------------|--------|
| `@dmx review [code]` | Full code review | Review report + decision |
| `@reviewer approve` | Final approval | APPROVED / BLOCKED |
| `@dmx check deployment` | Verify deploy readiness | Checklist status |
| `@dmx explain [violation]` | Explain quality issue | Explanation + correct pattern |

---

## Quality Gates Enforced

| Gate | Threshold | Source |
|------|-----------|--------|
| Complexity | < 12 avg, < 15 max | Keisha's standards |
| Coverage | > 85%, critical > 95% | Keisha's standards |
| Security | 0 critical/high | Soulja Slim's scan |
| Performance | No regression | Soulja Slim's baseline |
| Architecture | Sound + scalable | DMX review |

---

## Decision Matrix

| Condition | Decision |
|-----------|----------|
| All gates pass | ✅ APPROVED |
| Standards violated | ❌ BLOCKED |
| Minor concerns | ⚠️ APPROVED WITH WARNINGS |
| Security issue | ❌ BLOCKED (immediate) |

---

## Exclusive Tools (Python/Shell)

| Tool | Purpose |
|------|---------|
| `difflib` | Code diff analysis |
| `git diff` | Change analysis |
| `json-diff` | Config comparison |
| Health check scripts | Deployment verification |
| Metrics dashboards | Quality tracking |

---

## Handoff

When approved:
```
Ship it. 🚀
```

When blocked:
```
@ox fix these issues: [list]
```

---

## Exit Character

To dismiss DMX:
```
@dismiss
exit dmx
switch to [other agent]
```

---

## Files in This Folder

| File | Purpose |
|------|---------|
| `DMX_Space_Prompt.md` | Full system prompt (copy this) |
| `DMX_Enforcer_System.md` | Detailed role documentation |
| `DMX_System_Prompt.md` | Legacy prompt |
| `README.md` | This file |
