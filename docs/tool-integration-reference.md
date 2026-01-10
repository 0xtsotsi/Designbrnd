# Tool Integration Reference
## Technical Documentation for Design OS Workflow Tools

---

## Overview

This document provides technical details for integrating the four core tools in the automated consulting workflow:

1. **Design OS** - React-based planning and design documentation tool
2. **Figma MCP Server** - AI-powered Figma design automation
3. **RALPH LOOP** - Test-driven development workflow with visual verification
4. **Claude Reflection System** - Meta-learning skill improvement system

---

## Tool 1: Design OS

### Architecture

**Technology Stack:**
- React 19.2.0
- TypeScript 5.9.3
- Vite 7.2.4
- Tailwind CSS v4.1.17
- React Router DOM 7.9.6
- shadcn/ui component library

**Core Concept:**
Build-time file loading using Vite's `import.meta.glob()` to treat files as data layer.

**Data Flow:**
```
User Input (markdown/JSON) → Build-time Glob → Loaders → React Components → UI
```

### Directory Structure

```
Designbrnd/
├── src/                          # React application
│   ├── components/               # UI components
│   │   ├── ui/                   # shadcn/ui base components
│   │   ├── ProductPage.tsx       # Product overview page
│   │   ├── DataModelPage.tsx     # Data model visualization
│   │   ├── DesignPage.tsx        # Design system page
│   │   ├── SectionsPage.tsx      # Sections list
│   │   ├── SectionPage.tsx       # Section detail page
│   │   └── ExportPage.tsx        # Export package page
│   │
│   ├── lib/                      # Data loaders
│   │   ├── product-loader.ts     # Load product overview, roadmap
│   │   ├── section-loader.ts     # Load section specs, data
│   │   ├── design-system-loader.ts # Load colors, typography
│   │   └── router.tsx            # React Router config
│   │
│   └── types/                    # TypeScript interfaces
│       ├── product.ts            # Product types
│       └── section.ts            # Section types
│
├── product/                      # User's product definition (input)
│   ├── product-overview.md       # Business vision
│   ├── product-roadmap.md        # Sections/phases
│   ├── data-model/
│   │   └── data-model.md         # Entities and relationships
│   ├── design-system/
│   │   ├── colors.json           # Color palette
│   │   └── typography.json       # Font selections
│   └── sections/                 # Per-section content
│       └── [section-id]/
│           ├── spec.md           # Requirements
│           ├── data.json         # Sample data
│           └── *.png             # Screenshots
│
├── product-plan/                 # Export output (generated)
│   ├── prompts/                  # AI prompts
│   ├── instructions/             # Implementation guides
│   └── ...
│
└── .claude/                      # Claude integration
    └── commands/design-os/       # Command definitions
        ├── product-vision.md
        ├── product-roadmap.md
        ├── data-model.md
        ├── design-tokens.md
        ├── shape-section.md
        ├── sample-data.md
        ├── design-screen.md
        └── export-product.md
```

### Key Commands

#### /product-vision
**Purpose:** Document business vision and goals

**Process:**
1. AI asks discovery questions
2. User provides answers
3. AI generates `product/product-overview.md`

**Output Format:**
```markdown
# [Product Name]

## Description
[Business description]

## Problems We Solve
1. [Problem 1]
2. [Problem 2]

## Key Features
1. [Feature 1]
2. [Feature 2]

## Target Audience
[Target customer description]
```

**Integration Point:** Output used by Figma MCP for context-aware design

---

#### /product-roadmap
**Purpose:** Define deliverable sections/phases

**Output Format:**
```markdown
# Product Roadmap

## Sections
1. **[Section Name]** - [Description]
2. **[Section Name]** - [Description]
```

**Integration Point:** Sections become screens in Figma MCP

---

#### /data-model
**Purpose:** Define data entities and relationships

**Output Format:**
```markdown
# Data Model

## Entities

### [Entity Name]
**Description:** [What it represents]

**Properties:**
- [property]: [type] - [description]
```

**Integration Point:** Used for TypeScript type generation and sample data

---

#### /design-tokens
**Purpose:** Select colors and typography

**Output Files:**
- `product/design-system/colors.json`
- `product/design-system/typography.json`

**colors.json Format:**
```json
{
  "primary": {
    "name": "Red",
    "value": "#DC2626",
    "tailwind": "red"
  },
  "secondary": {
    "name": "Gold",
    "value": "#F59E0B",
    "tailwind": "amber"
  }
}
```

