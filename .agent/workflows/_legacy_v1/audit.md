---
description: Audit codebase for tech debt, complexity, and security issues
---

# /audit Workflow

Run a comprehensive codebase audit using Keisha's analysis tools.

## Steps

### 1. Activate Keisha
```
@keisha audit [REPO_PATH] for tech debt
```

### 2. Provide Context (if asked)
- Tech stack (Rust, TypeScript, Go, Python)
- Specific concerns (performance, security, complexity)
- Critical modules to focus on

### 3. Review Audit Report
Keisha will provide:
- **Metrics**: Complexity, coverage, coupling
- **Hotspots**: Files ranked by risk
- **Recommendations**: Actions with ROI estimates

### 4. Optional: Deep Dive
```
@keisha analyze [SPECIFIC_MODULE] in detail
```

### 5. Optional: Research Best Practices
```
@keisha fetch transcript from [YOUTUBE_URL] about [TECH]
```
- Use `youtube-transcript` MCP to find conference talks
- Learn from industry experts on best practices

### 6. Optional: Security Focus
```
@soulja run security scan on [REPO_PATH]
```

## Output
- Audit report with metrics
- Ranked hotspots
- Prioritized recommendations
- Optional: Security vulnerability report
