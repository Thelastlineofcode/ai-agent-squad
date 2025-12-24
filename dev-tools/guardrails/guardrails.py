#!/usr/bin/env python3
import argparse
import os
import re
import sys
from pathlib import Path


SKIP_DIRS = {
    ".git",
    "node_modules",
    "dist",
    "build",
    ".next",
    "target",
    "venv",
    ".venv",
    "__pycache__",
}

STACK_MARKERS = {
    "node": ["package.json", "pnpm-lock.yaml", "yarn.lock", "bun.lockb"],
    "python": ["pyproject.toml", "requirements.txt", "setup.py", "Pipfile"],
    "rust": ["Cargo.toml"],
    "go": ["go.mod"],
    "java": ["pom.xml", "build.gradle", "build.gradle.kts"],
    "dotnet": ["*.csproj", "global.json"],
    "ruby": ["Gemfile"],
    "php": ["composer.json"],
}

DEFAULT_TEST_COMMANDS = {
    "node": "npm test",
    "python": "pytest",
    "rust": "cargo test",
    "go": "go test ./...",
    "java": "mvn test",
    "dotnet": "dotnet test",
    "ruby": "bundle exec rspec",
    "php": "vendor/bin/phpunit",
}


VOICE_LINES = {
    "ox": {
        "name": "OX",
        "pass": "OX: Clear. Tests first. Move.",
        "fail": "OX: Blocked. Fix the gaps, then re-run.",
    },
    "soulja": {
        "name": "SOULJA",
        "pass": "SOULJA: Verified. Nothing slips.",
        "fail": "SOULJA: Blocked. No shortcuts.",
    },
    "dmx": {
        "name": "DMX",
        "pass": "DMX: Approved to proceed. Do not lower the bar.",
        "fail": "DMX: Blocked. Fix and resubmit.",
    },
    "keisha": {
        "name": "KEISHA",
        "pass": "KEISHA: Requirements met. Proceed.",
        "fail": "KEISHA: Blocked. Requirements incomplete.",
    },
    "suge": {
        "name": "SUGE",
        "pass": "SUGE: Green light. Stay in lane.",
        "fail": "SUGE: Stop. Fix the gaps.",
    },
    "igor": {
        "name": "IGOR",
        "pass": "IGOR: No cracks. For now.",
        "fail": "IGOR: I see weakness. Blocked.",
    },
    "master-p": {
        "name": "MASTER P",
        "pass": "MASTER P: Clear. Keep it clean and usable.",
        "fail": "MASTER P: Blocked. Experience is not ready.",
    },
}


def find_repo_root(start):
    current = Path(start).resolve()
    for parent in [current] + list(current.parents):
        if (parent / ".git").exists():
            return parent
    return current


def resolve_tasks_dir(root, tasks_dir):
    if not tasks_dir:
        return root / "tasks"
    path = Path(tasks_dir)
    if not path.is_absolute():
        path = root / path
    return path


def detect_stacks(root):
    found = []
    for stack, markers in STACK_MARKERS.items():
        hits = []
        for marker in markers:
            if "*" in marker:
                if list(root.glob(marker)):
                    hits.append(marker)
            else:
                if (root / marker).exists():
                    hits.append(marker)
        if hits:
            found.append((stack, hits))
    return found


def find_latest_prd(tasks_dir):
    if not tasks_dir.exists():
        return None
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


def read_text(path):
    try:
        return path.read_text(encoding="utf-8", errors="ignore")
    except OSError:
        return ""


def collect_test_files(root, stack):
    files = []
    for base, dirs, files in os.walk(root):
        dirs[:] = [d for d in dirs if d not in SKIP_DIRS]
        for name in files:
            path = Path(base) / name
            if stack == "node":
                if name.endswith((".test.js", ".test.jsx", ".test.ts", ".test.tsx")):
                    files.append(path)
                if name.endswith((".spec.js", ".spec.jsx", ".spec.ts", ".spec.tsx")):
                    files.append(path)
                if "__tests__" in path.parts:
                    files.append(path)
            elif stack == "python":
                if name.startswith("test_") and name.endswith(".py"):
                    files.append(path)
                if "tests" in path.parts and name.endswith(".py"):
                    files.append(path)
            elif stack == "rust":
                if name.endswith("_test.rs"):
                    files.append(path)
                if "tests" in path.parts and name.endswith(".rs"):
                    files.append(path)
            elif stack == "go":
                if name.endswith("_test.go"):
                    files.append(path)
            elif stack == "java":
                if "src" in path.parts and "test" in path.parts and name.endswith(".java"):
                    files.append(path)
                if name.endswith("Test.java"):
                    files.append(path)
            elif stack == "dotnet":
                if name.endswith("Tests.csproj") or name.endswith(".Tests.csproj"):
                    files.append(path)
                if name.endswith(".cs") and "Tests" in path.parts:
                    files.append(path)
            elif stack == "ruby":
                if name.endswith("_spec.rb"):
                    files.append(path)
                if "spec" in path.parts and name.endswith(".rb"):
                    files.append(path)
            elif stack == "php":
                if name.endswith("Test.php") or name.endswith("Tests.php"):
                    files.append(path)
                if "tests" in path.parts and name.endswith(".php"):
                    files.append(path)
    return files


