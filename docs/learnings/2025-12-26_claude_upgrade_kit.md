# The Claude Upgrade Kit (Late 2025 Edition)
**Date:** 2025-12-26
**Objective:** Upgrade **Claude 4.5 Sonnet** (and 3.7 legacy) with state-of-the-art Agentic capabilities via MCP.

This guide defines the optimal "Skill Stack" to turn a base Claude 4.5 instance into a senior software engineer agent.

## 1. The Core Execution Layer (The "Hands")
These MCP servers allow Claude 4.5 to manipulate the environment safely and effectively.

*   **`@modelcontextprotocol/server-filesystem`**:
    *   **Capability**: Read/Write access to local project files.
    *   **Why**: Essential for direct code editing.
    *   **Upgrade**: Enable "diff-based" edits to save tokens on large files.

*   **`coding-agent-mcp` (or `server-terminal`)**:
    *   **Capability**: Execute shell commands (build, test, git).
    *   **Why**: "Code Mode" requires running tests to verify work.
    *   **Safety**: Use `coding-agent-mcp` for easier sandboxing over raw terminal access.

*   **`github-mcp-server`**:
    *   **Capability**: Issue tracking, PR management, CI/CD triggering.
    *   **Why**: Connects the agent to the team workflow, not just the code.

## 2. The Sandbox Layer (The "Playground")
For executing *untrusted* or *exploratory* code without breaking the local dev environment.

*   **`E2B (Execute to Build) MCP`**:
    *   **Capability**: Spin up ephemeral microVMs (Firecracker) in <200ms.
    *   **Why**: The industry standard for "Agent Sandboxes". Allows Claude to write and run Python/JS scripts to analyze data, generate graphs, or test isolated snippets without risking your machine.
    *   **Key Feature**: "Code execution as a service" – safer than running `python -c` locally.

## 3. The Cognitive Layer (The "Brain")
Tools that enhance reasoning and context management.

*   **`sequential-thinking-mcp`**:
    *   **Capability**: Forces a structured "thought process" before action.
    *   **Why**: Prevents "lazy coding". Critical for debugging complex architectures.

*   **`memory-bank-mcp` (or `knowledge-graph-mcp`)**:
    *   **Capability**: Persistent memory across sessions.
    *   **Why**: Allows Claude to "remember" architectural decisions, user preferences, and project context between chats.

## 4. The Vision/Research Layer (The "Eyes")
*   **`puppeteer-mcp` (or `brave-search`)**:
    *   **Capability**: Browse documentation and search for solutions.
    *   **Why**: The "Freshness Rule" – agents must check up-to-date docs (Dec 2025) rather than relying on stale training data.

---

## How to "Install" This Upgrade
Tell Claude (in Claude Desktop or Agent settings) to configure these MCP servers:

```json
{
  "mcpServers": {
    "filesystem": { "command": "npx", "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/project"] },
    "git": { "command": "npx", "args": ["-y", "@modelcontextprotocol/server-github"] },
    "e2b": { "command": "npx", "args": ["-y", "@e2b/mcp-server"] },
    "memory": { "command": "npx", "args": ["-y", "@modelcontextprotocol/server-memory"] },
    "puppeteer": { "command": "npx", "args": ["-y", "@modelcontextprotocol/server-puppeteer"] }
  }
}
```

## Top "Agentic IDE" Wrappers (Alternative Upgrade)
If not using raw MCP, use these IDEs which have this "stack" built-in:
1.  **Claude Code**: Anthropic's official terminal agent (deep MCP support).
2.  **Windsurf (Cascade)**: "Flow" state agent that predicts next edits.
3.  **Cursor (Agent Mode)**: The power-user standard for 2025.
