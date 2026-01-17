# PROJECT SPECIFICATIONS

This file defines project-specific configurations that override the agnostic Execs agent defaults.
Place this file in your project's `.agent-ops/` directory.

---

## PROJECT METADATA

**Project Name:** [Your Project Name]
**Primary Language:** [e.g., Rust, TypeScript, Python, Go, Java]
**Framework:** [e.g., Next.js, FastAPI, Axum, Spring Boot, or "None"]
**Architecture:** [e.g., Microservices, Monolith, Serverless]

---

## BUILD & TEST COMMANDS

These commands replace the `{{PLACEHOLDER}}` values in workflow files.

### Build Command
```bash
# Command to build/compile the project
PROJECT_BUILD_COMMAND="npm run build"
```

**Examples by language:**
- **Rust:** `cargo check` or `cargo build`
- **TypeScript/Node:** `npm run build` or `pnpm build`
- **Python:** `python -m build` or `poetry build`
- **Go:** `go build ./...`
- **Java:** `mvn compile` or `gradle build`

### Test Command
```bash
# Command to run the full test suite
PROJECT_TEST_COMMAND="npm test"
```

**Examples by language:**
- **Rust:** `cargo test`
- **TypeScript/Node:** `npm test` or `vitest run`
- **Python:** `pytest` or `python -m pytest`
- **Go:** `go test ./...`
- **Java:** `mvn test` or `gradle test`

### Lint Command
```bash
# Command to run code quality/style checks
PROJECT_LINT_COMMAND="npm run lint"
```

**Examples by language:**
- **Rust:** `cargo clippy`
- **TypeScript/Node:** `eslint .` or `npm run lint`
- **Python:** `ruff check .` or `pylint src/`
- **Go:** `golangci-lint run`
- **Java:** `mvn checkstyle:check`

### Coverage Command (Optional)
```bash
# Command to generate coverage reports
PROJECT_COVERAGE_COMMAND="npm run test:coverage"
```

**Examples by language:**
- **Rust:** `cargo tarpaulin` or `cargo llvm-cov`
- **TypeScript/Node:** `vitest run --coverage` or `jest --coverage`
- **Python:** `pytest --cov=src --cov-report=term`
- **Go:** `go test -cover ./...`

### Security Scan Command (Optional)
```bash
# Command to run security/vulnerability scans
PROJECT_SECURITY_SCAN_COMMAND="npm audit"
```

**Examples by language:**
- **Rust:** `cargo audit`
- **TypeScript/Node:** `npm audit` or `snyk test`
- **Python:** `safety check` or `bandit -r src/`
- **Go:** `gosec ./...`

---

## CODE QUALITY STANDARDS

### Coverage Targets
- **Minimum Coverage:** 85%
- **Critical Path Coverage:** 95%
- **Test Execution Time:** < 1 second per 100 unit tests

### Complexity Limits
- **Cyclomatic Complexity:** < 12 per function
- **Function Length:** < 30 lines (or well-justified)
- **File Length:** < 500 lines (or domain-justified)

### Error Handling
- **Pattern:** [e.g., Result<T, E> types, try/catch, error interfaces]
- **Custom Errors:** [Required/Optional]
- **Error Messages:** Must be actionable and contextual

---

## TESTING STRATEGY

### Unit Tests
- **Location:** [e.g., `tests/`, `src/__tests__/`, `*_test.go`]
- **Naming Convention:** [e.g., `test_*.py`, `*.test.ts`, `*_test.rs`]
- **Dev Environment:** [Describe if tests use real dev services vs mocks]

### Integration Tests
- **Location:** [e.g., `tests/integration/`, `e2e/`]
- **Requirements:** [e.g., Docker, local DB, API keys]

### E2E Tests
- **Framework:** [e.g., Playwright, Cypress, Selenium, or "None"]
- **Command:** [e.g., `npm run test:e2e`]

---

## ARCHITECTURE PATTERNS

### Dependency Injection
- **Approach:** [e.g., Traits/Interfaces, Constructor injection, Service containers]
- **Example:**
  ```
  [Show a minimal example of how dependencies are injected in your project]
  ```

### Repository Pattern
- **Usage:** [Required/Optional/Not Used]
- **Location:** [e.g., `src/repositories/`, `lib/data/`]

### Error Handling
- **Standard:** [e.g., Result types, Exceptions, Error interfaces]
- **Example:**
  ```
  [Show how errors are handled in your project]
  ```

---

## DEVELOPMENT ENVIRONMENT

### Prerequisites
- **Runtime:** [e.g., Node 20+, Python 3.11+, Rust 1.75+, Go 1.21+]
- **Package Manager:** [e.g., npm, pnpm, cargo, poetry, go modules]
- **Database:** [e.g., PostgreSQL 15, None]
- **Other Services:** [e.g., Redis, Neo4j, None]

### Setup Commands
```bash
# Install dependencies
[e.g., npm install, cargo build, poetry install]

# Start dev environment
[e.g., docker-compose up, npm run dev]

# Initialize database
[e.g., npm run db:migrate, alembic upgrade head]
```

---

## DEPLOYMENT

### Build Artifacts
- **Output:** [e.g., `dist/`, `target/release/`, `build/`]
- **Format:** [e.g., Docker image, Binary, Static files]

### Environment Variables
- **Required:** [List critical env vars]
- **Example File:** [e.g., `.env.example`, `config.example.yaml`]

---

## AGENT-SPECIFIC OVERRIDES

### Ox (Implementation)
- **Preferred Patterns:** [e.g., "Use Axum for all HTTP handlers", "Prefer composition over inheritance"]
- **Avoid:** [e.g., "No global state", "No circular dependencies"]

### Soulja Slim (Validation)
- **Critical Tests:** [e.g., "All API endpoints must have integration tests"]
- **Security Focus:** [e.g., "Scan all user inputs for SQL injection"]

### Keisha (Planning)
- **Documentation Style:** [e.g., "ADRs for architecture decisions", "Inline for implementation details"]
- **Complexity Budget:** [e.g., "Max 5 new files per feature"]

---

## NOTES

[Add any project-specific context, conventions, or gotchas that agents should know]

**Examples:**
- "We use monorepo with Nx, always run `nx affected:test` not `npm test`"
- "Database migrations must be reversible"
- "All public APIs must have OpenAPI specs"
- "Use feature flags for anything user-facing"
