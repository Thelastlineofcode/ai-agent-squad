#!/usr/bin/env python3
import argparse
import os
import sys

def read_file(path):
    try:
        with open(path, 'r', encoding='utf-8') as f:
            return f.read()
    except FileNotFoundError:
        return f"Error: File {path} not found."
    except Exception as e:
        return f"Error reading {path}: {e}"

def create_file(path, content):
    try:
        with open(path, 'w', encoding='utf-8') as f:
            f.write(content)
        return f"File {path} created successfully."
    except Exception as e:
        return f"Error creating {path}: {e}"

def str_replace(path, old, new):
    content = read_file(path)
    if content.startswith("Error"):
        return content
    
    if old not in content:
        return f"Error: '{old}' not found in {path}."
        
    new_content = content.replace(old, new)
    try:
        with open(path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        return f"Successfully replaced content in {path}."
    except Exception as e:
        return f"Error writing to {path}: {e}"

def insert_line(path, line_num, content):
    content_str = read_file(path)
    if content_str.startswith("Error"):
        return content_str
        
    lines = content_str.splitlines()
    if line_num < 0 or line_num > len(lines):
         return f"Error: Line number {line_num} out of range."
         
    lines.insert(line_num, content)
    new_content = "\n".join(lines)
    
    try:
        with open(path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        return f"Successfully inserted at line {line_num} in {path}."
    except Exception as e:
        return f"Error writing {path}: {e}"

def main():
    parser = argparse.ArgumentParser(description="Anthropic-Style Text Editor")
    subparsers = parser.add_subparsers(dest="command")
    
    # View
    view = subparsers.add_parser("view", help="View file contents")
    view.add_argument("path", help="File path")
    
    # Create
    create = subparsers.add_parser("create", help="Create new file")
    create.add_argument("path", help="File path")
    create.add_argument("content", help="File content")
    
    # Replace
    replace = subparsers.add_parser("str_replace", help="Replace string")
    replace.add_argument("path", help="File path")
    replace.add_argument("old", help="Old string")
    replace.add_argument("new", help="New string")
    
    # Insert
    insert = subparsers.add_parser("insert", help="Insert line")
    insert.add_argument("path", help="File path")
    insert.add_argument("line", type=int, help="Line number (0-indexed)")
    insert.add_argument("content", help="Content to insert")
    
    args = parser.parse_args()
    
    if args.command == "view":
        print(read_file(args.path))
    elif args.command == "create":
        print(create_file(args.path, args.content))
    elif args.command == "str_replace":
        print(str_replace(args.path, args.old, args.new))
    elif args.command == "insert":
        print(insert_line(args.path, args.line, args.content))
    else:
        parser.print_help()

if __name__ == "__main__":
    main()
