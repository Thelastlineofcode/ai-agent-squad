# KEISHA'S MCP TOOLS & SKILLS ARSENAL
## Expert-Level Code Analysis, Metrics, and Intelligence Tools

---

## OVERVIEW: Keisha's Toolbox

Keisha is only as good as her tools. She needs:

1. **Code Reading** (understand structure + syntax)
2. **Metrics Gathering** (complexity, coverage, coupling)
3. **Dependency Analysis** (what breaks if we change X?)
4. **Git Intelligence** (churn, blame, history patterns)
5. **Pattern Detection** (code smells, anti-patterns, security issues)
6. **Architecture Mapping** (relationships between modules)

Below is a **production-ready MCP tool stack** for Keisha, organized by capability.

---

## TIER 1: CORE ANALYSIS TOOLS (Essential)

### 1. Semgrep MCP Server
**What it does**: Static code analysis with semantic understanding (not just regex)  
**Why Keisha needs it**: Detects patterns, anti-patterns, code smells, security issues, architectural violations  
**For your stack**: Supports Rust, TypeScript, Python, Go, Java, and 30+ languages

**MCP Configuration**:
```json
{
  "mcpServers": {
    "semgrep": {
      "command": "semgrep",
      "args": ["--config=p/owasp-top-ten", "--json"],
      "env": {
        "SEMGREP_RULES": "p/security-audit,p/code-quality,p/best-practices"
      }
    }
  }
}
```

**Keisha uses Semgrep for**:
- Detecting unused functions (surface area bloat)
- Finding code duplicates (violation of DRY)
- Security vulnerabilities (OWASP, CWE)
- Anti-patterns (tight coupling, God objects, etc.)
- Language-specific idiom violations

**Example query**:
```bash
semgrep --config=p/code-quality --json src/
# Returns: violations ranked by severity + fix suggestions
```

---

### 2. Code Analysis MCP Server (TreeSitter + PostgreSQL + pgvector)
**What it does**: Semantic code parsing + embeddings for intelligent search + dependency graphs  
**Why Keisha needs it**: Understands codebase structure at scale; answers "where is X used?"

**Install**:
```bash
git clone https://github.com/johannhartmann/code-analysis-mcp.git
cd code-analysis-mcp
pip install -r requirements.txt
python -m code_analysis_mcp.server
```

**MCP Configuration**:
```json
{
  "mcpServers": {
    "code-analysis": {
      "command": "python",
      "args": ["-m", "code_analysis_mcp.server"],
      "env": {
        "DATABASE_URL": "postgresql://user:password@localhost/keisha_codebase",
        "REPOSITORY_PATH": "/path/to/your-project"
      }
    }
  }
}
```

**Keisha uses Code Analysis for**:
- Function call graph (who calls whom?)
- Import dependency mapping (coupling detection)
- Dead code identification (unused functions, unreachable code)
- Module cohesion analysis (do these functions belong together?)
- Complexity calculation (nested depth, branch count)
- Semantic search ("find all functions that work with Database")

**Example**:
```
Keisha: "Show me all functions that call Database queries directly"
Code Analysis: Returns list + locations + test coverage for each
```

---

### 3. Rust-Specific: Clippy (via MCP wrapper)
**What it does**: Lint warnings + suggestions for Rust idioms  
**Why Keisha needs it**: Project A/Project B are Rust; Clippy catches anti-patterns, inefficiencies, safety issues

**MCP Wrapper**:
```rust
// In your MCP server (e.g., using mcp-server-rust crate)
#[derive(Clone)]
pub struct ClippyTool;

impl Tool for ClippyTool {
    fn name(&self) -> &str {
        "run_clippy"
    }

    fn description(&self) -> &str {
        "Run Clippy linter on Rust codebase; returns warnings ranked by severity"
    }

    async fn execute(&self, args: HashMap<String, String>) -> Result<String> {
        let repo_path = args.get("repo_path").ok_or("Missing repo_path")?;
        
        let output = Command::new("cargo")
            .args(&["clippy", "--all-targets", "--message-format=json"])
            .current_dir(repo_path)
            .output()?;

        Ok(String::from_utf8(output.stdout)?)
    }
}
```