**typography.json Format:**
```json
{
  "display": {
    "name": "Playfair Display",
    "googleFont": "Playfair+Display:wght@400;600;700"
  },
  "body": {
    "name": "Open Sans",
    "googleFont": "Open+Sans:wght@400;600;700"
  }
}
```

**Integration Point:** Consumed by Figma MCP to create color/text styles

---

#### /shape-section [name]
**Purpose:** Define section requirements

**Output:** `product/sections/[name]/spec.md`

**Format:**
```markdown
# [Section Name]

## Purpose
[What this section does]

## User Flow
1. [Step 1]
2. [Step 2]

## UI Requirements
- [Requirement 1]
- [Requirement 2]

## Components Needed
- [Component 1]
- [Component 2]
```

**Integration Point:** Used by Figma MCP to design screens

---

#### /sample-data
**Purpose:** Generate realistic sample content

**Output:** `product/sections/[name]/data.json`

**Format:**
```json
{
  "items": [
    {
      "id": "1",
      "title": "Example Item",
      "description": "Realistic description..."
    }
  ]
}
```

**Integration Point:** Used in Figma designs and React components

---

#### /export-product
**Purpose:** Generate complete handoff package

**Output:** `product-plan.zip` containing:
- `prompts/` - Ready-to-use AI prompts
- `instructions/` - Implementation guides
- `design-system/` - Color/typography tokens
- `data-model/` - TypeScript types
- `sections/` - Component exports

**Integration Point:** Handoff to developers or AI coding agents

---

### API Integration

**Loading Product Data:**
```typescript
// src/lib/product-loader.ts
import { parseProductOverview } from './parsers';

export function loadProductData() {
  const files = import.meta.glob('/product/product-overview.md', {
    as: 'raw',
    eager: true
  });

  const content = Object.values(files)[0];
  return parseProductOverview(content);
}
```

**Using in React:**
```typescript
// src/components/ProductPage.tsx
import { loadProductData } from '@/lib/product-loader';

export function ProductPage() {
  const productData = useMemo(() => loadProductData(), []);

  if (!productData) {
    return <EmptyState>Run /product-vision to start</EmptyState>;
  }

  return <ProductOverview data={productData} />;
}
```

---

## Tool 2: Figma MCP Server

### Architecture

**Technology Stack:**
- Express.js MCP server
- WebSocket communication
- Figma Plugin (TypeScript)

**Communication Flow:**
```
AI Agent → MCP Server → WebSocket → Figma Plugin → Figma API → Figma Document
         ←            ←            ←             ←          ←
```

**Key Components:**
1. **MCP Server** (Node.js) - Receives tool calls from AI
2. **WebSocket Server** - Mediates communication
3. **Figma Plugin** - Executes commands in Figma

### Installation

```bash
# Clone repository
git clone https://github.com/Antonytm/figma-mcp-server.git
cd figma-mcp-server

# Install dependencies
npm install

# Build
npm run build

# Start server
npm start
# Server runs on http://localhost:38450
```

### Figma Plugin Setup

1. Open Figma Desktop App
2. **Plugins → Development → Import plugin from manifest**
3. Select: `figma-mcp-server/figma-plugin/manifest.json`
4. Run: **Plugins → Development → Figma MCP Server**
5. Verify: "✓ Connected to MCP server"

### Available Tools (23 Total)

**Document Management:**
- `get-document-info` - Get current file info
- `create-page` - Create new page
- `get-pages` - List all pages
- `select-page` - Switch to page

**Component Creation:**
- `create-component` - Create component node
- `add-component-property` - Add variant/property
- `set-node-component-property-references` - Link properties
- `create-component-instance` - Instance from component

**Layout & Frames:**
- `create-frame` - Create frame node
- `set-auto-layout` - Configure auto-layout
- `set-layout-sizing` - Set FILL/FIXED sizing
- `set-padding` - Set frame padding
- `set-gap` - Set auto-layout gap

**Styling:**
- `create-color-style` - Create color style
- `create-text-style` - Create text style
- `set-fill` - Apply fill color
- `set-stroke` - Apply stroke
- `apply-color-style` - Use color style
- `apply-text-style` - Use text style

