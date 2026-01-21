# Contributing Guide

**Purpose:** Development guide and standards for contributors (humans and AI agents).

**Last Updated:** [YYYY-MM-DD]

---

## Project Overview

**Name:** [Project Name]
**Type:** [Web App / CLI Tool / Library / etc.]
**Status:** [Planning / Development / Production]

**Description:**
[1-2 paragraph description of what this project does and why it exists]

---

## Tech Stack

### Frontend
- **Framework:** [e.g., React, Leptos, etc.]
- **Language:** [e.g., TypeScript, Rust]
- **Build Tool:** [e.g., Vite, Trunk]
- **Key Libraries:** [List important deps]

### Backend
- **Framework:** [e.g., Axum, Express, etc.]
- **Language:** [e.g., Rust, Node.js]
- **Database:** [e.g., PostgreSQL, MongoDB]
- **Cache:** [e.g., Redis, if applicable]

### Infrastructure
- **Hosting:** [e.g., Vercel, AWS, Railway]
- **CI/CD:** [e.g., GitHub Actions]
- **Monitoring:** [e.g., Sentry, if applicable]

---

## Code Standards

### File Organization
```
[Describe your folder structure]
src/
├── components/
├── services/
└── utils/
```

### Naming Conventions
- **Files:** [e.g., kebab-case, snake_case]
- **Functions:** [e.g., camelCase, snake_case]
- **Components:** [e.g., PascalCase]
- **Constants:** [e.g., SCREAMING_SNAKE_CASE]

### Code Style
- **Linter:** [e.g., eslint, clippy]
- **Formatter:** [e.g., prettier, rustfmt]
- **Git Hooks:** [e.g., pre-commit, husky]

---

## Development Workflow

### Getting Started
```bash
# Clone and setup
git clone [repo-url]
cd [project-name]

# Install dependencies
[install command]

# Setup environment
cp .env.example .env
# Edit .env with required values

# Run development server
[dev command]
```

### Testing
```bash
# Run tests
[test command]

# Check coverage
[coverage command]
```

### Building
```bash
# Production build
[build command]
```

---

## Agent Workflow

**Core Doctrine File:** `team-fullstack.txt` (project root). Agents must load this after `CONTRIBUTING.md`.

### Planning Phase (@keisha)
1. Read this file for context
2. Analyze requirements
3. Create PRD in `.agent-ops/_squad-output/features/`
4. Update ops board with tasks

### Implementation Phase (@ox)
1. Read PRD and this file
2. Implement according to code standards above
3. Follow architecture patterns
4. Update ops board on completion

### Testing Phase (@soulja)
1. Run full test suite
2. Verify coverage meets threshold
3. Document results
4. Update ops board

### Review Phase (@dmx)
1. Check code quality
2. Verify standards compliance
3. Approve or request changes

---

## Critical Rules

### DO
- [Important things to always do]
- [Critical patterns to follow]

### DON'T
- [Important things to avoid]
- [Common mistakes to prevent]

---

## Key Files & Locations

| Purpose | Location |
|---------|----------|
| Configuration | [path] |
| Entry Point | [path] |
| Tests | [path] |
| Docs | [path] |

---

## Environment Variables

| Variable | Purpose | Example |
|----------|---------|---------|
| [VAR_NAME] | [What it does] | [Sample value] |

---

## External Dependencies

| Service | Purpose | Docs |
|---------|---------|------|
| [Service name] | [What it's used for] | [Link] |

---

## Known Issues / Debt

- [Technical debt item 1]
- [Known issue 1]

---

## Future Roadmap

- [Planned feature 1]
- [Planned improvement 1]

---

**Template Version:** 1.0
