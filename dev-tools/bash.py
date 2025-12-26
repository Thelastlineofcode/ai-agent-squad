#!/usr/bin/env python3
import subprocess
import argparse
import sys
import os

def run_bash(command, timeout=30):
    """Run a bash command with timeout."""
    try:
        result = subprocess.run(
            command, 
            shell=True, 
            capture_output=True, 
            text=True, 
            timeout=timeout,
            executable="/bin/bash" 
        )
        output = result.stdout
        if result.stderr:
            output += "\nSTDERR:\n" + result.stderr
        return output.strip()
    except subprocess.TimeoutExpired:
        return "Error: Command timed out."
    except Exception as e:
        return f"Error executing command: {e}"

def main():
    parser = argparse.ArgumentParser(description="Bash Command Executor")
    parser.add_argument("command", help="Bash command to execute")
    parser.add_argument("--timeout", type=int, default=30, help="Timeout in seconds")
    
    args = parser.parse_args()
    
    # Basic safety check (very distinct from a real sandbox, but prevents accidental rm -rf /)
    forbidden = ["rm -rf /", ":(){ :|:& };:"]
    if any(bad in args.command for bad in forbidden):
        print("Error: Forbidden command detected.")
        sys.exit(1)
        
    print(run_bash(args.command, args.timeout))

if __name__ == "__main__":
    main()