**Text & Content:**
- `create-text` - Create text node
- `set-text-content` - Update text
- `set-font` - Change font properties

**Node Management:**
- `get-node` - Get node by ID
- `set-parent` - Move node to parent
- `delete-node` - Remove node

### cloud.md Integration

**Purpose:** Provide design rules and best practices for AI

**Location:** Project root (`cloud.md`)

**Key Sections:**

```markdown
# Figma Design Rules

## Component Creation Process
- Components created using create-component tool
- All parts should be ancestors of component node
- Component properties added via add-component-property
- Use set-node-component-property-references for linking

## Auto Layout Rules
- Use auto layout for everything
- Vertical auto layout: Fixed width, children use FILL horizontal
- Horizontal auto layout: Fixed height, children use FILL vertical
- Prefer Frames over Rectangles

## Document Organization
- Page 1: Brand Guidelines
- Page 2: Components
- Page 3+: Screens
- No overlapping elements
- Hierarchical structure with proper spacing
```

**AI reads cloud.md** before executing design tasks.

### Example Prompts

**Create Brand System:**
```
Using the design tokens from Design OS (colors.json, typography.json)
and following the rules in cloud.md, create a complete brand system
in Figma with:

1. Brand Guidelines page with color palette and typography scale
2. Components page with Button, Input, Card, Navigation components
3. All components should use auto-layout and component properties
```

**Create Screen Design:**
```
Using the approved component library and the homepage spec from
product/sections/homepage/spec.md, create a homepage design on
the "Screens/Homepage" page with:

1. Hero section (1920x800, overlay, centered content)
2. Featured items grid (3 columns using Card components)
3. Testimonials (2 columns using Card components)
4. Footer CTA (background: primary color, centered)

Create both desktop (1440px) and mobile (375px) versions.
Follow all spacing and layout rules from cloud.md.
```

**Iterate Design:**
```
Update the homepage hero section:
1. Increase height to 1000px
2. Change CTA button to Secondary variant
3. Add second CTA button (Outline variant)
4. Maintain 16px gap between buttons using auto-layout
```

### Integration with Design OS

**Data Flow:**
```
Design OS → colors.json → AI reads → Figma MCP creates color styles
          → typography.json → AI reads → Figma MCP creates text styles
          → spec.md → AI reads → Figma MCP creates screens
```

**Example:**
```typescript
// After running /design-tokens in Design OS
// File created: product/design-system/colors.json

// AI prompt to Figma MCP:
"Create color styles in Figma from colors.json"

// Figma MCP executes:
// 1. Read colors.json
// 2. For each color:
//    - create-color-style (Primary/500, #DC2626)
//    - create-color-style (Primary/600, #B91C1C)
//    - ...
```

### Error Handling

**Common Issues:**

1. **Connection Failed**
   - Check MCP server is running
   - Verify Figma plugin is active
   - Check port 38450 not blocked

2. **Tool Execution Timeout**
   - Complex operations may take time
   - MCP server has timeout (configurable)
   - Break into smaller operations

3. **Invalid Node References**
   - Always get fresh node IDs
   - Don't reuse IDs across sessions
   - Use `get-node` to verify existence

---

## Tool 3: RALPH LOOP

### Architecture

**Technology Stack:**
- Next.js 14+ (App Router)
- React 19+
- Playwright for E2E testing
- shadcn/ui component library
- Tailwind CSS

**Workflow:**
```
1. Write E2E Test → 2. Run Test (FAIL) → 3. Implement → 4. Run Test (PASS) →
5. Verify Screenshots → 6. Fix Issues → 7. Re-run → 8. Mark Verified → 9. Done
```

### Test Structure

**Directory Layout:**
```
client-project/
├── e2e/
│   ├── screenshots/
│   │   ├── feature-name/
│   │   │   ├── desktop-view.png
│   │   │   ├── mobile-view.png
│   │   │   └── verified_desktop-view.png  # After verification
│   │   └── ...
│   ├── homepage.spec.ts
│   ├── menu.spec.ts
│   └── ...
│
├── app/
│   ├── page.tsx
│   └── ...
│
├── components/
│   ├── ui/                    # shadcn/ui components
│   │   ├── button.tsx
│   │   ├── card.tsx
│   │   └── ...
│   └── ...
│
└── playwright.config.ts
```

### Test Template

