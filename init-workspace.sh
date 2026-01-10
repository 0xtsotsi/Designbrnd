#!/bin/bash

# ============================================================================
# DESIGNBRND WORKSPACE INITIALIZER
# ============================================================================
# One-command setup for complete AI-powered consulting workflow
#
# Usage:
#   ./init-workspace.sh [project-name] [client-name]
#
# Example:
#   ./init-workspace.sh italian-restaurant "Maria's Trattoria"
#
# Sets up:
#   - Design OS commands
#   - Figma MCP Server
#   - RALPH LOOP testing
#   - Reflection System skills
#   - Beads project tracker
#   - cloud.md design rules
# ============================================================================

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
WORKSPACE_ROOT="${1:-my-project}"
CLIENT_NAME="${2:-Client Project}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DESIGNBRND_ROOT="$SCRIPT_DIR"

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

log_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

log_success() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

check_command() {
    if ! command -v "$1" &> /dev/null; then
        log_error "$1 is not installed. Please install it first."
        return 1
    fi
    return 0
}

# ============================================================================
# PHASE 1: PREREQUISITES CHECK
# ============================================================================

check_prerequisites() {
    log_info "Checking prerequisites..."

    local missing=0

    # Check required commands
    check_command "git" || ((missing++))
    check_command "node" || ((missing++))
    check_command "npm" || ((missing++))
    check_command "jq" || ((missing++))

    # Check Node version
    NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VERSION" -lt 18 ]; then
        log_error "Node.js version 18+ required (found: $(node -v))"
        ((missing++))
    else
        log_success "Node.js $(node -v)"
    fi

    # Check optional but recommended
    if ! check_command "bd"; then
        log_warning "Beads (bd) not found. Will skip Beads setup."
    fi

    if [ $missing -gt 0 ]; then
        log_error "Missing $missing required dependencies. Please install them first."
        exit 1
    fi

    log_success "All prerequisites met"
}

# ============================================================================
# PHASE 2: WORKSPACE CREATION
# ============================================================================

create_workspace() {
    log_info "Creating workspace: $WORKSPACE_ROOT"

    mkdir -p "$WORKSPACE_ROOT"
    cd "$WORKSPACE_ROOT"

    # Initialize git
    if [ ! -d ".git" ]; then
        git init
        log_success "Git repository initialized"
    fi

    # Create directory structure
    mkdir -p product/design-system
    mkdir -p product/data-model
    mkdir -p product/sections
    mkdir -p product-plan
    mkdir -p src/components/ui
    mkdir -p src/lib
    mkdir -p e2e/screenshots
    mkdir -p .claude/commands
    mkdir -p .claude/skills
    mkdir -p .claude/hooks

    log_success "Workspace structure created"
}

# ============================================================================
# PHASE 3: DESIGN OS SETUP
# ============================================================================

setup_design_os() {
    log_info "Setting up Design OS..."

    # Copy Design OS commands
    if [ -d "$DESIGNBRND_ROOT/.claude/commands/design-os" ]; then
        cp -r "$DESIGNBRND_ROOT/.claude/commands/design-os" .claude/commands/
        log_success "Design OS commands installed"
    else
        log_warning "Design OS commands not found in $DESIGNBRND_ROOT"
    fi

    # Create initial product structure
    cat > product/README.md << 'EOF'
# Product Definition

This directory contains your product definition files created by Design OS.

## Structure

- `product-overview.md` - Business vision (created by /product-vision)
- `product-roadmap.md` - Sections/phases (created by /product-roadmap)
- `data-model/` - Data entities (created by /data-model)
- `design-system/` - Colors, typography (created by /design-tokens)
- `sections/[name]/` - Per-section specs and data

## Commands

Run these in order:
1. `/product-vision` - Document business goals
2. `/product-roadmap` - Define sections
3. `/data-model` - Structure data
4. `/design-tokens` - Select colors/fonts
5. `/shape-section [name]` - Define section requirements
6. `/sample-data` - Generate content
7. `/design-screen [name]` - Create React component
8. `/export-product` - Generate handoff package
EOF

    log_success "Design OS configured"
}

# ============================================================================
# PHASE 4: FIGMA MCP SETUP
# ============================================================================

