#!/usr/bin/env python3
import argparse
import datetime
import os
import re
import sys
from pathlib import Path


AUDIT_TEMPLATES = [
    ("keisha", "requirements", "keisha-requirements-audit.template.md"),
    ("keisha", "architecture", "keisha-architecture-audit.template.md"),
    ("keisha", "tech-debt", "keisha-tech-debt-audit.template.md"),
    ("soulja", "validation", "soulja-validation-audit.template.md"),
    ("soulja", "flow-coverage", "soulja-flow-coverage-audit.template.md"),
    ("ox", "implementation", "ox-implementation-audit.template.md"),
    ("igor", "security", "igor-security-audit.template.md"),
    ("master-p", "ux", "master-p-ux-audit.template.md"),
    ("dmx", "release", "dmx-release-audit.template.md"),
    ("suge", "ops", "suge-ops-audit.template.md"),
]


def find_repo_root(start):
    current = Path(start).resolve()
    for parent in [current] + list(current.parents):
        if (parent / ".git").exists():
            return parent
    return current


def resolve_tasks_dir(root, tasks_dir):
    path = Path(tasks_dir)
    if not path.is_absolute():
        path = root / path
    return path


def read_text(path):
    try:
        return path.read_text(encoding="utf-8", errors="ignore")
    except OSError:
        return ""


def parse_prd_naming(prd_path):
    content = read_text(prd_path)
    for line in content.splitlines():
        if line.startswith("Feature:"):
            match = re.match(
                r"^Feature:\s*(.*?)\s*\|\s*Codename:\s*(.*?)\s*\|\s*Owner:\s*(.*)$",
                line.strip(),
            )
            if match:
                return match.group(1).strip(), match.group(2).strip(), match.group(3).strip()
    return "<Name>", "<Codename>", "<Agent>"


def load_template(root, template_name):
    template_path = root / "Execs" / "docs" / "audits" / "templates" / template_name
    if not template_path.exists():
        raise FileNotFoundError("Template missing: {}".format(template_path))
    return template_path.read_text(encoding="utf-8", errors="ignore")


def render_template(content, feature_name, codename, owner, date_str):
    content = content.replace("Feature: <Name> | Codename: <Codename> | Owner: <Agent>",
                              "Feature: {} | Codename: {} | Owner: {}".format(feature_name, codename, owner))
    content = content.replace("Date: YYYY-MM-DD", "Date: {}".format(date_str))
    return content


def ensure_report(root, agent, audit_type, feature, date_str, template_content, overwrite):
    reports_dir = root / "Execs" / "docs" / "audits" / "reports" / agent
    reports_dir.mkdir(parents=True, exist_ok=True)
    report_name = "audit-{}-{}-{}.md".format(feature, audit_type, date_str)
    report_path = reports_dir / report_name
    if report_path.exists() and not overwrite:
        return report_path, False
    report_path.write_text(template_content, encoding="utf-8")
    return report_path, True


def parse_args(argv):
    parser = argparse.ArgumentParser(
        description="Scaffold audit reports from templates."
    )
    parser.add_argument("--feature", required=True, help="Feature slug (prd-<slug>.md)")
    parser.add_argument("--tasks-dir", default="tasks", help="Tasks directory")
    parser.add_argument("--date", help="Override date (YYYY-MM-DD)")
    parser.add_argument("--overwrite", action="store_true", help="Overwrite existing reports")
    return parser.parse_args(argv)


def main(argv):
    args = parse_args(argv)
    root = find_repo_root(os.getcwd())
    tasks_dir = resolve_tasks_dir(root, args.tasks_dir)

    prd_path = tasks_dir / "prd-{}.md".format(args.feature)
    feature_name, codename, owner = parse_prd_naming(prd_path) if prd_path.exists() else (
        "<Name>", "<Codename>", "<Agent>"
    )

    if args.date:
        date_str = args.date
    else:
        date_str = datetime.date.today().strftime("%Y-%m-%d")

    created = []
    skipped = []

    for agent, audit_type, template in AUDIT_TEMPLATES:
        template_content = load_template(root, template)
        rendered = render_template(template_content, feature_name, codename, owner, date_str)
        report_path, did_create = ensure_report(
            root, agent, audit_type, args.feature, date_str, rendered, args.overwrite
        )
        if did_create:
            created.append(report_path)
        else:
            skipped.append(report_path)

    print("AUDIT SCAFFOLD: feature {}".format(args.feature))
    print("DATE: {}".format(date_str))
    if created:
        print("CREATED:")
        for path in created:
            print("- {}".format(path))
    if skipped:
        print("SKIPPED (already exists):")
        for path in skipped:
            print("- {}".format(path))

    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
