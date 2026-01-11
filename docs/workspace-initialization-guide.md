# Workspace Initialization Guide
## Automated Setup for AI-Powered Consulting Workflow

---

## Overview

This guide shows you how to initialize a complete workspace with **one command** that configures:

- ✅ Design OS (planning & documentation)
- ✅ Figma MCP Server (AI-powered design)
- ✅ RALPH LOOP (test-driven development)
- ✅ Reflection System (meta-learning)
- ✅ Beads (project tracking)
- ✅ All hooks, skills, and configurations

**Total Setup Time:** ~5-10 minutes (mostly automatic)

---

## Quick Start

### One-Command Initialization

```bash
cd /path/to/Designbrnd

# Initialize new client project
./init-workspace.sh "italian-restaurant" "Maria's Trattoria"
```

**That's it!** Everything is configured and ready.

---

## What Gets Installed

### Directory Structure Created

```
italian-restaurant/
├── product/                      # Design OS outputs
│   ├── README.md
│   ├── product-overview.md       # Created by /product-vision
│   ├── product-roadmap.md        # Created by /product-roadmap
│   ├── design-system/
│   │   ├── colors.json           # Created by /design-tokens
│   │   └── typography.json
│   ├── data-model/
│   │   └── data-model.md         # Created by /data-model
│   └── sections/
│       └── [section-name]/
│           ├── spec.md           # Created by /shape-section
│           ├── data.json         # Created by /sample-data
│           └── *.png             # Screenshots
│
├── src/                          # Next.js application
│   ├── app/                      # App Router
│   ├── components/
│   │   └── ui/                   # shadcn/ui components
│   └── lib/
│
├── e2e/                          # Playwright tests
│   ├── screenshots/
│   │   └── [feature]/
│   │       └── verified_*.png
│   └── *.spec.ts                 # E2E tests
│
├── .claude/                      # Claude Code configuration
│   ├── commands/
│   │   ├── design-os/            # Design OS commands
│   │   │   ├── product-vision.md
│   │   │   ├── product-roadmap.md
│   │   │   ├── data-model.md
│   │   │   ├── design-tokens.md
│   │   │   ├── shape-section.md
│   │   │   ├── sample-data.md
│   │   │   ├── design-screen.md
│   │   │   └── export-product.md
│   │   ├── ralph-loop.md         # RALPH LOOP guidance
│   │   ├── beads-init.md         # Beads setup
│   │   ├── reflect.md            # Reflection command
│   │   └── marketplace.md        # Marketplace browser
│   │
│   ├── skills/                   # (Created in ~/.claude/skills/)
│   │   ├── client-discovery/
│   │   ├── brand-design/
│   │   ├── figma-design/
│   │   ├── implementation/
│   │   └── qa-verification/
│   │
│   ├── hooks/
│   │   ├── stop-hook-reflect.sh
│   │   └── user-prompt-submit-beads.sh
│   │
│   └── mcp-servers/
│       └── figma-mcp.json        # Figma MCP config
│
├── .beads/                       # Beads project tracker
│   └── *.jsonl                   # Task data
│
├── cloud.md                      # Figma design rules
├── .beads-template.json          # Beads project template
├── package.json                  # Next.js dependencies
├── playwright.config.ts          # Playwright configuration
├── README.md                     # Project documentation
└── .gitignore
```

### Installed Dependencies

**Node Modules:**
- `next` - Next.js framework
- `react` - React library
- `@playwright/test` - E2E testing
- `tailwindcss` - Styling
- `typescript` - Type safety

**Global Skills (in ~/.claude/skills/):**
- Client Discovery
- Brand Design
- Figma Design
- Implementation
- QA Verification

---

## Step-by-Step Breakdown

### Phase 1: Prerequisites Check ✅

The script checks for:
- ✅ Git
- ✅ Node.js 18+
- ✅ npm
- ✅ jq (JSON processor)
- ⚠️ Beads (optional, warns if missing)

If anything is missing, it tells you exactly what to install.

---

### Phase 2: Workspace Creation 📁

Creates directory structure:
- `product/` - Design OS outputs
- `src/` - Next.js app
- `e2e/` - Playwright tests
- `.claude/` - Claude configuration

Initializes Git repository with `.gitignore`.

---

### Phase 3: Design OS Setup 📋

**Installs:**
- Design OS commands in `.claude/commands/design-os/`
- Product structure with README
- Template directories

**Available Commands:**
- `/product-vision` - Document business vision
- `/product-roadmap` - Define sections
- `/data-model` - Structure data
- `/design-tokens` - Select colors/fonts
- `/shape-section` - Define section requirements
- `/sample-data` - Generate content
- `/design-screen` - Create React component
- `/export-product` - Generate handoff package

---

### Phase 4: Figma MCP Configuration 🎨

**Creates:**
- `cloud.md` - Figma design rules (auto-layout, component standards)
- `.claude/mcp-servers/figma-mcp.json` - MCP config

**Manual Step Required:**
You'll need to separately install and run Figma MCP Server:

