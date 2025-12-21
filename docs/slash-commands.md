# Comprehensive Slash Command Reference
## AI Coding Agent Workflows (December 2025)

---

## Quick Reference Table

| Category | Command | Invocation | Input | Output | Best For |
|----------|---------|-----------|-------|--------|----------|
| **PLANNING** | `/plan` | `/plan "implement OAuth2"` | Requirements string | Task JSON + markdown | Breaking down features |
| | `/architect` | `/architect $ARGUMENTS` | Feature description | Architecture diagram + decisions | System design |
| | `/analyze` | `/analyze` | Codebase context | Complexity report + patterns | Understanding existing code |
| | `/organize` | `/organize` | Codebase | Reorganization plan | Refactoring structure |
| **CODING** | `/implement` | `/implement $ARGUMENTS` | Task specification | Code diff + tests | Feature development |
| | `/refactor` | `/refactor "simplify payment logic"` | Code section + goal | Refactored code + explanation | Code quality improvements |
| | `/scaffold` | `/scaffold api-endpoint` | Module type + name | Boilerplate structure | New module creation |
| | `/fix` | `/fix` | Error message + context | Code patch + explanation | Bug fixes |
| **TESTING** | `/test-gen` | `/test-gen $ARGUMENTS` | Function/feature name | Test cases + examples | Test coverage |
| | `/debug` | `/debug` | Error stack + context | Root cause + fix suggestion | Debugging issues |
| | `/trace` | `/trace "auth flow"` | Function path | Execution flow diagram | Understanding execution paths |
| | `/perf` | `/perf` | Function/query | Optimization suggestions | Performance analysis |
| **REVIEW** | `/review` | `/review` | Code diff | Feedback + decision | Code quality review |
| | `/security-scan` | `/security-scan` | Code/dependencies | Vulnerabilities + fixes | Security assessment |
| | `/coverage` | `/coverage` | Test results | Coverage gaps + recommendations | Test completeness |
| **QUALITY** | `/improve` | `/improve` | Codebase/Product | Refinement plan + evidence | Improving without new features |
| | `/lint-fix` | `/lint-fix` | Code section | Formatted code | Style/formatting |
| | `/dependency-audit` | `/dependency-audit` | package.json/Cargo.toml | Vulnerability report | Dependency security |
| **DOCS** | `/document` | `/document $ARGUMENTS` | Code section | API docs + comments | Documentation |
| | `/migrate` | `/migrate "jest→vitest"` | Module/config | Migration script + changes | Version/framework updates |

---

## Detailed Command Specifications

### PLANNING COMMANDS

#### `/plan`
**Purpose**: Break down requirements into implementable tasks
```
Usage: /plan "implement real-time notifications"

Expected Input:
- Feature description (1-2 sentences)
- Optional: constraints, timeline

Returns:
{
  "tasks": [
    {"id": 1, "title": "Design notification schema", "hours": 2, "dependencies": []},
    {"id": 2, "title": "Implement push service", "hours": 4, "dependencies": [1]},
    {"id": 3, "title": "Add client integration", "hours": 3, "dependencies": [2]},
    {"id": 4, "title": "Write tests", "hours": 2, "dependencies": [2,3]},
  ],
  "estimated_total_hours": 11,
  "risks": ["Latency critical", "Cross-platform complexity"],
  "acceptance_criteria": ["Notifications deliver within 1s", "98% uptime SLA"]
}
```

#### `/architect`
**Purpose**: Design system structure, data models, API contracts
```
Usage: /architect "multi-tenant SaaS payment system"

Returns:
- Database schema design (tables, relationships)
- API contract (REST/gRPC endpoints)
- Architecture diagram (text-based)
- Technology recommendations
- Trade-off analysis
- Scalability considerations
```

