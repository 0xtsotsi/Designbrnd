# Shape UX - Transform Section Spec into UX Specification

## Overview

This command transforms a functional section specification (PRD) into a detailed UX specification that defines HOW users experience the feature.

**Problem it solves:** Prevents generic, vanilla UIs by forcing detailed UX planning before implementation.

**Key insight:** "Every minute saved by not planning ends up being 10 minutes down the line of extra work."

---

## Usage

```
/shape-ux <section-name>
```

**Example:**
```
/shape-ux homepage
```

---

## What This Command Does

1. **Reads** the section spec (PRD)
2. **Generates** a comprehensive UX specification
3. **Writes** to `product/sections/{section}/ux-spec.md`
4. **Saves** to ByteRover for future queries

---

## UX Specification Structure

The generated UX spec must include these 5 critical elements:

### 1. Mental Model Alignment

**Question:** What does the user think is happening or think should be happening?

**What to document:**
- User expectations when encountering this feature
- Familiar patterns/metaphors user already knows
- How this feature fits their mental model
- What assumptions user brings to this interaction

**Example:**
```markdown
## Mental Model

When users land on a restaurant homepage, they expect:
- Large, appetizing food photography (establishes atmosphere)
- Immediate understanding: "This is a restaurant"
- Clear path to booking (primary action)
- Menu preview (secondary action)
- Social proof (reviews/testimonials)

How we reinforce this model:
- Hero: Full-width, high-quality food photo (establishes "restaurant")
- Typography: Elegant serif = upscale dining
- Colors: Warm red/gold = appetizing, welcoming
- CTA placement: Above fold, prominent
```

---

### 2. Information Architecture

**Question:** What actually exists in this feature and how is it organized?

**What to document:**
- All UI elements and concepts that exist
- Hierarchical organization (primary, secondary, tertiary)
- Grouping and categorization strategy
- Progressive disclosure (what shows when)
- Relationships between elements

**Example:**
```markdown
## Information Architecture

### Primary Concepts
1. **Hero Section**
   - Background image (full-width, parallax)
   - Restaurant name (centered, large)
   - Tagline (supporting text)
   - Primary CTA (prominent button)

2. **Featured Items**
   - Dish image (400x300px)
   - Dish name (heading)
   - Description (2-3 sentences)
   - Price (right-aligned)

3. **Booking Widget**
   - Date selector (calendar picker)
   - Time selector (dropdown)
   - Party size (number input)
   - Submit button

### Hierarchy
**Level 1 (Immediate Attention):**
- Hero with CTA

**Level 2 (Browsing):**
- Featured dishes grid

**Level 3 (Action):**
- Booking form

**Level 4 (Support):**
- Footer info

### Grouping Strategy
- Visual dishes: Cards with images
- Form inputs: Grouped in single panel
- Social proof: Separate testimonials section
```

---

### 3. Affordance & Action

**Question:** How do you make the actions people can take CLEAR to them?

**What to document:**
- What looks clickable (buttons, links, cards)
- What looks editable (inputs, textareas, selectors)
- What visual signals indicate interactivity
- Hover states, focus states, active states
- Loading/processing indicators

**Example:**
```markdown
## Affordances & Actions

### Clickable Elements

**Primary CTA ("Reserve Table")**
- Visual: Solid red button, 16px padding, drop shadow
- Hover: Lift 4px, shadow increases (0 6px 12px)
- Active: Scale 0.98x
- Cursor: pointer
- Mobile: Full-width, touch target 48px minimum

**Menu Item Cards**
- Visual: White card, subtle border
- Hover: Scale 1.02x, shadow appears
- Cursor: pointer
- Indicates: "Click to view full menu item"

**Navigation Links**
- Visual: Text with underline on hover
- Hover: Color shifts to primary red
- Active: Stays red
- Cursor: pointer

### Editable Fields

**Date Picker**
- Visual: Input with calendar icon (right side)
- Click icon: Opens calendar overlay
- Focus: Blue border (2px), calendar icon turns blue
- Keyboard: Tab-accessible, arrow keys navigate calendar
- Placeholder: "Select date"

**Time Selector**
- Visual: Dropdown with down arrow icon
- Click: Expands options (30min intervals, 5pm-10pm)
- Hover option: Light gray background
- Selected: Blue background
- Keyboard: Type to search times

**Party Size**
- Visual: Number input with +/- buttons
- Buttons: Rounded, gray background
- Hover: Blue tint
- Limits: Min 1, max 12
- Keyboard: Up/down arrows adjust

### Loading Indicators

**Button Loading**
- Primary CTA: Spinner replaces text, button disabled
- Visual: "Reserve Table" → [Spinner] "Processing..."
- Duration: Shows for entire async operation

**Image Loading**
- Hero: Blur-up effect (low-res → high-res)
- Featured dishes: Skeleton placeholder → fade-in
- Duration: Progressive enhancement

**Page Load**
- Top progress bar (linear, blue)
- Hero loads first (critical)
- Below-fold lazy loads
```

