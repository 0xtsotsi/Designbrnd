# Professional UX Workflow Integration

## The Missing Piece We Just Discovered

**From the transcript:** "Every minute saved by not planning ends up being 10 minutes down the line of extra work."

**The Problem:**
Most people (including us!) jump from specs → code, resulting in generic UIs.

**The Solution:**
Add a detailed UX specification layer BEFORE building.

---

## Current vs Enhanced Workflow

### BEFORE (What We Had)

```
Phase 1: Design OS
  ↓
  Creates: product-overview.md, colors.json, spec.md
  ↓
Phase 2: Figma MCP
  ↓
  Agent guesses UX details ❌
  ↓
Phase 3: RALPH LOOP
  ↓
  Agent guesses implementation details ❌
  ↓
Result: Generic, vanilla UI 😞
```

### AFTER (Enhanced with UX Layer)

```
Phase 1: Design OS
  ↓
  Creates: product-overview.md, colors.json, spec.md
  ↓
Phase 1.5: UX Specification ← NEW!
  ↓
  Creates: ux-spec.md, build-order.md
  ↓
  Defines:
  • Mental model (what user expects)
  • Information architecture (what exists, how organized)
  • Affordances (what looks clickable)
  • System states (loading, empty, error)
  ↓
Phase 2: Figma MCP
  ↓
  Reads UX spec ✅ (knows exact details)
  ↓
Phase 3: RALPH LOOP
  ↓
  Reads UX spec + build order ✅ (knows exact steps)
  ↓
Result: Professional, polished UI 🎨
```

---

## The 3-Step UX Process

### Step 1: PRD (Product Requirements Document)

**What it is:** Functional definition of features

**What it contains:**
- Features list
- User flows
- Success criteria
- Technical requirements

**Design OS already does this!**
```
product/sections/homepage/spec.md = Our PRD
```

**Example PRD:**
```markdown
# Homepage Section PRD

## Purpose
Landing page for Italian restaurant showcasing menu and booking

## Key Features
1. Hero section with appetizing image
2. Featured menu items (3 columns)
3. Booking CTA
4. Testimonials

## User Flow
1. User lands on homepage
2. Sees hero with restaurant ambiance
3. Scrolls to see featured dishes
4. Clicks "Book Table" CTA

## Success Criteria
- Hero loads in < 2s
- CTA converts at > 5%
- Mobile responsive
```

---

### Step 2: UX Specification (THE CRITICAL MISSING PIECE)

**What it is:** How the user EXPERIENCES the features

**From transcript - 5 key elements:**

#### 1. Mental Model Alignment
"What does the user think is happening or think should be happening?"

**Example:**
```markdown
# Homepage UX Spec - Mental Model

## User Mental Model
User expects:
- Restaurant website = Big appetizing food photo first
- Italian = Warm, inviting, family atmosphere
- Booking = Prominent, easy to find
- Menu = Visual (photos of dishes)

## How we reinforce this:
- Hero: Full-width image (1000px) with warm overlay
- Typography: Elegant serif for headings (Playfair Display)
- Colors: Red/Gold (appetizing, premium)
- CTA: Large, prominent "Reserve Table" button
```

#### 2. Information Architecture
"What actually exists and how is it organized?"

**Example:**
```markdown
# Homepage UX Spec - Information Architecture

## Primary Concepts
1. Hero
   - Background image
   - Restaurant name
   - Tagline
   - Primary CTA

2. Featured Items
   - Dish name
   - Photo
   - Description
   - Price

3. Booking Section
   - Date picker
   - Time selector
   - Party size
   - Submit button

## Hierarchy
Level 1: Hero (full attention)
Level 2: Featured dishes (browsing)
Level 3: Booking (action)
Level 4: Footer (info)
```

#### 3. Affordance & Action
"How do you make actions clear?"

**Example:**
```markdown
# Homepage UX Spec - Affordances

## Visual Signals

### Clickable Elements
- Primary CTA: Solid red button, 16px padding, hover lift effect
- Menu items: Subtle hover scale (1.02x)
- Navigation links: Underline on hover

### Editable Fields
- Date picker: Calendar icon, border on focus
- Time selector: Dropdown arrow indicator
- Input fields: Placeholder text, focus state blue border

### Loading States
- Booking submission: Button shows spinner, disabled
- Menu images: Skeleton placeholder → fade in
- Page load: Hero loads first, content progressively

### Empty States
- No featured items: "Coming soon - Check back tomorrow!"
- Booking unavailable: "Call us at (555) 123-4567"
```

