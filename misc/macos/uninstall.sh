#!/bin/bash
set -euo pipefail

WORKFLOW_NAME="Focus Ghostty"
SERVICES_DIR="$HOME/Library/Services"

echo "Removing '${WORKFLOW_NAME}' Quick Action..."

rm -rf "$SERVICES_DIR/FocusGhostty.workflow"

echo "Done. Quick Action removed."
echo "You may want to remove the shortcut entry manually in:"
echo "  System Settings → Keyboard → Keyboard Shortcuts → Services → General"
