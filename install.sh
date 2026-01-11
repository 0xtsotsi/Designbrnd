#!/bin/bash

# ============================================================================
# WEBRNDS MARKETPLACE - COMPLETE INSTALLATION
# ============================================================================
# Installs the complete Designbrnd consulting workflow
#
# Usage:
#   # Download the script first
#   curl -fsSL https://raw.githubusercontent.com/0xtsotsi/Designbrnd/main/install.sh -o install.sh
#
#   # Review the script (recommended)
#   less install.sh
#
#   # Run the installation
#   bash install.sh
#
# Or locally:
#   ./install.sh
# ============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

# Banner
echo ""
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${PURPLE}   WEBRNDS MARKETPLACE - COMPLETE INSTALLATION${NC}"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${BLUE}Installing:${NC}"
echo "  • Design OS Commands (8 commands)"
echo "  • Figma MCP Integration (cloud.md rules)"
echo "  • RALPH LOOP (Test-driven development)"
echo "  • Reflection Skills (5 learning modules)"
echo "  • Beads Integration (Task tracking)"
echo "  • Workspace Initializer (One-command setup)"
echo ""

# Check if we're in Designbrnd repo or need to clone
if [ -f "webrnds-marketplace.json" ]; then
    DESIGNBRND_ROOT="$(pwd)"
    echo -e "${GREEN}✓${NC} Found Designbrnd repository"
else
    echo -e "${BLUE}ℹ${NC} Cloning Designbrnd repository..."
    TEMP_DIR=$(mktemp -d)
    git clone https://github.com/0xtsotsi/Designbrnd.git "$TEMP_DIR"
    DESIGNBRND_ROOT="$TEMP_DIR"
    echo -e "${GREEN}✓${NC} Repository cloned"
fi

cd "$DESIGNBRND_ROOT"

