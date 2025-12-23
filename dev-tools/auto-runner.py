#!/usr/bin/env python3
import argparse
import os
import subprocess
import sys
from pathlib import Path


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


def find_latest_prd(tasks_dir):
    candidates = list(tasks_dir.glob("prd-*.md"))
    if not candidates:
        return None
    candidates.sort(key=lambda p: p.stat().st_mtime, reverse=True)
    return candidates[0]


def slug_from_prd(prd_path):
    name = prd_path.name
    if not name.startswith("prd-") or not name.endswith(".md"):
        return None
    return name[len("prd-") : -len(".md")]


def run_guardrails(root, feature, stage):
    guardrails = root / "Execs" / "dev-tools" / "guardrails" / "guardrails.py"
    cmd = [
        sys.executable,
        str(guardrails),
        "--voice",
        "soulja",
        "--feature",
        feature,
        "--stage",
        stage,
    ]
    return subprocess.call(cmd, cwd=str(root))


def ensure_artifacts(tasks_dir, feature):
    prd = tasks_dir / f"prd-{feature}.md"
    tasklist = tasks_dir / f"tasks-{feature}.md"
    tdd = tasks_dir / f"tdd-{feature}.md"
    missing = [path for path in (prd, tasklist, tdd) if not path.exists()]
    return missing


def print_steps(feature, phase):
    if phase == "preflight":
        print("NEXT STEPS:")
        print("1) @ox build {} with tests first (dev env, no mocks)".format(feature))
        print("2) When tests + code are ready, run:")
        print("   python Execs/dev-tools/auto-runner.py --feature {} --phase post".format(feature))
        return
    print("NEXT STEPS:")
    print("1) @soulja validate {}".format(feature))
    print("2) @dmx review and approve for production")


def parse_args(argv):
    parser = argparse.ArgumentParser(
        description="Auto runner for preflight → build → validate → review."
    )
    parser.add_argument("--feature", help="Feature slug (matches prd-<slug>.md)")
    parser.add_argument("--tasks-dir", default="tasks", help="Tasks directory")
    parser.add_argument(
        "--phase",
        default="preflight",
        choices=["preflight", "post"],
        help="Phase to run: preflight or post",
    )
    return parser.parse_args(argv)


def main(argv):
    args = parse_args(argv)
    root = find_repo_root(os.getcwd())
    tasks_dir = resolve_tasks_dir(root, args.tasks_dir)

    if not tasks_dir.exists():
        print("AUTO RUNNER: tasks directory missing ({})".format(tasks_dir))
        return 1

    feature = args.feature
    if not feature:
        latest = find_latest_prd(tasks_dir)
        if not latest:
            print("AUTO RUNNER: no PRD found in {}".format(tasks_dir))
            return 1
        feature = slug_from_prd(latest)

    if not feature:
        print("AUTO RUNNER: unable to determine feature slug")
        return 1

    missing = ensure_artifacts(tasks_dir, feature)
    if missing:
        print("AUTO RUNNER: missing required files:")
        for path in missing:
            print("- {}".format(path))
        return 1

    print("AUTO RUNNER: feature {}".format(feature))
    if args.phase == "preflight":
        print("PHASE: preflight")
        code = run_guardrails(root, feature, "preflight")
        if code != 0:
            return code
        print_steps(feature, "preflight")
        return 0

    print("PHASE: post")
    code = run_guardrails(root, feature, "post")
    if code != 0:
        return code
    print_steps(feature, "post")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
