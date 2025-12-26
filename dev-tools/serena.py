#!/usr/bin/env python3
import os
import sys
import argparse
import fnmatch
import subprocess

def find_files(root_dir, pattern, type_filter=None):
    """
    Find files matching a glob pattern, optionally filtered by type (f=file, d=directory).
    """
    matches = []
    for root, dirs, files in os.walk(root_dir):
        # Exclude common ignore dirs
        if '.git' in dirs:
            dirs.remove('.git')
        if 'node_modules' in dirs:
            dirs.remove('node_modules')
        if 'target' in dirs:
            dirs.remove('target')
            
        search_list = []
        if type_filter == 'f' or type_filter is None:
            search_list.extend(files)
        if type_filter == 'd' or type_filter is None:
            search_list.extend(dirs)
            
        for name in search_list:
            if fnmatch.fnmatch(name, pattern):
                matches.append(os.path.join(root, name))
                
    return matches

def grep_files(root_dir, query, file_pattern="*"):
    """
    Search for text content within files matching a pattern.
    """
    # Use grep for speed if available
    cmd = ["grep", "-r", "--line-number", query, root_dir]
    if file_pattern != "*":
         cmd.extend(["--include", file_pattern])
         
    # Exclude dirs
    cmd.extend(["--exclude-dir=.git", "--exclude-dir=node_modules", "--exclude-dir=target"])
    
    try:
        result = subprocess.run(cmd, capture_output=True, text=True)
        return result.stdout.splitlines()
    except Exception as e:
        return [f"Error executing grep: {e}"]

def main():
    parser = argparse.ArgumentParser(description="Serena: High-Fidelity File Finder & Context Mapper")
    subparsers = parser.add_subparsers(dest="command")
    
    # Find command
    find_parser = subparsers.add_parser("find", help="Find files by name pattern")
    find_parser.add_argument("pattern", help="Glob pattern to search for (e.g. *.rs)")
    find_parser.add_argument("--root", default=".", help="Root directory to search")
    find_parser.add_argument("--type", choices=['f', 'd'], help="Filter by type (f=file, d=directory)")
    
    # Grep command
    grep_parser = subparsers.add_parser("grep", help="Search for content in files")
    grep_parser.add_argument("query", help="Text to search for")
    grep_parser.add_argument("--root", default=".", help="Root directory to search")
    grep_parser.add_argument("--pattern", default="*", help="File pattern to include")

    args = parser.parse_args()
    
    if args.command == "find":
        results = find_files(args.root, args.pattern, args.type)
        for r in results:
            print(r)
            
    elif args.command == "grep":
        results = grep_files(args.root, args.query, args.pattern)
        for r in results:
            print(r)
    else:
        parser.print_help()

if __name__ == "__main__":
    main()
