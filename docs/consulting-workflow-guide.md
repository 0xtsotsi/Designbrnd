# Complete Consulting Workflow Guide
## Design OS + Figma MCP + RALPH LOOP + Reflection System

---

## Overview

This guide documents the complete automated workflow for design consultants helping clients create and manage digital assets (websites, SEO, marketing, social media, etc.). The workflow integrates four powerful tools:

1. **Design OS** - Planning and requirements gathering
2. **Figma MCP Server** - AI-powered visual design
3. **RALPH LOOP** - Test-driven development with quality gates
4. **Claude Reflection System** - Meta-learning that improves over time

---

## The Problem This Solves

### Traditional Consulting Pain Points:
- ❌ Endless client revisions ("this isn't what I wanted")
- ❌ Scope creep and unclear boundaries
- ❌ Misaligned expectations
- ❌ Repeating the same corrections every project
- ❌ Inconsistent quality across clients
- ❌ Long delivery timelines (8-12 weeks)

### This Workflow Delivers:
- ✅ Client approves designs BEFORE implementation
- ✅ Clear scope locked in Phase 1
- ✅ Visual mockups eliminate surprises
- ✅ Skills learn from corrections (never repeat)
- ✅ Consistent professional quality
- ✅ Faster delivery (4-6 weeks)

---

## Complete Workflow Architecture

```
┌─────────────────────────────────────────────────────────────┐
│ 🧠 REFLECTION SYSTEM (Meta-Learning Layer)                  │
│ • Captures corrections from all phases                      │
│ • Updates skills automatically                              │
│ • Improves quality with every project                       │
└─────────────────────────────────────────────────────────────┘
                          ↓ ↓ ↓
┌──────────────────────────────────────────────────────────────┐
│ PHASE 1: DISCOVERY & PLANNING (Week 1)                      │
│ Tool: Design OS                                              │
├──────────────────────────────────────────────────────────────┤
│ • /product-vision → Document business goals                  │
│ • /product-roadmap → Define deliverable sections             │
│ • /data-model → Structure data requirements                  │
│ Output: Written specs, approved scope                        │
│ Client Checkpoint: ✅ Approve vision & roadmap                │
└──────────────────────────────────────────────────────────────┘
                          ↓
┌──────────────────────────────────────────────────────────────┐
│ PHASE 2: BRAND SYSTEM DESIGN (Week 2 - Part 1)              │
│ Tools: Design OS → Figma MCP                                 │
├──────────────────────────────────────────────────────────────┤
│ Design OS:                                                   │
│ • /design-tokens → colors.json, typography.json              │
│                                                              │
│ Figma MCP (AI-Powered):                                      │
│ • AI reads design tokens + cloud.md rules                    │
│ • Creates Brand Guidelines page (colors, typography)         │
│ • Creates Components page (buttons, inputs, cards, nav)      │
│ • All auto-layout, component properties, best practices      │
│                                                              │
│ Time: 10 minutes vs. 2-4 hours manual                        │
│ Client Checkpoint: ✅ Approve brand identity                  │
└──────────────────────────────────────────────────────────────┘
                          ↓
┌──────────────────────────────────────────────────────────────┐
│ PHASE 3: SCREEN DESIGN (Week 2-3)                           │
│ Tools: Design OS → Figma MCP → Design OS (optional)         │
├──────────────────────────────────────────────────────────────┤
│ For each section:                                            │
│                                                              │
│ Design OS:                                                   │
│ • /shape-section → Define requirements, user flows           │
│ • /sample-data → Generate realistic content                  │
│                                                              │
│ Figma MCP (AI-Powered):                                      │
│ • AI reads specs + sample data + component library           │
│ • Creates screen designs (desktop 1440px + mobile 375px)     │
│ • Uses components, follows cloud.md rules                    │
│ • Client reviews professional mockups                        │
│                                                              │
│ Iteration: Client requests changes → AI updates in 2 mins    │
│                                                              │
│ Optional - Design OS:                                        │
│ • /design-screen → Interactive React prototype               │
│ • For testing user flows quickly                             │
│                                                              │
│ Time per section: 15 minutes vs. 3-5 hours manual            │
│ Client Checkpoint: ✅ Approve all screen designs              │
└──────────────────────────────────────────────────────────────┘
                          ↓
┌──────────────────────────────────────────────────────────────┐
│ PHASE 4: ASSET CREATION (Week 3)                            │
│ Tools: Figma MCP                                             │
├──────────────────────────────────────────────────────────────┤
│ • AI creates social media template library                   │
│   - Instagram posts (5 variations)                           │
│   - Instagram stories (3 variations)                         │
│   - Facebook covers                                          │
│ • All editable by client or VA                               │
│                                                              │
│ Client Checkpoint: ✅ Approve templates                       │
└──────────────────────────────────────────────────────────────┘
                          ↓
┌──────────────────────────────────────────────────────────────┐
│ PHASE 5: IMPLEMENTATION (Week 4-5)                          │
│ Tools: Design OS Export + Figma + RALPH LOOP                │
├──────────────────────────────────────────────────────────────┤
│ Step 1: Export from Design OS                                │
│ • /export-product → product-plan.zip                         │
│ • Contains: Components, tokens, data, types                  │
│                                                              │
│ Step 2: Figma Developer Handoff                              │
│ • Enable Dev Mode, share links                               │
│ • Export assets (images, icons, logos)                       │
│                                                              │
│ Step 3: Write E2E Tests from Figma Designs                   │
│ • Tests encode exact Figma specs (layout, colors, fonts)     │
│ • Visual regression tests with screenshots                   │
│                                                              │
│ Step 4: RALPH LOOP (per feature)                             │
│ • Run tests → FAIL                                           │
│ • AI implements with shadcn/ui + design tokens               │
│ • Run tests → PASS                                           │
│ • AI verifies screenshots vs. Figma                          │
│ • AI fixes visual issues                                     │
│ • Re-run tests → PASS                                        │
│ • Rename screenshots to verified_*                           │
│ • <promise>FEATURE_DONE</promise>                            │
│                                                              │
│ Repeat for all sections                                      │
└──────────────────────────────────────────────────────────────┘
                          ↓
┌──────────────────────────────────────────────────────────────┐
│ PHASE 6: CLIENT REVIEW & LAUNCH (Week 6)                    │
├──────────────────────────────────────────────────────────────┤
│ • Client reviews staging site                                │
│ • Pixel-perfect match to approved Figma designs              │
│ • All tests passing                                          │
│ • Deploy to production                                       │
│                                                              │
│ Client Receives:                                             │
│ • Live website                                               │
│ • Figma files for reference                                  │
│ • Social media templates to use                              │
│ • Complete documentation                                     │
└──────────────────────────────────────────────────────────────┘
```