#### `/analyze`
**Purpose**: Examine codebase for complexity, patterns, dependencies
```
Usage: /analyze  # Analyzes full project
Usage: /analyze src/payment/  # Analyzes specific directory

Returns:
{
  "total_files": 42,
  "total_lines": 15000,
  "cyclomatic_complexity": 3.2,
  "modules": [
    {"name": "auth", "type": "critical", "health": "good"},
    {"name": "cache", "type": "utility", "health": "needs_refactor"}
  ],
  "dependency_graph": {...},
  "code_duplication": "4.2%",
  "recommendations": [...]
}
```

---

### CODING COMMANDS

#### `/implement`
**Purpose**: Generate code from task specification
```
Usage: /implement "Create REST endpoint for user profiles with RBAC"

Requires:
- Task specification (from /plan)
- Language context (inferred or specified)
- Code style guide (from .agent/config/)

Returns:
- Code diff (git-compatible)
- New files created
- Modified files with line numbers
- Import statements added
- Test files generated

Example output:
```diff
+ src/routes/profiles.rs (NEW)
+ tests/profiles_test.rs (NEW)
~ src/main.rs (MODIFIED)
  - Added route registration
  - Added dependency injection
```
```

#### `/refactor`
**Purpose**: Restructure code for quality, performance, or maintainability
```
Usage: /refactor "Extract payment logic into separate service"
Usage: /refactor "Convert callbacks to async/await"

Input:
- Target code section (file, class, or function)
- Refactoring goal (extract, simplify, async, etc.)

Returns:
- Before/after comparison
- Explanation of changes
- Test verification
- Impact analysis (what else might break)
```

#### `/scaffold`
**Purpose**: Generate boilerplate for common structures
```
Usage: /scaffold api-endpoint
Usage: /scaffold database-model
Usage: /scaffold middleware

Available scaffolds:
- api-endpoint (REST CRUD)
- database-model (with migrations)
- middleware (auth, logging, etc.)
- service-layer (business logic)
- test-suite (unit + integration)
```

#### `/fix`
**Purpose**: Analyze errors and provide fixes
```
Usage: /fix "TypeError: Cannot read property 'map' of undefined"

Input:
- Error message
- Code context (surrounding lines)
- Stack trace (optional)

Returns:
- Root cause analysis
- Code fix with explanation
- Prevention tips
- Related issues to check
```

---

### TESTING COMMANDS

#### `/test-gen`
**Purpose**: Generate tests for functions/features
```
Usage: /test-gen "validatePaymentMethod function"
Usage: /test-gen  # Generate tests for modified files

Returns:
- Unit test cases (normal flow, edge cases, errors)
- Integration test scenarios
- Mock setup code
- Expected assertions
- Coverage analysis

Example:
```rust
#[test]
fn test_validate_payment_empty_card_number() {
    let payment = PaymentMethod { card_number: "", ... };
    assert!(validate_payment_method(&payment).is_err());
}
```
```

#### `/debug`
**Purpose**: Trace execution and find bugs
```
Usage: /debug  # Run in debug mode on failing tests

Returns:
- Execution trace
- Variable state at each step
- Comparison with expected behavior
- Root cause identification
- Suggested fixes with line numbers
```

#### `/trace`
**Purpose**: Understand code execution flow
```
Usage: /trace "user login flow"
Usage: /trace "payment processing"

Returns:
- Step-by-step execution flow
- Function call graph
- Data transformations
- External dependencies invoked
- Timing analysis
- Visual flow diagram (ASCII)
```

#### `/perf`
**Purpose**: Identify performance bottlenecks
```
Usage: /perf  # Profile entire application
Usage: /perf "queryUserData function"

Returns:
- CPU profile (hot functions)
- Memory profile (allocations)
- I/O operations (database, network)
- Optimization suggestions with code examples
- Benchmark results
- Comparison with baseline
```

---

### REVIEW COMMANDS

