# Code Execution with MCP: Building More Efficient Agents
**Date:** 2025-12-26
**Source:** User / Anthropic Blog (Nov 04, 2025)
**Context:** Strategy for scaling agent capabilities efficiently.

## Core Insight
Direct tool calls consume context for each definition and result. Agents scale better by **writing code to call tools instead**.

## The Problem: Direct Tool Calling Inefficiency
As MCP usage scales, two patterns increase cost and latency:
1.  **Context Overload**: Loading thousands of tool definitions (schemas, descriptions) directly into context consumes massive tokens.
2.  **Double-Processing**: Intermediate results (e.g., fetching a 50k token transcript) flow through the LLM's context window merely to be passed to the next tool, wasting tokens and risking hallucinations.

## The Solution: Code Execution ("Code Mode")
Instead of the LLM calling tools directly (`gdrive.getDocument(...)`), the LLM writes a **script** to interact with MCP servers presented as code APIs.

### Infrastructure Pattern
Present MCP servers as a file tree or importable modules:
```typescript
// ./servers/google-drive/getDocument.ts
export async function getDocument(input: GetDocumentInput) { ... }
```

### Workflow Example
**Task:** "Download meeting transcript and add to Salesforce."

**Traditional (Inefficient):**
1. LLM calls `gdrive.getDocument`.
2. **Output:** 50,000 tokens of text enters LLM context.
3. LLM calls `salesforce.updateRecord` with the 50,000 tokens.
4. **Total:** ~100k+ tokens processed.

**Code Execution (Efficient):**
1. LLM writes script:
```typescript
import * as gdrive from './servers/google-drive';
import * as salesforce from './servers/salesforce';

const transcript = (await gdrive.getDocument({ documentId: 'abc123' })).content;
await salesforce.updateRecord({
  data: { Notes: transcript }
});
```
2. Agent executes script in sandbox.
3. Data flows directly from Drive to Salesforce in the runtime environment.
4. **Total:** < 2k tokens processed (just the script definition).

## Key Benefits

1.  **Progressive Disclosure**: Agents "discover" tools by listing files/directories rather than having all schemas loaded at once.
2.  **Context Efficiency**: Data filtering happens in code, not context.
    *   *Example*: Fetch 10,000 rows -> Filter in JS -> LLM sees only the 5 relevant rows.
3.  **Better Control Flow**: Loops, conditionals, and error handling (retries) happen in fast code, not slow LLM turn-taking.
4.  **Privacy**: Sensitive data (PII) stays in the execution runtime and doesn't need to enter the LLM context to be moved between systems.
5.  **Persistence**: Agents can save reusable scripts ("Skills") to simple files (`skills/save-sheet-to-csv.ts`) to build their own toolbox.

## Implementation Checklist for Agent Builder
- [x] **Zero-Dependency Tools**: We have implemented Python scripts (`web_fetch`, `serena`, etc.) that act as importable modules.
- [ ] **Importable Wrapper**: Ensure all MCP servers are accessible via a standard import interface for the agents.
- [ ] **Sandboxing**: Ensure `bash.py` and `python` execution is sandboxed or monitored (currently relying on `SafeToAutoRun` and user review).

## Summary
Treating MCP servers as **libraries** for code generation rather than **functions** for direct calling reduces token usage by orders of magnitude (e.g., 98.7% reduction) for complex data tasks.
