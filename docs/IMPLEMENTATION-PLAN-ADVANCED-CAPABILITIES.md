# Implementation Plan: Advanced Capabilities (All 10)

**Project:** Squad OS v2.0 - Advanced Capabilities
**Timeline:** 14 days (2 weeks)
**Status:** Ready for Execution
**Executor:** Any agent with implementation capabilities

---

## Overview

This plan implements all 10 advanced capabilities in priority order:
- **P0 (Days 1-4):** Foundation capabilities
- **P1 (Days 5-9):** Intelligence capabilities
- **P2 (Days 10-14):** Tooling capabilities

Each day has clear deliverables, success criteria, and testing steps.

---

## Week 1: Foundation + Intelligence (P0 + P1)

### Day 1: Workflow State Persistence & Recovery

**Capability:** Never lose workflow progress

**Files to Create:**

1. `Execs/.agent/workflows/_shared/resume-workflow.md`
```markdown
# Resume Workflow

## MANDATORY RULES:
- Scan `_squad-output/` for incomplete workflows
- Parse frontmatter `status` field
- Present menu of resumable workflows

## EXECUTION:

### 1. Scan for Active Workflows
```bash
# Find all incomplete workflows
find Execs/_squad-output -name "*.md" -type f -exec grep -l 'status: "in-progress"' {} \;
```

### 2. Parse Frontmatter
For each incomplete workflow:
- Extract: `workflow`, `stepsCompleted`, `started`, `status`
- Calculate: time elapsed, last step completed

### 3. Present Menu
"You have {count} incomplete workflows:

[1] {workflow_name} - Step {current_step}/{total_steps} - Started {time_ago}
[2] {workflow_name} - Step {current_step}/{total_steps} - Started {time_ago}

[E] Exit

Choose workflow to resume or [E] to exit:"

### 4. Resume Selected Workflow
- Load workflow.md to identify next step
- Load `step-0{current_step+1}-{agent}-{purpose}.md`
- Continue execution from where it left off
```

2. `Execs/.agent/workflows/_shared/list-active-workflows.md`
```markdown
# List Active Workflows

Shows all in-progress workflows without resuming.

## EXECUTION:
- Same scan logic as resume-workflow.md
- Display only, no action
- Useful for status checks
```

3. `Execs/.agent/workflows/_shared/checkpoint-workflow.sh`
```bash
#!/bin/bash
# Auto-save frontmatter after each step

WORKFLOW_DOC="$1"

# Extract current frontmatter
sed -n '/^---$/,/^---$/p' "$WORKFLOW_DOC" > /tmp/frontmatter.yaml

# Backup previous version
cp "$WORKFLOW_DOC" "${WORKFLOW_DOC}.backup"

# Update timestamp
echo "last_checkpoint: $(date -Iseconds)" >> /tmp/frontmatter.yaml

echo "✅ Checkpoint saved for $WORKFLOW_DOC"
```

**Testing:**
1. Start `/new-feature` workflow
2. Complete step 1
3. Exit without completing
4. Run `/resume`
5. Verify it detects incomplete workflow
6. Resume and continue to completion

**Success Criteria:**
- ✅ Detects all incomplete workflows
- ✅ Correctly identifies next step
- ✅ Resumes from exact point of interruption
- ✅ No data loss or corruption

**Deliverables:**
- 3 files created
- Integration test passed
- Documentation in `docs/workflow-resume-guide.md`

---

### Day 2: Workflow Validation Engine

**Capability:** Automated quality checks for workflows

**Files to Create:**

1. `Execs/dev-tools/validate-workflow.sh`
```bash
#!/bin/bash
# Validates workflow structure against BMAD architecture

WORKFLOW_DIR="$1"

if [ -z "$WORKFLOW_DIR" ]; then
    echo "Usage: $0 <workflow-directory>"
    exit 1
fi

echo "🔍 Validating workflow: $WORKFLOW_DIR"

ERRORS=0

# Check 1: workflow.md exists
if [ ! -f "$WORKFLOW_DIR/workflow.md" ]; then
    echo "❌ Missing workflow.md"
    ERRORS=$((ERRORS + 1))
fi

# Check 2: templates/ directory exists
if [ ! -d "$WORKFLOW_DIR/templates" ]; then
    echo "⚠️  No templates/ directory"
fi

# Check 3: steps/ directory exists
if [ ! -d "$WORKFLOW_DIR/steps" ]; then
    echo "❌ Missing steps/ directory"
    ERRORS=$((ERRORS + 1))
fi

# Check 4: At least one step file
STEP_COUNT=$(find "$WORKFLOW_DIR/steps" -name "step-*.md" 2>/dev/null | wc -l)
if [ "$STEP_COUNT" -eq 0 ]; then
    echo "❌ No step files found"
    ERRORS=$((ERRORS + 1))
else
    echo "✅ Found $STEP_COUNT step files"
fi

# Check 5: Step files have required sections
for STEP_FILE in "$WORKFLOW_DIR/steps"/step-*.md; do
    if [ -f "$STEP_FILE" ]; then
        if ! grep -q "MANDATORY EXECUTION RULES" "$STEP_FILE"; then
            echo "❌ $(basename "$STEP_FILE"): Missing MANDATORY EXECUTION RULES section"
            ERRORS=$((ERRORS + 1))
        fi

        if ! grep -q "EXECUTION" "$STEP_FILE"; then
            echo "❌ $(basename "$STEP_FILE"): Missing EXECUTION section"
            ERRORS=$((ERRORS + 1))
        fi

        if ! grep -q "exec \./step-" "$STEP_FILE"; then
            echo "⚠️  $(basename "$STEP_FILE"): No handoff to next step (might be final step)"
        fi
    fi
done

# Check 6: Step sequence has no gaps (01, 02, 03... no skipping)
STEP_NUMBERS=$(find "$WORKFLOW_DIR/steps" -name "step-*.md" | sed 's/.*step-0*//' | sed 's/[a-z-].*//' | sort -n)
EXPECTED=1
for NUM in $STEP_NUMBERS; do
    if [ "$NUM" != "$EXPECTED" ] && [ "$NUM" != "${EXPECTED}b" ]; then
        echo "⚠️  Step sequence gap: expected step-0$EXPECTED, found step-0$NUM"
    fi
    EXPECTED=$((NUM + 1))
done

# Check 7: Template has frontmatter
if [ -f "$WORKFLOW_DIR/templates"/*.md ]; then
    TEMPLATE=$(find "$WORKFLOW_DIR/templates" -name "*.md" | head -1)
    if ! grep -q "^---$" "$TEMPLATE"; then
        echo "❌ Template missing YAML frontmatter"
        ERRORS=$((ERRORS + 1))
    fi
fi

# Summary
echo ""
echo "========================================="
if [ "$ERRORS" -eq 0 ]; then
    echo "✅ VALIDATION PASSED"
    echo "Workflow is compliant with BMAD architecture"
    exit 0
else
    echo "❌ VALIDATION FAILED"
    echo "Found $ERRORS critical errors"
    exit 1
fi
```

