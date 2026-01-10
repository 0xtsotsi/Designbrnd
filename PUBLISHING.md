# Publishing Webrnds Marketplace to Claude Code

Guide for publishing the Webrnds marketplace to the official Claude Code marketplace system.

---

## Prerequisites

1. **GitHub Repository**
   - Repository: https://github.com/0xtsotsi/Designbrnd
   - Must be public
   - Contains all necessary files

2. **Required Files**
   - ✅ `webrnds-marketplace.json` - Marketplace manifest
   - ✅ `install.sh` - Complete installation script
   - ✅ `MARKETPLACE.md` - Marketplace documentation
   - ✅ All plugin files and documentation

3. **Accounts**
   - GitHub account
   - Claude Code account (if required for marketplace submission)

---

## Marketplace Manifest

The `webrnds-marketplace.json` file defines your marketplace:

```json
{
  "marketplace": {
    "id": "webrnds",
    "name": "Webrnds Marketplace",
    "version": "1.0.0",
    "description": "Complete AI-powered consulting workflow automation",
    "author": {...},
    "repository": "https://github.com/0xtsotsi/Designbrnd"
  },
  "plugins": [...],
  "workflows": [...],
  "documentation": {...}
}
```

**Key fields:**
- `id`: Unique marketplace identifier
- `name`: Display name
- `version`: Semantic version (1.0.0)
- `repository`: GitHub repo URL
- `plugins`: Array of plugin definitions
- `workflows`: Pre-configured workflows

---

## Publishing Steps

### Step 1: Verify Repository Structure

Ensure your repository has this structure:

```
Designbrnd/
├── webrnds-marketplace.json    # Marketplace manifest
├── install.sh                  # Installation script
├── MARKETPLACE.md              # Documentation
├── PUBLISHING.md               # This file
├── init-workspace.sh           # Workspace initializer
├── cloud.md                    # Figma design rules
├── .claude/
│   ├── commands/
│   │   ├── design-os/          # Design OS commands
│   │   ├── marketplace.md      # Marketplace command
│   │   ├── ralph-loop.md       # RALPH LOOP command
│   │   └── reflect.md          # Reflection command
│   ├── hooks/
│   │   └── user-prompt-submit-beads.sh
│   └── marketplace/
│       └── registry.json
└── docs/
    ├── consulting-workflow-guide.md
    ├── quick-start-guide.md
    ├── workspace-initialization-guide.md
    └── architecture-diagram.md
```

### Step 2: Test Installation Locally

Before publishing, test the installation script:

```bash
# Test complete installation
bash install.sh

# Verify all files installed
ls ~/.claude/commands/design-os/
ls ~/.claude/skills/
ls ~/.local/bin/designbrnd-init

# Test workspace initialization
designbrnd-init "test-project" "Test Client"
cd test-project
/product-vision
```

**Verify:**
- ✅ All commands available
- ✅ Skills created
- ✅ Workspace initializer works
- ✅ Documentation accessible

### Step 3: Create GitHub Release

```bash
# Tag the release
git tag -a v1.0.0 -m "Webrnds Marketplace v1.0.0 - Initial release"
git push origin v1.0.0

# Create GitHub release
# Go to: https://github.com/0xtsotsi/Designbrnd/releases/new
```

**Release notes template:**

```markdown
# Webrnds Marketplace v1.0.0

Complete AI-powered consulting workflow automation for Claude Code.

## What's Included

- **Design OS Commands** - 8 planning & design commands
- **Figma MCP Integration** - AI-powered design automation
- **RALPH LOOP** - Test-driven development workflow
- **Reflection Skills** - 5 learning modules
- **Beads Integration** - Git-backed task tracking
- **Workspace Initializer** - One-command project setup

## Installation

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/0xtsotsi/Designbrnd/main/install.sh)
```

## Quick Start

```bash
designbrnd-init "my-project" "Client Name"
cd my-project
/product-vision
```

## Documentation

- [Marketplace README](./MARKETPLACE.md)
- [Quick Start Guide](./docs/quick-start-guide.md)
- [Workflow Guide](./docs/consulting-workflow-guide.md)

## What's New in v1.0.0

- Initial marketplace release
- Complete workflow automation
- 6-week consulting workflow
- Meta-learning reflection system
- Git-backed task tracking
```

### Step 4: Submit to Claude Code Marketplace

**Method 1: Official Submission Form**

If Claude Code has a marketplace submission form:

1. Go to marketplace submission page
2. Fill out form with:
   - Marketplace ID: `webrnds`
   - Name: Webrnds Marketplace
   - Repository: https://github.com/0xtsotsi/Designbrnd
   - Manifest URL: https://raw.githubusercontent.com/0xtsotsi/Designbrnd/main/webrnds-marketplace.json
   - Installation URL: https://raw.githubusercontent.com/0xtsotsi/Designbrnd/main/install.sh
3. Submit for review

**Method 2: Pull Request to Official Registry**

If Claude Code uses a centralized registry:

1. Fork the official marketplace registry repository
2. Add your marketplace entry:
```json
{
  "marketplaces": [
    {
      "id": "webrnds",
      "name": "Webrnds Marketplace",
      "manifest": "https://raw.githubusercontent.com/0xtsotsi/Designbrnd/main/webrnds-marketplace.json",
      "install": "https://raw.githubusercontent.com/0xtsotsi/Designbrnd/main/install.sh",
      "description": "Complete AI-powered consulting workflow automation",
      "author": "Webrnds",
      "repository": "https://github.com/0xtsotsi/Designbrnd",
      "version": "1.0.0"
    }
  ]
}
```
3. Submit pull request
4. Wait for review and approval

**Method 3: Community Announcement**

If Claude Code has community forums/discussions:

1. Post announcement in marketplace forum
2. Include:
   - Marketplace description
   - Installation instructions
   - Link to repository
   - Link to documentation
3. Engage with community feedback

---

## Marketplace URLs

Once published, your marketplace will be accessible via:

```
# Marketplace manifest
https://raw.githubusercontent.com/0xtsotsi/Designbrnd/main/webrnds-marketplace.json