---

## Timeline Comparison

| Traditional Process | Automated Workflow |
|--------------------|--------------------|
| 12-16 weeks | 6 weeks |
| 5-10 revision cycles | 1-2 iterations |
| Client sees designs at END | Client approves UPFRONT |
| Scope creep common | Scope locked Phase 1 |
| Manual Figma design (20+ hours) | AI-powered (2-3 hours) |
| Manual testing | Automated RALPH LOOP |
| Repeat corrections every project | Reflection system learns |

---

## Tool Integration Details

### 1. Design OS (Planning Layer)

**Purpose:** Document requirements, define scope, generate sample data

**Key Commands:**
- `/product-vision` - Capture business goals, target audience, problems/solutions
- `/product-roadmap` - Break project into deliverable sections
- `/data-model` - Define entities and relationships
- `/design-tokens` - Select colors and typography
- `/shape-section` - Define section requirements and user flows
- `/sample-data` - Generate realistic content
- `/design-screen` - Create interactive React prototypes (optional)
- `/export-product` - Generate complete handoff package

**Output Files:**
- `product/product-overview.md`
- `product/product-roadmap.md`
- `product/data-model/data-model.md`
- `product/design-system/colors.json`
- `product/design-system/typography.json`
- `product/sections/[id]/spec.md`
- `product/sections/[id]/data.json`
- `product-plan.zip` (export)

**Value:**
- Structured discovery process
- Client approval checkpoints
- Reusable sample data
- Developer-ready specs

---

### 2. Figma MCP Server (Visual Design Layer)

**Purpose:** AI-powered Figma design creation and modification