2. `Execs/dev-tools/validate-all-workflows.sh`
```bash
#!/bin/bash
# Validate all workflows

WORKFLOWS_DIR="Execs/.agent/workflows"
PASSED=0
FAILED=0

for WORKFLOW in "$WORKFLOWS_DIR"/*; do
    if [ -d "$WORKFLOW" ] && [ "$(basename "$WORKFLOW")" != "_shared" ] && [ "$(basename "$WORKFLOW")" != "_legacy_v1" ]; then
        if bash Execs/dev-tools/validate-workflow.sh "$WORKFLOW"; then
            PASSED=$((PASSED + 1))
        else
            FAILED=$((FAILED + 1))
        fi
        echo ""
    fi
done

echo "========================================="
echo "VALIDATION SUMMARY"
echo "Passed: $PASSED"
echo "Failed: $FAILED"
echo "========================================="

if [ "$FAILED" -eq 0 ]; then
    exit 0
else
    exit 1
fi
```

**Testing:**
1. Run on known-good workflow: `bash Execs/dev-tools/validate-workflow.sh Execs/.agent/workflows/new-feature`
2. Create intentionally broken workflow (missing MANDATORY RULES)
3. Run validator, verify it catches the error
4. Run `validate-all-workflows.sh`, verify summary

**Success Criteria:**
- ✅ Detects missing workflow.md
- ✅ Detects missing step files
- ✅ Detects missing required sections
- ✅ Detects step sequence gaps
- ✅ All existing workflows pass validation

**Deliverables:**
- 2 validation scripts
- All 8 workflows validated
- Pre-commit hook integration guide

---

### Day 3: Agent Context Optimizer

**Capability:** Measure and track token overhead

**Files to Create:**

1. `Execs/dev-tools/measure-context-overhead.sh`
```bash
#!/bin/bash
# Measures context overhead for a workflow step

WORKFLOW_DOC="$1"
STEP_NUM="$2"

if [ -z "$WORKFLOW_DOC" ] || [ -z "$STEP_NUM" ]; then
    echo "Usage: $0 <workflow-document> <step-number>"
    echo "Example: $0 Execs/_squad-output/features/auth-prd.md 2"
    exit 1
fi

# Extract step content from document
STEP_CONTENT=$(sed -n "/## Step $STEP_NUM:/,/## Step $((STEP_NUM + 1)):/p" "$WORKFLOW_DOC" | head -n -1)

# Count actual content tokens (estimate: words / 0.75)
CONTENT_WORDS=$(echo "$STEP_CONTENT" | wc -w)
CONTENT_TOKENS=$((CONTENT_WORDS * 4 / 3))

# Simulate step execution (would need actual LLM API call for real measurement)
# For now, estimate overhead based on step file size + frontmatter
STEP_FILE=$(grep -r "step-0$STEP_NUM-" Execs/.agent/workflows/*/steps/ | head -1 | cut -d: -f1)
if [ -f "$STEP_FILE" ]; then
    STEP_FILE_WORDS=$(wc -w < "$STEP_FILE")
    STEP_FILE_TOKENS=$((STEP_FILE_WORDS * 4 / 3))
fi

FRONTMATTER_TOKENS=50  # Estimate

TOTAL_TOKENS=$((STEP_FILE_TOKENS + FRONTMATTER_TOKENS))
OVERHEAD_TOKENS=$((TOTAL_TOKENS - CONTENT_TOKENS))
OVERHEAD_PCT=$((OVERHEAD_TOKENS * 100 / CONTENT_TOKENS))

echo "Step $STEP_NUM Context Analysis:"
echo "  Content Tokens: $CONTENT_TOKENS"
echo "  Overhead Tokens: $OVERHEAD_TOKENS"
echo "  Overhead %: $OVERHEAD_PCT%"

if [ "$OVERHEAD_PCT" -gt 20 ]; then
    echo "  ⚠️  WARNING: Overhead exceeds 20% threshold"
else
    echo "  ✅ Within acceptable overhead"
fi

# Log to CSV
echo "$(date -Iseconds),$WORKFLOW_DOC,$STEP_NUM,$CONTENT_TOKENS,$OVERHEAD_TOKENS,$OVERHEAD_PCT" >> Execs/.agent-ops/context-metrics.csv
```

