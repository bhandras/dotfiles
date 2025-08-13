#!/bin/bash

# Enhanced notification script with context
# Usage: ./notify-enhanced.sh <message> <sound>
subtitle="$1"
sound="$2"

# Get current directory.
dir=$(pwd)
dir_name=$(basename "$dir")

# Get git branch if in a git repo.
git_branch=""
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    git_branch=$(git branch --show-current 2>/dev/null || echo "detached")
    git_info="$git_branch"
else
    git_info=""
fi

# Construct enhanced message
message="\[$dir_name ($git_info)]"

# Show alert and play sound.
terminal-notifier -title "Claude Code" -subtitle "$subtitle" -message "$message" -sound "$sound"