setup_figma_mcp() {
    log_info "Setting up Figma MCP..."

    # Copy cloud.md design rules
    if [ -f "$DESIGNBRND_ROOT/cloud.md" ]; then
        cp "$DESIGNBRND_ROOT/cloud.md" ./
        log_success "cloud.md design rules copied"
    else
        log_warning "cloud.md not found, creating template..."
        create_cloud_md_template
    fi

    # Create MCP configuration
    mkdir -p .claude/mcp-servers

    cat > .claude/mcp-servers/figma-mcp.json << 'EOF'
{
  "name": "figma-mcp",
  "description": "Figma MCP Server for AI-powered design",
  "url": "http://localhost:38450",
  "enabled": true,
  "setup_instructions": [
    "1. Clone: git clone https://github.com/Antonytm/figma-mcp-server.git",
    "2. Install: cd figma-mcp-server && npm install",
    "3. Build: npm run build",
    "4. Start: npm start (runs on port 38450)",
    "5. Install Figma plugin from figma-plugin/ directory",
    "6. Run plugin in Figma Desktop app"
  ]
}
EOF

    log_success "Figma MCP configuration created"
    log_warning "Manual step: Install and start Figma MCP Server (see .claude/mcp-servers/figma-mcp.json)"
}

create_cloud_md_template() {
    cat > cloud.md << 'EOF'
# Figma Design Rules

## Component Creation
- Components created using create-component tool
- All parts should be ancestors of component node
- Use add-component-property for variants
- Use auto-layout for everything

## Auto Layout Rules
- Vertical auto layout: Fixed width, children use FILL horizontal
- Horizontal auto layout: Fixed height, children use FILL vertical
- Prefer Frames over Rectangles

## Document Organization
- Page 1: Brand Guidelines
- Page 2: Components
- Page 3+: Screens
- No overlapping elements
- Use 8px grid system for spacing

## Component Standards
### Buttons
- Padding: 16px horizontal
- Border-radius: 8px
- Heights: 36px (sm), 44px (md), 52px (lg)

### Cards
- Padding: 24px
- Border-radius: 8px

### Input Fields
- Height: 48px
- Padding: 12px horizontal
- Border-radius: 6px
EOF
}

# ============================================================================
# PHASE 5: RALPH LOOP SETUP
# ============================================================================

setup_ralph_loop() {
    log_info "Setting up RALPH LOOP (Test-Driven Development)..."

    # Create Next.js with TypeScript and Tailwind
    log_info "Initializing Next.js project..."

    cat > package.json << EOF
{
  "name": "$(echo $WORKSPACE_ROOT | tr '[:upper:]' '[:lower:]' | tr ' ' '-')",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "test": "playwright test",
    "test:ui": "playwright test --ui"
  },
  "dependencies": {
    "next": "^14.2.0",
    "react": "^19.0.0",
    "react-dom": "^19.0.0"
  },
  "devDependencies": {
    "@playwright/test": "^1.48.0",
    "@types/node": "^20.0.0",
    "@types/react": "^19.0.0",
    "@types/react-dom": "^19.0.0",
    "autoprefixer": "^10.4.0",
    "eslint": "^8.0.0",
    "eslint-config-next": "^14.2.0",
    "postcss": "^8.4.0",
    "tailwindcss": "^4.0.0",
    "typescript": "^5.0.0"
  }
}
EOF

    # Install dependencies
    log_info "Installing dependencies (this may take a few minutes)..."
    npm install --silent

    # Install Playwright browsers
    npx playwright install chromium --with-deps > /dev/null 2>&1

    # Create Playwright config
    cat > playwright.config.ts << 'EOF'
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './e2e',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: 'html',

  use: {
    baseURL: 'http://localhost:3000',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
  },

  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
    {
      name: 'mobile',
      use: { ...devices['Pixel 5'] },
    },
  ],

  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:3000',
    reuseExistingServer: !process.env.CI,
  },
});
EOF

    # Create RALPH LOOP helper script
    cat > .claude/commands/ralph-loop.md << 'EOF'
# RALPH LOOP Workflow

## Test-Driven Development with Visual Verification