**Keisha uses Clippy for**:
- Detecting inefficient patterns (unnecessary clones, inefficient collections)
- Naming convention violations
- Complexity warnings (functions too long, too many parameters)
- Trait/lifetime issues (ownership design problems)
- Performance suggestions

---

### 4. TypeScript-Specific: ESLint + TypeScript Compiler MCP
**What it does**: Linting + type checking for TypeScript/JavaScript  
**Why Keisha needs it**: For Project B UI, Project C frontend, any TS/JS code

**MCP Configuration**:
```json
{
  "mcpServers": {
    "eslint-mcp": {
      "command": "eslint",
      "args": ["--format=json", "--no-eslintrc"],
      "env": {
        "ESLINT_CONFIG": "/path/to/.eslintrc.json"
      }
    }
  }
}
```

**Keisha uses ESLint + TSC for**:
- Type errors and implicit `any`
- Unused variables and imports
- Complexity violations (cyclomatic complexity, cognitive complexity)
- Best practice violations
- Async/await correctness

---

## TIER 2: METRICS TOOLS (High Value)

### 5. Test Coverage MCP (tarpaulin for Rust, c8 for TypeScript)

**For Rust** (tarpaulin):
```json
{
  "mcpServers": {
    "coverage-rust": {
      "command": "cargo",
      "args": ["tarpaulin", "--json", "--timeout=300"],
      "env": {
        "RUST_BACKTRACE": "1"
      }
    }
  }
}
```

**For TypeScript** (c8):
```json
{
  "mcpServers": {
    "coverage-ts": {
      "command": "c8",
      "args": ["--reporter=json", "npm", "test"]
    }
  }
}
```

**Keisha uses Coverage for**:
- Overall coverage % (target: > 85%)
- Coverage by module (which areas are under-tested?)
- Untested hot-spots (critical paths with low coverage = risk)
- Coverage trends over time (improving or degrading?)

**Example output**:
```json
{
  "overall": {
    "lines": { "pct": 72, "total": 1500, "covered": 1080 },
    "statements": { "pct": 72, "total": 1500, "covered": 1080 },
    "functions": { "pct": 68, "total": 120, "covered": 82 },
    "branches": { "pct": 62, "total": 450, "covered": 279 }
  },
  "by_file": [
    {
      "file": "src/comparison/aspect_calculator.rs",
      "coverage": 62,
      "is_critical": true,
      "status": "RED"
    }
  ]
}
```

---

### 6. Complexity Analysis MCP (Radon for Python, Rust-Analyzer for Rust)

**For Rust**:
```json
{
  "mcpServers": {
    "complexity-rust": {
      "command": "rust-analyzer",
      "args": ["--config", "{}"],
      "env": {
        "RA_LOG": "error"
      }
    }
  }
}
```

**For TypeScript/JavaScript**:
```bash
# Install npm package
npm install --save-dev eslint-plugin-complexity

# Add to .eslintrc.json
{
  "plugins": ["complexity"],
  "rules": {
    "complexity/complexity": ["warn", 8]
  }
}
```

**Keisha uses Complexity Analysis for**:
- Cyclomatic complexity per function (target: < 12)
- Cognitive complexity (hard-to-understand logic)
- Nesting depth violations (max 3 levels)
- Function length (target: < 30 lines)
- Parameter count (max 5-7 for maintainability)

---

### 7. Dependency Analysis MCP (cargo-tree for Rust, npm ls for TypeScript)

**For Rust**:
```json
{
  "mcpServers": {
    "deps-rust": {
      "command": "cargo",
      "args": ["tree", "--depth", "3", "--json"]
    }
  }
}
```

**For TypeScript**:
```bash
# Install for better analysis
npm install --save-dev depcheck dependency-cruiser

# Dependency Cruiser MCP wrapper
{
  "mcpServers": {
    "deps-ts": {
      "command": "depcruise",
      "args": ["--outputType=json", "src/"]
    }
  }
}
```

