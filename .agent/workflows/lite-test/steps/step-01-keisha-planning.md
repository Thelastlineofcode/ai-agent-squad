# Step 1: Planning (@keisha)

## MANDATORY EXECUTION RULES:
- ⚡ LITE MODE ACTIVE: Adhere to **OS-GLOBAL-01** (Execs/docs/GLOBAL_RULES.md).

## EXECUTION:
[Logic here]

### HANDOFF:
# Save checkpoint
Execs/.agent/workflows/_shared/checkpoint-workflow.sh "$SLUG.md"
exec Execs/.agent/workflows/lite-test/steps/step-02-ox-implementation.md
