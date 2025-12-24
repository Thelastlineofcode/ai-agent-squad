# MCP Tools: Agent Distribution
## Which MCPs Go With Which Agent

This document maps the free MCP tools to their designated agents, following the **No Shared Kitchen Sink** principle.

---

## Quick Reference

| MCP | Agent | Purpose |
|-----|-------|---------|
| YouTube Transcript | @keisha | Learning resources, conference talks |
| DocFork | @ox | 9,000+ library docs for implementation |
| Docs Fetcher | @ox | Project examples, READMEs |

---

## @keisha (Planner) — Learning & Research

### YouTube Transcript MCP
```json
"youtube-transcript": {
  "command": "npx",
  "args": ["@emit-ia/youtube-transcript-mcp"]
}
```

**Commands:**
```
@keisha fetch transcript from [YOUTUBE_URL]
@keisha summarize key points from [YOUTUBE_URL]
@keisha find talks about [TOPIC]
```

**Use in workflows:**
- `/audit` — Research best practices for unfamiliar tech
- `/new-feature` — Find conference talks about similar implementations

---

## @ox (Coder) — Documentation & Examples

### DocFork MCP (9,000+ Library Docs)
```json
"docfork": {
  "command": "npx",
  "args": ["docfork-mcp"]
}
```

**Commands:**
```
@ox get docs for [LIBRARY_NAME]
@ox show API for [FUNCTION] in [LIBRARY]
@ox what's the correct pattern for [TASK] in [FRAMEWORK]
```

### Docs Fetcher MCP (Project Examples)
```json
"docs-fetcher": {
  "command": "npx",
  "args": ["@cdugo/docs-fetcher-mcp"]
}
```

**Commands:**
```
@ox fetch README for [PROJECT]
@ox show code examples for [LIBRARY] in [LANGUAGE]
@ox get setup guide for [FRAMEWORK]
```

**Use in workflows:**
- `/new-feature` — Reference official docs during implementation
- `/refactor` — Find idiomatic patterns for target library

---

## @soulja (Soulja Slim) — Security Research

### Docs Fetcher MCP (Testing Docs)
```json
"docs-fetcher": {
  "command": "npx",
  "args": ["@cdugo/docs-fetcher-mcp"]
}
```

**Commands:**
```
@soulja get testing docs for [FRAMEWORK]
@soulja find security testing patterns for [LANGUAGE]
```

**Use in workflows:**
- `/security-scan` — Reference OWASP testing guides
- `/debug` — Find debugging patterns for specific frameworks

---

## @dmx (Enforcer) — Best Practices

### DocFork MCP (Architecture Patterns)
```json
"docfork": {
  "command": "npx",
  "args": ["docfork-mcp"]
}
```

**Commands:**
```
@dmx get architecture docs for [FRAMEWORK]
@dmx show best practices for [PATTERN]
```

**Use in workflows:**
- `/code-review` — Verify code against official patterns
- `/improve` — Research optimization patterns

---

## Full Configuration

Add to `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "youtube-transcript": {
      "command": "npx",
      "args": ["@emit-ia/youtube-transcript-mcp"]
    },
    "docfork": {
      "command": "npx",
      "args": ["docfork-mcp"]
    },
    "docs-fetcher": {
      "command": "npx",
      "args": ["@cdugo/docs-fetcher-mcp"]
    }
  }
}
```

---

## Installation (One-Time)

```bash
npm install -g @emit-ia/youtube-transcript-mcp
npm install -g docfork-mcp
npm install -g @cdugo/docs-fetcher-mcp
```

**Total Cost**: $0
**API Keys**: None required