#### `/review`
**Purpose**: Comprehensive code review
```
Usage: /review  # Review modified files
Usage: /review src/auth.rs  # Review specific file

Checks:
- Architecture & design patterns
- Code quality & readability
- Performance implications
- Security vulnerabilities
- Test coverage
- Documentation

Returns:
{
  "decision": "approve|request_changes|comment",
  "issues": [
    {"severity": "critical", "file": "src/auth.rs:42", "issue": "SQL injection risk", "fix": "..."},
    {"severity": "medium", "file": "src/cache.rs", "issue": "Memory leak potential", "fix": "..."}
  ],
  "suggestions": ["Add error handling", "Extract method"],
  "test_coverage": 0.87,
  "security_score": 0.92
}
```

#### `/security-scan`
**Purpose**: Detect security vulnerabilities
```
Usage: /security-scan
Usage: /security-scan --deep  # Include code analysis

Scans:
- SAST (static code analysis)
- Dependency vulnerabilities (npm audit, cargo audit)
- Secret detection (API keys, credentials)
- Authentication/authorization review
- Input validation coverage
- XSS/CSRF protection

Returns:
{
  "vulnerabilities": [
    {"cve": "CVE-2025-1234", "package": "lodash", "severity": "high", "fix": "npm install lodash@4.17.21"},
    {"type": "secret", "file": "config.js:5", "content": "***exposed_api_key***"}
  ],
  "score": 72,  // out of 100
  "report": "..."
}
```

#### `/coverage`
**Purpose**: Analyze test coverage
```
Usage: /coverage
Usage: /coverage src/payment/

Returns:
{
  "overall": 0.87,  // 87%
  "by_file": [
    {"file": "auth.rs", "coverage": 0.95, "uncovered": [42, 43]},
    {"file": "cache.rs", "coverage": 0.71, "uncovered": [...]},
  ],
  "gaps": [
    {"file": "payment.rs", "lines": "15-30", "description": "Error handling paths"}
  ],
  "recommendations": [
    "Add tests for failure cases in payment.rs",
    "Test edge cases in cache eviction logic"
  ]
}
```

---

### QUALITY & MAINTENANCE

#### `/lint-fix`
**Purpose**: Auto-fix code style and formatting
```
Usage: /lint-fix
Usage: /lint-fix src/  # Fix specific directory

Returns:
- Auto-fixed code
- Summary of changes (lines reformatted, rules applied)
- Manual review items (complex refactorings)
- Before/after diff
```

#### `/dependency-audit`
**Purpose**: Scan dependencies for vulnerabilities
```
Usage: /dependency-audit
Usage: /dependency-audit --fix  # Auto-upgrade vulnerable packages

Returns:
{
  "vulnerabilities": [
    {"package": "lodash", "current": "4.17.15", "latest_safe": "4.17.21", "severity": "medium"},
    {"package": "axios", "current": "0.21.0", "latest": "1.6.0", "security_issue": "request validation"}
  ],
  "total_packages": 42,
  "vulnerable": 3,
  "outdated": 12,
  "recommendations": [
    "Upgrade lodash to 4.17.21 immediately",
    "Plan axios upgrade for next minor release"
  ]
}
```

---

### DOCUMENTATION

#### `/document`
**Purpose**: Generate API docs, README, code comments
```
Usage: /document "API endpoints"
Usage: /document "src/auth.rs"  # Document specific module
Usage: /document --format=openapi  # Generate OpenAPI spec

Returns:
- API documentation (Markdown or OpenAPI)
- Function/class documentation
- Usage examples
- Error responses
- Type definitions
- Integration guide
```

#### `/migrate`
**Purpose**: Refactor for major version/framework changes
```
Usage: /migrate "jest→vitest"
Usage: /migrate "sync→async"
Usage: /migrate "express→fastify"

Returns:
- Migration script/checklist
- Code changes (before/after)
- Test updates
- Configuration changes
- Rollback plan
- Known issues & workarounds
```

---

## Advanced Usage Patterns

