# Marketplace Command

Browse, install, and configure MCPs, skills, hooks, and tools for the Designbrnd workflow.

## Usage

```bash
/marketplace              # Show all available tools
/marketplace install      # Install specific tool
/marketplace list         # List installed tools
/marketplace info <id>    # Get detailed info about a tool
```

## Available Categories

- **MCP Servers** - Model Context Protocol servers for AI capabilities
- **Skills** - Learning modules that improve over time
- **Hooks** - Event-triggered automation scripts
- **Tools** - Development and project management tools
- **Workflows** - Complete multi-tool workflows

## Quick Install

### Complete Workspace Setup
```bash
# Initialize new client project with ALL tools
./init-workspace.sh "project-name" "Client Name"
```

### Individual Tools

**Design OS:**
```bash
# Commands already available in .claude/commands/design-os/
/product-vision
/product-roadmap
/data-model
```

**Figma MCP Server:**
```bash
# Clone and setup
git clone https://github.com/Antonytm/figma-mcp-server.git
cd figma-mcp-server && npm install && npm run build
npm start  # Runs on port 38450

# Install Figma plugin (Figma Desktop → Plugins → Development → Import)
```

**RALPH LOOP:**
```bash
# Configured via init-workspace.sh
# Or manually:
npm install -D @playwright/test
npx playwright install chromium
npx shadcn@latest init
```

**Reflection System:**
```bash
# Skills auto-created in ~/.claude/skills/
/reflect [skill-name]      # Manual reflection
/reflect on                # Enable auto-reflection
```

**Beads:**
```bash
# Install from: https://github.com/steveyegge/beads
# Then in project:
bd init
bd create epic "6-Week Project"
```

## Registry

All available tools are cataloged in:
```
.claude/marketplace/registry.json
```

## MCP Servers

### Figma MCP
- **Purpose:** AI-powered Figma design automation
- **Port:** 38450
- **Protocol:** WebSocket
- **Tools:** 23 design manipulation tools
- **Integration:** Design OS, claude.md, Beads

## Skills

### Client Discovery
- **Learns:** Question patterns, industry requirements
- **Triggers:** /product-vision, client intake
- **File:** ~/.claude/skills/client-discovery/SKILL.md

### Brand Design
- **Learns:** Industry colors, component standards
- **Triggers:** /design-tokens, Figma design
- **File:** ~/.claude/skills/brand-design/SKILL.md

### Figma Design
- **Learns:** claude.md patterns, naming conventions
- **Triggers:** Figma MCP usage
- **File:** ~/.claude/skills/figma-design/SKILL.md

### Implementation
- **Learns:** Tech stack, code structure
- **Triggers:** Code implementation, RALPH LOOP
- **File:** ~/.claude/skills/implementation/SKILL.md

### QA Verification
- **Learns:** Screenshot checks, visual bugs
- **Triggers:** RALPH LOOP verification
- **File:** ~/.claude/skills/qa-verification/SKILL.md

## Hooks

### Auto-Reflection (Stop Hook)
- **Event:** When Claude stops responding
- **Action:** Captures learnings, updates skills
- **Enable:** /reflect on
- **File:** ~/.claude/hooks/stop-hook-reflect.sh

### Git Commit Checker (Stop Hook)
- **Event:** When Claude stops responding
- **Action:** Checks for untracked files
- **Status:** Enabled by default
- **File:** ~/.claude/hooks/stop-hook-git-check.sh

### Beads Task Tracker (UserPromptSubmit Hook)
- **Event:** When user submits prompt
- **Action:** Shows next ready task from Beads
- **Requires:** Beads (bd command)
- **File:** ~/.claude/hooks/user-prompt-submit-beads.sh

## Tools

### Beads Project Tracker
- **Purpose:** Git-backed task tracking for AI agents
- **Features:** Dependencies, memory decay, multi-agent
- **Commands:** `bd ready`, `bd status`, `bd done`
- **Repository:** https://github.com/steveyegge/beads

### RALPH LOOP
- **Purpose:** Test-driven development with visual QA
- **Technologies:** Playwright, Next.js, shadcn/ui
- **Workflow:** Test → Implement → Verify → Promise
- **Command:** /ralph-loop (for guidance)

## Workflows

### 6-Week Consulting Workflow
1. **Week 1:** Discovery (Design OS)
2. **Week 2:** Brand Design (Design OS + Figma MCP)
3. **Week 3:** Screen Design (Design OS + Figma MCP)
4. **Week 4-5:** Implementation (RALPH LOOP)
5. **Week 6:** Launch

**Initialize with:**
```bash
./init-workspace.sh "client-project" "Client Name"
```

## Custom Configuration

### Add Your Own MCP Server

Edit `.claude/marketplace/registry.json`:

```json
{
  "mcp_servers": [
    {
      "id": "your-mcp",
      "name": "Your MCP Server",
      "description": "Description",
      "port": 3000,
      "setup_command": "setup-your-mcp.sh",
      "tools": ["tool1", "tool2"]
    }
  ]
}
```

### Add Custom Skill

1. Create directory: `~/.claude/skills/your-skill/`
2. Create SKILL.md with your learning patterns
3. Add to registry.json
4. Use with `/reflect your-skill`

### Add Custom Hook

1. Create script: `.claude/hooks/your-hook.sh`
2. Make executable: `chmod +x .claude/hooks/your-hook.sh`
3. Add to `~/.claude/settings.json`:
```json
{
  "hooks": {
    "YourEvent": {
      "hooks": [
        {
          "type": "command",
          "command": "~/.claude/hooks/your-hook.sh"
        }
      ]
    }
  }
}
```

## Documentation

- **Workflow Guide:** docs/consulting-workflow-guide.md
- **Quick Start:** docs/quick-start-guide.md
- **Technical Reference:** docs/tool-integration-reference.md
- **Presentation:** slides.md (Slidev format)

## Support

- **Repository:** https://github.com/0xtsotsi/Designbrnd
- **Issues:** https://github.com/0xtsotsi/Designbrnd/issues
- **Registry:** .claude/marketplace/registry.json

---

**Quick Start:**
```bash
# Initialize complete workspace
./init-workspace.sh "my-project" "Client Name"

# Start working
/product-vision
```