```typescript
// e2e/feature-name.spec.ts
import { test, expect } from '@playwright/test';

test.describe('Feature Name', () => {
  test('should display correctly', async ({ page }) => {
    await page.goto('/');

    // Test element presence
    const element = page.getByTestId('feature-element');
    await expect(element).toBeVisible();

    // Test exact text from approved design
    const headline = page.getByTestId('feature-headline');
    await expect(headline).toContainText('Exact Text from Figma');

    // Test exact color from design tokens
    const button = page.getByTestId('feature-cta');
    await expect(button).toHaveCSS('background-color', 'rgb(220, 38, 38)');

    // Test layout dimensions
    const heroBox = await element.boundingBox();
    expect(heroBox?.height).toBeCloseTo(800, 10); // 800px ±10px

    // Visual regression test
    await page.screenshot({
      path: 'e2e/screenshots/feature-name/desktop-view.png',
      fullPage: false
    });
  });

  test('should be responsive on mobile', async ({ page }) => {
    await page.setViewportSize({ width: 375, height: 667 });
    await page.goto('/');

    const element = page.getByTestId('feature-element');
    await expect(element).toBeVisible();

    await page.screenshot({
      path: 'e2e/screenshots/feature-name/mobile-view.png'
    });
  });
});
```

### Workflow Steps

**Step 1: Run Tests (Initial FAIL)**
```bash
pnpm test e2e/feature-name.spec.ts
# Expected: FAIL - no components implemented
```

**Step 2: Implement Components**
```typescript
// components/feature-element.tsx
import { Button } from '@/components/ui/button';

export function FeatureElement() {
  return (
    <section
      data-testid="feature-element"
      className="h-[800px] bg-cover"
    >
      <h1 data-testid="feature-headline">
        Exact Text from Figma
      </h1>
      <Button
        data-testid="feature-cta"
        className="bg-primary-red"
      >
        Call to Action
      </Button>
    </section>
  );
}
```

**Step 3: Run Tests (Should PASS)**
```bash
pnpm test e2e/feature-name.spec.ts
# Expected: PASS - all assertions pass
# Screenshots generated in e2e/screenshots/feature-name/
```

**Step 4: Visual Verification**
```bash
# List screenshots
ls e2e/screenshots/feature-name/
# desktop-view.png
# mobile-view.png

# AI reads each screenshot and assesses
Read tool: e2e/screenshots/feature-name/desktop-view.png

# AI Assessment:
# ✅ Headline visible and positioned correctly
# ✅ Button present with correct color
# ❌ Button text is cut off (overflow issue)
# ❌ Background image too dark (low contrast)
```

**Step 5: Fix Issues**
```typescript
// Fix overflow
<Button className="... px-6 py-3"> {/* Explicit padding */}

// Fix contrast
<div className="absolute inset-0 bg-black/40" /> {/* Overlay */}
```

**Step 6: Re-run Tests**
```bash
pnpm test e2e/feature-name.spec.ts
# New screenshots generated
```

**Step 7: Verify Fixed**
```bash
# AI reads new screenshots
# ✅ All issues resolved
# ✅ Matches Figma design
```

**Step 8: Mark Verified**
```bash
mv e2e/screenshots/feature-name/desktop-view.png \
   e2e/screenshots/feature-name/verified_desktop-view.png

mv e2e/screenshots/feature-name/mobile-view.png \
   e2e/screenshots/feature-name/verified_mobile-view.png
```

**Step 9: Confirm Completion**
```bash
ls e2e/screenshots/feature-name/
# verified_desktop-view.png
# verified_mobile-view.png

# All files have 'verified_' prefix ✅
```

**Step 10: Output Promise**
```
<promise>FEATURE_NAME_DONE</promise>
```

### Integration with Design OS

**Test Data from Design OS:**
```typescript
// e2e/homepage.spec.ts
import sampleData from '../product/sections/homepage/data.json';

test('should display menu items from sample data', async ({ page }) => {
  await page.goto('/');

  // Test exact content from Design OS sample data
  for (const item of sampleData.menuItems) {
    const element = page.getByText(item.name);
    await expect(element).toBeVisible();
  }
});
```

**Design Tokens in Tests:**
```typescript
import designTokens from '../product/design-system/colors.json';

test('should use brand colors', async ({ page }) => {
  const primaryColor = designTokens.primary.value; // #DC2626
  const rgbColor = hexToRgb(primaryColor); // rgb(220, 38, 38)

  const button = page.getByTestId('cta-button');
  await expect(button).toHaveCSS('background-color', rgbColor);
});
```