### Workflow Steps:
1. **Run tests** → `pnpm test e2e/[feature].spec.ts`
2. Tests will **FAIL** (no implementation yet)
3. **Implement components** to make tests pass
4. **Run tests** → Should PASS
5. **Read screenshots** in `e2e/screenshots/[feature]/`
6. **Fix visual issues** (z-index, positioning, overflow, styling)
7. **Re-run tests** after fixes
8. **Verify all screenshots** - read each with Read tool
9. **Rename verified screenshots** - `mv file.png verified_file.png`
10. **Confirm completion** - ensure ALL files have `verified_` prefix
11. **Output promise** - `<promise>FEATURE_NAME_DONE</promise>`

### Technology Requirements:
- Framework: Next.js/React with App Router
- Testing: Playwright E2E
- UI Components: shadcn/ui
- Styling: Tailwind CSS

### Screenshot Verification Protocol:
After tests pass:
1. List screenshots: `ls e2e/screenshots/[feature]/`
2. For EACH .png file WITHOUT 'verified_' prefix:
   - Read it with Read tool
   - Write one-line assessment
   - If issues found → fix, re-run tests, restart verification
   - If no issues → rename: `mv [file].png verified_[file].png`
3. After renaming ALL screenshots, wait for NEXT iteration
4. Next iteration confirms ALL files have 'verified_' prefix
5. Run tests one final time
6. Output: `<promise>FEATURE_NAME_DONE</promise>`
EOF

    log_success "RALPH LOOP configured"
    log_info "Install shadcn/ui when needed: npx shadcn@latest init"
}

# ============================================================================
# PHASE 6: REFLECTION SYSTEM SETUP
# ============================================================================

setup_reflection_system() {
    log_info "Setting up Claude Reflection System..."

    # Create skills directory structure
    SKILLS_ROOT="$HOME/.claude/skills"
    mkdir -p "$SKILLS_ROOT"

    # Create skill templates
    create_skill_template "client-discovery" "Client Discovery" "Discovery question order, industry patterns, required info"
    create_skill_template "brand-design" "Brand Design" "Industry colors, component standards, typography pairings"
    create_skill_template "figma-design" "Figma Design" "cloud.md patterns, component organization, naming conventions"
    create_skill_template "implementation" "Implementation" "Tech stack rules, code structure, testing requirements"
    create_skill_template "qa-verification" "QA Verification" "Screenshot checks, common bugs, accessibility standards"

    # Create reflection command
    cat > .claude/commands/reflect.md << 'EOF'
# Reflect Command

## Manual Reflection

Analyze the current session and update skills based on corrections and success patterns.

### Usage:
```bash
/reflect [skill-name]
```

### Process:
1. AI analyzes conversation for corrections
2. AI identifies success patterns
3. AI proposes skill updates with confidence levels:
   - HIGH: Explicit corrections ("never do X", "always do Y")
   - MEDIUM: Patterns that worked well
   - LOW: Observations to review
4. You review and approve changes
5. AI edits SKILL.md file
6. AI commits and pushes to Git

### Example:
```bash
/reflect brand-design
```

### Toggle Commands:
- `/reflect on` - Enable auto-reflection
- `/reflect off` - Disable auto-reflection
- `/reflect status` - Check if enabled
EOF

    # Create Stop hook for auto-reflection
    cat > .claude/hooks/stop-hook-reflect.sh << 'EOF'
#!/bin/bash
# Auto-reflection hook (runs when Claude stops responding)

SKILLS_DIR="$HOME/.claude/skills"

# Check if disabled
[ -f "$SKILLS_DIR/reflect/.disabled" ] && exit 0

# TODO: Implement pattern detection and skill updates
# For now, just notify
if [ -n "$CLAUDE_SESSION_ID" ]; then
    echo '{"systemMessage": "✓ Session complete. Run /reflect to capture learnings."}'
fi

exit 0
EOF

    chmod +x .claude/hooks/stop-hook-reflect.sh

    log_success "Reflection System configured"
    log_success "Skills created in: $SKILLS_ROOT"
}

create_skill_template() {
    local skill_dir="$HOME/.claude/skills/$1"
    local skill_name="$2"
    local description="$3"

    mkdir -p "$skill_dir"

    cat > "$skill_dir/SKILL.md" << EOF
# $skill_name Skill

## Description
$description

## Learned Patterns
[Will be populated as you use /reflect]

## Notes
This skill will learn and improve over time based on your corrections and preferences.

---
Last Updated: $(date +%Y-%m-%d)
Total Learnings: 0
EOF

    log_success "Created skill: $skill_name"
}

