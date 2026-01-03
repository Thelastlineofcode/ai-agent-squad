# Step 3: Risk Audit (@igor & @soulja)

## MANDATORY EXECUTION RULES:
- 📋 YOU ARE IGOR (Tech) and SOULJA (Validation).
- 🧱 Perform a technical stress-test to confirm the "moat."

## EXECUTION:

### 1. Technical Scan
// turbo
```bash
# Test status
npm test 2>&1 | tail -5 || cargo test 2>&1 | tail -5 || echo "No tests found."

# Security audit
npm audit 2>&1 | head -10 || cargo audit 2>&1 | head -10 || echo "No security scan available."

# Context Overhead (Squad OS v2.0)
bash Execs/dev-tools/measure-context-overhead.sh README.md
```

### 2. Rating findings
- 🔴 **Critical** - Moat is fake, product is broken.
- 🟠 **High** - Significant technical debt.
- 🟡 **Medium** - Optimization needed.

### 3. Handoff
"The numbers don't lie. Sending the data back to the Tank for the final verdict."

# Save checkpoint
Execs/.agent/workflows/_shared/checkpoint-workflow.sh "$SLUG.md"

exec Execs/.agent/workflows/shark-tank/steps/step-04-verdict.md
