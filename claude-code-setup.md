# Claude Code Setup Guide

Setting up Claude Code from zero with Context7, Superpowers, Serena, and Caveman.

## Prerequisites

- Node.js (for npx)
- Python 3.13+ with `uvx` (for Serena)
- Claude Code CLI installed

```bash
npm install -g @anthropic-ai/claude-code
```

## Step 1: Install Claude Code & Complete Onboarding

```bash
claude
# Follow the interactive onboarding (auth, model selection, etc.)
```

## Step 2: Add Context7 (Live Documentation Fetching)

Context7 fetches up-to-date, version-specific documentation for any library or framework directly into your prompts.

### Option A — CLI + Skills (recommended)

```bash
npx ctx7 setup --claude
```

Then create `~/.claude/rules/context7.md` with instructions telling Claude when to call `npx ctx7@latest library` and `npx ctx7@latest docs`. This approach works without an API key for basic usage.

For higher rate limits:

```bash
npx ctx7@latest login
# or set CONTEXT7_API_KEY environment variable
```

### Option B — MCP Server

```bash
claude mcp add --scope user context7 -- npx -y @upstash/context7-mcp --api-key YOUR_API_KEY
```

## Step 3: Add Serena MCP Server (Semantic Code Tools)

Serena provides IDE-like semantic code retrieval and editing via LSP — symbol-level navigation, refactoring, and renaming across the codebase.

```bash
claude mcp add --scope user serena -- uvx --python 3.13 \
  --from git+https://github.com/oraios/serena serena start-mcp-server \
  --context=claude-code --project-from-cwd
```

Then create `.serena/project.yml` in your project root:

```yaml
project_name: "your-project"
languages:
  - typescript
  - kotlin
encoding: "utf-8"
ignore_all_files_in_gitignore: true
read_only: false
excluded_tools: []
```

> **Note:** Do NOT also install the `serena` plugin from the official marketplace. The MCP server with `--context=claude-code --project-from-cwd` is the better option — it auto-activates the project based on your working directory and tailors behavior for Claude Code.

## Step 4: Install Superpowers Plugin (Development Workflows)

Superpowers adds structured development skills that Claude invokes automatically when relevant.

Inside Claude Code:

```
/plugin install superpowers@claude-plugins-official
```

### Skills included

- **Brainstorming** — explores intent, requirements, and design before implementation
- **Writing Plans** — creates multi-step implementation plans from specs
- **Executing Plans** — runs plans with review checkpoints
- **Test-Driven Development** — TDD workflow before writing implementation code
- **Systematic Debugging** — structured approach to bugs and test failures
- **Code Review** — requesting and receiving code review
- **Verification Before Completion** — requires evidence before claiming work is done
- **Git Worktrees** — isolated feature work in worktrees
- **Parallel Agents** — dispatches independent tasks concurrently

## Step 5: Install Caveman Plugin (Compressed Output Mode)

Caveman cuts token usage ~75% by compressing output while keeping full technical accuracy.

First, add the marketplace source in `~/.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "caveman": {
      "source": {
        "source": "github",
        "repo": "JuliusBrussee/caveman"
      }
    }
  }
}
```

Then inside Claude Code:

```
/plugin install caveman@caveman
```

Activate by saying "caveman mode" or `/caveman`. Supports intensity levels: lite, full (default), ultra.

## Step 6: Install LSP Plugins (IDE Diagnostics)

LSP plugins pipe language-server diagnostics (errors, warnings, type info) directly to Claude, enabling it to catch issues without running builds.

```
/plugin install typescript-lsp@claude-plugins-official
/plugin install kotlin-lsp@claude-plugins-official
/plugin install php-lsp@claude-plugins-official
```

## Summary

| Tool | What it provides | How it's configured |
|------|-----------------|-------------------|
| **Context7** | Live, up-to-date library docs | CLI rule in `~/.claude/rules/` or MCP server |
| **Serena** | Semantic code nav & refactoring via LSP | MCP server (`claude mcp add`) |
| **Superpowers** | Dev workflow skills (TDD, debugging, planning) | Plugin (`/plugin install`) |
| **Caveman** | Compressed output mode | Plugin (`/plugin install`) |
| **LSP Plugins** | IDE diagnostics (TypeScript, Kotlin, PHP) | Plugin (`/plugin install`) |