2. `Execs/.agent-ops/context-metrics.csv`
```csv
timestamp,workflow_doc,step,content_tokens,overhead_tokens,overhead_pct
```

3. `Execs/dev-tools/analyze-context-metrics.sh`
```bash
#!/bin/bash
# Analyzes accumulated context metrics

METRICS_FILE="Execs/.agent-ops/context-metrics.csv"

if [ ! -f "$METRICS_FILE" ]; then
    echo "No metrics data found"
    exit 1
fi

echo "Context Overhead Analysis"
echo "========================="
echo ""

# Average overhead across all workflows
AVG_OVERHEAD=$(awk -F, 'NR>1 {sum+=$6; count++} END {print sum/count}' "$METRICS_FILE")
echo "Average Overhead: ${AVG_OVERHEAD}%"

# Highest overhead workflow
MAX_OVERHEAD=$(awk -F, 'NR>1 {print $2,$6}' "$METRICS_FILE" | sort -k2 -nr | head -1)
echo "Highest Overhead: $MAX_OVERHEAD"

# Workflows exceeding threshold
echo ""
echo "Workflows Exceeding 20% Threshold:"
awk -F, 'NR>1 && $6>20 {print "  -", $2, "Step", $3, ":", $6"%"}' "$METRICS_FILE"

# Trend over time (last 7 days)
echo ""
echo "7-Day Trend:"
SEVEN_DAYS_AGO=$(date -d '7 days ago' -Iseconds 2>/dev/null || date -v-7d -Iseconds)
awk -F, -v cutoff="$SEVEN_DAYS_AGO" 'NR>1 && $1>=cutoff {sum+=$6; count++} END {print "Recent Avg:", sum/count"%"}' "$METRICS_FILE"
```

**Testing:**
1. Run on completed workflow document
2. Verify token calculations are reasonable
3. Check CSV logging works
4. Run analyzer, verify summary report

**Success Criteria:**
- ✅ Accurately measures content vs. overhead tokens
- ✅ Logs metrics to CSV
- ✅ Identifies workflows exceeding 20% threshold
- ✅ Generates trend analysis

**Deliverables:**
- 3 measurement tools
- Initial baseline metrics for all workflows
- Optimization recommendations document

---

### Day 4: P0 Integration & Testing

**Capability:** Ensure P0 capabilities work together

**Tasks:**

1. **Integration Testing**
   - Start workflow, checkpoint, exit
   - Resume workflow, complete
   - Validate workflow structure
   - Measure context overhead
   - Verify all steps work end-to-end

2. **Documentation**
   - Create `docs/P0-capabilities-guide.md`
   - Document resume workflow usage
   - Document validation workflow
   - Document context measurement

3. **Bug Fixes**
   - Fix any issues found during testing
   - Refine error messages
   - Improve UX

**Deliverables:**
- All P0 capabilities tested and working
- Integration test suite passed
- Documentation complete

---

### Day 5: Multi-Workflow Orchestration (Swarm Mode)

**Capability:** Run workflows in parallel

**Files to Create:**

1. `Execs/.agent/workflows/swarm/workflow.md`
```markdown
# Swarm Workflow
# Trigger: /swarm

**Goal:** Orchestrate multiple workflows in parallel
**Squad:** Suge (Orchestrator) → Multiple Agents

## Workflow Architecture

- **Step 1:** @suge defines swarm configuration
- **Step 2:** @suge launches parallel workflows
- **Step 3:** @suge monitors and aggregates results
- **Step 4:** @suge generates unified report

## Usage

```
/swarm audit security-scan
```

Runs audit and security-scan simultaneously, aggregates findings.
```

2. `Execs/.agent/workflows/swarm/steps/step-01-suge-configure.md`
```markdown
# Step 1: Swarm Configuration (@suge)

## MANDATORY RULES:
- YOU ARE SUGE KNIGHT (CEO). Stay in character.
- Validate workflow compatibility before launch
- Detect resource conflicts

## EXECUTION:

### 1. Parse Swarm Request
User requested: `/swarm {workflow1} {workflow2} {workflow3}`

### 2. Validate Workflows
For each workflow:
- Check exists in `Execs/.agent/workflows/`
- Check not already running (scan for in-progress docs)
- Check output directories don't conflict

### 3. Detect Conflicts
- If workflows modify same files → WARN user
- If workflows require same agents simultaneously → SEQUENCE them
- If workflows are compatible → PARALLEL execution

### 4. Present Plan
"Swarm Plan:

**Parallel Track 1:** {workflow1}, {workflow2}
**Parallel Track 2:** {workflow3}

**Estimated Time:** {minutes} minutes
**Resource Conflicts:** {None or list}

[C] Continue
[M] Modify plan
[E] Exit

Your choice:"

### 5. Handoff
Update frontmatter: `swarm_workflows: [{workflow1}, {workflow2}]`
Load: `./step-02-suge-launch.md`
```

3. `Execs/.agent/workflows/swarm/steps/step-02-suge-launch.md`
```markdown
# Step 2: Launch Swarm (@suge)

## EXECUTION:

### 1. Create Swarm Document
```bash
SWARM_ID="swarm-$(date +%s)"
mkdir -p Execs/_squad-output/swarm
cp Execs/.agent/workflows/swarm/templates/swarm-report.md \
   Execs/_squad-output/swarm/$SWARM_ID.md