# ============================================================================
# PHASE 7: BEADS SETUP
# ============================================================================

setup_beads() {
    log_info "Setting up Beads project tracker..."

    if ! command -v bd &> /dev/null; then
        log_warning "Beads (bd) not installed. Skipping Beads setup."
        log_info "Install from: https://github.com/steveyegge/beads"
        return
    fi

    # Initialize Beads
    bd init

    # Create project structure
    cat > .beads-template.json << EOF
{
  "project": "$CLIENT_NAME - 6 Week Delivery",
  "phases": [
    {
      "name": "Week 1: Discovery & Planning",
      "tasks": [
        "Run /product-vision command",
        "Run /product-roadmap command",
        "Run /data-model command",
        "Client approves scope and vision"
      ]
    },
    {
      "name": "Week 2: Brand System Design",
      "tasks": [
        "Run /design-tokens command",
        "Figma MCP: Create brand guidelines page",
        "Figma MCP: Create component library",
        "Client approves brand identity"
      ]
    },
    {
      "name": "Week 3: Screen Design",
      "tasks": [
        "Design and approve Homepage",
        "Design and approve Menu/About/Contact",
        "Design and approve remaining sections",
        "Create social media templates"
      ]
    },
    {
      "name": "Week 4-5: Implementation (RALPH LOOP)",
      "tasks": [
        "Run /export-product command",
        "Write E2E tests for all features",
        "RALPH LOOP: Implement all sections",
        "All tests passing and screenshots verified"
      ]
    },
    {
      "name": "Week 6: Launch",
      "tasks": [
        "Client reviews staging site",
        "Client final approval",
        "Deploy to production",
        "Handoff and documentation"
      ]
    }
  ]
}
EOF

    # Create Beads initialization script
    cat > .claude/commands/beads-init.md << 'EOF'
# Beads Project Initialization

## Setup Project Tracking

This command initializes the Beads task tracker with your 6-week project structure.

### Usage:
Run this ONCE at project start:
```bash
bd init
# Then import template
cat .beads-template.json | jq -r '.phases[] | .name' | while read phase; do
  bd create epic "$phase"
done
```

### Check Progress:
```bash
bd ready          # What's ready to work on?
bd status         # Overall progress
bd done [task-id] # Mark task complete
```
EOF

    log_success "Beads configured with project template"
}

# ============================================================================
# PHASE 8: DOCUMENTATION & README
# ============================================================================