### Playwright Configuration

```typescript
// playwright.config.ts
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
      name: 'mobile-chrome',
      use: { ...devices['Pixel 5'] },
    },
  ],

  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:3000',
    reuseExistingServer: !process.env.CI,
  },
});
```

---

## Tool 4: Claude Reflection System

### Architecture

**Technology Stack:**
- Bash scripts for hooks
- Git for version control
- Markdown for skill definitions

**Data Flow:**
```
Session → User Corrections → /reflect OR Stop Hook →
Analysis → Skill Updates → Git Commit/Push → Next Session Uses Updates
```

### Directory Structure

```
~/.claude/
├── settings.json              # Hook configuration
└── skills/
    ├── .git/                  # Git repository
    ├── reflect/
    │   ├── reflect.sh         # Reflection script
    │   └── .disabled          # Toggle file (if disabled)
    │
    ├── client-discovery/
    │   └── SKILL.md           # Discovery skill definition
    │
    ├── brand-design/
    │   └── SKILL.md           # Brand design skill
    │
    ├── figma-design/
    │   └── SKILL.md           # Figma automation skill
    │
    ├── implementation/
    │   └── SKILL.md           # Implementation skill
    │
    └── qa-verification/
        └── SKILL.md           # QA verification skill
```

### SKILL.md Format

```markdown
# [Skill Name] Skill

## [Category 1]
[Current knowledge/rules]

### Learned Patterns
- [Pattern 1] - [LEARNED: YYYY-MM-DD]
- [Pattern 2] - [LEARNED: YYYY-MM-DD]

## [Category 2]
[Current knowledge/rules]

## Notes
[Additional context]

---
Last Updated: YYYY-MM-DD HH:MM
Total Learnings: [count]
```

### Example Skill: brand-design/SKILL.md

```markdown
# Brand Design Skill

## Industry Color Guidelines

### Restaurants
- General restaurants: Warm colors (red, orange, gold)
- Seafood restaurants: Cool colors (blue, teal)
- Coffee shops: Warm browns, oranges
- [LEARNED: 2026-01-10 - Restaurant color preferences]

### Tech/SaaS
- Primary: Blues, purples
- Accent: Bright colors for CTAs
- [LEARNED: 2026-01-12 - Tech industry standards]

### Health/Wellness
- Primary: Greens, blues
- Accent: Natural earth tones
- [LEARNED: 2026-01-15 - Health industry preferences]

## Component Standards

### Buttons
- Padding: 16px horizontal (NEVER 20px or 24px)
- Border-radius: 8px for consistency
- Heights: 36px (sm), 44px (md), 52px (lg)
- [LEARNED: 2026-01-10 - Button sizing standards]

### Cards
- Padding: 24px (NEVER 20px or 32px)
- Border-radius: 8px
- Shadow: Subtle (0px 2px 8px rgba(0,0,0,0.1))
- [LEARNED: 2026-01-10 - Card standards]

### Input Fields
- Height: 48px for text inputs
- Padding: 12px horizontal
- Border-radius: 6px
- [LEARNED: 2026-01-11 - Input standards]

## Typography Pairings

### Elegant/Traditional
- Display: Playfair Display, Merriweather
- Body: Open Sans, Lato
- [LEARNED: 2026-01-10 - Works well for restaurants]

### Modern/Tech
- Display: Inter, Poppins
- Body: Inter, Roboto
- [LEARNED: 2026-01-12 - Tech industry preference]

---
Last Updated: 2026-01-15 14:30
Total Learnings: 12
```

### Reflection Commands

#### Manual Reflection: /reflect [skill-name]

**Workflow:**
1. User runs `/reflect brand-design`
2. AI analyzes conversation for corrections
3. AI proposes skill updates with confidence levels
4. User reviews and approves
5. AI edits SKILL.md file
6. AI commits and pushes to Git

**Example Output:**
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

#### Automatic Reflection: Stop Hook

**Configuration:**
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

**reflect.sh Script:**
```bash
#!/bin/bash

SKILLS_DIR=~/.claude/skills/reflect

# Check if disabled
[ -f "$SKILLS_DIR/.disabled" ] && exit 0

# Analyze conversation for learnable patterns
# (Implementation details depend on Claude API access)

# If patterns found, show notification
if learnable_patterns_found; then
  jq -n '{
    "systemMessage": "✓ Learned from session → [skill-name]"
  }'
fi

exit 0
```

