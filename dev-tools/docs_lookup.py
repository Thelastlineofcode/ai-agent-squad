#!/usr/bin/env python3
import argparse
import webbrowser
import sys

# Mapping of common tools to their documentation URLs
# This simulates "docfork" instant access without an external index
DOCS_MAP = {
    "rust": "https://doc.rust-lang.org/std/",
    "python": "https://docs.python.org/3/",
    "react": "https://react.dev/reference/react",
    "nextjs": "https://nextjs.org/docs",
    "leptos": "https://leptos.dev/docs",
    "axum": "https://docs.rs/axum/latest/axum/",
    "tokio": "https://docs.rs/tokio/latest/tokio/",
    "sqlx": "https://docs.rs/sqlx/latest/sqlx/",
    "tailwindcss": "https://tailwindcss.com/docs",
    "git": "https://git-scm.com/doc",
    "docker": "https://docs.docker.com/",
    "kubernetes": "https://kubernetes.io/docs/home/",
    "stripe": "https://docs.stripe.com/",
    "supabase": "https://supabase.com/docs",
    "gcp": "https://cloud.google.com/docs",
    "aws": "https://docs.aws.amazon.com/",
    "typescript": "https://www.typescriptlang.org/docs/",
    "node": "https://nodejs.org/docs/latest/api/",
    "wgpu": "https://docs.rs/wgpu/latest/wgpu/",
    "bevy": "https://bevyengine.org/learn/",
    "pandas": "https://pandas.pydata.org/docs/",
    "numpy": "https://numpy.org/doc/stable/",
    "scipy": "https://docs.scipy.org/doc/scipy/",
    "matplotlib": "https://matplotlib.org/stable/contents.html",
    "pytorch": "https://pytorch.org/docs/stable/index.html",
    "tensorflow": "https://www.tensorflow.org/api_docs",
    "openai": "https://platform.openai.com/docs/introduction",
    "anthropic": "https://docs.anthropic.com/claude/docs",
    "huggingface": "https://huggingface.co/docs"
}

def get_url(query):
    query = query.lower().strip()
    if query in DOCS_MAP:
        return DOCS_MAP[query]
    
    # Partial match fallback
    for key, url in DOCS_MAP.items():
        if query in key:
            return url
            
    return None

def main():
    parser = argparse.ArgumentParser(description="Docs Lookup: Instant Documentation Links")
    parser.add_argument("query", help="Library/Framework name to find docs for")
    
    args = parser.parse_args()
    
    url = get_url(args.query)
    if url:
        print(f"Documentation for '{args.query}': {url}")
        print(f"Use web_fetch.py to read content: ./web_fetch.py {url}")
    else:
        print(f"No direct documentation found for '{args.query}'.")
        print("Try simpler keywords or use web_fetch.py with a specific URL.")

if __name__ == "__main__":
    main()
