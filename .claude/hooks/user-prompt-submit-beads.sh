#!/bin/bash

# ============================================================================
# BEADS TASK TRACKER HOOK
# ============================================================================
# Automatically checks Beads for next ready task when user submits a prompt
# Event: UserPromptSubmit
# ============================================================================

# Check if Beads is installed
if ! command -v bd &> /dev/null; then
    exit 0  # Silently exit if Beads not installed
fi

# Check if we're in a Beads-initialized project
if [ ! -d ".beads" ] && [ ! -d ".git/beads" ]; then
    exit 0  # Not a Beads project
fi

# Check for disable flag
if [ -f ".beads/.disable-hook" ]; then
    exit 0
fi

# Get ready tasks (suppress errors)
READY_TASKS=$(bd ready --json 2>/dev/null | jq -r '.[] | .id + ": " + .title' | head -n 3)

if [ -n "$READY_TASKS" ]; then
    # Format output as system message
    MESSAGE=$(cat <<EOF
📋 Beads: Ready tasks:
$READY_TASKS

Use: bd show [id] for details
EOF
)

    # Output as JSON for Claude
    jq -n --arg msg "$MESSAGE" '{systemMessage: $msg}'
fi

exit 0