def scan_for_mocks(test_files):
    pattern = re.compile(r"\b(mock|stub|fake|spy)\b", re.IGNORECASE)
    hits = []
    for path in test_files:
        content = read_text(path)
        if pattern.search(content):
            hits.append(path)
    return hits


def parse_field(content, field):
    for line in content.splitlines():
        if line.startswith(field):
            return line[len(field) :].strip()
    return ""


def check_tdd_evidence(tdd_path, stage):
    if not tdd_path.exists():
        return False, ["Missing TDD evidence file: {}".format(tdd_path)]
    content = read_text(tdd_path)
    if stage == "preflight":
        if "Test Command:" not in content:
            return False, ["TDD evidence missing fields: Test Command:"]
        return True, []
    required = [
        "Test Command:",
        "Red:",
        "Green:",
        "Dev Run:",
        "Deployment Run:",
        "Failure Cases:",
        "Edge Cases:",
        "No Mocks:",
    ]
    missing = [field for field in required if field not in content]
    if missing:
        return False, ["TDD evidence missing fields: {}".format(", ".join(missing))]
    issues = []
    no_mocks_value = parse_field(content, "No Mocks:").lower()
    if no_mocks_value not in {"yes", "true"}:
        issues.append("No Mocks must be 'yes' or 'true'")
    failure_cases = parse_field(content, "Failure Cases:")
    if not failure_cases:
        issues.append("Failure Cases must be documented")
    edge_cases = parse_field(content, "Edge Cases:")
    if not edge_cases:
        issues.append("Edge Cases must be documented")
    dev_run = parse_field(content, "Dev Run:")
    if not dev_run:
        issues.append("Dev Run must be documented")
    deploy_run = parse_field(content, "Deployment Run:")
    if not deploy_run:
        issues.append("Deployment Run must be documented")
    if issues:
        return False, issues
    return True, []


def check_naming_canon(prd_path):
    content = read_text(prd_path)
    missing = []
    for field in ("Feature:", "Codename:", "Owner:"):
        if field not in content:
            missing.append(field)
    if missing:
        return False, ["PRD naming missing fields: {}".format(", ".join(missing))]

    owner_value = ""
    for line in content.splitlines():
        if "Owner:" in line:
            owner_value = line.split("Owner:", 1)[1].strip()
            break
    owner_value = owner_value.split("|", 1)[0].strip()
    if not owner_value:
        return False, ["PRD naming missing Owner value"]

    canonical = {
        "Suge",
        "Keisha",
        "Ox",
        "Soulja Slim",
        "DMX",
        "Igor",
        "Master P",
    }
    alias_map = {
        "@suge": "Suge",
        "@keisha": "Keisha",
        "@ox": "Ox",
        "@soulja": "Soulja Slim",
        "@tester": "Soulja Slim",
        "@dmx": "DMX",
        "@reviewer": "DMX",
        "@igor": "Igor",
        "Soulja": "Soulja Slim",
        "MasterP": "Master P",
    }
    normalized = alias_map.get(owner_value, owner_value)
    if normalized not in canonical:
        return False, ["Owner not canonical: {}".format(owner_value)]

    return True, []