**Behavior:**
- Runs silently at session end
- No prompts or interruptions
- Just shows notification if learned something
- Auto-commits to Git

#### Toggle Commands

```bash
/reflect on      # Enable auto-reflection
/reflect off     # Disable auto-reflection
/reflect status  # Check if enabled
```

### Integration with Other Tools

**Design OS Integration:**
```markdown
# figma-design/SKILL.md

## Design OS Token Usage
- Always read colors from product/design-system/colors.json
- Always read fonts from product/design-system/typography.json
- Use exact values when creating Figma styles
- [LEARNED: 2026-01-10 - Token sync is critical]
```

**Figma MCP Integration:**
```markdown
# figma-design/SKILL.md

## Figma Component Creation
- Always use create-component tool (not manual creation)
- Always add component properties for variants
- Always use auto-layout (FILL sizing for responsive)
- Card padding: 24px (learned from corrections)
- [LEARNED: 2026-01-10 - Component best practices]
```

**RALPH LOOP Integration:**
```markdown
# qa-verification/SKILL.md

## Screenshot Verification Checklist
Before marking screenshot as verified, check:
1. Text contrast ratio (WCAG AA - 4.5:1 minimum)
2. Buttons fully visible (no cut-off text or overflow)
3. Spacing matches Figma (8px grid system)
4. Responsive behavior works (columns stack on mobile)
5. Images load and display correctly

[LEARNED: 2026-01-10 - These 5 checks catch 90% of issues]

## Common Fixes
- Hero too dark → Add 40% black overlay
- Button text overflow → Check padding (should be 16px)
- Spacing inconsistent → Verify auto-layout gaps
- Mobile nav broken → Check z-index layering

[LEARNED: 2026-01-11 - Pattern of common issues]
```

### Git Workflow

**Initialize Skills Repository:**
```bash
cd ~/.claude/skills
git init
git add .
git commit -m "Initial skills setup"
git remote add origin [your-private-repo]
git push -u origin main
```

**Automatic Commits:**
When reflection updates a skill:
```bash
# AI executes:
git add [skill-name]/SKILL.md
git commit -m "[skill-name]: [learned pattern description]"
git push origin main
```

**Collaboration:**
- Share skills repo with team
- Pull updates: `git pull origin main`
- Each team member benefits from collective learning

---

## Integration Flow Diagram

```
┌─────────────────────────────────────────────────────────────┐
│ CLIENT SESSION                                              │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│ DESIGN OS                                                   │
│ • /product-vision → product-overview.md                     │
│ • /design-tokens → colors.json, typography.json             │
│ • /shape-section → spec.md                                  │
│ • /sample-data → data.json                                  │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│ FIGMA MCP SERVER                                            │
│ Input:                                                      │
│ • colors.json (Design OS)                                   │
│ • typography.json (Design OS)                               │
│ • spec.md (Design OS)                                       │
│ • cloud.md (project root)                                   │
│ • figma-design/SKILL.md (learned patterns)                  │
│                                                             │
│ Process:                                                    │
│ • AI reads inputs                                           │
│ • Creates Figma designs via MCP tools                       │
│ • Follows cloud.md + SKILL.md rules                         │
│                                                             │
│ Output:                                                     │
│ • Figma file with designs                                   │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│ RALPH LOOP                                                  │
│ Input:                                                      │
│ • Figma designs (specs)                                     │
│ • colors.json (design tokens)                               │
│ • data.json (sample data)                                   │
│ • implementation/SKILL.md (tech stack rules)                │
│ • qa-verification/SKILL.md (QA criteria)                    │
│                                                             │
│ Process:                                                    │
│ 1. Write E2E tests encoding Figma specs                     │
│ 2. Run tests → FAIL                                         │
│ 3. Implement components (shadcn/ui + tokens)                │
│ 4. Run tests → PASS                                         │
│ 5. Verify screenshots against Figma                         │
│ 6. Fix issues, re-test                                      │
│ 7. Mark verified                                            │
│                                                             │
│ Output:                                                     │
│ • Implemented features                                      │
│ • Passing tests                                             │
│ • Verified screenshots                                      │
│ • <promise>DONE</promise>                                   │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│ CLAUDE REFLECTION SYSTEM                                    │
│ Input:                                                      │
│ • Entire session transcript                                 │
│ • User corrections                                          │
│ • Success patterns                                          │
│                                                             │
│ Process:                                                    │
│ • Analyze corrections (HIGH confidence)                     │
│ • Identify working patterns (MEDIUM confidence)             │
│ • Propose skill updates                                     │
│ • User approves                                             │
│ • Update SKILL.md files                                     │
│ • Git commit + push                                         │
│                                                             │
│ Output:                                                     │
│ • Updated skills for next session                           │
│ • Git history of learnings                                  │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
              NEXT CLIENT SESSION
         (Benefits from all learnings)
```

