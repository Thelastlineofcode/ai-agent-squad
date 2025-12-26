#!/usr/bin/env python3
import os
import argparse
import fnmatch

def parse_gitignore(root):
    """Simple gitignore parsing. Returns a list of patterns."""
    patterns = []
    ignore_path = os.path.join(root, ".gitignore")
    if os.path.exists(ignore_path):
        with open(ignore_path, "r") as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith("#"):
                    patterns.append(line)
    
    # Add default ignores
    patterns.extend([".git", "node_modules", "target", ".DS_Store", "__pycache__", "dist", "build"])
    return patterns

def is_ignored(name, patterns):
    for pattern in patterns:
        if fnmatch.fnmatch(name, pattern):
            return True
        # Handle simple directory matches (e.g., "dist/")
        if pattern.endswith("/") and name + "/" == pattern:
            return True
    return False

def print_tree(startpath, patterns, prefix=""):
    """Recursive tree printer."""
    try:
        # Get list and filter
        contents = os.listdir(startpath)
        contents = [c for c in contents if not is_ignored(c, patterns)]
        contents.sort()
    except PermissionError:
        return

    pointers = [("├── ", "│   ")] * (len(contents) - 1) + [("└── ", "    ")]
    
    for pointer, content in zip(pointers, contents):
        path = os.path.join(startpath, content)
        print(prefix + pointer[0] + content)
        
        if os.path.isdir(path):
            extension = pointer[1]
            print_tree(path, patterns, prefix + extension)

def main():
    parser = argparse.ArgumentParser(description="Project Tree: Context Visualizer")
    parser.add_argument("root", nargs="?", default=".", help="Root directory")
    args = parser.parse_args()
    
    root = os.path.abspath(args.root)
    patterns = parse_gitignore(root)
    
    print(os.path.basename(root) + "/")
    print_tree(root, patterns)

if __name__ == "__main__":
    main()
