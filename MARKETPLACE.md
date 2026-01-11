# Webrnds Marketplace

**Complete AI-Powered Consulting Workflow Automation**

Official marketplace for Design OS, Figma MCP, RALPH LOOP, Reflection System, and Beads integration tools.

---

## 🚀 Quick Install

### Complete Bundle (Recommended)

Install everything by downloading and running the install script:

```bash
# Download the install script
curl -fsSL https://raw.githubusercontent.com/0xtsotsi/Designbrnd/main/install.sh -o install.sh

# Review the script (recommended)
less install.sh

# Run the installation
bash install.sh
```

This installs:
- ✅ Design OS Commands (8 planning & design commands)
- ✅ Figma MCP Integration (AI-powered design automation)
- ✅ RALPH LOOP (Test-driven development workflow)
- ✅ Reflection Skills (5 learning modules that improve over time)
- ✅ Beads Integration (Git-backed task tracking)
- ✅ Workspace Initializer (One-command project setup)

**Installation Time:** ~2-3 minutes

---

## 📦 Individual Plugins

### 1. Design OS Commands

**What it does:** Structured planning and design documentation system

**Commands:**
- `/product-vision` - Document business goals and vision
- `/product-roadmap` - Define deliverable sections
- `/data-model` - Structure data entities
- `/design-tokens` - Select brand colors and typography
- `/shape-section` - Define section requirements
- `/sample-data` - Generate realistic content
- `/design-screen` - Create React component prototypes
- `/export-product` - Generate complete handoff package

**Install:**
```bash
# Included in complete bundle, or install manually:
git clone https://github.com/0xtsotsi/Designbrnd.git
cp -r Designbrnd/.claude/commands/design-os ~/.claude/commands/
```

**Category:** Design, Planning
**Tags:** planning, design, documentation

---

### 2. Figma MCP Integration

**What it does:** AI-powered Figma design automation with write capabilities

**Features:**
- Create components via AI commands
- Generate brand guidelines automatically
- Design screens from specs
- Apply design tokens (colors, typography)
- Use cloud.md design rules

**Install:**
```bash
# Clone Figma MCP Server
git clone https://github.com/Antonytm/figma-mcp-server.git
cd figma-mcp-server
npm install && npm run build

# Start server
npm start  # Runs on http://localhost:38450

# Install Figma plugin
# Figma Desktop → Plugins → Development → Import manifest
# Select: figma-mcp-server/figma-plugin/manifest.json

# Copy cloud.md design rules
cp Designbrnd/cloud.md ./cloud.md
```

**Requirements:**
- Node.js 18+
- Figma Desktop app
- Figma MCP Server running

**Category:** Design, Automation
**Tags:** figma, design, automation, mcp

---

### 3. RALPH LOOP - Test-Driven Development

**What it does:** Test-driven development workflow with visual verification

**Workflow:**
1. Write E2E tests encoding Figma designs
2. Run tests → FAIL (no implementation)
3. AI implements components
4. Run tests → PASS
5. AI verifies screenshots vs. Figma
6. Fix visual issues
7. Mark verified
8. Output: `<promise>FEATURE_DONE</promise>`

**Features:**
- Playwright E2E testing
- Visual regression testing
- Screenshot verification
- Pixel-perfect quality guarantee

**Install:**
```bash
# Included in complete bundle, or in any Next.js project:
npm install -D @playwright/test
npx playwright install chromium
npx shadcn@latest init
```

**Category:** Development, Testing
**Tags:** testing, tdd, quality, automation

---

### 4. Reflection Skills System

**What it does:** Meta-learning system that improves from corrections

**Skills:**
1. **Client Discovery** - Learns discovery question patterns
2. **Brand Design** - Learns industry colors and component standards
3. **Figma Design** - Learns cloud.md preferences and naming
4. **Implementation** - Learns tech stack and code structure
5. **QA Verification** - Learns screenshot verification criteria

**How it works:**
- During session: You correct Claude
- End of session: Run `/reflect <skill-name>`
- AI analyzes corrections and proposes updates
- Skills improve with every project

**Commands:**
- `/reflect <skill-name>` - Update specific skill
- `/reflect on` - Enable auto-reflection
- `/reflect off` - Disable auto-reflection

**Install:**
```bash
# Included in complete bundle
# Skills stored in ~/.claude/skills/
```

**Category:** Productivity, Learning
**Tags:** learning, ai, improvement, skills

---

### 5. Beads Integration

**What it does:** Git-backed task tracking with persistent memory for AI agents

**Features:**
- Task dependencies and tracking
- Persistent memory across sessions
- Git-backed storage (version controlled)
- Auto-displays next ready task
- 6-week project template

**Commands:**
- `bd init` - Initialize project
- `bd ready` - Show ready tasks
- `bd status` - Show progress
- `bd done <id>` - Mark task complete

**Install:**
```bash
# Install Beads from official repo
# See: https://github.com/steveyegge/beads

# Hook auto-installed with complete bundle
# Or manually add to ~/.claude/settings.json
```

**Category:** Project Management
**Tags:** project-management, tasks, git, memory
**Optional:** Yes

---

### 6. Workspace Initializer

**What it does:** One-command workspace setup for complete workflow