```

### 2. Launch Workflows
For each workflow in swarm_workflows:
```bash
# Launch in background
(
  cd Execs/.agent/workflows/{workflow}
  exec ./workflow.md > /tmp/swarm-{workflow}.log 2>&1
) &
echo "🚀 Launched {workflow} (PID: $!)"
```

### 3. Track PIDs
Update frontmatter:
```yaml
swarm_pids: [12345, 12346, 12347]
swarm_status: "running"
```

### 4. Handoff
"Swarm launched. Monitoring progress...

[C] Continue to monitoring
"

Load: `./step-03-suge-monitor.md`
```

4. `Execs/.agent/workflows/swarm/templates/swarm-report.md`
```yaml
---
workflow: "swarm"
swarm_id: "{swarm_id}"
swarm_workflows: []
swarm_pids: []
swarm_status: "not-started"
started: ""
completed: ""
---

# Swarm Report: {swarm_id}

**Orchestrator:** Suge Knight
**Date:** {date}
**Status:** {status}

## Workflows Executed

### {workflow1}
- Status: {status}
- Duration: {minutes}
- Result: {summary}

### {workflow2}
- Status: {status}
- Duration: {minutes}
- Result: {summary}

## Aggregated Findings

[Suge fills: Combined insights from all workflows]

## Conflicts Detected

[If any workflows had overlapping changes]

## Recommendations

[Suge fills: Next steps based on aggregate results]
```

**Testing:**
1. Run `/swarm audit code-review`
2. Verify both workflows launch
3. Verify they run in parallel (check timestamps)
4. Verify aggregated report generated

**Success Criteria:**
- ✅ Detects workflow conflicts before launch
- ✅ Launches workflows in parallel
- ✅ Monitors completion status
- ✅ Aggregates results into unified report

**Deliverables:**
- Swarm workflow (4 steps)
- Swarm report template
- Integration tests
- Documentation

---

### Day 6-7: Workflow Branching & Conditionals

**Capability:** Smart routing based on results

**Implementation Strategy:**

1. **Add Conditional Logic to Existing Workflows**

Example: `/audit` workflow

**Before (Linear):**
```markdown
Step 02 → Always load Step 03 (security scan)
```

**After (Conditional):**
```markdown
## End of Step 02

Read frontmatter: `risk_level`

If risk_level == "critical" or "high":
  Load ./step-03-security-scan.md
Else if risk_level == "medium":
  Present menu:
    [1] Run security scan anyway (recommended)
    [2] Skip to recommendations
Else if risk_level == "low":
  Skip security scan
  Load ./step-04-keisha-recommendations.md
```

2. **Files to Modify:**

- `Execs/.agent/workflows/audit/steps/step-02-keisha-metrics-analysis.md`
  - Add risk level calculation
  - Add conditional routing logic

- `Execs/.agent/workflows/new-feature/steps/step-03-soulja-validation.md`
  - If tests fail → route to step-02b-ox-fix-issues.md
  - If tests pass → route to step-04-dmx-review.md

- `Execs/.agent/workflows/code-review/steps/step-02-igor-security.md`
  - If critical vulns found → route to step-03a-emergency-remediation.md
  - If no vulns → route to step-03-dmx-verdict.md

3. **Files to Create:**

- `Execs/.agent/workflows/new-feature/steps/step-02b-ox-fix-issues.md` (loop-back for fixes)
- `Execs/.agent/workflows/code-review/steps/step-03a-emergency-remediation.md` (critical path)
- `Execs/docs/workflow-branching-guide.md` (documentation)

**Testing:**
1. Run `/audit` with high-complexity code → verify security scan triggers
2. Run `/audit` with low-complexity code → verify security scan skips
3. Run `/new-feature`, intentionally fail tests → verify loop-back to fixes
4. Verify conditional logic documented in frontmatter

**Success Criteria:**
- ✅ Workflows route based on results, not always linear
- ✅ Critical paths trigger automatically
- ✅ User has override options where appropriate
- ✅ Frontmatter logs decision points

**Deliverables:**
- 3 existing workflows updated with conditionals
- 3 new conditional step files
- Branching guide documentation
- Decision tree diagrams

---

### Day 8-9: Custom Technique Builder

**Capability:** User-extensible intelligence library

**Files to Create:**

1. `Execs/.agent/workflows/create-technique/workflow.md`
```markdown
# Create Technique Workflow
# Trigger: /create-technique

**Goal:** Add custom elicitation technique to library
**Squad:** Keisha (Designer) → Soulja (Validator)

## Workflow Steps

1. **Technique Design** - Define new technique (@keisha)
2. **Validation** - Ensure schema compliance (@soulja)
3. **Integration** - Add to CSV and update workflows (@keisha)
```

2. `Execs/.agent/workflows/create-technique/steps/step-01-keisha-design.md`
```markdown
# Step 1: Design Technique (@keisha)

## EXECUTION:

### 1. Gather Technique Details
"Let's create a custom elicitation technique.

**Technique Design Questions:**

1. **Category?** (planning / architecture / creative / security / validation / analysis)
2. **Technique Name?** (e.g., "Assumption Testing")
3. **Primary Agent?** (keisha / ox / soulja / igor / masterp / dmx / suge)
4. **Description?** (What does this technique do? How does it work?)
5. **Use Case?** (When should this be used?)

Please provide answers:"

### 2. Validate Inputs
- Category must be one of 6 valid categories
- Name must be unique (check against existing CSV)
- Agent must be valid squad member
- Description must be clear (>20 words)

### 3. Preview
"Here's your technique:

**Category:** {category}
**Name:** {technique_name}
**Agent:** {agent}
**Description:** {description}
**Use Case:** {use_case}

Does this look correct? [Y/N]"

### 4. Handoff
Update frontmatter:
```yaml
technique_category: "{category}"
technique_name: "{name}"
technique_agent: "{agent}"
technique_description: "{description}"
technique_use_case: "{use_case}"
```

Load: `./step-02-soulja-validate.md`
```