---

### 4. System Feedback

**Question:** How does the system respond in different states?

**What to document:**
- Success states (when things work)
- Error states (when things fail)
- Loading states (during processing)
- Empty states (when no data exists)
- Partial states (incomplete data)

**Example:**
```markdown
## System Feedback

### Success States

**Booking Confirmed**
- Visual: Green toast notification (top-right)
- Message: "Table reserved! Check your email for confirmation."
- Duration: 5 seconds, dismissible
- Email: Sends confirmation with reservation details
- Next step: Show "View Reservation" button

**Form Submission**
- Visual: Checkmark animation in button
- Transition: Button → Success state → Reset after 2s
- Feedback: Haptic on mobile
- Analytics: Track conversion

### Error States

**Invalid Date Selection**
- Visual: Red border on date input (2px)
- Message: Below field, "Please select a future date"
- Icon: Warning icon (red)
- Fix: Clear invalid date on focus
- Keyboard: Auto-focus on field

**No Availability**
- Visual: Orange warning banner above form
- Message: "No tables available at this time. Try different time?"
- Suggestion: Show next 3 available times as chips
- Action: Click chip → auto-populates form

**Network Error**
- Visual: Red toast notification
- Message: "Connection lost. Check your internet."
- Action: "Retry" button
- Behavior: Retries submission on click
- Fallback: "Call us at (555) 123-4567"

**Validation Errors**
- Visual: Red border on invalid fields
- Message: Inline below each field
- Examples:
  - Email: "Please enter valid email"
  - Phone: "Format: (555) 123-4567"
  - Party size: "Max 12 guests per reservation"

### Loading States

**Submitting Booking**
- Button: Disabled, shows spinner
- Text: "Processing reservation..."
- Form: All inputs disabled
- Timeout: If > 5s, show "Taking longer than usual..."
- Analytics: Track slow submissions

**Page Loading**
- Hero: Loads immediately (priority)
- Content: Progressive (fold-aware)
- Images: Lazy load below fold
- Slow connection: Show message after 3s

### Empty States

**No Featured Dishes Yet**
- Visual: Illustration of empty plate
- Message: "Our chef is preparing something special!"
- Subtext: "Check back tomorrow for featured dishes"
- CTA: "View Full Menu" button
- Do NOT show: Empty grid or skeleton

**No Testimonials**
- Behavior: Hide entire section
- Do NOT show: Empty cards or "No reviews yet"
- Reason: Maintains credibility

**No Available Times**
- Visual: Calendar with grayed-out dates
- Message: "Fully booked for selected date"
- Help: "Try another date or call us"
- Alternative: Show waiting list signup

### Partial States

**Incomplete Form**
- Visual: Required fields marked with asterisk
- Behavior: Submit button disabled until all required filled
- Helper: "3 more fields required" count
- Accessibility: Screen reader announces requirements

**Loading Additional Dishes**
- Visual: Skeleton cards at bottom of grid
- Behavior: Infinite scroll triggers load
- Indicator: Spinner below grid
- Error: "Unable to load more" with retry
```

---

### 5. Content Strategy

**Question:** How should content be presented and what tone should it have?

**What to document:**
- Tone of voice
- Copy length guidelines
- Formatting rules
- Microcopy examples
- Visual content requirements
- Accessibility considerations

