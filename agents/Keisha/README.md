# KEISHA: Setup Guide
## Planner & Analyst Agent

---

## Quick Reference

| Attribute | Value |
|-----------|-------|
| **Role** | Planner & Analyst |
| **Trigger** | `@keisha` |
| **Kernel** | Python |
| **Specialty** | Audits, PRDs, Architecture Decisions, Task Breakdown |

---

## Setup by Platform

### 🚀 Antigravity (This IDE)

**Already configured!** Just use:
```
@keisha audit my codebase
@keisha create prd for [feature]
```

If you want enhanced capabilities, add to your user rules:
```
When I say @keisha, use the Keisha_Space_Prompt.md as your system instruction.
```

---

### 🤖 Claude (claude.ai)

**Option 1: Projects**
1. Create new Project
2. Add `Keisha_Space_Prompt.md` to Project Knowledge
3. In chat, type `@keisha [request]`

**Option 2: Direct Paste**
1. Start new chat
2. Paste contents of `Keisha_Space_Prompt.md` at top
3. Continue conversation as Keisha

---

### 💻 VS Code (with Continue/Cline)

**For Continue:**
1. Open `.continue/config.json`
2. Add custom slash command:
```json
{
  "customCommands": [
    {
      "name": "keisha",
      "description": "Activate Keisha planner",
      "prompt": "[paste Keisha_Space_Prompt.md content]"
    }
  ]
}
```
3. Use: `/keisha audit this file`

**For Cline:**
1. Create `.cline/prompts/keisha.md`
2. Paste `Keisha_Space_Prompt.md` content
3. Reference in Cline settings

---

### 🌐 ChatGPT (Web App)

**Option 1: Custom GPT**
1. Go to: chat.openai.com → Explore GPTs → Create
2. Name: "Keisha - AI Planner"
3. Instructions: Paste `Keisha_Space_Prompt.md` content
4. Enable: Code Interpreter
5. Save and use

**Option 2: Direct Chat**
1. Start new chat
2. Paste Keisha prompt at start
3. Say: "You are now Keisha. Stay in character."

---

### 🔮 Gemini (Google AI Studio)

1. Go to: aistudio.google.com
2. Create new chat
3. Click "System Instructions"
4. Paste `Keisha_Space_Prompt.md` content
5. Enable code execution
6. Chat as Keisha

---

### 🌊 Perplexity Spaces

1. Create new Space
2. Name: "Keisha - AI Planner"
3. Description: "Strategic planner and codebase analyst"
4. Instructions: Paste `Keisha_Space_Prompt.md` content
5. Save and use Space

---

## Commands

| Command | Description | Output |
|---------|-------------|--------|
| `@keisha audit [repo]` | Analyze codebase for tech debt | Metrics, hotspots, recommendations |
| `@keisha create prd for [feature]` | Generate PRD | PRD with acceptance criteria |
| `@keisha plan [feature]` | Break down into tasks | TASKLIST with estimates |
| `@keisha decide [A vs B]` | Architecture decision | Trade-off analysis |
| `@keisha summarize [work]` | Progress report | Status + blockers + next steps |

---

## Exclusive Tools (Python Kernel)

| Tool | Purpose |
|------|---------|
| `radon` | Complexity metrics |
| `gitpython` | Git history analysis |
| `ast` | Python AST parsing |
| `graphviz` | Architecture diagrams |
| `pygments` | Syntax highlighting |

---

## Handoff

When planning is done:
```
@ox take it from here
```

---

## Exit Character

To dismiss Keisha:
```
@dismiss
exit keisha
switch to [other agent]
```

---

## Files in This Folder

| File | Purpose |
|------|---------|
| `Keisha_Space_Prompt.md` | Full system prompt (copy this) |
| `Keisha_Planner_System.md` | Detailed role documentation |
| `Keisha_Prompts_Schemas.md` | JSON schemas for PRD, TASKLIST |
| `Keisha_Quickstart_Guide.md` | 30-min integration guide |
| `Keisha_Voice_Manual.md` | Personality & voice examples |
| `Keisha_MCP_Tools_Arsenal.md` | MCP tools setup |
| `README.md` | This file |