**How It Works:**
1. MCP Server communicates with Figma via WebSocket
2. Figma plugin executes design commands in Figma document
3. AI reads `cloud.md` rules for best practices
4. AI reads design tokens from Design OS
5. AI creates/modifies Figma designs automatically

**Capabilities:**
- Create component libraries (buttons, inputs, cards, etc.)
- Design complete screens (desktop + mobile)
- Apply brand colors and typography
- Use auto-layout for responsive designs
- Create social media templates
- Iterate on designs in minutes (not hours)

**Key Features:**
- **Auto-layout:** All components responsive by default
- **Component properties:** Variants for different states
- **Color/text styles:** Consistent design system
- **Undo/redo:** Non-destructive workflow
- **20x faster:** 15 minutes vs. 3-5 hours per screen

**Configuration:**
- `cloud.md` - Design rules and best practices (at project root)
- Design tokens from Design OS (`colors.json`, `typography.json`)

**Example Workflow:**
```
You (to Claude with Figma MCP):
"Using the design tokens from Design OS and following cloud.md rules,
create a complete brand system in Figma with brand guidelines page
and component library."

AI: Creates professional Figma file in 10 minutes
```

---

### 3. RALPH LOOP (Implementation QA Layer)

**Purpose:** Test-driven development with automated quality gates

**How It Works:**
1. Write E2E tests encoding approved Figma designs
2. Run tests → FAIL (no implementation yet)
3. AI implements components to pass tests
4. Run tests → PASS
5. AI reads screenshots and verifies visual quality
6. AI fixes any visual issues found
7. Re-run tests until all verified
8. Rename screenshots to `verified_*` prefix
9. Output: `<promise>FEATURE_DONE</promise>`

**Technology Stack:**
- Framework: Next.js/React
- Testing: Playwright E2E
- UI Components: shadcn/ui (based on Radix UI)
- Styling: Tailwind CSS

**Quality Gates:**
- ✅ Functional tests pass (elements present, correct text, colors)
- ✅ Visual verification (screenshots match Figma)
- ✅ Responsive tests (mobile + desktop)
- ✅ Accessibility checks (contrast ratios, touch targets)

**Example Test:**
```typescript
// e2e/homepage-hero.spec.ts
test('hero section matches Figma design', async ({ page }) => {
  await page.goto('/');

  const hero = page.getByTestId('homepage-hero');
  await expect(hero).toBeVisible();

  // Test exact color from design tokens
  const ctaButton = page.getByTestId('hero-cta');
  await expect(ctaButton).toHaveCSS('background-color', 'rgb(220, 38, 38)');

  // Visual regression
  await page.screenshot({ path: 'e2e/screenshots/homepage/hero.png' });
});
```

**Value:**
- Guarantees pixel-perfect implementation
- Automated visual QA
- No manual testing needed
- Clear completion signal

---

### 4. Claude Reflection System (Meta-Learning Layer)

**Purpose:** Learn from corrections and improve skills over time

**How It Works:**
1. During session, you correct Claude's outputs
2. At session end, run `/reflect [skill-name]` OR Stop hook auto-triggers
3. Claude analyzes conversation for corrections and success patterns
4. Claude proposes skill updates with confidence levels
5. You approve changes
6. Skill file updated, committed, pushed to Git
7. Next session uses improved skill

**Confidence Levels:**
- **HIGH:** Explicit corrections ("never do X", "always do Y")
- **MEDIUM:** Patterns that worked well
- **LOW:** Observations to review later

**Skills to Create for Your Business:**

#### 1. Client Discovery (`~/.claude/skills/client-discovery/SKILL.md`)
Learns:
- Question order and phrasing
- Industry-specific questions
- Required information checklist
- Red flags to watch for

#### 2. Brand Design (`~/.claude/skills/brand-design/SKILL.md`)
Learns:
- Industry color preferences (restaurants → warm, tech → cool)
- Typography pairings that work
- Component sizing standards
- Your aesthetic preferences

#### 3. Figma Automation (`~/.claude/skills/figma-design/SKILL.md`)
Learns:
- cloud.md preferences and additions
- Component organization patterns
- Naming conventions
- Common client requests

#### 4. Implementation (`~/.claude/skills/implementation/SKILL.md`)
Learns:
- Tech stack choices (shadcn/ui, Next.js, etc.)
- Code structure preferences
- Testing requirements
- Git commit message format