**Example:**
```markdown
## Content Strategy

### Tone of Voice

**Brand Personality:**
- Warm, family-oriented (not corporate)
- Passionate about food and traditions
- Welcoming but not overly casual
- Authentic, not trying too hard

**Writing Style:**
- Conversational but respectful
- Sensory language for food descriptions
- Action-oriented for CTAs
- Supportive for errors

**Examples:**
- Hero: "Experience authentic Italian cuisine" (not "We serve food")
- Dish: "Hand-rolled pasta in grandmother's secret sauce" (not "Pasta with tomato sauce")
- CTA: "Reserve Your Table" (not "Book Now" or "Submit")
- Error: "Oops! Try another date?" (not "ERROR: Invalid input")

### Copy Length Guidelines

**Headlines:**
- Hero headline: 5-7 words (punchy, memorable)
- Section headings: 2-4 words
- Card titles: 3-5 words

**Body Copy:**
- Dish descriptions: 15-20 words (sensory, appetizing)
- Hero tagline: 8-12 words (supporting, emotional)
- Error messages: 5-10 words (clear, actionable)

**Buttons:**
- Primary CTAs: 2-3 words (action verb + noun)
- Secondary CTAs: 1-2 words
- Examples: "Reserve Table", "View Menu", "Learn More"

### Microcopy

**Form Labels:**
- Date: "When would you like to dine?"
- Time: "Preferred time"
- Party size: "Number of guests"

**Placeholders:**
- Email: "your@email.com"
- Phone: "(555) 123-4567"
- Special requests: "Dietary restrictions, celebrations..."

**Success Messages:**
- Booking: "Table reserved! We're excited to host you."
- Newsletter: "Thanks! We'll send you our latest specials."

**Error Messages:**
- Required: "This field is required"
- Invalid: "Please check this field"
- Network: "Connection issue. Please try again."

**Empty States:**
- No dishes: "Our chef is preparing something special!"
- No results: "Try adjusting your filters"

### Visual Content Requirements

**Photography:**
- Hero: Warm-toned, shows people enjoying food
- Dishes: Close-up, steam visible, garnished
- Behind-scenes: Kitchen, chef, family photos
- Quality: High-res (1920px wide minimum)
- Style: Natural lighting, not overly saturated

**Icons:**
- Style: Outlined (not filled)
- Color: Match primary palette
- Size: 24px standard, 32px for primary actions
- Examples: Calendar, Clock, People, Phone

**Illustrations:**
- Empty states only
- Style: Simple line art
- Color: Single accent color
- Mood: Friendly, approachable

### Accessibility

**Text:**
- Minimum 16px body text
- 1.5 line-height for readability
- Contrast ratio: 4.5:1 (WCAG AA)
- Link text: Descriptive (not "click here")

**Images:**
- Alt text: Descriptive (not "image" or "photo")
- Example: "Steaming bowl of handmade fettuccine with fresh basil"
- Decorative images: Empty alt attribute

**Forms:**
- Labels: Visible (not placeholder-only)
- Errors: Announced to screen readers
- Required: Clearly marked
- Focus: Visible outline (not removed)

**Navigation:**
- Keyboard: Full keyboard navigation
- Skip links: "Skip to main content"
- Landmark roles: header, main, nav, footer
```

---

## Workflow Steps

When user runs `/shape-ux homepage`:

### Step 1: Read Section Spec

```typescript
// Read the PRD
const spec = readFile('product/sections/homepage/spec.md');

// Also read design system if exists
const colors = tryReadFile('product/design-system/colors.json');
const typography = tryReadFile('product/design-system/typography.json');
```

### Step 2: Generate Each Section

For each of the 5 elements:
1. Mental Model
2. Information Architecture
3. Affordances
4. System Feedback
5. Content Strategy

Think deeply about:
- What user expects
- How to make it clear
- What all states look like
- How content is presented

### Step 3: Write UX Spec

```typescript
// Write complete UX specification
writeFile('product/sections/homepage/ux-spec.md', uxSpec);
```

### Step 4: Save to ByteRover

```bash
brv curit "UX spec for homepage: mental model (user expects big food photo), IA (hero→dishes→booking), affordances (red CTA with lift, calendar picker), states (loading/error/empty defined), content (warm, family tone)" @product/sections/homepage/ux-spec.md
```

---

## Quality Checklist

Before completing, verify UX spec includes:

- ✅ Mental Model: Clear user expectations defined
- ✅ Information Architecture: All elements organized hierarchically
- ✅ Affordances: Every clickable/editable thing has visual signals
- ✅ System Feedback: All 4 states covered (success, error, loading, empty)
- ✅ Content Strategy: Tone, length, microcopy examples provided
- ✅ Accessibility: Basic WCAG guidelines considered
- ✅ Mobile: Responsive considerations noted
- ✅ Specificity: No vague descriptions (exact pixels, colors, behaviors)

---

## Example Output Format

```markdown
# Homepage UX Specification

Generated: 2026-01-12
Section: Homepage
Based on: product/sections/homepage/spec.md

---

## 1. Mental Model Alignment

[Mental model content]

---

## 2. Information Architecture

[IA content with hierarchy]

---

## 3. Affordance & Action

[All interactive elements defined]

---

## 4. System Feedback

[All states defined]

---

## 5. Content Strategy

[Tone, length, examples]

---

## Implementation Notes

- This UX spec should be used by Figma MCP for design
- This UX spec should be used by RALPH LOOP for implementation
- Query from ByteRover: `brv query "homepage affordances"`
```

---

## Integration with Workflow

This command fits between `/shape-section` and design/implementation:

```
/shape-section homepage    (PRD)
         ↓
/shape-ux homepage         (UX Spec) ← YOU ARE HERE
         ↓
/build-order homepage      (Sequential prompts)
         ↓
Figma MCP / RALPH LOOP     (Implementation)
```

---

## Notes

- This command is inspired by world-class product organizations
- The 5 elements are industry-standard UX considerations
- Skipping this step results in generic, vanilla UIs
- 3 hours of planning saves 10+ hours of revisions
- Prevents "agent guessing" during implementation

---

## Success Criteria

You'll know this command worked when:
- ✅ UX spec is comprehensive (not vague)
- ✅ Every interactive element has defined affordances
- ✅ All system states are documented
- ✅ Figma MCP/RALPH LOOP can query ByteRover for exact specs
- ✅ Implementation matches vision (not generic)
- ✅ Client says "This feels professional!" not "This is generic"
