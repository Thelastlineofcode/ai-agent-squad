# Step 2: Metrics Analysis

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER make up metrics - use actual tool output
- ✅ ALWAYS show tool commands before running them
- 📋 YOU ARE AN ANALYST interpreting data, not generating fake numbers
- 💬 FOCUS on metrics collection and interpretation only

---

## YOUR TASK:

Collect and analyze codebase metrics: complexity, coverage, coupling.

---

## METRICS COLLECTION:

### A. Load Audit Context

Read from document frontmatter:
- `repo_path` - Where to run analysis
- `tech_stack` - Which tools to use
- `focus_areas` - What metrics to prioritize

### B. Run Appropriate Tools Based on Tech Stack

**For Rust projects:**
```bash
cd {repo_path}

# Complexity analysis
cargo-bloat --release

# Coverage (if tests exist)
cargo tarpaulin --out Stdout

# Dependency audit
cargo audit
```

**For TypeScript/JavaScript projects:**
```bash
cd {repo_path}

# Complexity
npx complexity-report src/

# Bundle size
npx webpack-bundle-analyzer

# Security audit
npm audit
```

**For Python projects:**
```bash
cd {repo_path}

# Complexity
radon cc . -a

# Coverage
pytest --cov --cov-report=term

# Security
safety check
```

Show user which commands will run, get approval, then execute.

### C. Analyze Results

After collecting metrics, analyze:

**Complexity Hotspots:**
- Which files have cyclomatic complexity > 12?
- Which functions are > 30 lines?
- Rank top 10 most complex files

**Coverage Gaps:**
- Overall coverage percentage
- Which modules have < 70% coverage?
- Critical paths without tests

**Coupling Issues:**
- Which modules import too many dependencies?
- Circular dependencies detected?
- High-fan-out modules

### D. Update Audit Report

Append to document:

```markdown
## Metrics Analysis

**Collected:** {datetime}
**Tools Used:** {list_of_tools}

### Complexity Metrics

- **Average Cyclomatic Complexity:** {value}
- **Functions > 30 lines:** {count}
- **Top Complexity Hotspots:**
  1. {file}:{function} - Complexity {value}
  2. {file}:{function} - Complexity {value}
  3. ...

### Coverage Metrics

- **Overall Coverage:** {percentage}%
- **Modules < 70% Coverage:**
  1. {module} - {percentage}%
  2. ...

### Coupling/Dependency Metrics

- **Circular Dependencies:** {count}
- **High-Fan-Out Modules:** {list}
- **Dependency Audit Issues:** {count} vulnerabilities
```

Update frontmatter:
```yaml
metrics_collected: true
stepsCompleted: [1, 2]
```

### E. Present Findings Summary

"Metrics analysis complete. Here's the summary:

**Complexity:**
- {count} files exceed complexity threshold
- Top hotspot: {file} (complexity {value})

**Coverage:**
- Overall: {percentage}%
- {count} modules need test coverage

**Dependencies:**
- {count} security vulnerabilities found
- {count} circular dependencies detected

**Next Steps:**

[1] Run security deep-dive (optional - calls @igor or @soulja)
[2] Skip to recommendations
[3] Exit

### 3. Handoff

# Save checkpoint
Execs/.agent/workflows/_shared/checkpoint-workflow.sh "$SLUG.md"

# Conditional Routing
# If risk level is high (>7), force security scan.
if Execs/.agent/workflows/_shared/check-condition.sh "$SLUG.md" risk_level gt 7; then
    echo "⚠️ RISK LEVEL HIGH. Launching Security Scan."
    exec Execs/.agent/workflows/audit/steps/step-03-security-scan.md
else
    echo "✅ Risk level acceptable. Proceeding to Recommendations."
    exec Execs/.agent/workflows/audit/steps/step-04-keisha-recommendations.md
fi

---

## STEP COMPLETION:

Before loading next step, update frontmatter:
```yaml
stepsCompleted: [1, 2]
```

Then execute chosen step file.

---

## CONTEXT HANDOFF:

Next step will read from frontmatter:
- `metrics_collected: true` - Metrics are available in document
- `stepsCompleted: [1, 2]` - Ready for step 3 or 4
- Document body contains all metrics data
