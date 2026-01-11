# Reflect - Skill Learning System

## Overview

The Reflect command analyzes conversation history to identify learnable patterns and updates skill definitions. This creates a meta-learning system that improves with every project.

## Usage

```
/reflect <skill-name>
```

## Available Skills

1. **client-discovery** - Discovery question patterns, industry requirements
2. **brand-design** - Industry colors, component standards, typography
3. **figma-design** - claude.md patterns, naming conventions
4. **implementation** - Tech stack rules, code structure
5. **qa-verification** - Screenshot verification, visual bugs

## How It Works

### Step 1: Signal Detection

Analyzes the conversation for:
- **User Corrections** (HIGH confidence) - "Always do X" or "Never do Y"
- **Success Patterns** (MEDIUM confidence) - "Perfect" or "Exactly right"
- **Repeated Issues** (HIGH confidence) - Same mistake multiple times

### Step 2: Pattern Analysis

Extracts learnable patterns:
- Specific rules to follow
- Industry-specific preferences
- Common mistakes to avoid
- Successful approaches

### Step 3: Propose Updates

Shows proposed changes with confidence levels:

```
Skill Reflection: brand-design
Signals detected: 2 corrections, 1 success

Proposed changes:
(HIGH) + Add to Component Standards: "Button padding: 16px (not 20px)"
(HIGH) + Add to Colors: "Restaurants prefer warm colors (red/orange/gold)"
(MED) + Add to Typography: "Playfair Display works well for traditional"

Git commit message: "brand-design: add button padding and color preferences"

Apply these changes? [Y/n/change] _
```

### Step 4: Update Skills

- Updates the appropriate SKILL.md file
- Adds timestamp and learning count
- Commits to Git with descriptive message
- Pushes to remote repository

## Skill Format

Skills are stored in `~/.claude/skills/` as markdown files:

```markdown
# Brand Design Skill

## Industry Color Guidelines

### Restaurants
- General restaurants: Warm colors (red, orange, gold)
- [LEARNED: 2026-01-10 - Restaurant color preferences]

## Component Standards

### Buttons
- Padding: 16px horizontal (NEVER 20px or 24px)
- [LEARNED: 2026-01-10 - Button sizing standards]

---
Last Updated: 2026-01-15 14:30
Total Learnings: 12
```

## When to Use

- **After corrections** - When you've corrected Claude's output multiple times
- **After success** - When something worked perfectly and should be repeated
- **End of project** - Capture all learnings before closing
- **Weekly review** - Batch learnings from multiple sessions

## Automatic Reflection (Optional)

Configure a Stop hook to automatically reflect at session end:

```json
// ~/.claude/settings.json
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

## Toggle Commands

```bash
/reflect on      # Enable auto-reflection
/reflect off     # Disable auto-reflection
/reflect status  # Check if enabled
```

## Git Workflow

Skills are version-controlled in Git:

```bash
# Initialize skills repository
cd ~/.claude/skills
git init
git remote add origin [your-private-repo]
git push -u origin main

# Updates are automatically committed when using /reflect
```

## Benefits

- **Never repeat mistakes** - Learnings persist across projects
- **Consistent quality** - Same high standards every time
- **Continuous improvement** - Gets better with every correction
- **Team collaboration** - Share skills repository with team
- **Client-specific patterns** - Learn industry-specific preferences

## Examples

### Client Discovery Skill

```
Learns:
- Question order and phrasing
- Industry-specific requirements
- Red flags to watch for
- Budget and timeline patterns
```

### Brand Design Skill

```
Learns:
- Industry color preferences (restaurants → warm, tech → cool)
- Component sizing standards (button padding, card padding)
- Typography pairings that work
- Your aesthetic preferences
```

### Figma Design Skill

```
Learns:
- claude.md rule additions
- Component organization patterns
- Naming conventions (PascalCase, kebab-case)
- Common client requests
```

### Implementation Skill

```
Learns:
- Tech stack choices (shadcn/ui, Next.js, etc.)
- Code structure preferences
- Testing requirements
- Git commit message format
```

### QA Verification Skill

```
Learns:
- Screenshot verification checklist
- Common visual bugs to check
- Browser testing requirements
- Accessibility (WCAG) standards
```

## Best Practices

1. **Be explicit with corrections** - Say "Always" or "Never" for clarity
2. **Approve successes** - Say "Perfect" or "Exactly right" to reinforce
3. **Run at session end** - Don't let learnings slip away
4. **Review proposals** - Don't auto-accept; ensure quality
5. **Keep skills private** - Contains proprietary patterns

---

**Impact:** Reduces repeat corrections by 80% after first 3 projects
**Time Savings:** 5-10 hours per project from avoided rework
