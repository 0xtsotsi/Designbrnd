# Workflow Cluster + Beads ByteRover Integration

## Overview

Your consulting workflow involves **4 tools** operating in sequence:
1. **Design OS** → Planning & requirements
2. **Figma MCP** → Design automation
3. **RALPH LOOP** → Test-driven development
4. **Reflect** → Skill learning

**Problem:** Each phase creates context that's needed in later phases, but currently:
- Context stored in scattered files (markdown, JSON, Figma)
- No unified way to query "what decisions were made in Phase 1?"
- Agents in Phase 3 can't easily recall Phase 1 reasoning
- New team members joining mid-project lack context

**Solution:** Beads ByteRover becomes the **shared memory layer** for the entire workflow.

---

## Current Workflow (Without ByteRover)

```
Phase 1: Design OS
├─ Creates: product-overview.md
├─ Creates: colors.json, typography.json
├─ Creates: spec.md per section
└─ Agent memory: Lost after session ends

Phase 2: Figma MCP
├─ Reads: colors.json, typography.json
├─ Reads: spec.md
├─ Creates: Figma designs
└─ Agent memory: Lost after session ends

Phase 3: RALPH LOOP
├─ Reads: colors.json, data.json
├─ Reads: Figma specs (manual interpretation)
├─ Creates: React components + tests
└─ Agent memory: Lost after session ends

Phase 4: Reflect
├─ Analyzes: All corrections from Phases 1-3
├─ Updates: SKILL.md files
└─ Retains: General principles only
```

**Pain Points:**
- ❌ Why did we choose red as primary? (Lost reasoning from Phase 1)
- ❌ What's the hero section height? (Must re-read Figma or code)
- ❌ Did client approve this change? (No audit trail)
- ❌ New team member: "What's the architecture?" (Must read everything)

---

## Enhanced Workflow (With ByteRover)

```
                  ┌───────────────────────────┐
                  │   BEADS BYTEROVER         │
                  │   (Shared Memory)         │
                  │                           │
                  │  Stores:                  │
                  │  • Design decisions       │
                  │  • Client approvals       │
                  │  • Architecture choices   │
                  │  • Implementation notes   │
                  │  • Issue resolutions      │
                  └───────────────────────────┘
                       ↑↓    ↑↓    ↑↓    ↑↓
              ┌────────┴┴────┴┴────┴┴────┴┴────────┐
              │                                     │
    ┌─────────▼─────────┐    ┌──────────▼──────────┐
    │  DESIGN OS        │    │  FIGMA MCP          │
    │  Phase 1          │    │  Phase 2            │
    │                   │    │                     │
    │  • Queries BR     │    │  • Queries BR       │
    │  • Saves BR       │    │  • Saves BR         │
    └─────────┬─────────┘    └──────────┬──────────┘
              │                         │
    ┌─────────▼─────────┐    ┌──────────▼──────────┐
    │  RALPH LOOP       │    │  REFLECT            │
    │  Phase 3          │    │  Phase 4            │
    │                   │    │                     │
    │  • Queries BR     │    │  • Queries BR       │
    │  • Saves BR       │    │  • Analyzes BR      │
    └───────────────────┘    └─────────────────────┘
```

**Benefits:**
- ✅ Every decision captured with reasoning
- ✅ Cross-phase context queries
- ✅ Complete audit trail (git-backed)
- ✅ Instant onboarding for new team members
- ✅ Agents autonomous across all phases

---

## How Each Phase Uses ByteRover

### Phase 1: Design OS (Planning)

**Agent Behavior:**

**Before creating specs:**
```bash
# Agent queries existing context
brv query "What brand colors did we discuss?"
brv query "What's the target audience?"
```

**While working with client:**
```bash
# After client approves vision
brv curit "Client approved product vision: Restaurant booking platform for Gen Z" @product-overview.md

# After choosing colors
brv curit "Primary color: Red (#DC2626) - client wanted bold, appetizing feel" @colors.json

# After defining sections
brv curit "Approved roadmap: Homepage, Menu, Booking, About sections" @product-roadmap.md
```

**Example Memory:**
```markdown
# /design-decisions/color-choice

**Decision:** Primary color is Red (#DC2626)

**Reasoning:**
- Client runs Italian restaurant
- Wanted bold, appetizing feel
- Red evokes passion, appetite
- Competitor analysis showed red works well in food industry

**Client Quote:** "I love it! Reminds me of tomato sauce"

**Files:** product/design-system/colors.json

**Date:** 2026-01-12
```