#### 4. System Feedback
"How does the system respond to user actions?"

**Example:**
```markdown
# Homepage UX Spec - System Feedback

## Success States
- Booking confirmed: Green checkmark toast, "Table reserved!"
- Form submitted: Success message with reservation details

## Error States
- Invalid date: Red border, "Please select future date"
- No availability: Orange warning, "Try different time?"
- Network error: Retry button, "Connection lost"

## Loading States
- Submitting: Button disabled, spinner, "Processing..."
- Slow connection: "Taking longer than usual..."
- Background: Subtle progress bar at top

## Empty States
- No menu items yet: Illustration + "Menu coming soon!"
- No testimonials: Hide section entirely (not empty div)
```

#### 5. Content Strategy
"How should content be presented?"

**Example:**
```markdown
# Homepage UX Spec - Content Strategy

## Tone of Voice
- Warm, family-oriented
- Authentic, not corporate
- Passionate about food

## Copy Guidelines
- Hero headline: Short, evocative (5-7 words)
- Dish descriptions: Sensory, appetizing (15-20 words)
- CTAs: Action-oriented, urgent ("Reserve Your Table")

## Visual Content
- Hero: Warm-toned, people enjoying food
- Dishes: Close-up, steam/garnish visible
- Testimonials: Customer photos (with permission)
```

---

### Step 3: Build Order (Sequential Prompts)

**What it is:** Breaking UX spec into step-by-step prompts

**From transcript:** "Translate what we have built into something that's going to work for these tools"

**Example Build Order:**
```markdown
# Homepage Build Order

## Prompt 1: Design Tokens
Create design tokens:
- Colors: Red (#DC2626), Gold (#F59E0B), Warm Gray
- Typography: Playfair Display (headings), Open Sans (body)
- Spacing: 8px grid system
- Shadows: Subtle elevation (0 2px 8px rgba(0,0,0,0.1))

## Prompt 2: Layout Shell
Create responsive layout shell:
- Desktop: 1440px max-width, centered
- Mobile: 375px, full-width
- Sections: Hero (full-width), Featured (3-col grid), Booking (centered)
- Navigation: Sticky header with logo + links

## Prompt 3: Hero Section
Build hero with these exact specs:
- Height: 1000px desktop, 600px mobile
- Background: Parallax image of pasta dish
- Overlay: 50% black (rgba(0,0,0,0.5))
- Content: Centered, white text
  - H1: "Mamma Mia's Italian Kitchen" (Playfair 64px)
  - Tagline: "Authentic flavors, family traditions" (Open Sans 24px)
  - CTA: Red button "Reserve Table" with hover lift

Affordances:
- CTA: Obvious button styling, drop shadow
- Hover: Lifts 4px, shadow increases
- Mobile: Button full-width

Loading states:
- Image: Blur-up progressive load
- Content: Fade in after image

## Prompt 4: Featured Dishes Grid
Build 3-column grid (1 column mobile):
- Card structure: Image → Name → Description → Price
- Hover effect: Scale 1.02x, shadow increases
- Images: 400x300px, object-fit cover
- Gap: 24px between cards

Affordances:
- Entire card clickable (subtle cursor change)
- Hover: Clear lift effect

Empty state:
- No dishes: Show message "Menu coming soon!"

## Prompt 5: Booking Section
Build booking form:
- Fields: Date, Time, Party Size
- Validation: Required fields, date must be future
- Submit: "Reserve Table" button

Affordances:
- Date: Calendar icon, opens picker
- Time: Dropdown with 30min intervals
- Party size: Number selector (1-12)

States:
- Default: All fields enabled
- Submitting: Button disabled, spinner shown
- Success: Green toast "Reserved!" + confirmation
- Error: Red border + message below field

## Prompt 6: Testimonials
Build testimonials slider:
- 2 columns desktop, 1 mobile
- Quote + Customer name + Photo
- Auto-rotate every 5 seconds

Empty state:
- No testimonials: Hide section entirely

## Prompt 7: Footer
Build footer with:
- Address, Phone, Hours
- Social media links
- Copyright

## Prompt 8: Responsive Refinement
Test and fix:
- All breakpoints (375px, 768px, 1024px, 1440px)
- Touch targets 44x44px minimum
- Keyboard navigation working
```

---

## Integration with Our Workflow Cluster

### Phase 1: Design OS (Product Vision)

**Command:** `/product-vision`, `/shape-section`

**Output:**
- `product/product-overview.md`
- `product/sections/homepage/spec.md`

