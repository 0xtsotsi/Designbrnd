#!/bin/bash

# Script to create PR using GitHub CLI

echo "Creating Pull Request..."
echo ""
echo "From: claude/byte-rover-beads-engine-wnV4Z"
echo "To: main"
echo ""

# Check if gh is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed."
    echo ""
    echo "To install gh CLI:"
    echo "  Ubuntu/Debian: sudo apt install gh"
    echo "  macOS: brew install gh"
    echo "  Other: https://cli.github.com/manual/installation"
    echo ""
    echo "After installation, run: gh auth login"
    echo "Then run this script again."
    exit 1
fi

# Create the PR
gh pr create \
  --base main \
  --head claude/byte-rover-beads-engine-wnV4Z \
  --title "Complete System Architecture & Documentation - Unified Platform Integration" \
  --body "$(cat PR_DETAILS.md)"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Pull Request created successfully!"
    echo ""
    read -p "Do you want to merge the PR now? (y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Get the PR number
        PR_NUMBER=$(gh pr list --head claude/byte-rover-beads-engine-wnV4Z --json number --jq '.[0].number')

        if [ -n "$PR_NUMBER" ]; then
            echo "Merging PR #$PR_NUMBER..."
            gh pr merge $PR_NUMBER --merge --delete-branch

            if [ $? -eq 0 ]; then
                echo ""
                echo "🎉 Pull Request merged and branch deleted!"
            else
                echo ""
                echo "❌ Failed to merge. You can merge manually at:"
                gh pr view $PR_NUMBER --web
            fi
        fi
    fi
else
    echo ""
    echo "❌ Failed to create PR"
    echo "Please create it manually using PR_DETAILS.md"
fi
