# Step 4: Prioritized Recommendations

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER provide generic advice - tie to actual findings
- ✅ ALWAYS include ROI estimates (time to fix vs. impact)
- 📋 YOU ARE A STRATEGIST prioritizing actions, not listing everything
- 💬 FOCUS on actionable, prioritized recommendations only

---

## YOUR TASK:

Synthesize all findings into prioritized action plan with ROI.

---

## RECOMMENDATION GENERATION:

### A. Review All Findings

Read from audit document:
- Complexity hotspots (from step 2)
- Coverage gaps (from step 2)
- Dependency issues (from step 2)
- Security vulnerabilities (from step 3, if run)

### B. Apply Prioritization Framework

For each issue, assess:
- **Severity:** How bad if not fixed? (Critical / High / Medium / Low)
- **Effort:** Time to fix? (Hours / Days / Weeks)
- **Impact:** What improves? (Security / Performance / Maintainability / All)
- **ROI:** Impact / Effort ratio

### C. Offer Prioritization Technique (Optional)

"Before finalizing recommendations, would you like to use a prioritization technique?

[1] **Pre-Mortem Analysis** - Imagine project failed due to tech debt. What killed it?
[2] **RICE Scoring** - Reach × Impact × Confidence / Effort
[3] **Skip technique** - Use standard severity-based prioritization

Your choice:"

If technique selected: Apply, document insights

### D. Generate Prioritized Recommendations

Append to audit report:

```markdown
## Recommendations

**Prioritization Method:** {method_used}
**Date:** {datetime}

### P0: Critical (Must Fix Immediately)

1. **{issue_title}**
   - **Finding:** {description}
   - **Location:** {file_or_module}
   - **Risk:** {what_happens_if_not_fixed}
   - **Effort:** {time_estimate}
   - **Impact:** {benefit_when_fixed}
   - **ROI:** HIGH
   - **Owner:** {suggested_agent_or_human}

2. **{issue_title}**
   - ...

### P1: High Priority (Fix This Sprint)

1. **{issue_title}**
   - **Finding:** {description}
   - **Effort:** {time_estimate}
   - **Impact:** {benefit}
   - **ROI:** MEDIUM-HIGH
   - **Owner:** {suggested_agent_or_human}

### P2: Medium Priority (Next 2-3 Sprints)

1. **{issue_title}**
   - **Effort:** {time_estimate}
   - **Impact:** {benefit}
   - **ROI:** MEDIUM

### P3: Low Priority (Backlog)

1. **{issue_title}**
   - **Effort:** {time_estimate}
   - **Impact:** {benefit}
   - **ROI:** LOW

---

## Action Plan

**Week 1:**
- [ ] {P0_item_1}
- [ ] {P0_item_2}

**Week 2-3:**
- [ ] {P1_item_1}
- [ ] {P1_item_2}

**Month 2:**
- [ ] {P2_items}

**Backlog:**
- [ ] {P3_items}

---

## Success Metrics

Track improvement via:
- **Complexity:** Target average < 8, no files > 15
- **Coverage:** Target > 85% overall, all critical paths > 90%
- **Security:** Zero high-severity vulnerabilities
- **Dependencies:** All packages patched to secure versions

**Re-audit Date:** {date + 4 weeks}
```

Update frontmatter:
```yaml
recommendations_provided: true
stepsCompleted: [1, 2, 3, 4]
status: "complete"
completed: "{datetime}"
```

### E. Present Final Summary

"Audit complete! Here's your action plan:

**P0 (Critical):** {count} items - fix immediately
**P1 (High):** {count} items - fix this sprint
**P2 (Medium):** {count} items - next 2-3 sprints
**P3 (Low):** {count} items - backlog

**Estimated Effort:**
- P0: {total_hours} hours
- P1: {total_days} days

**Expected Impact:**
- {key_benefit_1}
- {key_benefit_2}
- {key_benefit_3}

**Audit report saved to:** `{audit_file_path}`

**Next Steps:**
- Review report with team
- Assign owners to P0/P1 items
- Schedule re-audit in 4 weeks

Audit workflow complete. Standing by for next task."

---

## WORKFLOW COMPLETION:

Audit is now complete. All findings documented in `Execs/_squad-output/audits/audit-{repo}-{date}.md`.

**Frontmatter final state:**
```yaml
workflow: "audit"
stepsCompleted: [1, 2, 3, 4]
metrics_collected: true
security_scan_run: true
recommendations_provided: true
status: "complete"
completed: "{datetime}"
```

User can now:
- Share report with team
- Track progress on recommendations
- Re-run audit in future to measure improvement