def check_prd_requirements(prd_path):
    content = read_text(prd_path)
    missing = []
    if "## User Stories" not in content:
        missing.append("## User Stories section")
    if not re.search(r\"\\bUS-\\d+\\b\", content):
        missing.append(\"User story IDs (US-#)\")
    if "Tech Debt Budget:" not in content:
        missing.append("Tech Debt Budget:")
    if "Bloat Budget:" not in content:
        missing.append("Bloat Budget:")
    if missing:
        return False, ["PRD missing: {}".format(", ".join(missing))]
    return True, []


def build_report(voice, status, lines, next_steps):
    name = voice["name"]
    output = []
    output.append("{} GUARDRAIL REPORT".format(name))
    output.append("STATUS: {}".format(status))
    output.extend(lines)
    if next_steps:
        output.append("NEXT:")
        output.extend(["- {}".format(step) for step in next_steps])
    output.append(voice["pass"] if status == "PASS" else voice["fail"])
    return "\n".join(output)


def parse_args(argv):
    parser = argparse.ArgumentParser(
        description="Guardrails for PRD, TDD evidence, and stack-aware testing."
    )
    parser.add_argument("--voice", default="dmx", choices=sorted(VOICE_LINES.keys()))
    parser.add_argument("--feature", help="Feature slug (matches prd-<slug>.md)")
    parser.add_argument("--tasks-dir", default="tasks", help="Tasks directory path")
    parser.add_argument("--stack", help="Override detected stack name")
    parser.add_argument("--test-cmd", help="Override default test command")
    parser.add_argument(
        "--stage",
        default="post",
        choices=["preflight", "post"],
        help="Validation stage: preflight or post-implementation",
    )
    return parser.parse_args(argv)


def main(argv):
    args = parse_args(argv)
    voice = VOICE_LINES[args.voice]
    root = find_repo_root(os.getcwd())
    tasks_dir = resolve_tasks_dir(root, args.tasks_dir)

    findings = []
    next_steps = []
    blocked = False

    stacks = detect_stacks(root)
    stack_override = args.stack
    stack = None
    stack_note = ""
    if stack_override:
        stack = stack_override
        stack_note = "STACK: {} (override)".format(stack)
    elif len(stacks) == 1:
        stack = stacks[0][0]
        stack_note = "STACK: {} (detected via {})".format(stack, ", ".join(stacks[0][1]))
    elif len(stacks) == 0:
        blocked = True
        findings.append("STACK: none detected")
        next_steps.append("Declare stack or pass --stack and --test-cmd")
    else:
        blocked = True
        stack_list = ["{}({})".format(name, ", ".join(hits)) for name, hits in stacks]
        findings.append("STACK: ambiguous ({})".format("; ".join(stack_list)))
        next_steps.append("Declare stack or pass --stack and --test-cmd")

    if stack_note:
        findings.append(stack_note)

    prd_path = None
    feature = args.feature
    if not tasks_dir.exists():
        blocked = True
        findings.append("TASKS DIR: missing ({})".format(tasks_dir))
        next_steps.append("Create tasks directory or pass --tasks-dir")
    else:
        if not feature:
            prd_path = find_latest_prd(tasks_dir)
            if prd_path:
                feature = slug_from_prd(prd_path)
        if not feature:
            blocked = True
            findings.append("PRD: missing (prd-<feature>.md)")
            next_steps.append("Add PRD or pass --feature")

    if feature:
        if not prd_path:
            prd_path = tasks_dir / "prd-{}.md".format(feature)
        tasks_path = tasks_dir / "tasks-{}.md".format(feature)
        tdd_path = tasks_dir / "tdd-{}.md".format(feature)

        if not prd_path.exists():
            blocked = True
            findings.append("PRD: missing ({})".format(prd_path))
            next_steps.append("Create PRD before implementation")
        else:
            findings.append("PRD: OK ({})".format(prd_path))
            ok_naming, naming_notes = check_naming_canon(prd_path)
            if not ok_naming:
                blocked = True
                findings.extend(naming_notes)
                next_steps.append("Add Feature/Codename/Owner to PRD")
            else:
                findings.append("NAMING: OK (Feature/Codename/Owner)")
            ok_prd, prd_notes = check_prd_requirements(prd_path)
            if not ok_prd:
                blocked = True
                findings.extend(prd_notes)
                next_steps.append("Add user stories (US-#) and debt/bloat budgets to PRD")
            else:
                findings.append("PRD REQUIREMENTS: OK (User Stories + Budgets)")

        if not tasks_path.exists():
            blocked = True
            findings.append("TASKLIST: missing ({})".format(tasks_path))
            next_steps.append("Create task list before implementation")
        else:
            findings.append("TASKLIST: OK ({})".format(tasks_path))

        ok_tdd, tdd_notes = check_tdd_evidence(tdd_path, args.stage)
        if not ok_tdd:
            blocked = True
            findings.extend(tdd_notes)
            next_steps.append("Create TDD evidence in {}".format(tdd_path))
        else:
            findings.append("TDD: OK ({})".format(tdd_path))

    if stack:
        test_cmd = args.test_cmd or DEFAULT_TEST_COMMANDS.get(stack)
        if not test_cmd:
            blocked = True
            findings.append("TEST CMD: missing for stack {}".format(stack))
            next_steps.append("Provide --test-cmd for this stack")
        else:
            findings.append("TEST CMD: {}".format(test_cmd))

        if args.stage == "post":
            test_files = collect_test_files(root, stack)
            if not test_files:
                blocked = True
                findings.append("TEST FILES: none detected for stack {}".format(stack))
                next_steps.append("Add tests before implementation")
            else:
                findings.append("TEST FILES: found ({})".format(len(test_files)))
                findings.append("TEST SAMPLE: {}".format(test_files[0]))
                mock_hits = scan_for_mocks(test_files)
                if mock_hits:
                    blocked = True
                    findings.append("MOCKS: detected in {}".format(mock_hits[0]))
                    next_steps.append("Remove mocks; use real dev environment dependencies")

    status = "BLOCKED" if blocked else "PASS"
    report = build_report(voice, status, findings, next_steps)
    print(report)
    return 1 if blocked else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
