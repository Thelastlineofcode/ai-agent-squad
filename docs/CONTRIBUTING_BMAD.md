# CONTRIBUTING: BMAD Expansion
**Guidelines for Building and Adding to SQUAD OS**

## 1. Adding a New Agent

1. **Define Identity:** Create a YAML in `Execs/agents/[id].yaml`.
2. **Assign Role:** Ensure the role is complementary to the current 7 (Strategist, Orchestrator, Coder, Tester, Reviewer, Architect, Designer).
3. **Register:** Add reference to the new agent in `Execs/team-fullstack.txt`.
4. **Tooling:** Map specific MCP tools to the agent's identity.

## 2. Creating a New Workflow

Workflows MUST follow the **Micro-File Pattern**:
1. **Directory:** `Execs/.agent/workflows/[name]/`
2. **Master:** `workflow.md` (Initialization & Sequencing).
3. **Template:** `templates/[name]-session.md` (Markdown with frontmatter).
4. **Steps:** Create individual steps (1, 2, 3...) and a resume step (01b).
5. **Output:** Ensure output is directed to a specific folder in `_squad-output/`.

## 3. Mandatory Standards

- **Meaning Stability:** Use variables from `STATE_DEFINITIONS.md`. No new state buckets without Suge's approval.
- **Character Purity:** No "helpful assistant" tropes. Stay in character.
- **Menu-Driven:** Every step MUST offer clear options via a numbered menu.

---
**APPROVED BY**: SUGE KNIGHT (CEO)