**Value:** Phase 2 agent can query "Why red?" and get full context!

---

### Phase 2: Figma MCP (Design Automation)

**Agent Behavior:**

**Before creating designs:**
```bash
# Agent queries Phase 1 context
brv query "What colors and fonts were approved?"
brv query "What's the hero section supposed to communicate?"
brv query "Any specific brand guidelines from client?"
```

**While designing:**
```bash
# After creating component library
brv curit "Figma component library: Button, Card, Input with variants" @figma-components-spec.md

# After client feedback on hero
brv curit "Hero section: Increased height to 1000px per client request (wanted more impact)" @hero-design-notes.md

# After creating screens
brv curit "Homepage design: Hero + 3-col menu grid + testimonials + footer CTA" @homepage-spec.md
```

**Example Memory:**
```markdown
# /design/hero-iterations

**Initial Design:** 800px height

**Client Feedback:** "Feels too cramped, needs more breathing room"

**Revision:** Increased to 1000px height

**Client Response:** "Perfect! Much more impactful"

**Final Specs:**
- Height: 1000px
- Background: hero-image.jpg with 40% overlay
- CTA buttons: Primary + Secondary, 16px gap
- Typography: Display font, 64px heading

**Date:** 2026-01-13
```

**Value:** Phase 3 agent knows EXACT specs without guessing!

---

### Phase 3: RALPH LOOP (Implementation)

**Agent Behavior:**

**Before writing tests:**
```bash
# Agent queries approved designs
brv query "Hero section specifications"
brv query "What components were approved in Figma?"
brv query "Any client-specific requirements?"
```

**While implementing:**
```bash
# After fixing a tricky bug
brv curit "Hero overlay issue: z-index needed on text container to show above image overlay" @hero.tsx

# After client visual review
brv curit "Client approved hero but requested darker overlay (changed from 40% to 50%)" @hero.tsx

# After completing feature
brv curit "Hero section complete: 1000px height, 50% overlay, auto-layout CTA buttons" @hero.tsx @hero.spec.ts
```

**Example Memory:**
```markdown
# /implementation/hero-section

**Test Specs:**
- Height: 1000px (±10px tolerance)
- Overlay: rgba(0,0,0,0.5) - 50%
- CTA Buttons: 16px gap, auto-layout
- Responsive: Stacks on mobile (< 768px)

**Implementation Notes:**
- Used Next.js Image component for optimization
- z-index: 10 on text container (above overlay)
- Tailwind: h-\[1000px\] relative

**Client Changes:**
- Changed overlay from 40% → 50% (wanted darker)

**Test Status:** ✅ All passing
**Screenshots:** Verified desktop + mobile

**Date:** 2026-01-14
```

**Value:** Complete implementation history for future reference!

---

### Phase 4: Reflect (Skill Learning)

**Agent Behavior:**

**During reflection:**
```bash
# Agent queries memories to find patterns
brv query "What corrections did client make?"
brv query "What worked well this project?"
brv query "Any repeated mistakes?"
```

**After analysis:**
```bash
# Extract general principles
brv curit "Pattern: Italian restaurants prefer warm red colors (3rd project in a row)" @pattern-analysis.md

# Cross-reference with Reflect
# Reflect updates: brand-design/SKILL.md
# ByteRover stores: Project-specific examples
```

**Integration Example:**
```markdown
# /learnings/overlay-pattern

**Pattern Detected:**
Across last 3 projects, clients always request darker overlays on hero images.

**Initial Attempts:**
- Project A: Started 30% → Increased to 50%
- Project B: Started 40% → Increased to 60%
- Project C: Started 40% → Increased to 50%

**Learning:**
Start with 50% overlay on hero images by default.

**Action:**
✅ Updated Reflect: brand-design/SKILL.md
✅ Stored in ByteRover: Cross-project pattern

**Date:** 2026-01-15
```

**Value:**
- Reflect learns the PRINCIPLE ("Use 50% overlay")
- ByteRover stores the EVIDENCE (all 3 projects)
- Future projects benefit from both!

---

## Cross-Phase Query Examples

### Designer in Phase 2 queries Phase 1 decisions:

