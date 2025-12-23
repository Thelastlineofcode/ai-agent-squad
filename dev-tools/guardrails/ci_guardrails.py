#!/usr/bin/env python3
import os
import subprocess
import sys
from pathlib import Path


def run(cmd, cwd):
    return subprocess.check_output(cmd, cwd=cwd, text=True).strip()


def get_changed_files(root, base_sha, head_sha):
    output = run(["git", "diff", "--name-only", base_sha, head_sha], cwd=root)
    if not output:
        return []
    return [line.strip() for line in output.splitlines() if line.strip()]


def prd_slugs(changed):
    slugs = []
    for path in changed:
        if path.startswith("tasks/prd-") and path.endswith(".md"):
            name = Path(path).name
            slug = name[len("prd-") : -len(".md")]
            if slug:
                slugs.append(slug)
    return sorted(set(slugs))


def run_guardrails(root, slug):
    guardrails = root / "Execs" / "dev-tools" / "guardrails" / "guardrails.py"
    cmd = [
        sys.executable,
        str(guardrails),
        "--voice",
        "soulja",
        "--feature",
        slug,
        "--stage",
        "preflight",
    ]
    return subprocess.call(cmd, cwd=str(root))


def main():
    root = Path(__file__).resolve().parents[3]
    base_sha = os.environ.get("BASE_SHA")
    head_sha = os.environ.get("HEAD_SHA")
    if not base_sha or not head_sha:
        print("CI guardrails: BASE_SHA/HEAD_SHA missing")
        return 1

    changed = get_changed_files(root, base_sha, head_sha)
    slugs = prd_slugs(changed)
    if not slugs:
        print("CI guardrails: no PRD changes detected")
        return 0

    print("CI guardrails: PRD slugs -> {}".format(", ".join(slugs)))
    for slug in slugs:
        code = run_guardrails(root, slug)
        if code != 0:
            return code
    return 0


if __name__ == "__main__":
    sys.exit(main())