**This becomes our PRD!**

---

### Phase 1.5: UX Specification (NEW!)

**New Command:** `/shape-ux <section-name>`

**Process:**
1. Read section spec.md (PRD)
2. Generate UX specification with 5 elements:
   - Mental model
   - Information architecture
   - Affordances
   - System feedback
   - Content strategy

**Output:**
- `product/sections/homepage/ux-spec.md`

**Storage:**
```bash
brv curit "UX spec for homepage: Mental model, IA, affordances defined" @ux-spec.md
```

---

**New Command:** `/build-order <section-name>`

**Process:**
1. Read ux-spec.md
2. Break into sequential prompts
3. Each prompt = one atomic piece

**Output:**
- `product/sections/homepage/build-order.md`

**Storage:**
```bash
brv curit "Build order for homepage: 8 sequential prompts ready" @build-order.md
```

---

### Phase 2: Figma MCP (Visual Design)

**BEFORE:**
```
Agent: "Design homepage"
Figma MCP: *guesses layout* ❌
Result: Generic layout
```

**AFTER:**
```
Agent: "Design homepage using ux-spec.md"
Figma MCP: *reads exact affordances, IA, mental model* ✅
Result: Professional, thoughtful design
```

**Agent queries ByteRover:**
```bash
brv query "homepage UX specifications"
→ Gets mental model, affordances, system states
```

---

### Phase 3: RALPH LOOP (Implementation)

**BEFORE:**
```
Agent: *reads spec.md*
Agent: "I'll implement homepage"
Agent: *guesses interaction details* ❌
Result: Works, but feels generic
```

**AFTER:**
```
Agent: *reads ux-spec.md + build-order.md*
Agent: "Following prompt 1: Design tokens"
Agent: "Following prompt 2: Layout shell"
Agent: "Following prompt 3: Hero with EXACT specs"
Result: Matches UX spec perfectly ✅
```

**Agent queries ByteRover:**
```bash
brv query "homepage build order"
→ Gets sequential steps

brv query "hero affordances"
→ Gets exact hover states, loading behavior
```

---

## Creating the Claude Skills

### Skill 1: `/shape-ux`

**File:** `.claude/commands/design-os/shape-ux.md`

```markdown
# Shape UX Specification

## Purpose
Transform section spec (PRD) into detailed UX specification

## Workflow

1. Read section spec:
   - product/sections/{section-name}/spec.md

2. Generate UX specification with 5 sections:

### Mental Model Alignment
- What does user expect when they see this?
- How does this section fit their understanding?
- What metaphors/patterns are familiar?

### Information Architecture
- List all UI elements/concepts
- Define hierarchy (primary, secondary, tertiary)
- Group related elements
- Define progressive disclosure strategy

### Affordance & Action
- What looks clickable? (buttons, links, cards)
- What looks editable? (inputs, textareas, pickers)
- What visual signals indicate state? (hover, active, focus)
- What indicates loading/progress?

### System Feedback
- Success states (what happens when things work)
- Error states (what happens when things fail)
- Loading states (what happens during processing)
- Empty states (what shows when no data)

### Content Strategy
- Tone of voice
- Copy length guidelines
- Visual content requirements
- Accessibility considerations

3. Output to:
   - product/sections/{section-name}/ux-spec.md

4. Save to ByteRover:
   - brv curit "UX spec for {section}: [summary]" @ux-spec.md

## Example Usage

User: "/shape-ux homepage"

Agent:
1. Reads product/sections/homepage/spec.md
2. Generates comprehensive UX spec covering all 5 areas
3. Writes to product/sections/homepage/ux-spec.md
4. Saves to ByteRover for future reference
```

---

### Skill 2: `/build-order`

**File:** `.claude/commands/design-os/build-order.md`

```markdown
# Generate Build Order

## Purpose
Transform UX specification into sequential prompts for implementation

## Workflow

1. Read files:
   - product/sections/{section-name}/spec.md (PRD)
   - product/sections/{section-name}/ux-spec.md (UX details)
   - product/design-system/colors.json (design tokens)
   - product/design-system/typography.json (design tokens)

2. Generate sequential prompts:

Each prompt should:
- Be atomic (one focused task)
- Include exact specifications from UX spec
- Reference affordances (how it should feel)
- Include all states (default, hover, loading, error, empty)
- Be ready to paste into builder tool

Typical sequence:
1. Design tokens setup
2. Layout shell
3. Primary components (with all states)
4. Secondary components
5. Interactions & animations
6. Responsive refinement
7. Accessibility pass
8. Final polish

3. Output to:
   - product/sections/{section-name}/build-order.md

4. Save to ByteRover:
   - brv curit "Build order for {section}: {N} sequential prompts" @build-order.md

## Example Usage

User: "/build-order homepage"

Agent:
1. Reads spec.md + ux-spec.md + design tokens
2. Generates 8-12 sequential prompts
3. Each prompt includes:
   - What to build
   - Exact specifications
   - Affordances to implement
   - All states to handle
4. Writes to product/sections/homepage/build-order.md
5. Saves to ByteRover
```