# ============================================================================
# PLUGIN 1: Design OS Commands
# ============================================================================

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}Installing: Design OS Commands${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

COMMANDS_DIR="$HOME/.claude/commands/design-os"
mkdir -p "$COMMANDS_DIR"

if [ -d ".claude/commands/design-os" ]; then
    cp -r .claude/commands/design-os/* "$COMMANDS_DIR/"
    echo -e "${GREEN}✓${NC} Design OS commands installed to ~/.claude/commands/design-os/"
    echo -e "${GREEN}✓${NC} Available commands:"
    echo "    /product-vision"
    echo "    /product-roadmap"
    echo "    /data-model"
    echo "    /design-tokens"
    echo "    /shape-section"
    echo "    /sample-data"
    echo "    /design-screen"
    echo "    /export-product"
else
    echo -e "${YELLOW}⚠${NC} Design OS commands not found in repository"
fi

# ============================================================================
# PLUGIN 2: Figma MCP Integration
# ============================================================================

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}Installing: Figma MCP Integration${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

MCP_DIR="$HOME/.claude/mcp-servers"
mkdir -p "$MCP_DIR"

# Copy cloud.md to home directory for easy access
if [ -f "cloud.md" ]; then
    cp cloud.md "$HOME/.claude/cloud.md"
    echo -e "${GREEN}✓${NC} cloud.md installed to ~/.claude/cloud.md"
fi

# Create Figma MCP config
cat > "$MCP_DIR/figma-mcp.json" << 'EOF'
{
  "name": "figma-mcp",
  "description": "Figma MCP Server for AI-powered design",
  "url": "http://localhost:38450",
  "enabled": false,
  "manual_setup_required": true,
  "installation_instructions": [
    "1. Clone repository:",
    "   git clone https://github.com/Antonytm/figma-mcp-server.git",
    "",
    "2. Install dependencies:",
    "   cd figma-mcp-server",
    "   npm install",
    "",
    "3. Build:",
    "   npm run build",
    "",
    "4. Start server:",
    "   npm start",
    "   (Runs on http://localhost:38450)",
    "",
    "5. Install Figma plugin:",
    "   - Open Figma Desktop app",
    "   - Plugins → Development → Import plugin from manifest",
    "   - Select: figma-mcp-server/figma-plugin/manifest.json",
    "",
    "6. Run plugin in Figma:",
    "   - Plugins → Development → Figma MCP Server",
    "   - Should show 'Connected to MCP server'"
  ]
}
EOF

echo -e "${GREEN}✓${NC} Figma MCP config created at ~/.claude/mcp-servers/figma-mcp.json"
echo -e "${YELLOW}⚠${NC} Manual setup required - see config file for instructions"

# ============================================================================
# PLUGIN 3: RALPH LOOP
# ============================================================================

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}Installing: RALPH LOOP${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# Copy RALPH LOOP command
if [ -f ".claude/commands/ralph-loop.md" ]; then
    cp .claude/commands/ralph-loop.md "$HOME/.claude/commands/ralph-loop.md"
    echo -e "${GREEN}✓${NC} RALPH LOOP command installed"
    echo -e "${GREEN}✓${NC} Use: /ralph-loop for workflow guidance"
fi

# ============================================================================
# PLUGIN 4: Reflection Skills
# ============================================================================

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}Installing: Reflection Skills System${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

SKILLS_DIR="$HOME/.claude/skills"
mkdir -p "$SKILLS_DIR"

# Create skills
SKILLS=("client-discovery" "brand-design" "figma-design" "implementation" "qa-verification")
SKILL_NAMES=("Client Discovery" "Brand Design" "Figma Design" "Implementation" "QA Verification")
SKILL_DESCS=(
    "Discovery question patterns, industry requirements"
    "Industry colors, component standards, typography"
    "cloud.md patterns, naming conventions"
    "Tech stack rules, code structure"
    "Screenshot verification, visual bugs"
)

for i in "${!SKILLS[@]}"; do
    SKILL_DIR="$SKILLS_DIR/${SKILLS[$i]}"
    mkdir -p "$SKILL_DIR"

    cat > "$SKILL_DIR/SKILL.md" << EOF
# ${SKILL_NAMES[$i]} Skill

## Description
${SKILL_DESCS[$i]}

## Learned Patterns
[Will be populated as you use /reflect]

## Notes
This skill will learn and improve over time based on your corrections and preferences.

---
Last Updated: $(date +%Y-%m-%d)
Total Learnings: 0
EOF

    echo -e "${GREEN}✓${NC} Created skill: ${SKILL_NAMES[$i]}"
done

# Copy reflect command
if [ -f ".claude/commands/reflect.md" ]; then
    cp .claude/commands/reflect.md "$HOME/.claude/commands/reflect.md"
    echo -e "${GREEN}✓${NC} Reflection command installed"
    echo -e "${GREEN}✓${NC} Use: /reflect <skill-name>"
fi

# Initialize git in skills directory
cd "$SKILLS_DIR"
if [ ! -d ".git" ]; then
    echo -e "${BLUE}ℹ${NC} Initializing git repository for skills..."
    git init
    git add .
    git commit -m "Initial skills setup"
    echo -e "${GREEN}✓${NC} Skills git repository initialized"
fi

cd "$DESIGNBRND_ROOT"

# ============================================================================
# PLUGIN 5: Beads Integration
# ============================================================================

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}Installing: Beads Integration${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

if command -v bd &> /dev/null; then
    echo -e "${GREEN}✓${NC} Beads (bd) is installed"

    # Copy Beads hook
    HOOKS_DIR="$HOME/.claude/hooks"
    mkdir -p "$HOOKS_DIR"

    if [ -f ".claude/hooks/user-prompt-submit-beads.sh" ]; then
        cp .claude/hooks/user-prompt-submit-beads.sh "$HOOKS_DIR/"
        chmod +x "$HOOKS_DIR/user-prompt-submit-beads.sh"
        echo -e "${GREEN}✓${NC} Beads hook installed"
    fi

    # Copy beads command
    if [ -f ".claude/commands/beads-init.md" ]; then
        cp .claude/commands/beads-init.md "$HOME/.claude/commands/beads-init.md"
        echo -e "${GREEN}✓${NC} Beads initialization command installed"
    fi

    echo -e "${YELLOW}ℹ${NC} To enable Beads hook, add to ~/.claude/settings.json:"
    echo '    "hooks": {'
    echo '      "UserPromptSubmit": {'
    echo '        "hooks": [{'
    echo '          "type": "command",'
    echo '          "command": "~/.claude/hooks/user-prompt-submit-beads.sh"'
    echo '        }]'
    echo '      }'
    echo '    }'
else
    echo -e "${YELLOW}⚠${NC} Beads (bd) not installed - skipping"
    echo -e "${YELLOW}ℹ${NC} Install from: https://github.com/steveyegge/beads"
fi

# ============================================================================
# PLUGIN 6: Workspace Initializer
# ============================================================================

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}Installing: Workspace Initializer${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

if [ -f "init-workspace.sh" ]; then
    cp init-workspace.sh "$BIN_DIR/designbrnd-init"
    chmod +x "$BIN_DIR/designbrnd-init"
    echo -e "${GREEN}✓${NC} Workspace initializer installed to ~/.local/bin/designbrnd-init"

    # Check if ~/.local/bin is in PATH
    if [[ ":$PATH:" == *":$HOME/.local/bin:"* ]]; then
        echo -e "${GREEN}✓${NC} ~/.local/bin is in PATH"
    else
        echo -e "${YELLOW}⚠${NC} Add to PATH: export PATH=\"\$HOME/.local/bin:\$PATH\""
    fi

    echo -e "${GREEN}✓${NC} Usage: designbrnd-init <project-name> <client-name>"
fi

# Copy marketplace command
if [ -f ".claude/commands/marketplace.md" ]; then
    cp .claude/commands/marketplace.md "$HOME/.claude/commands/marketplace.md"
    echo -e "${GREEN}✓${NC} Marketplace command installed"
    echo -e "${GREEN}✓${NC} Use: /marketplace"
fi

# ============================================================================
# DOCUMENTATION
# ============================================================================

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}Copying Documentation${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

DOCS_DIR="$HOME/.claude/docs/webrnds"
mkdir -p "$DOCS_DIR"

if [ -d "docs" ]; then
    cp -r docs/* "$DOCS_DIR/"
    echo -e "${GREEN}✓${NC} Documentation copied to ~/.claude/docs/webrnds/"
fi

# ============================================================================
# COMPLETION
# ============================================================================

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}   INSTALLATION COMPLETE!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${BLUE}Installed Plugins:${NC}"
echo "  ✓ Design OS Commands (8 commands)"
echo "  ✓ RALPH LOOP (Test-driven development)"
echo "  ✓ Reflection Skills (5 learning modules)"
echo "  ⚠ Figma MCP Integration (manual setup required)"
if command -v bd &> /dev/null; then
    echo "  ✓ Beads Integration (task tracking)"
else
    echo "  ⏸ Beads Integration (optional - not installed)"
fi
echo "  ✓ Workspace Initializer"
echo "  ✓ Marketplace Command"
echo ""
echo -e "${BLUE}Available Commands:${NC}"
echo "  /product-vision       - Document business vision"
echo "  /product-roadmap      - Define project sections"
echo "  /data-model           - Structure data entities"
echo "  /design-tokens        - Select colors and fonts"
echo "  /shape-section        - Define section requirements"
echo "  /sample-data          - Generate sample content"
echo "  /design-screen        - Create React prototypes"
echo "  /export-product       - Generate handoff package"
echo "  /ralph-loop           - TDD workflow guidance"
echo "  /reflect <skill>      - Update learning skills"
echo "  /marketplace          - Browse Webrnds marketplace"
echo ""
echo -e "${BLUE}Quick Start:${NC}"
echo "  # Initialize new project"
echo "  designbrnd-init \"my-project\" \"Client Name\""
echo ""
echo "  # Or manually in any directory"
echo "  /product-vision"
echo ""
echo -e "${BLUE}Documentation:${NC}"
echo "  ~/.claude/docs/webrnds/quick-start-guide.md"
echo "  ~/.claude/docs/webrnds/consulting-workflow-guide.md"
echo "  ~/.claude/docs/webrnds/workspace-initialization-guide.md"
echo ""
echo -e "${YELLOW}Next Steps:${NC}"
echo "  1. Install Figma MCP Server (optional):"
echo "     See: ~/.claude/mcp-servers/figma-mcp.json"
echo ""
echo "  2. Install Beads (optional):"
echo "     https://github.com/steveyegge/beads"
echo ""
echo "  3. Create your first project:"
echo "     designbrnd-init \"my-first-project\" \"My Client\""
echo ""
echo -e "${GREEN}Happy building! 🚀${NC}"
echo ""