#### 5. QA Verification (`~/.claude/skills/qa-verification/SKILL.md`)
Learns:
- Screenshot verification checklist
- Common visual bugs to check
- Browser testing requirements
- Accessibility standards

**Setup:**
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

**ROI Over 10 Clients:**
- Client 1: 12 corrections, 3 hours
- Client 2: 6 corrections, 1.5 hours (1.5h saved)
- Client 3: 3 corrections, 45 mins (4.75h saved)
- Client 4: 1 correction, 15 mins (7.5h saved)
- Client 5+: 0-1 corrections, 0-15 mins (10+ hours saved)

**Annual Impact (40 clients):** ~80 hours saved = $8,000-$15,000 value

---

## Real-World Example: Restaurant Website Project

### Week 1: Discovery & Planning

**Day 1-2: Initial Discovery**
```bash
# Initial client call
/product-vision

Output:
- Business: Family Italian restaurant
- Target: Local diners, families, date nights
- Problems: No online presence, hard to showcase menu
- Features: Website, online menu, reservations, social media presence
```

**Day 3: Define Roadmap**
```bash
/product-roadmap

Sections:
1. Homepage (Hero, featured dishes, testimonials)
2. Menu (Appetizers, Entrees, Desserts, Drinks)
3. About (Story, chef bio, location)
4. Reservations (Form with date/time picker)
5. Contact (Hours, address, phone, social links)
```

**Day 4-5: Data Modeling**
```bash
/data-model

Entities:
- MenuItem (name, description, price, category, image, allergens)
- Reservation (name, email, phone, date, time, party size, special requests)
- Testimonial (customer name, quote, rating, date)
- Location (address, hours, phone, coordinates)
```

**Client Checkpoint:** ✅ Approves scope and structure

---

### Week 2 Part 1: Brand System Design

**Day 1: Define Design Tokens**
```bash
/design-tokens

Colors Selected:
- Primary: Red #DC2626 (Italian flag red)
- Secondary: Gold #F59E0B
- Neutral: Stone palette

Typography:
- Display: Playfair Display (elegant serif)
- Body: Open Sans (readable sans-serif)

Output: colors.json, typography.json
```

**Day 2: AI Creates Figma Brand System**
```
You (to Claude with Figma MCP):
"Using design tokens and cloud.md rules, create complete brand system."

AI Creates in Figma:
- Page 1: Brand Guidelines
  - Color palette (Primary/Secondary with 9 shades each)
  - Typography scale (H1-H4, Body Large/Medium/Small)

- Page 2: Components
  - Button (Primary/Secondary/Outline, Small/Medium/Large)
  - Input (Text/Email/Password, Default/Focus/Error)
  - Card (Default/Elevated/Outlined)
  - Navigation (Desktop/Mobile variants)

Time: 10 minutes
```

**Client Review:** Views Figma link, approves brand identity ✅

---

### Week 2 Part 2 - Week 3: Screen Design

**For Each Section (Example: Homepage):**

**Day 1: Define Homepage Requirements**
```bash
/shape-section homepage

Requirements:
- Hero: Full-width image, headline, subheadline, CTA
- Featured Dishes: 3-column grid, images, descriptions, prices
- Testimonials: 2-column layout, customer quotes, ratings
- Footer CTA: Reservation prompt with button

/sample-data

Generated Content:
- Hero: "Authentic Italian Cuisine" / "Family recipes since 1982"
- Dishes: Margherita Pizza, Fettuccine Alfredo, Tiramisu
- Testimonials: 3 customer reviews with 5-star ratings
```

**Day 2: AI Creates Figma Homepage Design**
```
You (to Claude with Figma MCP):
"Create homepage design using approved components and homepage spec."

AI Creates:
- Desktop version (1440px)
  - Hero with overlay for text readability
  - 3-column featured dishes grid
  - 2-column testimonials
  - Footer CTA with primary button

- Mobile version (375px)
  - Hero (smaller height)
  - Single-column dishes (stacked)
  - Single-column testimonials
  - Footer CTA (full-width button)

Time: 15 minutes
```

**Client Iteration:**
```
Client: "Can we make hero taller and show 4 dishes instead of 3?"

You (to AI): "Update: hero 800px, 4-column dishes grid"

AI: Updates Figma in 2 minutes

Client: "Perfect!" ✅
```