---

## Enhanced Workflow Cluster

### Complete Flow

```
┌──────────────────────────────────────────────────────┐
│ PHASE 1: Design OS (Product Definition)             │
├──────────────────────────────────────────────────────┤
│ Commands:                                            │
│ • /product-vision → product-overview.md              │
│ • /design-tokens → colors.json, typography.json      │
│ • /shape-section homepage → spec.md (PRD)            │
│                                                      │
│ ByteRover:                                           │
│ • brv curit "Product vision approved"                │
│ • brv curit "Colors: Red/Gold chosen"                │
│ • brv curit "Homepage section shaped"                │
└──────────────────────────────────────────────────────┘
                        ↓
┌──────────────────────────────────────────────────────┐
│ PHASE 1.5: UX Specification (NEW!)                   │
├──────────────────────────────────────────────────────┤
│ Commands:                                            │
│ • /shape-ux homepage → ux-spec.md                    │
│   - Mental model                                     │
│   - Information architecture                         │
│   - Affordances                                      │
│   - System feedback                                  │
│   - Content strategy                                 │
│                                                      │
│ • /build-order homepage → build-order.md             │
│   - 8-12 sequential prompts                          │
│   - Each with exact specs                            │
│                                                      │
│ ByteRover:                                           │
│ • brv curit "UX spec: mental model + affordances"    │
│ • brv curit "Build order: 8 sequential prompts"      │
└──────────────────────────────────────────────────────┘
                        ↓
┌──────────────────────────────────────────────────────┐
│ PHASE 2: Figma MCP (Visual Design)                  │
├──────────────────────────────────────────────────────┤
│ Agent:                                               │
│ 1. brv query "homepage UX specifications"            │
│    → Gets mental model, IA, affordances              │
│                                                      │
│ 2. Creates designs using UX spec (not guessing!)     │
│                                                      │
│ 3. brv curit "Hero design: 1000px with hover lift"  │
│                                                      │
│ Result: Professional, polished mockups ✨             │
└──────────────────────────────────────────────────────┘
                        ↓
┌──────────────────────────────────────────────────────┐
│ PHASE 3: RALPH LOOP (Implementation)                │
├──────────────────────────────────────────────────────┤
│ Agent:                                               │
│ 1. brv query "homepage build order"                  │
│    → Gets 8 sequential prompts                       │
│                                                      │
│ 2. For each prompt:                                  │
│    - Write test matching exact specs                 │
│    - Implement with all states                       │
│    - Verify screenshots                              │
│                                                      │
│ 3. brv curit "Hero complete: all states verified"   │
│                                                      │
│ Result: Implementation matches UX spec perfectly ✅   │
└──────────────────────────────────────────────────────┘
                        ↓
┌──────────────────────────────────────────────────────┐
│ PHASE 4: Reflect (Learning)                         │
├──────────────────────────────────────────────────────┤
│ Agent:                                               │
│ 1. brv query "What UX patterns worked?"              │
│                                                      │
│ 2. Updates ~/.claude/skills/:                        │
│    - "Hero overlays: Always start at 50%"           │
│    - "CTAs: Lift on hover increases conversions"    │
│                                                      │
│ 3. brv curit "Pattern: UX spec prevents generic UI" │
│                                                      │
│ Result: Next project even better! 🚀                 │
└──────────────────────────────────────────────────────┘
```

---

## Before vs After Example

### BEFORE (No UX Spec)

**Prompt to Figma MCP:**
```
"Design homepage with hero, menu grid, and booking form"
```

**Result:**
- Generic hero (no specific height)
- Menu grid (no hover states defined)
- Booking form (no error/loading states)
- Feels vanilla 😐

---

### AFTER (With UX Spec)