```bash
brv query "Why did we choose red for primary color?"
```

**Output:**
```
🧠 Found in /design-decisions/color-choice

Decision: Primary color is Red (#DC2626)

Reasoning:
- Client runs Italian restaurant
- Wanted bold, appetizing feel
- Red evokes passion, appetite

Client Quote: "I love it! Reminds me of tomato sauce"

Date: 2026-01-12 (Phase 1)
```

---

### Developer in Phase 3 queries Phase 2 approvals:

```bash
brv query "Hero section specifications"
```

**Output:**
```
🧠 Found in /design/hero-iterations

Final Specs:
- Height: 1000px
- Background: hero-image.jpg with 50% overlay
- CTA buttons: Primary + Secondary, 16px gap
- Typography: Display font, 64px heading

Client approved: 2026-01-13 (Phase 2)

Implementation notes: See /implementation/hero-section (Phase 3)
```

---

### New team member joins mid-project:

```bash
brv query "What's the project about?"
brv query "What's been approved so far?"
brv query "Any known issues or client preferences?"
```

**Instant Context:**
- Product vision
- Approved colors/fonts
- Completed sections
- Client feedback history
- Architecture decisions

**Onboarding time:** 5 minutes vs. 2 hours!

---

## Memory Organization for Workflow

### Context Tree Structure:

```
/design-decisions
  ├─ color-choice
  ├─ typography-choice
  ├─ brand-identity
  └─ layout-approach

/client-feedback
  ├─ phase1-approvals
  ├─ phase2-design-reviews
  ├─ phase3-visual-verification
  └─ change-requests

/implementation
  ├─ hero-section
  ├─ menu-grid
  ├─ booking-form
  └─ navigation

/architecture
  ├─ tech-stack
  ├─ component-structure
  ├─ state-management
  └─ api-design

/learnings
  ├─ what-worked
  ├─ repeated-patterns
  ├─ client-preferences
  └─ common-issues
```

---

## Enhanced Rules for Workflow Agents

### Design OS Agent Rules:

```markdown
# Design OS + ByteRover Integration

Before running commands:
1. Query ByteRover for any prior context
2. Check if client has existing preferences

After completing work:
1. Save key decisions with reasoning to ByteRover
2. Include client quotes for approvals
3. Tag with phase: "design-os" or "phase1"

Example workflow:
User: "Create product vision"
You:
1. brv query "Any existing product context?"
2. Run /product-vision with client
3. brv curit "Client approved vision: [summary]" @product-overview.md
```

---

### Figma MCP Agent Rules:

```markdown
# Figma MCP + ByteRover Integration

Before designing:
1. brv query "What colors and fonts were approved?"
2. brv query "Any specific brand requirements?"
3. Read cloud.md + approved design tokens

After creating designs:
1. brv curit "Created [component/screen]" @figma-spec.md
2. Include client feedback iterations
3. Save final approved specifications

After client changes:
1. brv curit "Client requested [change]: [reasoning]" @design-notes.md
```

---

### RALPH LOOP Agent Rules:

```markdown
# RALPH LOOP + ByteRover Integration

Before writing tests:
1. brv query "[feature] specifications"
2. brv query "Any client-specific requirements for [feature]?"

During implementation:
1. Save complex solutions: brv curit "Fixed [issue]: [solution]" @code.tsx
2. Save client changes: brv curit "Client adjusted [aspect]" @code.tsx

After verification:
1. brv curit "[Feature] complete: [specs]" @code.tsx @test.spec.ts
2. Include screenshot verification status
```

---

### Reflect Agent Rules:

```markdown
# Reflect + ByteRover Integration

During reflection:
1. brv query "What corrections occurred this project?"
2. brv query "What patterns repeated?"

After identifying learnings:
1. Update Reflect: SKILL.md (general principle)
2. Save to ByteRover: Evidence and examples
3. Cross-reference: brv curit "Pattern detected: [description]" @pattern.md
```

---

## Workflow Benefits Summary

### Without ByteRover:
- ❌ Context scattered across files
- ❌ Agents forget after sessions
- ❌ "Why did we do X?" requires archaeology
- ❌ New team members lost
- ❌ Client approval history unclear
- ❌ Repeated questions to client