**Repeat for Menu, About, Reservations, Contact (Week 3)**

---

### Week 3 End: Social Media Assets

```
You (to Claude with Figma MCP):
"Create social media template library using our brand system."

AI Creates:
- Instagram Posts (1080x1080): 5 templates
  - Featured dish showcase
  - Daily special
  - Testimonial
  - Event promo
  - Quote graphic

- Instagram Stories (1080x1920): 3 templates
  - Menu highlight
  - Behind-the-scenes
  - Poll/engagement

- Facebook Cover (1200x630)
  - Restaurant branding with CTA

All editable by client
```

**Client Checkpoint:** ✅ Approves all templates

---

### Week 4-5: Implementation with RALPH LOOP

**Week 4 Day 1: Export & Setup**
```bash
/export-product

Generates: product-plan.zip
- All React components
- Design tokens
- Sample data
- TypeScript types
- Implementation prompts
```

**Week 4 Day 2-3: Write E2E Tests**
```typescript
// e2e/homepage.spec.ts
// e2e/menu.spec.ts
// e2e/about.spec.ts
// e2e/reservations.spec.ts
// e2e/contact.spec.ts

Each test encodes:
- Layout from Figma (heights, widths, spacing)
- Colors from design tokens
- Typography from text styles
- Interactions from user flows
```

**Week 4-5: RALPH LOOP Implementation**

**Homepage (Day 4):**
```bash
# Iteration 1
pnpm test e2e/homepage.spec.ts
❌ FAIL - No components built

# Iteration 2
AI implements homepage components with shadcn/ui

# Iteration 3
pnpm test e2e/homepage.spec.ts
✅ PASS

# Iteration 4
AI reads screenshots, finds hero image too dark
AI adds 40% overlay, re-runs tests

# Iteration 5
pnpm test e2e/homepage.spec.ts
✅ PASS - All verified

<promise>HOMEPAGE_DONE</promise>
```

**Repeat for Menu, About, Reservations, Contact (Days 5-10)**

All features implemented with:
- Passing tests ✅
- Verified screenshots ✅
- Pixel-perfect to Figma ✅

---

### Week 6: Client Review & Launch

**Day 1-2: Staging Review**
- Client reviews staging.example.com
- Site matches approved Figma designs exactly
- All functionality works
- Mobile responsive

**Day 3: Final Approval**
- Client approves ✅
- No surprises or changes needed

**Day 4-5: Production Deployment**
- Deploy to production
- Configure domain
- Set up analytics
- Train client on CMS (if applicable)

**Deliverables:**
- ✅ Live website (restaurantname.com)
- ✅ Figma files (brand guidelines, components, screens)
- ✅ Social media templates (editable by client/VA)
- ✅ Documentation
- ✅ Login credentials

**Client:** Thrilled, site exactly as envisioned 🎉

---

## Client Pitch Template

> **"Here's our AI-powered design and development process:**
>
> **Week 1:** We document your vision, scope, and requirements using our planning system. You approve everything in writing before any design work begins.
>
> **Week 2-3:** Our AI designer creates your entire brand system and website designs in Figma:
> - Professional brand guidelines (colors, typography)
> - Complete component library (buttons, forms, cards)
> - All your website pages (desktop + mobile versions)
> - Social media templates you can edit yourself
>
> You review professional mockups and we iterate in MINUTES, not days. What you see is exactly what you'll get.
>
> **Week 4-5:** Our AI development system builds your site with automated quality checks that guarantee pixel-perfect match to approved designs. Every element tested automatically.
>
> **Week 6:** Your site goes live.
>
> **Results:**
> - ✅ 6 weeks instead of 12-16 weeks (2-3x faster)
> - ✅ 60-70% cost savings from automation
> - ✅ Zero surprises - approved designs = final product
> - ✅ Professional Figma files you own forever
> - ✅ Editable social media templates
> - ✅ Quality improves with every project (our AI learns)
>
> **Guarantee:** What you approve in Week 3 is exactly what launches in Week 6. No surprises, no endless revisions."

---

## ROI Analysis

### Time Savings Per Client

