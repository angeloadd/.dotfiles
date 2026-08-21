#!/usr/bin/env bash
# Setup Claude Code plugins and MCP servers for this project
# Usage: ./scripts/setup-claude-plugins.sh

set -euo pipefail

CLAUDE_DIR="$HOME/.claude"
SETTINGS_FILE="$CLAUDE_DIR/settings.json"
PROJECT_MCP_FILE="$(git rev-parse --show-toplevel)/.mcp.json"

echo "=== Claude Code Plugin & MCP Setup ==="

# ── 1. Ensure ~/.claude/settings.json exists ──
if [ ! -f "$SETTINGS_FILE" ]; then
  mkdir -p "$CLAUDE_DIR"
  echo '{}' > "$SETTINGS_FILE"
  echo "Created $SETTINGS_FILE"
fi

# ── 2. Write plugin + marketplace config ──
# Uses jq to merge into existing settings without clobbering other keys
if ! command -v jq &>/dev/null; then
  echo "Error: jq is required. Install with: brew install jq"
  exit 1
fi

PLUGIN_CONFIG=$(cat <<'JSON'
{
  "enabledPlugins": {
    "caveman@caveman": true,
    "superpowers@claude-plugins-official": true,
    "serena@claude-plugins-official": true,
    "typescript-lsp@claude-plugins-official": true,
    "kotlin-lsp@claude-plugins-official": true,
    "php-lsp@claude-plugins-official": true
  },
  "extraKnownMarketplaces": {
    "caveman": {
      "source": {
        "source": "github",
        "repo": "JuliusBrussee/caveman"
      }
    }
  }
}
JSON
)

jq --argjson plugins "$PLUGIN_CONFIG" '
  .enabledPlugins = (.enabledPlugins // {} | . * $plugins.enabledPlugins) |
  .extraKnownMarketplaces = (.extraKnownMarketplaces // {} | . * $plugins.extraKnownMarketplaces)
' "$SETTINGS_FILE" > "${SETTINGS_FILE}.tmp" && mv "${SETTINGS_FILE}.tmp" "$SETTINGS_FILE"

echo "✓ Plugins enabled: caveman, superpowers, serena, typescript-lsp, kotlin-lsp, php-lsp"

# ── 3. Write project-level .mcp.json for MCP servers ──
MCP_CONFIG=$(cat <<'JSON'
{
  "mcpServers": {
    "serena": {
      "command": "uvx",
      "args": ["--from", "git+https://github.com/oraios/serena", "serena", "start-mcp-server"]
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    }
  }
}
JSON
)

if [ -f "$PROJECT_MCP_FILE" ]; then
  # Merge into existing .mcp.json
  jq --argjson mcp "$MCP_CONFIG" '
    .mcpServers = (.mcpServers // {} | . * $mcp.mcpServers)
  ' "$PROJECT_MCP_FILE" > "${PROJECT_MCP_FILE}.tmp" && mv "${PROJECT_MCP_FILE}.tmp" "$PROJECT_MCP_FILE"
else
  echo "$MCP_CONFIG" | jq . > "$PROJECT_MCP_FILE"
fi

echo "✓ MCP servers configured: serena, context7"

# ── 4. Prereq checks ──
echo ""
echo "=== Dependency Check ==="

if command -v uvx &>/dev/null; then
  echo "✓ uvx found (for serena)"
else
  echo "✗ uvx not found — install with: pip install uv"
fi

if command -v npx &>/dev/null; then
  echo "✓ npx found (for context7)"
else
  echo "✗ npx not found — install Node.js"
fi

echo ""
echo "Done! Run /reload-plugins in Claude Code to apply."