create_documentation() {
    log_info "Creating project documentation..."

    cat > README.md << EOF
# $CLIENT_NAME

AI-Powered Consulting Workflow Project

## Quick Start

### 1. Start Design OS (if using Designbrnd UI)
\`\`\`bash
cd path/to/Designbrnd
npm run dev
# Open http://localhost:5173
\`\`\`

### 2. Start Figma MCP Server
\`\`\`bash
cd path/to/figma-mcp-server
npm start
# Runs on http://localhost:38450
# Open Figma Desktop and run plugin
\`\`\`

### 3. Run Development Server
\`\`\`bash
npm run dev
# Open http://localhost:3000
\`\`\`

### 4. Run Tests
\`\`\`bash
npm test
npm run test:ui  # Visual test runner
\`\`\`

## Workflow

### Week 1: Discovery
- \`/product-vision\` - Document business goals
- \`/product-roadmap\` - Define sections
- \`/data-model\` - Structure data

### Week 2: Brand Design
- \`/design-tokens\` - Select colors/fonts
- Use Figma MCP to create brand system

### Week 3: Screen Design
- \`/shape-section [name]\` - Define requirements
- \`/sample-data\` - Generate content
- Use Figma MCP to create designs

### Week 4-5: Implementation
- Write E2E tests
- Run RALPH LOOP workflow
- Use \`/ralph-loop\` for guidance

### Week 6: Launch
- Client review
- Deploy
- Handoff

## Tools Configured

- ✅ Design OS commands
- ✅ Figma MCP (cloud.md rules)
- ✅ RALPH LOOP (Playwright E2E)
- ✅ Reflection System (skills in ~/.claude/skills)
- $(command -v bd &> /dev/null && echo "✅" || echo "⏸️") Beads project tracker

## Directory Structure

\`\`\`
$WORKSPACE_ROOT/
├── product/              # Design OS output
│   ├── product-overview.md
│   ├── product-roadmap.md
│   ├── design-system/
│   └── sections/
├── src/                  # Next.js application
│   ├── app/
│   └── components/
├── e2e/                  # Playwright tests
│   └── screenshots/
├── .claude/              # Claude Code config
│   ├── commands/
│   ├── skills/
│   └── hooks/
└── cloud.md             # Figma design rules
\`\`\`

## Commands Reference

### Design OS
- \`/product-vision\` - Business vision
- \`/product-roadmap\` - Sections
- \`/data-model\` - Data structure
- \`/design-tokens\` - Colors/fonts
- \`/shape-section\` - Section requirements
- \`/sample-data\` - Generate content
- \`/export-product\` - Handoff package

### RALPH LOOP
- \`npm test e2e/[feature].spec.ts\` - Run tests
- Follow verification protocol in \`/ralph-loop\`

### Reflection
- \`/reflect [skill-name]\` - Update skills
- \`/reflect on/off\` - Toggle auto-reflection

### Beads (if installed)
- \`bd ready\` - What's next?
- \`bd status\` - Progress overview
- \`bd done [id]\` - Complete task

## Support

- Documentation: docs/
- Issues: GitHub repository
- Community: [Link to community]

---
Generated by Designbrnd Workspace Initializer
EOF

    log_success "README.md created"
}

# ============================================================================
# PHASE 9: GIT SETUP
# ============================================================================

setup_git() {
    log_info "Setting up Git..."

    cat > .gitignore << 'EOF'
# Dependencies
node_modules/
.pnp
.pnp.js

# Testing
/coverage
/e2e/test-results/
/e2e/playwright-report/
playwright/.cache/

# Next.js
/.next/
/out/
.vercel

# Production
/build
/dist

# Misc
.DS_Store
*.pem
.env*.local

# Debug
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# Beads (if using stealth mode)
.git/beads/
EOF

    # Initial commit
    git add .
    git commit -m "Initial workspace setup

- Design OS commands configured
- Figma MCP with cloud.md rules
- RALPH LOOP testing framework
- Reflection System skills
- Beads project tracker
- Complete 6-week workflow ready" > /dev/null 2>&1

    log_success "Git initialized with initial commit"
}

# ============================================================================
# PHASE 10: COMPLETION & SUMMARY
# ============================================================================

print_summary() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "${GREEN}✓ Workspace Initialization Complete!${NC}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Project: $CLIENT_NAME"
    echo "Location: $(pwd)"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "NEXT STEPS"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "1. Start Figma MCP Server (if not already running):"
    echo "   cd path/to/figma-mcp-server && npm start"
    echo ""
    echo "2. Start development server:"
    echo "   cd $WORKSPACE_ROOT && npm run dev"
    echo ""
    echo "3. Begin workflow:"
    echo "   - Run /product-vision to start discovery"
    echo "   - Follow 6-week workflow in README.md"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "CONFIGURED TOOLS"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "✓ Design OS       - Commands in .claude/commands/"
    echo "✓ Figma MCP       - Rules in cloud.md"
    echo "✓ RALPH LOOP      - Playwright configured"
    echo "✓ Reflection      - Skills in ~/.claude/skills/"
    if command -v bd &> /dev/null; then
        echo "✓ Beads           - Project tracker initialized"
    else
        echo "⏸ Beads           - Not installed (optional)"
    fi
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "DOCUMENTATION"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "📖 README.md                  - Quick start guide"
    echo "📖 product/README.md          - Design OS workflow"
    echo "📖 .claude/commands/          - All available commands"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "DESIGNBRND WORKSPACE INITIALIZER"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Client: $CLIENT_NAME"
    echo "Workspace: $WORKSPACE_ROOT"
    echo ""

    check_prerequisites
    create_workspace
    setup_design_os
    setup_figma_mcp
    setup_ralph_loop
    setup_reflection_system
    setup_beads
    create_documentation
    setup_git
    print_summary
}

# Run main function
main
