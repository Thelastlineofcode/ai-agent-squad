# Step 3: Security Deep-Dive (Optional)

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER skip security checks - run all applicable scans
- ✅ ALWAYS use actual security tools, not hypothetical analysis
- 📋 YOU ARE A SECURITY AUDITOR, not a casual reviewer
- 💬 FOCUS on security vulnerabilities and resilience only

---

## YOUR TASK:

Conduct deep security analysis using @igor or @soulja.

---

## SECURITY SCAN:

### A. Determine Security Agent

"I'll now conduct a security deep-dive. Who should lead this?

[1] **@soulja** - Validation & QA focus (cargo audit, trufflehog, security tests)
[2] **@igor** - Architecture & Penetration Testing (security design, threat modeling)

Your choice:"

### B. Execute Security Scan

**If @soulja chosen:**

Call Soulja with MCP tools:
```bash
# Secret detection
trufflehog filesystem {repo_path} --only-verified

# Dependency vulnerabilities (Rust)
cargo audit

# Or for JS/TS
npm audit --audit-level=moderate

# Or for Python
safety check
```

**If @igor chosen:**

Call Igor for threat modeling:
- Apply **Threat Modeling (STRIDE)** technique from elicitation-techniques.csv
- Spoofing / Tampering / Repudiation / Info Disclosure / DoS / Elevation
- Identify attack vectors
- Recommend defenses

### C. Document Security Findings

Append to audit report:

```markdown
## Security Findings

**Security Auditor:** {agent_name}
**Scan Date:** {datetime}

### Vulnerabilities Identified

#### High Severity
- {vulnerability} in {location} - CVE-{number}
- {vulnerability} in {location} - CVE-{number}

#### Medium Severity
- {vulnerability} in {location}

#### Low Severity / Info
- {vulnerability} in {location}

### Secrets/Credentials Detected

- {type} found in {file}:{line}
- {type} found in {file}:{line}

### Threat Model (STRIDE Analysis)

- **Spoofing Risk:** {description}
- **Tampering Risk:** {description}
- **Repudiation Risk:** {description}
- **Information Disclosure:** {description}
- **Denial of Service:** {description}
- **Elevation of Privilege:** {description}

### Recommended Mitigations

1. {action} - Priority: {HIGH/MED/LOW}
2. {action} - Priority: {HIGH/MED/LOW}
```

Update frontmatter:
```yaml
security_scan_run: true
stepsCompleted: [1, 2, 3]
```

### D. Present Security Summary

"Security scan complete.

**Findings Summary:**
- **High Severity:** {count} vulnerabilities
- **Medium Severity:** {count} vulnerabilities
- **Secrets Detected:** {count} instances
- **Threat Model:** {key_risks}

**Next Step:** Generate prioritized recommendations

[C] Continue to Recommendations
[E] Exit and save progress

Your choice:"

---

## STEP COMPLETION:

When user chooses [C]:

Update frontmatter:
```yaml
stepsCompleted: [1, 2, 3]
```

**Load next step:**
"Loading Step 4: Recommendations..."

```
exec ./step-04-keisha-recommendations.md
```

---

## CONTEXT HANDOFF TO STEP 4:

Step 4 will read:
- `security_scan_run: true` - Security findings available
- `stepsCompleted: [1, 2, 3]` - Ready for final recommendations
- Document contains all metrics + security data