# Installation script
https://raw.githubusercontent.com/0xtsotsi/Designbrnd/main/install.sh

# Documentation
https://github.com/0xtsotsi/Designbrnd/blob/main/MARKETPLACE.md
```

Users can install with:

```bash
# Quick install
bash <(curl -fsSL https://raw.githubusercontent.com/0xtsotsi/Designbrnd/main/install.sh)

# Or via Claude Code (if integrated)
claude marketplace install webrnds
```

---

## Post-Publishing

### Announce on Social Media

**Twitter/X:**
```
🚀 Just launched Webrnds Marketplace for @ClaudeCode!

Complete AI-powered consulting workflow:
- Design OS (planning)
- Figma MCP (AI design)
- RALPH LOOP (test-driven dev)
- Reflection AI (learning)
- Beads (task tracking)

Install: [link]
Docs: [link]

#ClaudeCode #AIAutomation #Consulting
```

**LinkedIn:**
```
Excited to announce Webrnds Marketplace for Claude Code! 🎉

We've created a complete consulting workflow automation system that:
- Reduces project timelines from 12-16 weeks to 6 weeks
- Automates design creation with AI
- Guarantees pixel-perfect quality through test-driven development
- Learns and improves with every project

Perfect for consultants, agencies, and freelancers helping clients with websites, apps, and digital products.

Install in 2 minutes: [link]
Full workflow guide: [link]

[Add visual: workflow diagram or demo screenshot]
```

### Create Demo Video

Record a 5-10 minute demo showing:
1. Installation (`bash install.sh`)
2. Project initialization (`designbrnd-init`)
3. Running through discovery (`/product-vision`, `/product-roadmap`)
4. Creating designs with Figma MCP
5. RALPH LOOP in action
6. Reflection system learning

Upload to YouTube and link in README.

### Blog Post

Write a detailed blog post covering:
- Problem: Traditional consulting pain points
- Solution: Automated workflow
- Tools: Each plugin explained
- Results: Time savings, ROI, quality improvements
- Getting started: Installation and first project

---

## Versioning

Follow semantic versioning (semver):

**Format:** MAJOR.MINOR.PATCH

**Examples:**
- `1.0.0` - Initial release
- `1.0.1` - Bug fix (backward compatible)
- `1.1.0` - New feature (backward compatible)
- `2.0.0` - Breaking change

**Update process:**
1. Update `version` in `webrnds-marketplace.json`
2. Update `version` in each plugin definition
3. Update MARKETPLACE.md with changes
4. Git tag: `git tag -a v1.1.0 -m "Version 1.1.0"`
5. Push: `git push origin v1.1.0`
6. Create GitHub release
7. Update marketplace registry (if applicable)

---

## Maintenance

### Regular Updates

**Monthly:**
- Review and respond to GitHub issues
- Update documentation based on user feedback
- Check for dependency updates
- Test installation on clean systems

**Quarterly:**
- Review and update workflow guides
- Add new features or plugins
- Update version numbers
- Announce updates

### Community Engagement

**GitHub:**
- Monitor issues and pull requests
- Respond within 24-48 hours
- Accept community contributions
- Maintain issue templates

**Documentation:**
- Keep guides updated
- Add FAQ based on common questions
- Create troubleshooting guides
- Add examples and case studies

---

## Metrics to Track

**Installation Metrics:**
- Number of installs (if available)
- GitHub stars
- GitHub forks
- Repository clones

**Engagement Metrics:**
- GitHub issues opened
- Pull requests submitted
- Discussions started
- Documentation page views

**Quality Metrics:**
- Issue resolution time
- PR merge rate
- User feedback sentiment
- Bug reports vs. feature requests

---

## Support Channels

**GitHub Issues:**
- Bug reports
- Feature requests
- Questions

**GitHub Discussions:**
- General questions
- Show and tell
- Ideas and suggestions

**Documentation:**
- README.md - Overview
- MARKETPLACE.md - Plugin details
- docs/ - Detailed guides

---

## Troubleshooting Common Issues

### Installation Fails

**Issue:** `install.sh` fails with permission errors

**Solution:**
```bash
# Make executable
chmod +x install.sh

# Run with bash explicitly
bash install.sh
```

### Commands Not Available

**Issue:** `/product-vision` not found

**Solution:**
```bash
# Check if commands installed
ls ~/.claude/commands/design-os/

# Restart Claude Code session

# Manually copy if needed
cp -r .claude/commands/design-os ~/.claude/commands/
```

### Figma MCP Not Connecting

**Issue:** Figma plugin shows "Not connected"

**Solution:**
See `~/.claude/mcp-servers/figma-mcp.json` for full setup instructions.

---

## Legal & Compliance

### License

MIT License - Allows commercial and private use, modification, distribution.

### Attribution

If using external tools:
- Figma MCP Server: https://github.com/Antonytm/figma-mcp-server
- Beads: https://github.com/steveyegge/beads

### Privacy

- No data collection
- All processing local
- Git-backed storage (user-controlled)

---

## Contact & Support

**Maintainer:** Webrnds
**Repository:** https://github.com/0xtsotsi/Designbrnd
**Issues:** https://github.com/0xtsotsi/Designbrnd/issues
**Discussions:** https://github.com/0xtsotsi/Designbrnd/discussions

---

**Ready to publish?** Follow the steps above and launch your marketplace! 🚀