**Keisha uses Dependency Analysis for**:
- Identifying unused dependencies (bloat)
- Detecting circular dependencies (architectural smell)
- Calculating coupling index (how tightly coupled are modules?)
- Transitive dependency analysis (what's being dragged in?)
- Security scanning (outdated or vulnerable deps)

**Example output**:
```json
{
  "coupling_analysis": {
    "CoreCalculator": {
      "internal_deps": 3,
      "external_deps": 5,
      "coupling_index": 0.52,
      "status": "HIGH"
    }
  },
  "circular_deps": [
    {
      "path": ["ModuleA", "ModuleB", "ModuleA"],
      "risk": "HIGH",
      "fix": "Extract common functionality"
    }
  ]
}
```

---

## TIER 3: GIT INTELLIGENCE TOOLS (Pattern Detection)

### 8. Git History & Churn Analysis MCP

**Build a custom MCP wrapper** (Python):
```python
import json
import subprocess
from datetime import datetime

class GitAnalysisMCP:
    def get_file_churn(self, repo_path, file_path, weeks=4):
        """How often is this file changing? (indicator of instability)"""
        cmd = f"git -C {repo_path} log --oneline --since={weeks}w -- {file_path} | wc -l"
        churn = int(subprocess.getoutput(cmd))
        return {
            "file": file_path,
            "churn_count": churn,
            "weeks": weeks,
            "churn_per_week": churn / weeks,
            "stability": "HIGH" if churn < 2 else "MEDIUM" if churn < 5 else "LOW"
        }

    def get_hot_spots(self, repo_path, weeks=4):
        """Which files change most frequently? (coupling + instability = risk)"""
        cmd = f"git -C {repo_path} log --name-only --pretty=format: --since={weeks}w | sort | uniq -c | sort -rn | head -20"
        result = subprocess.getoutput(cmd)
        
        hot_spots = []
        for line in result.split('\n'):
            if line.strip():
                parts = line.split()
                count = int(parts[0])
                file = ' '.join(parts[1:])
                hot_spots.append({
                    "file": file,
                    "change_frequency": count,
                    "risk": "HIGH" if count > 10 else "MEDIUM" if count > 5 else "LOW"
                })
        
        return hot_spots

    def get_blame_statistics(self, repo_path, file_path):
        """Who touched this file and when? (age + developer churn indicator)"""
        cmd = f"git -C {repo_path} blame {file_path} --line-porcelain | grep '^author ' | sort | uniq -c | sort -rn"
        authors = subprocess.getoutput(cmd)
        
        return {
            "file": file_path,
            "author_diversity": len(authors.split('\n')),
            "primary_author": authors.split('\n')[0] if authors else None,
            "notes": "High author diversity = knowledge distributed; Low = bus factor risk"
        }
```

**MCP Registration**:
```json
{
  "mcpServers": {
    "git-analysis": {
      "command": "python",
      "args": ["git_analysis_mcp.py"],
      "env": {
        "REPO_PATH": "/path/to/your-project"
      }
    }
  }
}
```

**Keisha uses Git Analysis for**:
- **Churn detection**: Which files change most? (instability indicator)
- **Hot-spot identification**: Where do bugs cluster? (complexity + frequency = risk)
- **Bus factor analysis**: If one person leaves, does the project stall?
- **Age of code**: Is this a "legacy" module that needs refactoring?
- **Collaboration patterns**: Do teams work together or in silos?

**Example**:
```
Keisha: "What are the hot-spots in Project A?"
Git Analysis: [
  { "file": "src/comparison/aspect_calculator.rs", "churn": 24, "authors": 3, "risk": "HIGH" },
  { "file": "src/transit_engine.rs", "churn": 19, "authors": 2, "risk": "HIGH" },
  { "file": "src/lib.rs", "churn": 8, "authors": 4, "risk": "MEDIUM" }
]

Keisha: "CoreCalculator is changing frequently AND has poor test coverage. 
That's a safety risk. Refactor + test it first."
```

---

### 9. Defect Correlation Analysis
**What it does**: Correlates code changes with bug reports  
**Why Keisha needs it**: Identifies which areas breed bugs (technical debt validation)

```python
class DefectCorrelationMCP:
    def correlate_changes_to_issues(self, repo_path, issue_tracker_data, weeks=12):
        """
        Correlate git commits touching file X with bugs filed in file X.
        High correlation = area needs refactoring + testing.
        """
        hot_spots = self.get_hot_spots(repo_path, weeks)
        issues_by_file = self.parse_issue_tracker(issue_tracker_data)
        
        correlation = []
        for file_changes in hot_spots:
            file = file_changes['file']
            changes = file_changes['change_frequency']
            issues = len(issues_by_file.get(file, []))
            
            bug_density = issues / changes if changes > 0 else 0
            
            correlation.append({
                "file": file,
                "changes": changes,
                "bugs": issues,
                "bug_density": bug_density,
                "risk": "CRITICAL" if bug_density > 0.3 else "HIGH" if bug_density > 0.1 else "MEDIUM"
            })
        
        return sorted(correlation, key=lambda x: x['risk'] == "CRITICAL", reverse=True)
```

**Keisha uses Defect Correlation for**:
- Validating tech debt claims ("this area really does have problems")
- Prioritizing refactoring ("fix the areas that bleed bugs first")
- Predicting defect risk for new features

---

## TIER 4: ARCHITECTURE & RELATIONSHIP TOOLS

### 10. Database Query Tool (For the organization / Domain Data Model Analysis)

**Custom MCP for Database**:
```python
from database import GraphDatabase

class DatabaseAnalysisMCP:
    def __init__(self, uri, auth):
        self.driver = GraphDatabase.driver(uri, auth=auth)
    
    def analyze_data_model_coupling(self):
        """Analyze how tightly code is coupled to database model"""
        with self.driver.session() as session:
            result = session.run("""
                MATCH (n:Node)
                RETURN 
                  labels(n) as node_type,
                  n.name as name,
                  size((n)-[]-()) as relationship_count,
                  n.last_modified as last_modified
                ORDER BY relationship_count DESC
                LIMIT 50
            """)
            
            return [dict(record) for record in result]
    
    def find_domain_data_dependencies(self):
        """What data does comparison depend on?"""
        with self.driver.session() as session:
            result = session.run("""
                MATCH (comparison:Comparison)-[dep]->(data)
                RETURN 
                  type(dep) as relationship_type,
                  labels(data) as data_type,
                  COUNT(*) as usage_count
                ORDER BY usage_count DESC
            """)
            
            return [dict(record) for record in result]
```

**MCP Registration**:
```json
{
  "mcpServers": {
    "database-analysis": {
      "command": "python",
      "args": ["database_mcp.py"],
      "env": {
        "DATABASE_URI": "<DB_URI>",
        "DATABASE_USER": "database",
        "DATABASE_PASSWORD": "password"
      }
    }
  }
}
```

**Keisha uses Database Analysis for**:
- Understanding data model (what does comparison depend on?)
- Identifying shared data (potential tight coupling)
- Validating core/domain logic (does the data model match theory?)
- Planning migrations (impact analysis: "if we change this node, what breaks?")

---

## TIER 5: DOCUMENTATION & ARCHITECTURAL UNDERSTANDING

### 11. Tree-Sitter Code Structure Parser (for architecture mapping)

Already bundled in Code Analysis MCP (#2), but can be used standalone:

```python
class ArchitectureMapperMCP:
    def generate_architecture_map(self, repo_path):
        """
        Generate a visual + JSON map of module structure:
        - Which modules export what?
        - Which modules depend on which?
        - What's the public API surface?
        """
        # Parse all files, extract module boundaries
        # Return: JSON graph suitable for visualization
        return {
            "modules": [
                {
                    "name": "comparison",
                    "exports": ["CoreCalculator", "WorkflowEngine", "ComparisonChart"],
                    "internal_functions": 8,
                    "public_functions": 3,
                    "dependencies": ["database", "domain_math"],
                    "internal_coupling": 0.45,
                    "external_coupling": 0.38
                }
            ],
            "relationships": [
                { "from": "comparison", "to": "database", "type": "data_access" },
                { "from": "comparison", "to": "domain_math", "type": "computation" }
            ]
        }
```

---

## TIER 6: SECURITY & SUPPLY CHAIN

### 12. Semgrep + OWASP Dependency Check MCP

Already covered under Semgrep (#1), but enhanced:

```json
{
  "mcpServers": {
    "security-analysis": {
      "command": "semgrep",
      "args": ["--config=p/owasp-top-ten,p/security-audit", "--json"],
      "env": {
        "SEMGREP_RULES": "p/owasp-top-ten,p/cwe-top-25,p/security-audit"
      }
    }
  }
}
```

**Keisha uses Security Analysis for**:
- Identifying security vulnerabilities (injection, auth bypass, etc.)
- Flagging unsafe patterns (hardcoded secrets, weak crypto)
- Supply chain risks (vulnerable dependencies)
- Compliance violations (OWASP, CWE)

---

## COMPLETE KEISHA MCP CONFIG (All Tools)

**Claude for Desktop** (`~/Library/Application Support/Claude/claude_desktop_config.json`):

```json
{
  "mcpServers": {
    "semgrep": {
      "command": "semgrep",
      "args": ["--json"],
      "env": {
        "SEMGREP_RULES": "p/owasp-top-ten,p/code-quality,p/best-practices"
      }
    },
    "code-analysis": {
      "command": "python",
      "args": ["-m", "code_analysis_mcp.server"],
      "env": {
        "DATABASE_URL": "postgresql://keisha:password@localhost/keisha_analysis",
        "REPOSITORY_PATH": "/path/to/your-project"
      }
    },
    "clippy": {
      "command": "cargo",
      "args": ["clippy", "--message-format=json"]
    },
    "coverage-rust": {
      "command": "cargo",
      "args": ["tarpaulin", "--json"]
    },
    "git-analysis": {
      "command": "python",
      "args": ["tools/git_analysis_mcp.py"],
      "env": {
        "REPO_PATH": "/path/to/your-project"
      }
    },
    "database-analysis": {
      "command": "python",
      "args": ["tools/database_mcp.py"],
      "env": {
        "DATABASE_URI": "<DB_URI>",
        "DATABASE_USER": "database",
        "DATABASE_PASSWORD": "password"
      }
    }
  }
}
```

---

## KEISHA'S OPERATIONAL WORKFLOW WITH THESE TOOLS

### Audit Flow (Example)

```
User: "Keisha, audit Project A"
  ↓
Keisha:
  1. Code Analysis MCP: Parse codebase, build dependency graph
  2. Clippy MCP: Run linter, capture warnings
  3. Complexity Analysis: Calculate cyclomatic complexity per function
  4. Coverage MCP: Get test coverage report
  5. Git Analysis: Get churn + hot-spots + blame statistics
  6. Defect Correlation: Match code changes to bug reports
  7. Semgrep: Security + pattern analysis
  ↓
Keisha (synthesizes all data):
{
  "metrics": {
    "cyclomatic_complexity": 9.2,
    "test_coverage": 72,
    "tech_debt_ratio": 18,
    ...
  },
  "hot_spots": [
    {
      "file": "aspect_calculator.rs",
      "complexity": 24,
      "coverage": 62,
      "churn": 24,
      "bugs": 5,
      "bug_density": 0.21,
      "risk": "CRITICAL"
    }
  ],
  "recommendations": [...]
}
```

---

## SETUP CHECKLIST

Before Keisha can use these tools:

- [ ] **Python environment**: `pip install database semgrep code-analysis-mcp`
- [ ] **Rust tools**: `cargo install clippy tarpaulin`
- [ ] **Node tools**: `npm install -g @dependency-cruiser c8`
- [ ] **PostgreSQL**: For Code Analysis embeddings database
- [ ] **Git**: Accessible from MCP servers
- [ ] **Database**: Running and accessible (for the organization analysis)
- [ ] **MCP config**: Update `claude_desktop_config.json` or agent framework config
- [ ] **Paths**: Set correct `REPO_PATH` for each MCP server

---

## QUICK START: Enable Keisha's Tools Today

### Option 1: Minimal (Today)
```json
{
  "mcpServers": {
    "semgrep": { "command": "semgrep", "args": ["--json"] },
    "git-analysis": { "command": "python", "args": ["git_mcp.py"] }
  }
}
```

### Option 2: Intermediate (This Week)
Add Code Analysis + Coverage + Complexity

### Option 3: Full (This Month)
Deploy all tools; integrate into CI/CD

---

**Keisha with these tools is unstoppable. She sees everything: complexity, dependencies, bugs, patterns, history, risks. Deploy them incrementally, and watch code quality transform.**
