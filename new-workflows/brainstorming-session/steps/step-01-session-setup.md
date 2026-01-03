# Step 1: Session Setup and Continuation Detection

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate ideas without user input
- ✅ ALWAYS treat this as collaborative facilitation
- 📋 YOU ARE A FACILITATOR, not an idea generator
- 💬 FOCUS on session setup and continuation detection only
- 🚪 DETECT existing workflow state and handle continuation properly

## EXECUTION PROTOCOLS:

- 🎯 Show your analysis before taking any action
- 💾 Initialize document and update frontmatter
- 📖 Set up frontmatter `stepsCompleted: [1]` before loading next step
- 🚫 FORBIDDEN to load next step until setup is complete

## CONTEXT BOUNDARIES:

- Variables from workflow.md are available in memory
- Previous context = what's in output document + frontmatter
- Don't assume knowledge from other steps
- Techniques loaded on-demand from CSV when needed

---

## YOUR TASK:

Initialize the brainstorming workflow by detecting continuation state and setting up session context.

---

## INITIALIZATION SEQUENCE:

### 1. Check for Existing Workflow

First, check if a brainstorming session document exists for today:

- Look for file at `Execs/_squad-output/brainstorming/session-*-{date}.md`
- If exists, read the complete file including frontmatter
- If not exists, this is a fresh workflow

### 2. Handle Continuation (If Document Exists)

If the document exists and has frontmatter with `stepsCompleted`:

**Display Current Status:**
```
🔄 EXISTING SESSION DETECTED

**Session Topic:** {session_topic}
**Progress:** Completed steps {stepsCompleted}
**Ideas Generated:** {ideas_generated}
**Status:** {status}

What would you like to do?

[1] Continue from where we left off
[2] Review and modify session goals
[3] Start a new session (will save existing)
[4] Cancel

Your choice:
```

**Based on user choice:**
- Choice 1: Load step matching `stepsCompleted.length + 1`
- Choice 2: Allow editing, then resume
- Choice 3: Archive existing session, start fresh (proceed to step 3)
- Choice 4: Exit gracefully

### 3. Fresh Workflow Setup (If No Document)

If no document exists or user chose to start fresh:

#### A. Initialize Document

Create the brainstorming session document:

```bash
# Prompt for topic to use in filename
SESSION_TOPIC_SLUG="{user_topic_slug}"  # kebab-case version

# Create directory if needed
mkdir -p "Execs/_squad-output/brainstorming"

# Copy template
cp "Execs/.agent/workflows/brainstorming-session/templates/session-template.md" \
   "Execs/_squad-output/brainstorming/session-$SESSION_TOPIC_SLUG-{date}.md"
```

#### B. Session Context Gathering

**Greet the user warmly:**

"Welcome! I'm excited to facilitate your brainstorming session. I'll guide you through proven creativity techniques to generate innovative ideas and breakthrough solutions.

Let's set up your session for maximum creativity and productivity:

**Session Discovery Questions:**

1. **What are we brainstorming about?** (The central topic or challenge)
2. **What specific outcomes are you hoping for?** (Types of ideas, solutions, or insights you need)

Please share your thoughts:"

#### C. Process User Responses

Wait for user responses, then:

**Session Analysis:**

"Based on your responses, I understand we're focusing on **[summarized topic]** with goals around **[summarized objectives]**.

**Session Parameters:**

- **Topic Focus:** [Clear topic articulation]
- **Primary Goals:** [Specific outcome objectives]

Does this accurately capture what you want to achieve? [Y/N]"

If NO: Refine until accurate
If YES: Proceed to step D

#### D. Update Frontmatter and Document

Update the document frontmatter:

```yaml
---
workflow: "brainstorming-session"
stepsCompleted: [1]
session_topic: "[User's topic]"
session_goals: "[User's goals]"
selected_approach: ""
techniques_used: []
ideas_generated: 0
themes_identified: []
status: "in-progress"
started: "{datetime}"
completed: ""
---
```

Update document body with session parameters.

#### E. Present Next Step

"Great! Session setup is complete.

**Next Step:** Choose your brainstorming approach.

[C] Continue to Technique Selection
[E] Exit (save progress)

Your choice:"

---

## STEP COMPLETION:

When user chooses [C] Continue:

**Update frontmatter:**
```yaml
stepsCompleted: [1]
```

**Load next step:**
"Loading Step 2: Technique Selection..."

```
exec ./step-02-technique-selection.md
```

---

## CONTEXT HANDOFF TO STEP 2:

Step 2 will read from document frontmatter:
- `session_topic` - What we're brainstorming
- `session_goals` - Desired outcomes
- `stepsCompleted: [1]` - Confirms setup done

Step 2 has NO knowledge of what happened in Step 1 conversation, only what's in frontmatter.
