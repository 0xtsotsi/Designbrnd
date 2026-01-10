# Quick Start Guide
## Getting Your First Client Project Running in 1 Hour

---

## Overview

This guide gets you from zero to running your first client project using the complete workflow (Design OS + Figma MCP + RALPH LOOP + Reflection System).

**Time to First Client Session:** ~60 minutes setup

---

## Step 1: Install & Configure Design OS (15 minutes)

### Clone and Setup

```bash
# Clone Designbrnd repository
git clone https://github.com/yourusername/Designbrnd.git
cd Designbrnd

# Install dependencies
npm install

# Start dev server
npm run dev
```

**Verify:** Open http://localhost:5173 - you should see Design OS interface

### Learn the Commands

Open a Claude Code session in the Designbrnd directory:

```bash
# Discovery commands
/product-vision     # Document client's business vision
/product-roadmap    # Define deliverable sections
/data-model         # Structure data requirements

# Design commands
/design-tokens      # Select colors and typography
/design-shell       # Create app navigation/layout

# Section commands (repeat per section)
/shape-section      # Define section requirements
/sample-data        # Generate realistic content
/design-screen      # Create React component (optional)
/screenshot-design  # Capture design screenshot

# Export command
/export-product     # Generate complete handoff package
```

**Practice:** Run through commands once to understand the flow

---

## Step 2: Install Figma MCP Server (20 minutes)

### Installation

```bash
# Clone Figma MCP Server
git clone https://github.com/Antonytm/figma-mcp-server.git
cd figma-mcp-server

# Install dependencies
npm install

# Build the project
npm run build

# Start MCP server
npm start
```

**Server runs on:** `http://localhost:38450`

### Install Figma Plugin

1. Open Figma Desktop App
2. Go to **Plugins → Development → Import plugin from manifest**
3. Navigate to: `figma-mcp-server/figma-plugin/manifest.json`
4. Plugin appears in **Plugins → Development → Figma MCP Server**

### Test Connection

1. Create a new Figma file
2. Run plugin: **Plugins → Development → Figma MCP Server**
3. Plugin should show: "✓ Connected to MCP server"

**Troubleshooting:** If not connected:
- Verify MCP server is running (`npm start`)
- Check port 38450 is not blocked
- Restart Figma and try again

---

## Step 3: Create cloud.md for Your Projects (5 minutes)

### Copy Template

```bash
# In your Designbrnd directory
cp cloud.md ~/client-project-template/cloud.md
```

The `cloud.md` file contains Figma design rules. Key sections:

- **Component Creation** - Auto-layout, component properties
- **Typography** - Text style hierarchy (H1-H4, Body)
- **Colors** - Color style requirements
- **Spacing** - 8px grid system
- **Naming Conventions** - PascalCase, kebab-case rules

**Customize:** Add your specific preferences to cloud.md

---

## Step 4: Set Up RALPH LOOP Testing (10 minutes)

### Create Test Project

```bash
# Create Next.js project
npx create-next-app@latest client-project --typescript --tailwind --app

cd client-project

# Install Playwright
npm install -D @playwright/test
npx playwright install

# Install shadcn/ui
npx shadcn-ui@latest init
```

**Answer prompts:**
- Style: Default
- Base color: Stone (or your preference)
- CSS variables: Yes

### Create E2E Test Structure

```bash
# Create test directories
mkdir -p e2e/screenshots

# Create first test file
touch e2e/example.spec.ts
```

**Example test:**
```typescript
// e2e/example.spec.ts
import { test, expect } from '@playwright/test';

test('homepage loads', async ({ page }) => {
  await page.goto('/');

  const heading = page.getByTestId('main-heading');
  await expect(heading).toBeVisible();

  await page.screenshot({
    path: 'e2e/screenshots/homepage.png'
  });
});
```

**Run test:**
```bash
npx playwright test
```

---

## Step 5: Configure Claude Reflection System (10 minutes)

### Create Skills Directory

```bash
mkdir -p ~/.claude/skills
cd ~/.claude/skills

# Initialize git
git init
git remote add origin [your-skills-repo-url]
```

### Create Core Skills

```bash
# Create skill directories
mkdir -p client-discovery
mkdir -p brand-design
mkdir -p figma-design
mkdir -p implementation
mkdir -p qa-verification

# Create SKILL.md files
cat > client-discovery/SKILL.md << 'EOF'
# Client Discovery Skill

## Discovery Question Order
1. Target customer (who are they?)
2. Business description (what do you do?)
3. Problems you solve
4. Key features needed
5. Budget and timeline

## Notes
[Skills will learn and update this file over time]
EOF

cat > brand-design/SKILL.md << 'EOF'
# Brand Design Skill

## Industry Color Guidelines
[Will learn from projects]

## Component Standards
[Will learn from projects]
EOF

cat > figma-design/SKILL.md << 'EOF'
# Figma Design Skill

## Figma Best Practices
- Use auto-layout for everything
- Create 3 pages: Brand Guidelines, Components, Screens
- Component naming: PascalCase
- Frame naming: kebab-case

## Learned Patterns
[Will update from corrections]
EOF

cat > implementation/SKILL.md << 'EOF'
# Implementation Skill

## Tech Stack Rules
- UI Components: shadcn/ui
- Framework: Next.js with App Router
- Styling: Tailwind CSS
- Testing: Playwright

## Code Quality
[Will learn from corrections]
EOF

cat > qa-verification/SKILL.md << 'EOF'
# QA Verification Skill

## Screenshot Verification Checklist
1. Text contrast ratio (WCAG AA)
2. Buttons fully visible
3. Spacing matches Figma (8px grid)
4. Responsive behavior works

## Common Issues
[Will learn from fixes]
EOF
```