### With ByteRover:
- ✅ Unified memory layer
- ✅ Agents query context autonomously
- ✅ Every decision has reasoning recorded
- ✅ Instant team onboarding
- ✅ Complete audit trail (git-backed)
- ✅ Never ask client same question twice

---

## Implementation Priority

### Phase 1: Core CLI (Weeks 1-2)
Build ByteRover CLI with workflow-specific features:
- `brv query` - All agents can search context
- `brv curit` - All agents can save decisions
- Context tree optimized for workflow phases

### Phase 2: Agent Integration (Week 3)
Update rules for each tool:
- Design OS rules: Query before, save after
- Figma MCP rules: Query specs, save designs
- RALPH LOOP rules: Query all, save implementations
- Reflect rules: Query patterns, cross-reference

### Phase 3: Dashboard (Optional, Weeks 4-5)
Visual timeline showing:
- Phase 1 decisions → Phase 2 designs → Phase 3 code
- Client approval checkpoints
- Change request history

---

## ROI Analysis

### Time Savings Per Project:

**Without ByteRover:**
- Context lookup: 30 min/day × 30 days = 15 hours
- Re-asking client: 5 × 30 min = 2.5 hours
- Onboarding new team member: 2 hours
- **Total:** ~20 hours wasted

**With ByteRover:**
- Context lookup: Instant queries (5 min/day)
- Re-asking client: Never (has history)
- Onboarding: 5 minutes
- **Total:** ~2 hours
- **Savings:** 18 hours per project

**At $150/hr consulting rate:** $2,700 saved per project!

---

## Example: Full Project Flow

### Week 1 - Phase 1: Design OS

```
Agent: brv query "Any existing context for [ClientName]?"
→ No prior projects

Agent runs: /product-vision
Client: "Italian restaurant, target Gen Z, bold brand"

Agent: brv curit "Client vision: Italian restaurant targeting Gen Z, wants bold modern brand" @product-overview.md

Agent runs: /design-tokens
Client approves: Red primary, Playfair Display

Agent: brv curit "Primary color Red (#DC2626) - client: 'appetizing like tomato sauce'" @colors.json

Agent: brv curit "Typography: Playfair Display (elegant) + Open Sans (readable)" @typography.json
```

---

### Week 2 - Phase 2: Figma MCP

```
Agent: brv query "What colors were approved?"
→ Red (#DC2626) - appetizing feel

Agent: brv query "What typography was approved?"
→ Playfair Display + Open Sans

Agent creates Figma brand system using context

Agent: brv curit "Created component library: Button, Card, Navigation with Red primary" @figma-components.md

Client reviews hero: "Make it bigger, more impact"

Agent: brv curit "Hero height increased 800→1000px per client request" @hero-design.md
```

---

### Week 3 - Phase 3: RALPH LOOP

```
Agent: brv query "Hero section specifications"
→ 1000px height, Red CTA, 50% overlay

Agent writes test matching exact specs

Agent implements, tests pass

Client visual review: "Overlay too light"

Agent: brv curit "Changed overlay 40%→50% per client visual review" @hero.tsx

Tests pass, screenshots verified

Agent: brv curit "Hero section complete: 1000px, 50% overlay, verified" @hero.tsx @hero.spec.ts
```

---

### Week 4 - Phase 4: Reflect

```
Agent: brv query "What patterns emerged this project?"
→ Red for Italian restaurants (3rd time)
→ Overlays always need adjustment (4th time)
→ Gen Z clients prefer bold typography (2nd time)

Agent: brv curit "Pattern: Italian restaurants consistently choose warm red colors" @pattern-italian-red.md

Agent updates Reflect: brand-design/SKILL.md
"Italian restaurants: Default to Red/Orange warm palette"

Agent: brv curit "Pattern: Hero overlays always adjusted darker (avg 40%→50%)" @pattern-overlays.md

Agent updates Reflect: figma-design/SKILL.md
"Start hero overlays at 50% (saves iteration)"
```

---

## Next Steps

1. ✅ Build ByteRover CLI (Phase 1)
2. ✅ Test with one phase (Design OS first)
3. ✅ Add agent rules for all phases
4. ✅ Run complete project end-to-end
5. ✅ Measure time savings
6. ✅ Refine based on learnings

**Ready to supercharge your workflow?**

The workflow cluster becomes a **learning organism** where every project makes the next one faster, smarter, and more consistent!
