#!/usr/bin/env python3
import subprocess
import argparse
import sys

def run_git_cmd(args):
    """Run a git command and return output."""
    try:
        # Check if inside a git repo
        subprocess.run(["git", "rev-parse", "--is-inside-work-tree"], 
                     check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    except subprocess.CalledProcessError:
        return "Error: Not a git repository."
    except FileNotFoundError:
        return "Error: git executable not found."

    try:
        cmd = ["git"] + args
        result = subprocess.run(cmd, capture_output=True, text=True, check=True)
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        return f"Git Error: {e.stderr.strip()}"

def main():
    parser = argparse.ArgumentParser(description="Git Pulse: Zero-Dependency Git Intelligence")
    subparsers = parser.add_subparsers(dest="command")

    # Status
    subparsers.add_parser("status", help="Show short status")
    
    # Log
    log = subparsers.add_parser("log", help="Show recent commit log")
    log.add_argument("-n", "--limit", type=str, default="10", help="Number of commits")
    
    # Diff
    diff = subparsers.add_parser("diff", help="Show changes (staged or unstaged)")
    diff.add_argument("--staged", action="store_true", help="Show staged changes")
    
    # Branch info
    subparsers.add_parser("branch", help="Show current branch info")

    args = parser.parse_args()

    if args.command == "status":
        print(run_git_cmd(["status", "-s"]))
    elif args.command == "log":
        print(run_git_cmd(["log", "--oneline", "-n", args.limit]))
    elif args.command == "diff":
        base = ["diff"]
        if args.staged:
            base.append("--staged")
        # Limit diff size to avoid context handling overload
        output = run_git_cmd(base)
        if len(output) > 10000:
             print(output[:10000] + "\n... (truncated diff)")
        else:
             print(output)
    elif args.command == "branch":
        branch = run_git_cmd(["branch", "--show-current"])
        upstream = run_git_cmd(["rev-parse", "--abbrev-ref", "--symbolic-full-name", "@{u}"])
        print(f"Current Branch: {branch}")
        if "Git Error" not in upstream:
            print(f"Upstream: {upstream}")
    else:
        parser.print_help()

if __name__ == "__main__":
    main()