3. `Execs/dev-tools/validate-technique.sh`
```bash
#!/bin/bash
# Validates technique against schema

CATEGORY="$1"
NAME="$2"
AGENT="$3"
DESCRIPTION="$4"

VALID_CATEGORIES="planning architecture creative security validation analysis"
VALID_AGENTS="keisha ox soulja igor masterp dmx suge"

# Check category
if ! echo "$VALID_CATEGORIES" | grep -qw "$CATEGORY"; then
    echo "❌ Invalid category: $CATEGORY"
    exit 1
fi

# Check agent
if ! echo "$VALID_AGENTS" | grep -qw "$AGENT"; then
    echo "❌ Invalid agent: $AGENT"
    exit 1
fi

# Check name uniqueness
if grep -q ",$NAME," Execs/data/elicitation-techniques.csv; then
    echo "❌ Technique name already exists: $NAME"
    exit 1
fi

# Check description length
DESC_WORDS=$(echo "$DESCRIPTION" | wc -w)
if [ "$DESC_WORDS" -lt 20 ]; then
    echo "❌ Description too short (${DESC_WORDS} words, need 20+)"
    exit 1
fi

echo "✅ Technique validation passed"
exit 0
```

**Testing:**
1. Run `/create-technique`
2. Create valid technique, verify it's added to CSV
3. Try creating duplicate technique, verify rejection
4. Try creating technique with invalid category, verify rejection
5. Verify technique appears in relevant workflow menus

**Success Criteria:**
- ✅ Validates technique inputs
- ✅ Prevents duplicate names
- ✅ Appends to CSV correctly
- ✅ Updates workflow step files to include new technique
- ✅ New technique usable immediately

**Deliverables:**
- `/create-technique` workflow (3 steps)
- Validation script
- Automatic workflow integration
- Documentation

---

## Week 2: Tooling Capabilities (P2)

### Day 10: Squad Dashboard

**Capability:** Visual workflow status

**Files to Create:**

1. `Execs/dev-tools/generate-dashboard.sh`
```bash
#!/bin/bash
# Generates HTML dashboard from workflow data

OUTPUT_FILE="Execs/_squad-output/dashboard.html"

cat > "$OUTPUT_FILE" << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Squad OS Dashboard</title>
    <style>
        body { font-family: monospace; background: #1e1e1e; color: #d4d4d4; padding: 20px; }
        .container { max-width: 1200px; margin: 0 auto; }
        h1 { color: #4ec9b0; }
        .workflow { background: #252526; border-left: 4px solid #007acc; padding: 15px; margin: 10px 0; }
        .workflow.complete { border-left-color: #4ec9b0; }
        .workflow.blocked { border-left-color: #f48771; }
        .status { display: inline-block; padding: 2px 8px; border-radius: 3px; font-size: 12px; }
        .status.in-progress { background: #007acc; }
        .status.complete { background: #4ec9b0; }
        .status.blocked { background: #f48771; }
        .agent { color: #dcdcaa; }
        .metric { background: #2d2d30; padding: 10px; margin: 5px; display: inline-block; min-width: 150px; }
    </style>
</head>
<body>
<div class="container">
    <h1>🎯 Squad OS Dashboard</h1>
    <p>Generated: $(date)</p>

    <h2>📊 Metrics</h2>
    <div class="metrics">
EOF

# Calculate metrics
TOTAL_WORKFLOWS=$(find Execs/_squad-output -name "*.md" -type f | wc -l)
IN_PROGRESS=$(grep -l 'status: "in-progress"' Execs/_squad-output/**/*.md 2>/dev/null | wc -l)
COMPLETED=$(grep -l 'status: "complete"' Execs/_squad-output/**/*.md 2>/dev/null | wc -l)

cat >> "$OUTPUT_FILE" << EOF
        <div class="metric">
            <strong>Total Workflows:</strong> $TOTAL_WORKFLOWS
        </div>
        <div class="metric">
            <strong>In Progress:</strong> $IN_PROGRESS
        </div>
        <div class="metric">
            <strong>Completed:</strong> $COMPLETED
        </div>
    </div>

    <h2>🚀 Active Workflows</h2>
EOF

# List active workflows
for DOC in $(grep -l 'status: "in-progress"' Execs/_squad-output/**/*.md 2>/dev/null); do
    WORKFLOW=$(grep "^workflow:" "$DOC" | cut -d'"' -f2)
    STARTED=$(grep "^started:" "$DOC" | cut -d'"' -f2)
    STEPS=$(grep "^stepsCompleted:" "$DOC" | sed 's/.*\[//' | sed 's/\].*//' | tr ',' '\n' | wc -l)
    AGENTS=$(grep "^agents_involved:" "$DOC" | sed 's/.*\[//' | sed 's/\].*//')

    cat >> "$OUTPUT_FILE" << EOF
    <div class="workflow">
        <strong>$WORKFLOW</strong>
        <span class="status in-progress">IN PROGRESS</span><br>
        <small>Steps Completed: $STEPS | Agents: $AGENTS</small><br>
        <small>Started: $STARTED</small>
    </div>
EOF
done

# List completed workflows (last 7 days)
SEVEN_DAYS_AGO=$(date -d '7 days ago' '+%Y-%m-%d' 2>/dev/null || date -v-7d '+%Y-%m-%d')

cat >> "$OUTPUT_FILE" << EOF
    <h2>✅ Recently Completed</h2>
EOF

for DOC in $(grep -l 'status: "complete"' Execs/_squad-output/**/*.md 2>/dev/null); do
    COMPLETED_DATE=$(grep "^completed:" "$DOC" | cut -d'"' -f2 | cut -dT -f1)

    if [[ "$COMPLETED_DATE" > "$SEVEN_DAYS_AGO" ]]; then
        WORKFLOW=$(grep "^workflow:" "$DOC" | cut -d'"' -f2)

        cat >> "$OUTPUT_FILE" << EOF
    <div class="workflow complete">
        <strong>$WORKFLOW</strong>
        <span class="status complete">COMPLETE</span><br>
        <small>Completed: $COMPLETED_DATE</small>
    </div>
EOF
    fi
done

cat >> "$OUTPUT_FILE" << 'EOF'
</div>
</body>
</html>
EOF

echo "✅ Dashboard generated: $OUTPUT_FILE"
echo "Open with: open $OUTPUT_FILE"
```

