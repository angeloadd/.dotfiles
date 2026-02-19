#!/bin/bash
set -euo pipefail

WORKFLOW_NAME="Focus Ghostty"
SERVICES_DIR="$HOME/Library/Services"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing '${WORKFLOW_NAME}' Quick Action..."

# Copy workflow to Services
mkdir -p "$SERVICES_DIR"
cp -R "$SCRIPT_DIR/FocusGhostty.workflow" "$SERVICES_DIR/"

echo "Quick Action installed to $SERVICES_DIR/"

# Set keyboard shortcut: Cmd+Ctrl+T
# The key combo is encoded as: @ = Cmd, ^ = Ctrl, T = T
defaults write pbs NSServicesStatus -dict-add \
  "\"(null) - ${WORKFLOW_NAME} - runWorkflowAsService\"" \
  '{ "enabled" = 1; "key_equivalent" = "^@t"; }'

echo "Keyboard shortcut set to Cmd+Ctrl+T"
echo ""
echo "Done! You may need to log out and back in (or restart) for the shortcut to take effect."
echo "You can also check: System Settings → Keyboard → Keyboard Shortcuts → Services → General"
