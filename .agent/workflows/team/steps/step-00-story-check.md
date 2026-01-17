---
step: 0
agent: keisha
phase: STORY_CHECK
status: pending
---

# Step 0: Story Check (Keisha - Optional)

**Goal:** Determine if story exists, create if needed
**Agent:** @keisha (CSO/Product Strategy & Planner)
**Next Step:** step-01-write-tests.md

---

## Task

### 1. Parse User Request

Extract from user's `/team` command:
- Story path (if provided)
- Feature description (if no path)
- Target files (if adding tests)

### 2. Check for Existing Story

**If story path provided:**
```bash
# User provided: /team implement docs/features/.../story1.md
- Load story file
- Validate acceptance criteria exist
- Set frontmatter: story_exists=true, story_path=[path]
- Skip to Step 1 (Soulja writes tests)
```

**If no story path:**
```bash
# User provided: /team implement feature: [description]
- Set frontmatter: story_exists=false
- Invoke @keisha to analyze requirements
```

### 3. Keisha Creates Story (Only if needed)

**When invoked:**
- Analyze user's feature description
- Review codebase patterns in target project
- Create story breakdown with:
  - Feature overview
  - Acceptance criteria (testable)
  - Implementation notes
  - File locations
  - Dependencies

**Output:**
- Story document in `.agent-ops/active-stories/story-{timestamp}.md`
- Update frontmatter: story_path=[new path]

### 4. Transition

**Update frontmatter:**
```yaml
---
stepsCompleted: [0]
story_exists: true|false
story_path: "path/to/story.md"
keisha_invoked: true|false
current_iteration: 1
max_iterations: 10
---
```

**Load next step:**
```bash
exec Execs/.agent/workflows/team/steps/step-01-write-tests.md
```

---

## Decision Tree

```
User runs: /team implement [input]
    │
    ├─> Story path provided? (docs/features/...)
    │   │
    │   ├─> YES → Load story
    │   │         Set story_exists=true
    │   │         Skip to Step 1 (Soulja)
    │   │
    │   └─> NO → Feature description provided?
    │       │
    │       ├─> YES → Invoke @keisha
    │       │         Create story
    │       │         Set story_exists=true
    │       │         Go to Step 1
    │       │
    │       └─> NO → ERROR: Invalid input
    │                 Ask user for story or description
```

---

## Examples

### Example 1: Story Exists
```bash
/team implement docs/features/journey-ux/epic6/sprint5/story1.md

# Step 0 Result:
- story_exists: true
- story_path: "docs/features/journey-ux/epic6/sprint5/story1.md"
- keisha_invoked: false
- → Skip to Step 1 (Soulja writes tests)
```

### Example 2: No Story, Create First
```bash
/team implement feature: user profile settings with avatar upload

# Step 0 Result:
- story_exists: false → Invoke @keisha
- @keisha creates: .agent-ops/active-stories/story-1737000000.md
- story_path: ".agent-ops/active-stories/story-1737000000.md"
- keisha_invoked: true
- → Go to Step 1 (Soulja writes tests)
```

### Example 3: Add Tests Only
```bash
/team add tests for src/components/journey-tabs.tsx

# Step 0 Result:
- story_exists: false → Invoke @keisha
- @keisha analyzes existing component
- Creates test-focused story with coverage goals
- → Go to Step 1 (Soulja writes tests)
```

---

## Frontmatter Schema

```yaml
---
stepsCompleted: [0]           # Steps completed so far
workflowType: 'team-tdd'      # Workflow identifier
story_exists: bool            # Whether story was found/created
story_path: string            # Path to story file
keisha_invoked: bool          # Whether Keisha created story
current_iteration: 1          # Loop counter
max_iterations: 10            # Max loops before manual intervention
user_input: string            # Original user command
---
```