**Testing:**
1. Generate dashboard: `bash Execs/dev-tools/generate-dashboard.sh`
2. Open in browser
3. Verify metrics accurate
4. Verify active workflows listed
5. Verify completed workflows shown

**Success Criteria:**
- ✅ Shows accurate workflow count
- ✅ Lists active workflows with progress
- ✅ Shows recently completed workflows
- ✅ Refreshes when regenerated

**Deliverables:**
- Dashboard generator script
- HTML template
- Auto-refresh capability (optional)

---

### Day 11-12: Workflow Templates Generator

**Capability:** Create workflows in 15 minutes

**Files to Create:**

1. `Execs/dev-tools/create-workflow.sh`
```bash
#!/bin/bash
# Creates new workflow from templates

WORKFLOW_NAME="$1"
NUM_STEPS="${2:-3}"  # Default 3 steps
AGENTS="${3:-keisha,ox,soulja}"  # Default agent sequence

if [ -z "$WORKFLOW_NAME" ]; then
    echo "Usage: $0 <workflow-name> [num-steps] [agents]"
    echo "Example: $0 my-workflow 4 'keisha,ox,soulja,dmx'"
    exit 1
fi

WORKFLOW_DIR="Execs/.agent/workflows/$WORKFLOW_NAME"

# Check if workflow already exists
if [ -d "$WORKFLOW_DIR" ]; then
    echo "❌ Workflow already exists: $WORKFLOW_NAME"
    exit 1
fi

echo "🚀 Creating workflow: $WORKFLOW_NAME"

# Create directory structure
mkdir -p "$WORKFLOW_DIR/steps"
mkdir -p "$WORKFLOW_DIR/templates"

# Split agents into array
IFS=',' read -ra AGENT_ARRAY <<< "$AGENTS"

# Generate workflow.md
cat > "$WORKFLOW_DIR/workflow.md" << EOF
# $(echo "$WORKFLOW_NAME" | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g') Workflow
# Trigger: /$WORKFLOW_NAME

**Goal:** [TODO: Define workflow goal]
**Squad:** $(echo "$AGENTS" | sed 's/,/ -> /g')

---

## Workflow Architecture

This workflow uses **BMAD micro-file architecture**:
$(for i in $(seq 1 "$NUM_STEPS"); do
    AGENT=${AGENT_ARRAY[$((i-1))]}
    echo "- **Step $i:** @$AGENT [TODO: Define step purpose]"
done)

**State Tracking:**
- Progress tracked in document frontmatter
- Artifacts stored in \`Execs/_squad-output/$WORKFLOW_NAME/\`

---

## Initialization

### Configuration
- \`installed_path\` = \`Execs/.agent/workflows/$WORKFLOW_NAME\`
- \`template_path\` = \`{installed_path}/templates/${WORKFLOW_NAME}-template.md\`
- \`output_dir\` = \`Execs/_squad-output/$WORKFLOW_NAME\`

### Execution
Load and execute Step 1:

\`\`\`bash
exec Execs/.agent/workflows/$WORKFLOW_NAME/steps/step-01-${AGENT_ARRAY[0]}-[purpose].md
\`\`\`
EOF

# Generate template
cat > "$WORKFLOW_DIR/templates/${WORKFLOW_NAME}-template.md" << EOF
---
workflow: "$WORKFLOW_NAME"
stepsCompleted: []
status: "not-started"
agents_involved: []
started: ""
completed: ""
# [TODO: Add workflow-specific frontmatter fields]
---

# $WORKFLOW_NAME Report

**Date:** {date}
**Status:** {status}

---

## [Section 1 - TODO: Name this section]

[Step 1 fills this]

---

## [Section 2 - TODO: Name this section]

[Step 2+ fills this]

---

## Results

[Final step fills this]
EOF

# Generate step files
for i in $(seq 1 "$NUM_STEPS"); do
    AGENT=${AGENT_ARRAY[$((i-1))]}
    STEP_FILE="$WORKFLOW_DIR/steps/step-0$i-$AGENT-[purpose].md"

    cat > "$STEP_FILE" << EOF
# Step $i: [TODO: Step Name] (@$AGENT)

## MANDATORY EXECUTION RULES:
- 📋 YOU ARE $(echo "$AGENT" | tr '[:lower:]' '[:upper:]'). Stay in character.
- [TODO: Add agent-specific rules]
- 💾 Update frontmatter before loading next step

## CONTEXT:
- **Role:** $AGENT
- **Goal:** [TODO: Define step goal]
- **Next Step:** [TODO: Who's next?]

---

## EXECUTION:

### 1. [TODO: First Sub-Task]
[TODO: Implementation details]

### 2. [TODO: Second Sub-Task]
[TODO: Implementation details]

### 3. Document Results
Append to workflow document:

\`\`\`markdown
## [TODO: Section Name]

[TODO: What this step adds to document]
\`\`\`

Update frontmatter:
\`\`\`yaml
stepsCompleted: [1$(for j in $(seq 2 $i); do echo -n ", $j"; done)]
# [TODO: Update other frontmatter fields]
\`\`\`

### 4. Handoff
"[TODO: Summary of what was accomplished]

**Next Step:** [TODO: What happens next]

[C] Continue to [Next Step Name]
[E] Exit (save progress)

Your choice:"

---

## STEP COMPLETION:

When user chooses [C]:

Update frontmatter: \`stepsCompleted: [1$(for j in $(seq 2 $i); do echo -n ", $j"; done)]\`

Load next step:
\`\`\`bash
exec ./step-0$((i+1))-[next-agent]-[purpose].md
\`\`\`
EOF
done

# Create output directory
mkdir -p "Execs/_squad-output/$WORKFLOW_NAME"

echo "✅ Workflow created successfully!"
echo ""
echo "Next steps:"
echo "1. Edit workflow.md - Define goal and architecture"
echo "2. Edit templates/${WORKFLOW_NAME}-template.md - Define output structure"
echo "3. Edit each step file - Implement step logic"
echo "4. Replace all [TODO] markers"
echo "5. Test workflow: /$WORKFLOW_NAME"
echo "6. Validate: bash Execs/dev-tools/validate-workflow.sh $WORKFLOW_DIR"
```