**Usage:**
```bash
designbrnd-init "project-name" "Client Name"
```

**What it creates:**
- Complete Next.js project with TypeScript
- Design OS product structure
- Playwright E2E testing
- Reflection skills
- Beads project template
- cloud.md design rules
- Documentation and README

**Install:**
```bash
# Included in complete bundle as 'designbrnd-init' command
```

**Category:** Productivity, Setup
**Tags:** setup, automation, initialization

---

## 🔄 Complete Workflow

### 6-Week Consulting Workflow

**Week 1: Discovery & Planning**
- Use: Design OS Commands
- Run: `/product-vision`, `/product-roadmap`, `/data-model`
- Deliverable: Product specs and data model

**Week 2: Brand System Design**
- Use: Design OS + Figma MCP
- Run: `/design-tokens`, then AI creates brand system in Figma
- Deliverable: Brand guidelines and component library

**Week 3: Screen Design**
- Use: Design OS + Figma MCP
- Run: `/shape-section`, `/sample-data`, then AI creates screens
- Deliverable: Figma screen designs (desktop + mobile)

**Week 4-5: Implementation**
- Use: RALPH LOOP + Design OS
- Run: `/export-product`, write E2E tests, RALPH LOOP workflow
- Deliverable: Implemented features with passing tests

**Week 6: Launch**
- Deploy to production
- Client handoff
- Documentation

**Initialize workflow:**
```bash
designbrnd-init "client-project" "Client Name"
cd client-project
/product-vision  # Start working
```

---

## 📖 Documentation

**Installed with complete bundle to `~/.claude/docs/webrnds/`:**

- **quick-start-guide.md** - 60-minute quickstart
- **consulting-workflow-guide.md** - Complete workflow details
- **workspace-initialization-guide.md** - Setup walkthrough
- **tool-integration-reference.md** - Technical reference
- **architecture-diagram.md** - System architecture

**Online:**
- Repository: https://github.com/0xtsotsi/Designbrnd
- Issues: https://github.com/0xtsotsi/Designbrnd/issues
- Discussions: https://github.com/0xtsotsi/Designbrnd/discussions

---

## 🛠️ Requirements

### System Requirements
- **Node.js:** 18.0.0 or higher
- **npm:** 9.0.0 or higher
- **Git:** Any recent version
- **jq:** For JSON processing

### Optional
- **Figma Desktop:** 116.0.0+ (for Figma MCP)
- **Beads:** For task tracking

### Supported Platforms
- macOS
- Linux
- Windows (WSL2)

---

## 🔧 Configuration

### Enable Beads Hook

Add to `~/.claude/settings.json`:

```json
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

### Enable Auto-Reflection

```bash
/reflect on
```

Or add to `~/.claude/settings.json`:

```json
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

---

## 📊 Benefits

### Speed Improvements
- **Brand Design:** 10 mins vs. 2-4 hours (80% faster)
- **Screen Design:** 15 mins vs. 3-5 hours per screen (95% faster)
- **Overall Project:** 6 weeks vs. 12-16 weeks (2-3x faster)

### Quality Improvements
- Pixel-perfect implementation (RALPH LOOP)
- Automated visual QA
- Client approval before implementation
- Consistent professional quality

### Learning Improvements
- Reflection system captures corrections
- Skills improve with every project
- By project 10: ~20 hours saved from learnings

### ROI
- **Per Client:** 70 hours saved = 8.75 workdays
- **Annual (20 clients):** 1,400 hours = $70,000-$140,000 value

---

## 🚀 Getting Started

### 1. Install Complete Bundle

```bash
# Download the install script
curl -fsSL https://raw.githubusercontent.com/0xtsotsi/Designbrnd/main/install.sh -o install.sh

# Review the script (recommended)
less install.sh

# Run the installation
bash install.sh
```

### 2. Initialize First Project

```bash
designbrnd-init "my-first-project" "My Client"
cd my-first-project
```

### 3. Start Discovery

```bash
/product-vision
# Answer questions, generates product-overview.md

/product-roadmap
# Define sections

/data-model
# Structure data
```

### 4. Continue Through Weeks

Follow the 6-week workflow documented in the guides.

---

## 🤝 Contributing

We welcome contributions to the Webrnds marketplace!

**How to contribute:**
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

**Ideas for contributions:**
- New skills for Reflection System
- Additional Design OS commands
- Workflow templates
- Documentation improvements
- Bug fixes

---

## 📜 License

MIT License - See LICENSE file for details

---

## 🆘 Support

**Issues:** https://github.com/0xtsotsi/Designbrnd/issues
**Discussions:** https://github.com/0xtsotsi/Designbrnd/discussions
**Documentation:** https://github.com/0xtsotsi/Designbrnd/tree/main/docs

---

## 🎯 Marketplace Information

**Marketplace ID:** `webrnds`
**Version:** 1.0.0
**Author:** Webrnds
**Repository:** https://github.com/0xtsotsi/Designbrnd
**License:** MIT

**Categories:**
- Design
- Development
- Project Management
- Productivity

**Keywords:**
design, consulting, automation, figma, testing, workflow, ai-agents, project-management

---

**Last Updated:** 2026-01-10
**Marketplace Version:** 1.0.0