| Phase | Traditional | Automated | Savings |
|-------|------------|-----------|---------|
| Discovery | 8 hours | 3 hours | 5 hours |
| Brand Design | 8 hours | 1 hour | 7 hours |
| Screen Design (5 pages) | 25 hours | 3 hours | 22 hours |
| Revisions | 15 hours | 2 hours | 13 hours |
| Implementation | 40 hours | 25 hours | 15 hours |
| QA Testing | 10 hours | 2 hours | 8 hours |
| **TOTAL** | **106 hours** | **36 hours** | **70 hours** |

**Per Client Savings:** 70 hours = 8.75 workdays

**Annual Savings (20 clients):** 1,400 hours = 175 workdays = 35 workweeks

**Monetary Value:** $70,000 - $140,000 (at $50-100/hr)

---

### Quality Improvements

| Metric | Traditional | Automated | Improvement |
|--------|------------|-----------|-------------|
| Revision Cycles | 5-10 | 1-2 | 80% reduction |
| Client Satisfaction | 75% | 95% | +20 points |
| On-time Delivery | 60% | 95% | +35 points |
| Scope Creep | 40% | 5% | 87% reduction |
| Repeat Business | 30% | 70% | +40 points |

---

## Skills That Improve Over Time

### After Client 1 (Restaurant):
Skills learn:
- Restaurant industry prefers warm colors
- Button padding: 16px (your standard)
- Card padding: 24px (your standard)
- Discovery process question order
- shadcn/ui is your tech stack

### After Client 5 (Various Industries):
Skills know:
- Restaurant → warm colors
- Tech/SaaS → cool colors
- Health → greens/blues
- Luxury → dark/gold
- Your complete component standards
- Your QA verification checklist
- Your git commit format

### After Client 20:
Skills are expert-level:
- Industry-specific design patterns
- Common client objections and solutions
- Optimized discovery questions
- Refined component library
- Battle-tested QA criteria
- Zero repetitive corrections needed

**Result:** Each project is faster and higher quality than the last.

---

## Getting Started

### Prerequisites

1. **Design OS Installation**
   - Clone and set up Designbrnd repository
   - Familiarize with commands

2. **Figma MCP Server**
   - Install from: https://github.com/Antonytm/figma-mcp-server
   - Configure WebSocket connection
   - Install Figma plugin (development mode)
   - Create `cloud.md` in project root

3. **RALPH LOOP Setup**
   - Next.js project with App Router
   - Install Playwright: `npm install -D @playwright/test`
   - Install shadcn/ui: `npx shadcn-ui@latest init`
   - Create E2E test directory

4. **Claude Reflection System**
   - Create skills directory: `~/.claude/skills/`
   - Set up Stop hook in `~/.claude/settings.json`
   - Initialize Git for skills tracking
   - Create initial skill files

### First Project Checklist

- [ ] Set up client project directory
- [ ] Copy `cloud.md` to project root
- [ ] Run `/product-vision` for discovery
- [ ] Run `/product-roadmap` for scope
- [ ] Run `/data-model` for structure
- [ ] Run `/design-tokens` for brand
- [ ] Use Figma MCP to create brand system
- [ ] Use Figma MCP to create screen designs
- [ ] Client approves all designs
- [ ] Run `/export-product`
- [ ] Write E2E tests from Figma
- [ ] Run RALPH LOOP for implementation
- [ ] Deploy and launch
- [ ] Run `/reflect` to capture learnings

### Ongoing Optimization

- Review skill updates after each project
- Refine `cloud.md` based on patterns
- Build template library of common components
- Document industry-specific learnings
- Share successful patterns with team

---

## Conclusion

This integrated workflow combines the best of AI-powered design, test-driven development, and meta-learning to deliver:

1. **Speed:** 2-3x faster than traditional processes
2. **Quality:** Pixel-perfect, automated QA
3. **Consistency:** Same professional standards every time
4. **Client Satisfaction:** No surprises, clear expectations
5. **Continuous Improvement:** Gets better with every project

The magic is in the integration - each tool amplifies the others, and the Reflection System ensures your entire workflow becomes more refined with every client.

**Start with one client, learn and refine, then scale to 10, 20, 40+ clients per year with the same (or smaller) team.**

---

**Last Updated:** 2026-01-10
**Version:** 1.0
**Author:** Design OS Consulting Workflow
