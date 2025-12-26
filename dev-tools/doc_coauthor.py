#!/usr/bin/env python3
import argparse
import os
import sys
from datetime import datetime

def read_file(path):
    try:
        with open(path, 'r', encoding='utf-8') as f:
            return f.read()
    except FileNotFoundError:
        return None

def append_section(path, title, content):
    """Append a new markdown section to the end of the file."""
    current = read_file(path)
    if current is None:
        # Create new file
        timestamp = datetime.now().strftime("%Y-%m-%d")
        new_content = f"# {title}\n\n> Created: {timestamp}\n\n{content}\n"
        mode = 'w'
    else:
        # Append
        prefix = "\n" if current.endswith("\n") else "\n\n"
        new_content = f"{prefix}## {title}\n\n{content}\n"
        mode = 'a'
        
    with open(path, mode, encoding='utf-8') as f:
        f.write(new_content)
    return True

def insert_after_marker(path, marker, content):
    """Insert content after a specific marker line."""
    current = read_file(path)
    if current is None:
        return False
        
    lines = current.splitlines()
    new_lines = []
    inserted = False
    
    for line in lines:
        new_lines.append(line)
        if marker in line and not inserted:
            new_lines.append("")
            new_lines.extend(content.splitlines())
            new_lines.append("")
            inserted = True
            
    if not inserted:
        return False
        
    with open(path, 'w', encoding='utf-8') as f:
        f.write("\n".join(new_lines) + "\n")
    return True

def main():
    parser = argparse.ArgumentParser(description="Doc Co-Author: Smart Documentation Editor")
    subparsers = parser.add_subparsers(dest="command")
    
    # Append command
    append_parser = subparsers.add_parser("append", help="Append a section")
    append_parser.add_argument("file", help="Target file path")
    append_parser.add_argument("title", help="Section title")
    append_parser.add_argument("content", help="Content to append")
    
    # Insert command
    insert_parser = subparsers.add_parser("insert", help="Insert after marker")
    insert_parser.add_argument("file", help="Target file path")
    insert_parser.add_argument("marker", help="Marker text to find")
    insert_parser.add_argument("content", help="Content to insert")

    args = parser.parse_args()
    
    if args.command == "append":
        if append_section(args.file, args.title, args.content):
            print(f"Successfully appended section '{args.title}' to {args.file}")
        else:
            print(f"Error appending to {args.file}")
            
    elif args.command == "insert":
        if insert_after_marker(args.file, args.marker, args.content):
            print(f"Successfully inserted content after marker '{args.marker}' in {args.file}")
        else:
            print(f"Marker '{args.marker}' not found in {args.file}")
    else:
        parser.print_help()

if __name__ == "__main__":
    main()