**Prompt to Figma MCP:**
```
Following homepage ux-spec.md:

Mental Model: User expects big appetizing food photo first

Information Architecture:
- Hero: 1000px, full-width, centered content
- Featured: 3-col grid, 24px gap
- Booking: Centered form, 400px max-width

Affordances:
- CTA: Red button with 4px lift on hover
- Cards: Scale 1.02x on hover
- Inputs: Blue focus border, calendar icon for date

System States:
- Loading: Skeleton → fade in
- Error: Red border + message below
- Empty: "Menu coming soon!" message

Create designs implementing all specs above.
```

**Result:**
- Exact hero height (1000px)
- All hover states defined
- All system states designed
- Feels professional ✨

---

## Storing in ByteRover

### Context Tree Structure

```
/ux-specifications/
  ├─ homepage-mental-model
  ├─ homepage-information-architecture
  ├─ homepage-affordances
  ├─ homepage-system-states
  └─ homepage-content-strategy

/build-orders/
  ├─ homepage-sequential-prompts
  ├─ menu-sequential-prompts
  └─ booking-sequential-prompts

/ux-patterns/ (Reflect learns these)
  ├─ hero-overlay-50-percent
  ├─ cta-hover-lift-effect
  └─ form-error-below-field
```

### Query Examples

```bash
# Phase 2 agent
brv query "homepage affordances"
→ "CTA: Red button with 4px lift on hover, drop shadow increases"

# Phase 3 agent
brv query "booking form system states"
→ "Default: All enabled | Submitting: Spinner + disabled | Error: Red border + message"

# Future project
brv query "proven hero patterns"
→ "Overlay at 50%, lift on hover, progressive image load"
```

---

## ROI Analysis

### Time Investment

**Without UX Spec:**
- Planning: 1 hour (PRD only)
- Building: 8 hours (lots of back-and-forth)
- Revisions: 4 hours (client: "This feels generic")
- **Total: 13 hours**

**With UX Spec:**
- Planning: 3 hours (PRD + UX Spec + Build Order)
- Building: 4 hours (following exact prompts)
- Revisions: 0.5 hours (minor tweaks only)
- **Total: 7.5 hours**

**Savings: 5.5 hours per feature** (42% faster!)

**Quality:**
- Without: Generic, vanilla
- With: Professional, polished

**Cost:**
- Without: $1,950 (13 hours × $150/hr)
- With: $1,125 (7.5 hours × $150/hr)
- **Savings: $825 per feature**

---

## Implementation Priority

### Week 1: Create Skills

```bash
# Create new commands
.claude/commands/design-os/
├── shape-ux.md         ← NEW
└── build-order.md      ← NEW
```

### Week 2: Test with Designbrnd

```bash
cd ~/Designbrnd
claude

# Test flow
/shape-section test-feature
/shape-ux test-feature
/build-order test-feature

# Verify outputs
cat product/sections/test-feature/ux-spec.md
cat product/sections/test-feature/build-order.md
```

### Week 3: Use in Client Project

```bash
cd ~/projects/restaurant
claude

# Real workflow
/shape-section homepage
/shape-ux homepage        # Detailed UX spec
/build-order homepage     # Sequential prompts

# Store in ByteRover
brv curit "Homepage UX: mental model + IA + affordances" @ux-spec.md
brv curit "Homepage build: 8 sequential prompts" @build-order.md

# Phase 2: Figma MCP
brv query "homepage affordances"
# Design with exact specs

# Phase 3: RALPH LOOP
brv query "homepage build order"
# Implement step by step
```

---

## Summary

### What We Discovered

The **critical missing piece** between specs and implementation:
- **UX Specification Layer**

### The 5 Elements

1. Mental Model - What user expects
2. Information Architecture - What exists, how organized
3. Affordances - What looks actionable
4. System Feedback - All states (loading, error, empty, success)
5. Content Strategy - How content is presented

### Integration Points

- **Design OS**: Add `/shape-ux` and `/build-order` commands
- **ByteRover**: Store UX specs for cross-phase queries
- **Figma MCP**: Read UX specs instead of guessing
- **RALPH LOOP**: Follow build order instead of guessing
- **Reflect**: Learn UX patterns that work

### Result

**From vanilla 😐 → professional ✨**

Same workflow, 42% faster, $825 saved per feature!

---

## Next Steps

1. ✅ Understand UX workflow (done!)
2. ⏳ Create `/shape-ux` skill
3. ⏳ Create `/build-order` skill
4. ⏳ Test in Designbrnd
5. ⏳ Use in real client project
6. ⏳ Measure quality improvement

**Ready to add professional UX to our workflow?** 🎨
