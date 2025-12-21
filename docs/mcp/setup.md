# MCP Setup Guide
## Quick Installation & Configuration

One-time setup for all 3 free MCPs.

---

## Prerequisites
- Node.js 16+
- npm

---

## Installation (5 minutes)

```bash
# YouTube Transcript (for @keisha)
npm install -g @emit-ia/youtube-transcript-mcp

# DocFork - 9,000+ library docs (for @ox, @dmx)
npm install -g docfork-mcp

# Docs Fetcher - Project examples (for @ox, @soulja)
npm install -g @cdugo/docs-fetcher-mcp
```

---

## Configuration

Edit your Claude Desktop config:

**macOS:** `~/Library/Application Support/Claude/claude_desktop_config.json`
**Windows:** `%APPDATA%\Claude\claude_desktop_config.json`
**Linux:** `~/.config/Claude/claude_desktop_config.json`

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

## Verification

Restart Claude Desktop, then test:

```
@keisha fetch transcript from https://youtube.com/watch?v=...
@ox get docs for axios
@soulja get testing docs for pytest
```

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| MCP not responding | Restart Claude Desktop |
| npm install fails | Update npm: `npm install -g npm@latest` |
| YouTube transcript unavailable | Some videos have no public transcripts |
| DocFork not finding library | Try alternative name or use docs-fetcher |
