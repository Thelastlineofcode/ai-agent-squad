# Auto-Claude Patterns: Autonomous Loops

**Status:** Implementation Ready  
**Reference:** `.agent/execution.yaml` (autonomous_loop)

## Overview

Auto-Claude patterns enable the **Streetsmart AI Squad** to perform autonomous, self-correcting loops. Instead of a single-shot execution, agents can **Plan → Act → Verify → Iterate** until a goal is met or max iterations are reached.

## Supported Runtimes

You can choose your preferred model runtime for the loop:

1.  **Claude (Anthropic)**
    *   Binary: `claude`
    *   Capabilities: Excellent reasoning for complex code fixes.
    *   Command: `/auto-fix --runtime claude`

2.  **Gemini (Google)**
    *   Binary: `gemini`
    *   Capabilities: Fast execution, huge context window.
    *   Command: `/auto-fix --runtime gemini`

## Strategies

### 1. Code Fix (`strategy: code_fix`)
*   **Trigger:** `/auto-fix` or compilation/test failures.
*   **Agent:** @ox (Master Coder)
*   **Loop:**
    1.  **Plan:** Read error log (`cargo build`, `cargo test`).
    2.  **Act:** Apply fix to source code.
    3.  **Verify:** Run `cargo check` or `cargo test`.
    4.  **Iterate:** If error persists, re-plan with new error output.

### 2. Feature Implementation (`strategy: feature_implementation`)
*   **Trigger:** High-complexity tasks.
*   **Agent:** @keisha (Planner) + @ox (Coder)
*   **Loop:**
    1.  **Plan:** Break feature into atomic steps (Step 1, Step 2...).
    2.  **Act:** Implement Step N.
    3.  **Verify:** Run lint/security checks (`semgrep`, `clippy`).
    4.  **Iterate:** Proceed to Step N+1 if successful.

## Configuration

Located in `.agent/execution.yaml`:

```yaml
autonomous_loop:
  enabled: true
  max_iterations: 5
  runtimes:
    claude: ...
    gemini: ...
```

## Usage

**Trigger a fix in autonomous mode:**

```bash
# Default (routes based on preference)
/auto-fix

# Force specific runtime
/auto-fix --runtime gemini
```
