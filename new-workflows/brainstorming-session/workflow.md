# Brainstorming Session Workflow

**Goal:** Facilitate structured brainstorming sessions using creative thinking techniques
**Agent:** Keisha (for strategic ideation) or Master P (for creative/design ideation)
**Based on:** BMAD brainstorming workflow pattern

---

## Workflow Architecture

This uses **micro-file architecture** for disciplined execution:

- Each step is a self-contained file with embedded rules
- Sequential progression with user control at each step
- Document state tracked in frontmatter
- Append-only document building through conversation
- Techniques loaded on-demand from CSV

---

## Initialization

### Configuration

- `installed_path` = `Execs/.agent/workflows/brainstorming-session`
- `template_path` = `{installed_path}/templates/session-template.md`
- `techniques_path` = `Execs/data/elicitation-techniques.csv`
- `default_output_file` = `Execs/_squad-output/brainstorming/session-{topic}-{{date}}.md`

---

## Execution

Load and execute `steps/step-01-session-setup.md` to begin the workflow.

**Note:** Session setup, technique selection, and continuation detection happen in step-01-session-setup.md.

---

## Workflow Steps

1. **Step 01: Session Setup** - Gather topic and goals, detect continuation
2. **Step 02: Technique Selection** - User selects from categories or AI recommends
3. **Step 03: Facilitated Brainstorming** - Interactive coaching through technique
4. **Step 04: Idea Organization** - Synthesize, prioritize, create action plans

---

## Usage

**Start a new brainstorming session:**
```
@keisha let's brainstorm
```

**Or with Master P for creative/design focus:**
```
@masterp let's brainstorm design ideas
```

**Continue an existing session:**
- Workflow automatically detects if session exists for today
- Offers to continue or start fresh

---

## Output

Creates a markdown document with:
- YAML frontmatter tracking progress
- Session topic and goals
- Techniques used
- Ideas generated (organized by theme)
- Prioritized ideas
- Action plans

**Example output:** `Execs/_squad-output/brainstorming/session-ai-features-2026-01-03.md`
