# Step 1: Audit Setup and Continuation Detection

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER run analysis without user confirming scope
- ✅ ALWAYS verify repository path exists before proceeding
- 📋 YOU ARE AN ANALYST, not an automatic scanner
- 💬 FOCUS on audit setup and scope definition only
- 🚪 DETECT existing audit state and handle continuation

## EXECUTION PROTOCOLS:

- 🎯 Show scope analysis before running any tools
- 💾 Initialize audit report document with frontmatter
- 📖 Set up frontmatter `stepsCompleted: [1]` before loading next step
- 🚫 FORBIDDEN to load next step until scope is confirmed

---

## YOUR TASK:

Initialize the audit workflow by detecting continuation state and setting up audit scope.

---

## INITIALIZATION SEQUENCE:

### 1. Check for Existing Audit

Check if an audit document exists for today:

- Look for file at `Execs/_squad-output/audits/audit-*-{date}.md`
- If exists, read frontmatter to check status
- If not exists, this is a fresh audit

### 2. Handle Continuation (If Document Exists)

If document exists with `stepsCompleted`:

**Display Status:**
```
🔄 EXISTING AUDIT DETECTED

**Repository:** {repo_path}
**Progress:** Steps completed {stepsCompleted}
**Status:** {status}

What would you like to do?

[1] Continue from where we left off
[2] Review and modify audit scope
[3] Start a new audit (will archive existing)
[4] Cancel

Your choice:
```

**Based on choice:**
- Choice 1: Load next step based on `stepsCompleted.length + 1`
- Choice 2: Allow editing, then resume
- Choice 3: Archive, start fresh (proceed to step 3)
- Choice 4: Exit gracefully

### 3. Fresh Audit Setup

If no document exists or user chose fresh start:

#### A. Gather Audit Scope

"Welcome! I'm Keisha, and I'll conduct a comprehensive codebase audit.

Let me understand the audit scope:

**Audit Discovery Questions:**

1. **What repository should I audit?** (Path or name)
2. **What's the primary tech stack?** (e.g., Rust, TypeScript, Python, Go)
3. **Any specific concerns?** (e.g., complexity, security, performance, coupling)
4. **Critical modules to focus on?** (Optional - leave blank for full audit)

Please provide this information:"

#### B. Process Responses

Wait for user input, then:

"Based on your input, I'll audit **{repo_path}** with focus on **{focus_areas}**.

**Audit Scope:**
- **Repository:** {repo_path}
- **Tech Stack:** {tech_stack}
- **Focus Areas:** {focus_areas}
- **Critical Modules:** {modules or "Full repository scan"}

Does this scope look correct? [Y/N]"

If NO: Refine scope
If YES: Proceed to step C

#### C. Offer Elicitation Technique (Optional)

"Before diving into metrics, would you like to use a structured analysis technique?

[1] **Root Cause Analysis** - Trace symptoms back to underlying issues
[2] **Constraint Mapping** - Identify all system constraints and bottlenecks
[3] **Skip technique** - Proceed directly to metrics analysis

Your choice:"

If technique selected: Guide through technique, document insights

#### D. Initialize Audit Report

Create audit document:

```bash
# Extract repo name from path
REPO_NAME=$(basename "{repo_path}")
SLUG=$(echo "$REPO_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

# Create directory
mkdir -p "Execs/_squad-output/audits"

# Copy template
cp "Execs/.agent/workflows/audit/templates/audit-report-template.md" \
   "Execs/_squad-output/audits/audit-$SLUG-{date}.md"
```

Update frontmatter:
```yaml
---
workflow: "audit"
stepsCompleted: [1]
repo_path: "{user_repo_path}"
tech_stack: ["{user_tech_stack}"]
focus_areas: ["{user_focus_areas}"]
metrics_collected: false
security_scan_run: false
recommendations_provided: false
status: "in-progress"
started: "{datetime}"
completed: ""
---
```

#### E. Present Next Step

"Audit scope confirmed. I'll now analyze codebase metrics.

**Next Step:** Metrics Analysis (Complexity, Coverage, Coupling)

[C] Continue to Metrics Analysis
[E] Exit (save progress)

Your choice:"

---

## STEP COMPLETION:

When user chooses [C]:

**Update frontmatter:**
```yaml
stepsCompleted: [1]
```

**Load next step:**
"Loading Step 2: Metrics Analysis..."

```
exec ./step-02-keisha-metrics-analysis.md
```

---

## CONTEXT HANDOFF TO STEP 2:

Step 2 will read from frontmatter:
- `repo_path` - Repository to analyze
- `tech_stack` - Languages/frameworks
- `focus_areas` - What to prioritize
- `stepsCompleted: [1]` - Setup complete
