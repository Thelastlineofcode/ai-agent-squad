# Agent Evaluation Framework (2026 Standard)

This document establishes the standards for **Evaluation-Driven Development Operations (EDDOps)** within the Agent Builder ecosystem. It uses **Bloom's Taxonomy** as the primary metric for assessing cognitive depth and reliability.

## 1. Bloom's Taxonomy (Cognitive Depth)

We evaluate *every* agent output against these 6 levels. Agents must meet their **Minimum Required Level** to pass the gate.

| Level | Name | Definition | Key Verbs | Required For |
| :--- | :--- | :--- | :--- | :--- |
| **B1** | **Remember** | Recall facts and basic concepts. | Define, Duplicate, List, Memorize | *Basic Assistants* |
| **B2** | **Understand** | Explain ideas or concepts. | Classify, Describe, Discuss, Explain | *Basic Assistants* |
| **B3** | **Apply** | Use information in new situations. | Execute, Implement, Solve, Use | *Junior Devs* |
| **B4** | **Analyze** | Draw connections among ideas. | Differentiate, Organize, Relate, Compare | **Keisha, Ox** |
| **B5** | **Evaluate** | Justify a stand or decision. | Appraise, Argue, Defend, Judge, Select | **Soulja, DMX, Igor** |
| **B6** | **Create** | Produce new or original work. | Design, Assemble, Construct, Conjecture | **Suge / Architecture** |

### Agent Targets
- **Keisha (Empathize)**: **B4 (Analyze)** - Must differentiate between user wants vs. needs.
- **Ox (Realize)**: **B4 (Analyze)** - Must organize code structures and relate dependencies.
- **Soulja (Judge)**: **B5 (Evaluate)** - Must defend pass/fail decisions with evidence.
- **DMX (Deploy)**: **B5 (Evaluate)** - Must judge production readiness.
- **Igor (Security)**: **B5 (Evaluate)** - Must appraise security risks.

## 2. Autonomy Levels (L1-L5)

We track the autonomy level of each agent for every major task.

| Level | Name | Description | Human Oversight |
| :--- | :--- | :--- | :--- |
| **L1** | **Assistant** | Agent executes single commands only. | 100% (Every step) |
| **L2** | **Partial** | Agent executes sequences but stops for logical checks. | 50% (Key checkpoints) |
| **L3** | **Conditional** | Agent handles extensive workflows but requests help on error. | 20% (On exception) |
| **L4** | **High** | Agent autonomously handles errors and retries. | 5% (Post-action review) |
| **L5** | **Full** | Agent operates fully independently, self-correcting and self-improving. | 0% (Audit only) |

**Target**: Development agents (Ox, Soulja) should aim for **L3** (Conditional) in standard workflows and **L4** (High) for routine tasks.

## 3. Core Evaluation Metrics

### A. Reliability Requirements
-   **Task Completion Rate (TCR)**: % of user requests resolved without human intervention. (Target: > 90%)
-   **Tool Call Accuracy (TCA)**: % of tool invocations with correct syntax and valid arguments. (Target: > 99%)
-   **Latency**: Time to first token and total completion time. (Target: < 2s TTx)

### B. Quality Metrics (Judge Evaluated)
-   **Hallucination Rate (HR)**: Frequency of fabricated data or non-existent file references.
-   **Bloom Level Score**: Does the output meet the required B-Level? (Pass/Fail).
-   **Adherence to Persona**: Drift detection score (1-5 Scale).

## 4. "Agent-as-a-Judge" Rubrics

**Soulja Slim (@soulja)** uses these rubrics when validating other agents.

### Rubric: Cognitive Depth (Bloom Check)
-   **PASS**: Agent demonstrates thinking at or above their required B-Level.
    -   *Example (Ox/B4)*: Does not just write code (B3), but explains the *relationship* to existing modules (B4).
    -   *Example (Soulja/B5)*: Does not just say "Failed", but *defends* the failure with specific test evidence (B5).
-   **FAIL**: Agent operates below target level (e.g., specific instructions followed blindly without analysis).

### Rubric: Doctrine Adherence (Pass/Fail)
-   **PASS**: Agent output stricty follows `team-fullstack.txt` (ERC Flow).
-   **FAIL**: Agent skipped a phase, used mocks, or ignored "Stop" gates.

## 5. EDDOps Protocol
1.  **Define Success FIRST**: Soulja defines success rubric (Bloom Target) before Realize phase.
2.  **Pre-emptive Tool Testing**: Ox validates tools are online.
3.  **Adversarial Stress Test**: Igor fuzzes inputs.
4.  **Continuous Eval**: Every PR is scored against Core Metrics.