### Chaining Commands
```
# Plan → Implement → Test → Review pipeline
/plan "add two-factor auth"
/implement $ARGUMENTS  # Takes plan output as context
/test-gen $ARGUMENTS   # Tests the implementation
/review $ARGUMENTS     # Reviews the full implementation
```

### With Arguments
```
# Simple string argument
/implement "Create user profile page"

# Complex input with variables
/refactor "Extract $ARGUMENTS into separate service"
# Then invoke: /refactor payment processing logic

# Using $1, $2 positional arguments
/scaffold $1 $2  # /scaffold api-endpoint users
```

### File References
```
# Reference specific file
/analyze src/payment/processor.rs

# Reference by pattern
/lint-fix "src/**/*.ts"

# Current file context (automatic in IDE)
/review  # Reviews currently open file
```

---

## Multi-Agent Workflow Integration

### For Team of 4 Agents

**Agent: Keisha (Planner)**
```
Primary commands: /plan, /architect, /analyze
Inputs: Feature requirements, stakeholder needs
Outputs: Task breakdown, acceptance criteria, architecture docs
```

**Agent: Ox (Coder)**
```
Primary commands: /implement, /scaffold, /refactor
Inputs: Task breakdown from Keisha
Outputs: Code diff, test files, implementation details
```

**Agent: Soulja (Tester)**
```
Primary commands: /test-gen, /debug, /trace, /coverage, /perf
Inputs: Code from Ox
Outputs: Test results, performance profiles, identified issues
```

**Agent: DMX (Reviewer)**
```
Primary commands: /review, /security-scan, /coverage-analysis
Inputs: Code from Ox, tests from Soulja
Outputs: Review decision, feedback, approval/rejection
```

---

## Command Matrix by Technology

### Rust-Specific
- `/analyze` - Check for unsafe blocks, borrowing issues
- `/perf` - Profile memory allocations, lifetimes
- `/test-gen` - Generate tests with `#[test]` macros
- `/migrate` - Async runtime changes, edition migrations
- Relevant tools: `cargo clippy`, `cargo-audit`, `cargo-flamegraph`

### TypeScript/JavaScript
- `/lint-fix` - ESLint + Prettier
- `/refactor` - Type extraction, React hooks
- `/test-gen` - Jest/Vitest/Playwright
- `/migrate` - Dependency version jumps, CommonJS→ESM
- Relevant tools: `npm audit`, `TypeScript`, `Biome`

### Go
- `/implement` - Generate interfaces, error handling patterns
- `/perf` - Profile goroutines, allocations
- `/test-gen` - Table-driven tests
- `/migrate` - Go version updates, module migrations
- Relevant tools: `go vet`, `golangci-lint`, `pprof`

### Python
- `/lint-fix` - Black + isort + flake8
- `/test-gen` - pytest fixtures, mocks
- `/perf` - cProfile, memory profiling
- `/migrate` - Python 2→3, framework updates
- Relevant tools: `bandit`, `safety`, `mypy`

---

## Cost Optimization

**Low-cost operations** (good for high-frequency use):
- `/lint-fix` - Mostly pattern matching
- `/analyze` - Static analysis
- `/coverage` - Report generation
- `/document` - Template-based

**Medium-cost operations** (use strategically):
- `/refactor` - Requires code understanding
- `/test-gen` - Multiple test cases
- `/migrate` - Complex transformation

**High-cost operations** (use sparingly):
- `/architect` - Deep analysis
- `/review` - Comprehensive checking
- `/security-scan --deep` - Full analysis
- `/perf` - Profiling and optimization

**Tip**: Run `/analyze` once, then cheaper commands for iteration.

---

## Error Recovery

If a command fails or produces incorrect output:

```bash
# Provide additional context
/analyze "focus on performance issues"

# Request alternative approach
/refactor "extract payment logic, use composition pattern"

# Start over with simpler request
/implement "just create the database schema"
```

---

*This reference guide covers December 2025 best practices for AI coding agents.*
*Maintain in `.agent/README.md` for team access.*