```bash
# One-time setup
git clone https://github.com/Antonytm/figma-mcp-server.git
cd figma-mcp-server
npm install && npm run build

# Run server (keep running)
npm start
# Runs on http://localhost:38450

# Install Figma plugin
# Figma Desktop → Plugins → Development → Import manifest
# Select: figma-mcp-server/figma-plugin/manifest.json
```

---

### Phase 5: RALPH LOOP Setup 🔨

**Installs:**
- Next.js with TypeScript
- Playwright E2E testing
- Playwright chromium browser
- Tailwind CSS v4
- ESLint configuration

**Creates:**
- `playwright.config.ts` - Test configuration
- `package.json` - Dependencies
- `.claude/commands/ralph-loop.md` - Workflow guidance

**Note:** shadcn/ui components installed on-demand:
```bash
npx shadcn@latest add button
npx shadcn@latest add card
```

---

### Phase 6: Reflection System Setup 🧠

**Creates Skills:**
- `~/.claude/skills/client-discovery/SKILL.md`
- `~/.claude/skills/brand-design/SKILL.md`
- `~/.claude/skills/figma-design/SKILL.md`
- `~/.claude/skills/implementation/SKILL.md`
- `~/.claude/skills/qa-verification/SKILL.md`

**Creates Commands:**
- `.claude/commands/reflect.md` - Reflection command

**Creates Hooks:**
- `.claude/hooks/stop-hook-reflect.sh` - Auto-reflection (disabled by default)

**Usage:**
```bash
/reflect [skill-name]    # Manual reflection
/reflect on              # Enable auto-reflection
/reflect off             # Disable auto-reflection
```

---

### Phase 7: Beads Project Tracker 🔷

**If Beads is installed:**

**Creates:**
- `.beads/` - Beads data directory
- `.beads-template.json` - 6-week project template
- `.claude/commands/beads-init.md` - Initialization guide

**Initializes:**
```bash
bd init  # Initialize Beads in project
```

**If Beads is NOT installed:**
Shows warning with installation link.

---

### Phase 8: Documentation 📚

**Creates:**
- `README.md` - Project overview, quick start, workflow
- `product/README.md` - Design OS usage guide

**Copies from Designbrnd:**
- `docs/consulting-workflow-guide.md`
- `docs/quick-start-guide.md`
- `docs/tool-integration-reference.md`

---

### Phase 9: Git Setup 🔄

**Creates:**
- `.gitignore` - Excludes node_modules, .next, etc.

**Makes initial commit:**
```
Initial workspace setup

- Design OS commands configured
- Figma MCP with cloud.md rules
- RALPH LOOP testing framework
- Reflection System skills
- Beads project tracker
- Complete 6-week workflow ready
```

---

## After Initialization

### Start Working Immediately

```bash
cd italian-restaurant

# Option 1: Start Design OS workflow
/product-vision

# Option 2: Check Beads tasks
bd ready

# Option 3: Start dev server
npm run dev
# Open http://localhost:3000
```

---

## Marketplace System

### Browse Available Tools

```bash
/marketplace              # Show all available tools
/marketplace info beads   # Get info about Beads
```

**Registry Location:**
```
.claude/marketplace/registry.json
```

Contains:
- **MCP Servers** - Figma MCP, etc.
- **Skills** - Learning modules
- **Hooks** - Event triggers
- **Tools** - Beads, RALPH LOOP
- **Workflows** - 6-week consulting workflow

---

## Manual Configuration (If Needed)

### Enable Auto-Reflection Hook

```bash
# Edit ~/.claude/settings.json
{
  "hooks": {
    "Stop": {
      "hooks": [
        {
          "type": "command",
          "command": "~/.claude/hooks/stop-hook-reflect.sh"
        }
      ]
    }
  }
}
```

### Enable Beads Task Tracker Hook

```bash
# Edit ~/.claude/settings.json
{
  "hooks": {
    "UserPromptSubmit": {
      "hooks": [
        {
          "type": "command",
          "command": "~/.claude/hooks/user-prompt-submit-beads.sh"
        }
      ]
    }
  }
}
```

---

## Typical 6-Week Workflow

### Week 1: Discovery

```bash
cd italian-restaurant

# Run Design OS commands
/product-vision
# Answer questions, generates product-overview.md

/product-roadmap
# Define sections, generates product-roadmap.md

/data-model
# Define entities, generates data-model.md

# Track in Beads
bd create epic "Italian Restaurant - 6 Week Project"
bd create task "Product Vision" --parent [epic-id]
bd done [task-id]
```

### Week 2: Brand Design

```bash
/design-tokens
# Select colors and fonts, generates colors.json, typography.json

# Use Figma MCP
# Prompt Claude: "Create brand system in Figma using design tokens and cloud.md"
# AI creates: Brand guidelines, component library

# Reflect on learnings
/reflect brand-design
```

### Week 3: Screen Design