**Testing:**
1. Create test workflow: `bash Execs/dev-tools/create-workflow.sh test-workflow 3 keisha,ox,soulja`
2. Verify directory structure created
3. Verify all files have proper templates
4. Fill in TODOs, test workflow execution
5. Validate with validation engine

**Success Criteria:**
- ✅ Generates proper directory structure
- ✅ Creates workflow.md, template, and step files
- ✅ All files have required sections
- ✅ Passes validation engine
- ✅ Reduces workflow creation time to <15 minutes

**Deliverables:**
- Workflow generator script
- Template files
- Usage documentation
- Example workflow created with generator

---

### Day 13: Agent Performance Analytics

**Capability:** Track agent effectiveness

**Files to Create:**

1. `Execs/.agent-ops/agent-analytics.csv`
```csv
timestamp,agent,workflow,action,outcome,tokens_used
```

2. `Execs/dev-tools/log-agent-action.sh`
```bash
#!/bin/bash
# Logs agent action to analytics

AGENT="$1"
WORKFLOW="$2"
ACTION="$3"
OUTCOME="$4"
TOKENS="${5:-0}"

echo "$(date -Iseconds),$AGENT,$WORKFLOW,$ACTION,$OUTCOME,$TOKENS" >> Execs/.agent-ops/agent-analytics.csv
```

3. `Execs/dev-tools/generate-agent-report.sh`
```bash
#!/bin/bash
# Generates agent performance report

ANALYTICS_FILE="Execs/.agent-ops/agent-analytics.csv"

echo "Agent Performance Report"
echo "========================"
echo ""

# Actions per agent
echo "Actions by Agent:"
awk -F, 'NR>1 {count[$2]++} END {for (agent in count) print "  " agent ":", count[agent]}' "$ANALYTICS_FILE" | sort -t: -k2 -nr

echo ""

# Approval/Block rate for DMX
echo "DMX Decisions:"
DMX_TOTAL=$(awk -F, '$2=="dmx"' "$ANALYTICS_FILE" | wc -l)
DMX_APPROVED=$(awk -F, '$2=="dmx" && $4=="approved"' "$ANALYTICS_FILE" | wc -l)
DMX_BLOCKED=$(awk -F, '$2=="dmx" && $4=="blocked"' "$ANALYTICS_FILE" | wc -l)
echo "  Total Decisions: $DMX_TOTAL"
echo "  Approved: $DMX_APPROVED"
echo "  Blocked: $DMX_BLOCKED"

echo ""

# Average tokens per agent
echo "Average Tokens per Agent:"
awk -F, 'NR>1 {sum[$2]+=$6; count[$2]++} END {for (agent in sum) print "  " agent ":", int(sum[agent]/count[agent])}' "$ANALYTICS_FILE"
```

**Testing:**
1. Manually log some test actions
2. Generate report, verify calculations
3. Run multiple workflows, track agent participation
4. Verify analytics capture decision quality

**Success Criteria:**
- ✅ Logs all agent actions
- ✅ Tracks decisions (approved/blocked/modified)
- ✅ Calculates token efficiency per agent
- ✅ Identifies bottleneck agents

**Deliverables:**
- Analytics logging system
- Report generator
- Weekly report template

---

### Day 14: Integration Testing Suite

**Capability:** Automated workflow validation

**Files to Create:**

