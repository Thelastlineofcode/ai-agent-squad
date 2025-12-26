#!/usr/bin/env python3
import urllib.request
import urllib.error
import argparse
import sys
import re

def strip_html_tags(text):
    """
    Remove HTML tags using regex to avoid bs4 dependency.
    This is less robust than a parser but sufficient for basic text extraction.
    """
    # Remove script and style elements content
    clean = re.sub(r'<(script|style).*?>.*?</\1>', '', text, flags=re.DOTALL)
    # Remove tags
    clean = re.sub(r'<.*?>', '', clean)
    # Decode HTML entities (basic ones)
    clean = clean.replace('&nbsp;', ' ').replace('&lt;', '<').replace('&gt;', '>').replace('&amp;', '&')
    
    # Clean up whitespace
    lines = (line.strip() for line in clean.splitlines())
    chunks = (phrase.strip() for line in lines for phrase in line.split("  "))
    text = '\n'.join(chunk for chunk in chunks if chunk)
    return text

def fetch_url(url, extract_text=True):
    try:
        headers = {
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36'
        }
        req = urllib.request.Request(url, headers=headers)
        
        with urllib.request.urlopen(req, timeout=10) as response:
            encoding = response.headers.get_content_charset('utf-8')
            html = response.read().decode(encoding)
            
            if extract_text:
                return strip_html_tags(html)
            else:
                return html
            
    except urllib.error.URLError as e:
        return f"Error fetching URL: {e.reason}"
    except Exception as e:
        return f"Error: {e}"

def main():
    parser = argparse.ArgumentParser(description="Web Fetch Tool (Zero Dependency)")
    parser.add_argument("url", help="URL to fetch")
    parser.add_argument("--raw", action="store_true", help="Return raw HTML instead of extracted text")
    
    args = parser.parse_args()
    
    result = fetch_url(args.url, not args.raw)
    try:
        print(result)
    except UnicodeEncodeError:
        # Handle systems with poor default encoding
        print(result.encode('utf-8').decode('utf-8', 'ignore'))

if __name__ == "__main__":
    main()
