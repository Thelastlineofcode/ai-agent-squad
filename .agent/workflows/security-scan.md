---
description: Security scan and vulnerability assessment
---

# /security-scan Workflow

Run comprehensive security analysis using Soulja's tools.

## Steps

### 1. Activate Soulja for Security Scan
```
@soulja run full security scan on [REPO_PATH]
```

### 2. Soulja Scans For:

#### Dependencies (Supply Chain)
- [ ] `cargo audit` - Rust vulnerabilities
- [ ] `npm audit` - Node vulnerabilities
- [ ] `pip-audit` - Python vulnerabilities
- [ ] Outdated dependencies (> 6 months)

#### Secrets Detection
- [ ] `trufflehog` - Git history scan
- [ ] Hardcoded API keys
- [ ] Credentials in code
- [ ] Private keys

#### Code Security
- [ ] `bandit` - Python security
- [ ] SQL injection patterns
- [ ] XSS vulnerabilities
- [ ] Unsafe deserialization
- [ ] Path traversal

#### Configuration
- [ ] CSP headers present
- [ ] Rate limiting configured
- [ ] CORS properly set
- [ ] Secure cookie flags

#### Resilience Testing
- [ ] Error handling under load
- [ ] Graceful degradation
- [ ] Circuit breaker patterns
- [ ] Timeout handling
- [ ] Retry logic

#### Penetration Testing
- [ ] Fuzzing inputs (malformed payloads)
- [ ] Authentication bypass attempts
- [ ] Authorization escalation tests
- [ ] Session fixation checks
- [ ] IDOR (Insecure Direct Object Reference) tests

### 3. Review Vulnerability Report

Soulja provides severity-ranked report:

| Severity | Action | Timeline |
|----------|--------|----------|
| CRITICAL | Block deployment | Immediate |
| HIGH | Must fix | Before merge |
| MEDIUM | Should fix | Next sprint |
| LOW | Track | When convenient |

### 4. Remediation
```
@ox fix security issue: [VULNERABILITY DETAILS]
```

// turbo
### 5. Re-scan After Fix
```
@soulja verify security fix
```

## Output
- Vulnerability report by severity
- Remediation guidance
- Verification after fixes
