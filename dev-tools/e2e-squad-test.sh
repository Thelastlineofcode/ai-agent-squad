#!/bin/bash
# e2e-squad-test.sh
# Final integration test suite for Squad OS v2.0.

set -e

echo "🚀 STARTING SQUAD OS v2.0 E2E TEST SUITE"
echo "----------------------------------------"

# 1. Validation Test
echo "Test 1: Global Workflow Audit"
bash Execs/dev-tools/validate-all-workflows.sh
echo "✅ Test 1 Passed"

# 2. Persistence Test
echo "Test 2: Checkpoint Engine"
MOCK="Execs/_squad-output/features/mock-recovery-test.md"
bash Execs/.agent/workflows/_shared/checkpoint-workflow.sh "$MOCK"
grep -q "last_checkpoint:" "$MOCK"
echo "✅ Test 2 Passed"

# 3. Analytics Test
echo "Test 3: Performance Analysis"
bash Execs/dev-tools/analyze-agent-performance.sh
echo "✅ Test 3 Passed"

# 4. Dashboard Test
echo "Test 4: Dashboard Generation"
bash Execs/dev-tools/generate-dashboard.sh
echo "✅ Test 4 Passed"

# 5. Scaffolding Test
echo "Test 5: Workflow Scaffolding"
[ -d "Execs/.agent/workflows/e2e-test-workflow" ] && rm -rf "Execs/.agent/workflows/e2e-test-workflow"
bash Execs/dev-tools/scaffold-workflow.sh "e2e-test-workflow"
bash Execs/dev-tools/validate-workflow.sh "Execs/.agent/workflows/e2e-test-workflow"
echo "✅ Test 5 Passed"

echo "----------------------------------------"
echo "🏆 ALL SQUAD OS v2.0 TESTS PASSED"
echo "MISSION STATUS: READY FOR PRODUCTION"