```bash
/shape-section homepage
/sample-data
# Generates spec.md, data.json

# Use Figma MCP
# Prompt: "Create homepage design in Figma using spec and components"
# AI creates: Desktop + mobile designs

# Repeat for other sections
/shape-section menu
/sample-data
# ... Figma MCP creates menu design
```

### Week 4-5: Implementation

```bash
/export-product
# Generates product-plan.zip

# Write E2E tests
# e2e/homepage.spec.ts

# RALPH LOOP
npm test e2e/homepage.spec.ts
# FAIL → Implement → PASS → Verify → Mark verified

# Track progress
bd status
```

### Week 6: Launch

```bash
# Client review staging
npm run build
npm run start

# Deploy
# ... deployment steps ...

# Reflect on entire project
/reflect implementation
/reflect qa-verification
```

---

## Customization

### Add Your Own MCP Server

1. Edit `.claude/marketplace/registry.json`:

```json
{
  "mcp_servers": [
    {
      "id": "your-mcp",
      "name": "Your MCP Server",
      "port": 3001,
      "setup_command": "setup-your-mcp.sh"
    }
  ]
}
```

2. Create setup script:

```bash
#!/bin/bash
# setup-your-mcp.sh

# Installation steps
git clone https://your-repo.com/your-mcp.git
cd your-mcp
npm install
npm start
```

### Add Custom Skill

1. Create skill directory:
```bash
mkdir -p ~/.claude/skills/your-skill
```

2. Create SKILL.md:
```markdown
# Your Skill

## Learned Patterns
[Will be populated]
```

3. Use with:
```bash
/reflect your-skill
```

### Add Custom Command

1. Create command file:
```bash
# .claude/commands/your-command.md

# Your Command

Description of what this command does.

## Usage
...
```

2. Use with:
```bash
/your-command
```

---

## Troubleshooting

### "bd command not found"

**Solution:** Install Beads from https://github.com/steveyegge/beads

The script will still work, just without Beads integration.

---

### "Figma MCP not connecting"

**Solution:**
1. Make sure MCP server is running: `curl http://localhost:38450`
2. Check Figma Desktop app (not browser)
3. Restart Figma and re-run plugin

---

### "npm install fails"

**Solution:**
1. Check Node version: `node -v` (need 18+)
2. Clear npm cache: `npm cache clean --force`
3. Delete `node_modules` and `package-lock.json`, try again

---

### "Playwright browsers not installing"

**Solution:**
```bash
npx playwright install chromium --with-deps
```

If that fails, install system dependencies:
```bash
# Ubuntu/Debian
sudo apt-get install libgbm1 libatk-bridge2.0-0
```

---

## Advanced Usage

### Multi-Client Management

```bash
# Initialize multiple projects
./init-workspace.sh "client-a-restaurant" "Restaurant A"
./init-workspace.sh "client-b-gym" "Gym B"
./init-workspace.sh "client-c-shop" "Shop C"

# Work on different clients
cd client-a-restaurant
/product-vision

cd ../client-b-gym
/product-vision

# Beads tracks each separately
bd status  # Shows client-specific progress
```

### Team Collaboration

```bash
# Each team member initializes workspace
./init-workspace.sh "shared-project" "Client Name"

# Share repository
git remote add origin https://github.com/team/shared-project.git
git push -u origin main

# Other team members clone
git clone https://github.com/team/shared-project.git
cd shared-project
npm install

# Beads syncs via git
bd ready  # Shows same tasks for everyone
```

---

## FAQ

**Q: Do I need to install everything manually?**
A: No, `init-workspace.sh` handles most installation automatically. You only need to manually install Figma MCP Server.

**Q: Can I skip Beads?**
A: Yes, Beads is optional. The script detects if it's installed and skips that section if not.

**Q: Where are skills stored?**
A: Global location: `~/.claude/skills/` - shared across all projects.

**Q: Can I use this for non-client projects?**
A: Absolutely! Use for personal projects, side projects, open source, etc.

**Q: How do I update the workflow?**
A: Pull latest from Designbrnd repo, run `init-workspace.sh` again (won't overwrite existing files).

**Q: Can I customize the 6-week workflow?**
A: Yes, edit `.beads-template.json` to define your own phases.

---

## Summary

### One Command to Rule Them All

```bash
./init-workspace.sh "project-name" "Client Name"
```

**Configures:**
- ✅ Design OS (8 commands)
- ✅ Figma MCP (cloud.md rules)
- ✅ RALPH LOOP (Playwright + Next.js)
- ✅ Reflection System (5 skills)
- ✅ Beads (project tracker)
- ✅ All hooks and configurations

**Result:**
- 🚀 Ready to start in 5 minutes
- 📋 Complete 6-week workflow
- 🤖 AI-powered automation
- 📈 Continuous improvement via reflection

---

**Get Started:**
```bash
cd /path/to/Designbrnd
./init-workspace.sh "my-first-project" "My Client"
cd my-first-project
/product-vision
```

**Happy building!** 🎉

---

**Last Updated:** 2026-01-10
**Version:** 1.0