---

## Troubleshooting

### Design OS Issues

**Issue:** Commands not found
**Solution:**
- Verify in Designbrnd directory
- Check `.claude/commands/design-os/` exists
- Restart Claude session

**Issue:** Files not generating
**Solution:**
- Check `product/` directory permissions
- Verify markdown syntax in output
- Run with verbose logging

---

### Figma MCP Issues

**Issue:** Plugin not connecting
**Solution:**
- Verify MCP server running: `curl http://localhost:38450`
- Check Figma Desktop app (not browser)
- Restart Figma and plugin
- Check firewall/port blocking

**Issue:** Design not matching cloud.md rules
**Solution:**
- Verify cloud.md in project root
- Check AI prompt includes "following cloud.md rules"
- Review SKILL.md for conflicting learned patterns

---

### RALPH LOOP Issues

**Issue:** Tests fail immediately
**Solution:**
- Check dev server running: `npm run dev`
- Verify `playwright.config.ts` base URL
- Ensure components have `data-testid` attributes
- Run with UI mode: `npx playwright test --ui`

**Issue:** Screenshots don't match Figma
**Solution:**
- Check exact colors (use hex → rgb converter)
- Verify spacing with browser DevTools
- Compare font sizes and weights
- Check responsive breakpoints

---

### Reflection System Issues

**Issue:** Skills not updating
**Solution:**
- Start with manual `/reflect` (skip auto-hook)
- Verify `~/.claude/skills/` directory exists
- Check Git initialized: `cd ~/.claude/skills && git status`
- Ensure SKILL.md files writable

**Issue:** Corrections not detected
**Solution:**
- Be explicit: "Always do X" or "Never do Y"
- Approve successful patterns: "Perfect" or "Exactly right"
- Run `/reflect` at session end (don't rely on auto-hook initially)

---

## Performance Optimization

### Design OS
- **Build time:** ~2-3s for typical project
- **File loading:** Instant (build-time glob)
- **Recommendation:** Keep markdown files under 1000 lines

### Figma MCP
- **Design creation:** 10-15 minutes for complete brand system
- **Screen design:** 5-10 minutes per screen
- **Recommendation:** Break complex designs into smaller prompts

### RALPH LOOP
- **Test execution:** 30s-2min per feature
- **Screenshot verification:** 1-2 minutes per screenshot
- **Recommendation:** Parallelize independent tests

### Reflection System
- **Analysis time:** 10-30 seconds
- **Git operations:** 1-2 seconds
- **Recommendation:** Batch learnings (don't commit every tiny change)

---

## Security Considerations

### Figma MCP
- ⚠️ **Local only** - Do NOT expose to network
- ⚠️ WebSocket on localhost only
- ⚠️ No authentication (assumes trusted local environment)

### Reflection System
- ✅ Skills repo should be private
- ✅ Contains proprietary patterns and preferences
- ✅ Use SSH for Git authentication

### Design OS
- ✅ Client data in `product/` directory
- ✅ Keep separate Git repo per client
- ✅ Don't commit client data to public repos

---

## Version Compatibility

| Tool | Minimum Version | Recommended Version | Notes |
|------|----------------|---------------------|-------|
| Design OS | 1.0 | Latest | Vite 7+ required |
| Figma MCP | 1.0 | Latest | Figma Desktop app required |
| RALPH LOOP | - | - | Next.js 14+, Playwright 1.40+ |
| Node.js | 18.0 | 20.x LTS | For all tools |
| Figma Desktop | 116.0 | Latest | Browser version not supported for MCP |

---

**Last Updated:** 2026-01-10
**Version:** 1.0