1. `Execs/dev-tools/test-workflow.sh`
```bash
#!/bin/bash
# Tests a workflow end-to-end with simulated inputs

WORKFLOW="$1"

if [ -z "$WORKFLOW" ]; then
    echo "Usage: $0 <workflow-name>"
    exit 1
fi

WORKFLOW_DIR="Execs/.agent/workflows/$WORKFLOW"
FIXTURES_DIR="Execs/dev-tools/test-fixtures/$WORKFLOW"

if [ ! -d "$WORKFLOW_DIR" ]; then
    echo "❌ Workflow not found: $WORKFLOW"
    exit 1
fi

echo "🧪 Testing workflow: $WORKFLOW"

# Load test fixtures (simulated user inputs)
if [ ! -f "$FIXTURES_DIR/inputs.txt" ]; then
    echo "⚠️  No test fixtures found for $WORKFLOW"
    echo "Create: $FIXTURES_DIR/inputs.txt"
    exit 1
fi

# Simulate workflow execution
# (This is simplified - real implementation would need to actually run workflow)

# Test 1: Workflow structure validation
echo "Test 1: Structure validation..."
if bash Execs/dev-tools/validate-workflow.sh "$WORKFLOW_DIR"; then
    echo "  ✅ Structure valid"
else
    echo "  ❌ Structure invalid"
    exit 1
fi

# Test 2: Step sequence check
echo "Test 2: Step sequence..."
EXPECTED_STEPS=$(find "$WORKFLOW_DIR/steps" -name "step-*.md" | wc -l)
echo "  Found $EXPECTED_STEPS step files"

# Test 3: Template frontmatter check
echo "Test 3: Template frontmatter..."
TEMPLATE=$(find "$WORKFLOW_DIR/templates" -name "*.md" | head -1)
if grep -q "^---$" "$TEMPLATE"; then
    echo "  ✅ Frontmatter present"
else
    echo "  ❌ Frontmatter missing"
    exit 1
fi

# Test 4: Output directory exists
echo "Test 4: Output directory..."
OUTPUT_DIR="Execs/_squad-output/$WORKFLOW"
if [ ! -d "$OUTPUT_DIR" ]; then
    echo "  ⚠️  Creating output directory: $OUTPUT_DIR"
    mkdir -p "$OUTPUT_DIR"
fi
echo "  ✅ Output directory ready"

echo ""
echo "✅ All tests passed for $WORKFLOW"
```

2. `Execs/dev-tools/test-all-workflows.sh`
```bash
#!/bin/bash
# Tests all workflows

PASSED=0
FAILED=0

for WORKFLOW_DIR in Execs/.agent/workflows/*; do
    if [ -d "$WORKFLOW_DIR" ] && [ "$(basename "$WORKFLOW_DIR")" != "_shared" ] && [ "$(basename "$WORKFLOW_DIR")" != "_legacy_v1" ]; then
        WORKFLOW=$(basename "$WORKFLOW_DIR")

        if bash Execs/dev-tools/test-workflow.sh "$WORKFLOW"; then
            PASSED=$((PASSED + 1))
        else
            FAILED=$((FAILED + 1))
        fi
        echo ""
    fi
done

echo "========================================"
echo "TEST SUMMARY"
echo "Passed: $PASSED"
echo "Failed: $FAILED"
echo "========================================"

if [ "$FAILED" -eq 0 ]; then
    exit 0
else
    exit 1
fi
```

3. Create test fixtures directory structure:
```bash
mkdir -p Execs/dev-tools/test-fixtures/{new-feature,code-review,audit,debug,improve,organize,refactor,security-scan}
```

**Testing:**
1. Create test fixtures for 2-3 workflows
2. Run individual workflow tests
3. Run full test suite
4. Verify all tests pass

**Success Criteria:**
- ✅ Tests validate structure
- ✅ Tests check frontmatter schema
- ✅ Tests verify output directories
- ✅ Full test suite passes for all workflows

**Deliverables:**
- Test framework scripts
- Test fixtures for all workflows
- CI/CD integration guide

---

## Summary & Completion Checklist

### P0: Foundation (Days 1-4)
- [ ] Day 1: Workflow State Persistence & Recovery
- [ ] Day 2: Workflow Validation Engine
- [ ] Day 3: Agent Context Optimizer
- [ ] Day 4: P0 Integration & Testing

### P1: Intelligence (Days 5-9)
- [ ] Day 5: Multi-Workflow Orchestration (Swarm Mode)
- [ ] Day 6-7: Workflow Branching & Conditionals
- [ ] Day 8-9: Custom Technique Builder

### P2: Tooling (Days 10-14)
- [ ] Day 10: Squad Dashboard
- [ ] Day 11-12: Workflow Templates Generator
- [ ] Day 13: Agent Performance Analytics
- [ ] Day 14: Integration Testing Suite

---

## Success Metrics (Overall)

After completing all 10 capabilities:

### Efficiency
- ✅ Workflow completion time: 30% faster
- ✅ Context overhead: <15% average
- ✅ Interrupted workflow recovery: >95%
- ✅ New workflow creation: <15 minutes

### Quality
- ✅ Malformed workflows: 0%
- ✅ Workflow test coverage: 100%
- ✅ Agent decision quality: tracked and improving

### Adoption
- ✅ Custom techniques created: 5+ in first month
- ✅ Swarm mode usage: 20% of executions
- ✅ Dashboard daily users: 80%+

---

## Executor Notes

**For the agent implementing this:**

1. **Work sequentially** - Complete each day before moving to next
2. **Test thoroughly** - Every capability must pass tests before proceeding
3. **Update documentation** - Create docs as you build
4. **Track progress** - Update this checklist as capabilities complete
5. **Ask for help** - If blocked, consult CEO or other agents

**Daily Deliverables:**
- Working code/scripts
- Test results (all passing)
- Documentation
- Integration with existing system

**Communication:**
- Daily standup: What was completed, what's next, any blockers
- End of week: Demo of P0/P1/P2 capabilities

---

**Ready for execution. Good luck, squad!** 🚀

*CEO Suge Knight, standing by for progress reports.*