### Configure Stop Hook (Optional - Auto-Reflection)

**Edit:** `~/.claude/settings.json`

```json
{
  "hooks": {
    "Stop": {
      "hooks": [
        {
          "type": "command",
          "command": "~/.claude/skills/reflect/reflect.sh"
        }
      ]
    }
  }
}
```

**Note:** Start with manual `/reflect` command first, add auto-hook later

---

## Step 6: Run Your First Client Session (Now!)

### Session Workflow

**1. Start Design OS Session**
```bash
cd ~/Designbrnd
# Open in Claude Code
```

**2. Discovery Phase**
```bash
You: /product-vision

Claude: Walks through discovery questions

You: Provide client info (example: Italian Restaurant)

Claude: Creates product-overview.md
```

**3. Roadmap Phase**
```bash
You: /product-roadmap

Claude: Helps define sections

You: Define 5 sections (Homepage, Menu, About, Reservations, Contact)

Claude: Creates product-roadmap.md
```

**4. Design Tokens**
```bash
You: /design-tokens

Claude: Helps select colors and fonts

You: Choose warm colors (Italian restaurant), Playfair Display + Open Sans

Claude: Creates colors.json, typography.json
```

**5. Switch to Figma MCP**

Open Figma, start plugin, then in Claude:

```
You (to Claude with Figma MCP access):
"Using the design tokens from Design OS (colors.json, typography.json)
and following the rules in cloud.md, create a brand guidelines page
in Figma with color palette and typography scale."

Claude + Figma MCP: Creates Figma design in ~10 minutes
```

**6. Review with Mock Client**

Open Figma file, review:
- ✓ Colors match expectations?
- ✓ Typography looks good?
- ✓ Components structured well?

**7. End Session & Reflect**

```bash
You: /reflect brand-design

Claude: Analyzes session, proposes skill updates

You: Review and approve

Claude: Updates SKILL.md, commits to git
```

---

## Quick Reference Card

### Design OS Commands
| Command | Purpose |
|---------|---------|
| `/product-vision` | Document business vision |
| `/product-roadmap` | Define sections |
| `/data-model` | Structure data |
| `/design-tokens` | Select colors/fonts |
| `/shape-section [name]` | Define section requirements |
| `/sample-data` | Generate content |
| `/design-screen [name]` | Create React component |
| `/export-product` | Generate handoff package |

### Figma MCP Prompts
| Task | Prompt Template |
|------|----------------|
| Brand System | "Create brand guidelines and component library using design tokens from colors.json and typography.json" |
| Screen Design | "Create [page name] design using components and following cloud.md rules. Include desktop (1440px) and mobile (375px)" |
| Social Templates | "Create social media template library: Instagram posts, stories, Facebook cover" |
| Iterate | "Update [element] to [changes]" |

### RALPH LOOP Commands
| Command | Purpose |
|---------|---------|
| `pnpm test e2e/[feature].spec.ts` | Run tests for feature |
| `npx shadcn-ui@latest add [component]` | Install shadcn component |
| `ls e2e/screenshots/[feature]/` | List screenshots |
| `mv [file].png verified_[file].png` | Mark screenshot verified |

### Reflection Commands
| Command | Purpose |
|---------|---------|
| `/reflect` | Manual reflection (review and approve) |
| `/reflect on` | Enable auto-reflection hook |
| `/reflect off` | Disable auto-reflection |
| `/reflect status` | Check if enabled |

---

## Common First-Time Issues

### Issue: Figma Plugin Not Connecting

**Solution:**
1. Check MCP server is running: `curl http://localhost:38450`
2. Restart Figma Desktop App
3. Re-run plugin
4. Check firewall isn't blocking port 38450

---

### Issue: Design OS Commands Not Found

**Solution:**
1. Verify you're in Designbrnd directory
2. Check `.claude/commands/design-os/` exists
3. Restart Claude Code session
4. Try typing `/` to see available commands

---

### Issue: RALPH LOOP Tests Fail Immediately

**Solution:**
1. Make sure dev server is running: `npm run dev`
2. Check `playwright.config.ts` has correct base URL
3. Verify components have `data-testid` attributes
4. Run with UI mode to debug: `npx playwright test --ui`

---

### Issue: Reflection Not Working

**Solution:**
1. Start with manual `/reflect` (skip auto-hook initially)
2. Verify skills directory exists: `~/.claude/skills/`
3. Check SKILL.md files are writable
4. Make sure git is initialized in skills directory

---

## Next Steps

After completing your first session:

1. **Review Outputs**
   - Check `product/` directory for generated files
   - Review Figma designs
   - Read skill updates in `~/.claude/skills/`

2. **Refine cloud.md**
   - Add any preferences discovered
   - Document your button/card standards
   - Note industry-specific patterns

3. **Practice RALPH LOOP**
   - Write a simple E2E test
   - Run the test workflow
   - Practice screenshot verification

4. **Run Second Session**
   - Try a different industry (coffee shop, gym, etc.)
   - See what skills learned from first session
   - Note improvements in speed/quality

5. **Scale Up**
   - Build your template library
   - Document your workflow SOP
   - Train team members (if applicable)

---

## Success Checklist

After completing setup, you should be able to:

- [ ] Run Design OS commands and generate product specs
- [ ] Connect to Figma MCP and create designs via AI
- [ ] Write and run E2E tests with Playwright
- [ ] Use `/reflect` to update skills
- [ ] Complete a mock client session end-to-end (1-2 hours)

**Time Investment:** ~60 minutes setup + 2 hours practice = **Ready for real clients**

---

**Next Read:** [Complete Consulting Workflow Guide](./consulting-workflow-guide.md) for detailed phase-by-phase instructions.

---

**Last Updated:** 2026-01-10
**Version:** 1.0
