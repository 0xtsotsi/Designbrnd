# Build Order - Generate Sequential Implementation Prompts

## Overview

This command transforms UX specifications into sequential, atomic prompts ready to paste into builder tools (Stitch, Polyat, Replit, etc.).

**Problem it solves:** Prevents overwhelming builders with too much context at once. Breaks work into digestible, sequential steps.

**Key insight:** Builder tools work best with focused, atomic prompts. Feed them the whole spec → generic output. Feed them step-by-step → professional output.

---

## Usage

```
/build-order <section-name>
```

**Example:**
```
/build-order homepage
```

---

## What This Command Does

1. **Reads** the UX specification + design tokens
2. **Breaks down** into atomic, sequential prompts
3. **Each prompt** = one focused implementation task
4. **Writes** to `product/sections/{section}/build-order.md`
5. **Saves** to ByteRover for implementation phase

---

## Build Order Structure

### Typical Sequence

```
1. Design Tokens Setup
   ↓
2. Layout Shell
   ↓
3. Primary Components (with all states)
   ↓
4. Secondary Components
   ↓
5. Interactions & Animations
   ↓
6. Responsive Refinement
   ↓
7. Accessibility Pass
   ↓
8. Final Polish
```

Each step builds on the previous. No skipping ahead.

---

## Prompt Requirements

Each prompt in the build order MUST:

### 1. Be Atomic
- One focused task
- Can be completed independently
- Takes 5-15 minutes to build
- Doesn't require other tasks to be done first (except dependencies)

### 2. Be Specific
- Exact measurements (1000px, not "tall")
- Exact colors (#DC2626, not "red")
- Exact behaviors ("Scale 1.02x on hover", not "hover effect")
- Exact states (loading, error, empty, success)

### 3. Include Context
- Why this matters (from mental model)
- How it fits (from IA)
- What it should feel like (from affordances)

### 4. Be Ready to Paste
- No placeholders ({value})
- No "configure this later"
- Complete specification
- Works as-is in builder tool

---

## Prompt Template

```markdown
## Prompt {N}: {Component Name}

**Context:** {Why this matters from UX spec}

**Build:**
{Specific implementation details}

**Specifications:**
- Dimensions: {exact sizes}
- Colors: {exact hex codes}
- Typography: {exact font/size/weight}
- Spacing: {exact padding/margins}

**Affordances:**
- Default: {how it looks}
- Hover: {exact hover behavior}
- Active: {exact click behavior}
- Focus: {exact keyboard focus}

**States:**
- Default: {normal state}
- Loading: {what shows during async}
- Success: {what shows on success}
- Error: {what shows on error}
- Empty: {what shows when no data}

**Responsive:**
- Desktop (1440px+): {behavior}
- Tablet (768px-1439px): {behavior}
- Mobile (<768px): {behavior}

**Accessibility:**
- Keyboard: {tab order, arrow keys}
- Screen reader: {labels, announcements}
- Contrast: {WCAG compliance}

**Next Step:**
After this is built, proceed to Prompt {N+1}
```

---

## Example Build Order

### Prompt 1: Design Tokens Setup

**Context:**
From UX spec mental model: Users expect warm, welcoming Italian restaurant atmosphere.

**Build:**
Create design token system for consistent styling across all components.

**Specifications:**

Colors:
```css
--color-primary: #DC2626 (Red - appetizing, passionate)
--color-secondary: #F59E0B (Gold - premium, warm)
--color-background: #FAFAF9 (Warm white)
--color-text: #1C1917 (Almost black)
--color-text-muted: #78716C (Gray)
--color-border: #E7E5E4 (Light gray)
--color-success: #16A34A (Green)
--color-error: #DC2626 (Red)
--color-warning: #F59E0B (Orange)
```

Typography:
```css
--font-display: 'Playfair Display', serif
--font-body: 'Open Sans', sans-serif

--text-hero: 64px/1.1 bold (Playfair)
--text-h1: 48px/1.2 bold (Playfair)
--text-h2: 32px/1.3 semibold (Playfair)
--text-body: 16px/1.5 regular (Open Sans)
--text-small: 14px/1.4 regular (Open Sans)
```

Spacing (8px grid):
```css
--space-xs: 8px
--space-sm: 16px
--space-md: 24px
--space-lg: 32px
--space-xl: 48px
--space-2xl: 64px
```

Shadows:
```css
--shadow-sm: 0 1px 2px rgba(0,0,0,0.05)
--shadow-md: 0 4px 6px rgba(0,0,0,0.1)
--shadow-lg: 0 10px 15px rgba(0,0,0,0.1)
```

**Next Step:** Once tokens are set up, proceed to Prompt 2 (Layout Shell)

---

### Prompt 2: Layout Shell

**Context:**
From IA: Content organized in clear sections (Hero → Featured → Booking → Footer).

**Build:**
Create responsive page layout shell with header, main sections, and footer.

**Specifications:**

Container:
- Max-width: 1440px
- Margin: 0 auto (centered)
- Padding: 0 16px (mobile), 0 32px (desktop)

Header:
- Height: 80px
- Background: white with bottom border
- Sticky: yes (stays on scroll)
- Z-index: 100

Main sections:
- Hero: full-width, 0 padding
- Featured: max-width container, 48px vertical padding
- Booking: max-width container, 48px vertical padding
- Footer: full-width, background gray

**Responsive:**
- Desktop (1440px+): Container full 1440px
- Tablet (768-1439px): Container 100% with padding
- Mobile (<768px): Container 100%, reduced padding (16px)

**Next Step:** With layout shell complete, proceed to Prompt 3 (Hero Section)

---

### Prompt 3: Hero Section - Structure

**Context:**
From mental model: User expects large, appetizing food photo immediately. This establishes "restaurant" identity.

**Build:**
Create hero section with background image, overlay, and centered content.

**Specifications:**

Container:
- Width: 100vw (full viewport)
- Height: 1000px (desktop), 600px (mobile)
- Position: relative

Background:
- Image: Parallax pasta dish photo
- Object-fit: cover
- Object-position: center

Overlay:
- Background: rgba(0, 0, 0, 0.5) (50% black)
- Purpose: Ensures text readability
- Z-index: 1

Content Container:
- Position: absolute center (both axes)
- Z-index: 2 (above overlay)
- Max-width: 800px
- Text-align: center
- Color: white

**Affordances:**
- None (hero is visual, not interactive)

**States:**
- Loading: Blur-up (low-res → high-res image)
- Loaded: Full resolution with smooth fade-in

**Responsive:**
- Desktop: 1000px height, large text
- Tablet: 800px height, medium text
- Mobile: 600px height, smaller text, vertical layout

**Accessibility:**
- Image alt: "Steaming bowl of handmade fettuccine with fresh basil"
- Semantic: <section> with aria-label="Hero"

**Next Step:** Hero structure complete. Proceed to Prompt 4 (Hero Content).

---

### Prompt 4: Hero Section - Content & CTA

**Context:**
From content strategy: Warm, family-oriented tone. CTA should be prominent and action-oriented.

**Build:**
Add headline, tagline, and primary CTA to hero section.

**Specifications:**

Headline:
- Text: "Mamma Mia's Italian Kitchen"
- Font: Playfair Display, 64px (desktop), 40px (mobile)
- Weight: bold
- Color: white
- Margin-bottom: 16px

Tagline:
- Text: "Authentic flavors, family traditions since 1982"
- Font: Open Sans, 24px (desktop), 18px (mobile)
- Weight: regular
- Color: rgba(255, 255, 255, 0.9)
- Margin-bottom: 32px

Primary CTA:
- Text: "Reserve Your Table"
- Background: var(--color-primary) #DC2626
- Color: white
- Font: Open Sans, 18px, semibold
- Padding: 16px 32px
- Border-radius: 8px
- Border: none

**Affordances:**

Button Default:
- Drop shadow: 0 4px 6px rgba(0,0,0,0.2)
- Cursor: pointer
- Transition: all 200ms ease

Button Hover:
- Transform: translateY(-4px)
- Shadow: 0 8px 12px rgba(0,0,0,0.3)
- Background: slightly lighter (#E53E3E)

Button Active:
- Transform: scale(0.98)
- Shadow: 0 2px 4px rgba(0,0,0,0.2)

Button Focus:
- Outline: 2px solid white
- Outline-offset: 2px

**States:**
- Default: As specified above
- Loading: Not applicable (hero CTA navigates, doesn't submit)

**Responsive:**
- Desktop: Button inline, normal padding
- Tablet: Button inline, normal padding
- Mobile: Button full-width, touch target 48px min height

**Accessibility:**
- Button: Proper <button> element (not div)
- Keyboard: Tabbable, Enter/Space activates
- Screen reader: Announces "Reserve Your Table, button"

**Next Step:** Hero complete. Proceed to Prompt 5 (Featured Dishes Grid).

---

### Prompt 5: Featured Dishes Grid

**Context:**
From IA: Featured dishes are secondary browse action. 3-column grid on desktop, stacked on mobile.

**Build:**
Create responsive grid of dish cards with images, names, descriptions, and prices.

**Specifications:**

Grid Container:
- Display: grid
- Columns: 3 (desktop), 2 (tablet), 1 (mobile)
- Gap: 24px
- Margin: 48px 0

Card Structure:
- Background: white
- Border: 1px solid var(--color-border)
- Border-radius: 12px
- Overflow: hidden
- Transition: all 200ms

Card Image:
- Width: 100%
- Height: 300px
- Object-fit: cover
- Loading: Lazy (below fold)

Card Content:
- Padding: 24px

Dish Name:
- Font: Playfair Display, 24px, semibold
- Color: var(--color-text)
- Margin-bottom: 12px

Description:
- Font: Open Sans, 16px, regular
- Color: var(--color-text-muted)
- Line-height: 1.5
- Margin-bottom: 16px
- Max-lines: 2 (ellipsis overflow)

Price:
- Font: Open Sans, 20px, bold
- Color: var(--color-primary)
- Text-align: right

**Affordances:**

Card Default:
- Shadow: var(--shadow-sm)
- Cursor: pointer

Card Hover:
- Transform: scale(1.02)
- Shadow: var(--shadow-md)
- Border-color: var(--color-primary)

Card Active:
- Transform: scale(0.99)

**States:**
- Default: 3 cards shown with actual data
- Loading: Skeleton placeholder cards (gray animated pulse)
- Error: "Unable to load dishes. Try refreshing."
- Empty: "Our chef is preparing something special! Check back tomorrow."

**Responsive:**
- Desktop (1440px+): 3 columns, gap 24px
- Tablet (768-1439px): 2 columns, gap 20px
- Mobile (<768px): 1 column, gap 16px

**Accessibility:**
- Cards: Semantic <article> elements
- Images: Descriptive alt text (dish name + key ingredients)
- Keyboard: Cards focusable, Enter/Space to click
- Screen reader: "Fettuccine Alfredo, $18.95, Hand-rolled pasta in rich cream sauce"

**Next Step:** Featured grid complete. Proceed to Prompt 6 (Booking Form).

---

### Prompt 6: Booking Form - Structure

**Context:**
From affordances: Form inputs need clear visual signals. From feedback: All states must be defined.

**Build:**
Create booking form container with date, time, party size inputs.

**Specifications:**

Form Container:
- Max-width: 400px
- Margin: 0 auto (centered)
- Padding: 32px
- Background: white
- Border: 1px solid var(--color-border)
- Border-radius: 12px
- Shadow: var(--shadow-md)

Form Fields (all):
- Margin-bottom: 24px
- Label above input
- Input full-width

Label:
- Font: Open Sans, 14px, semibold
- Color: var(--color-text)
- Margin-bottom: 8px
- Required: red asterisk (*)

Input Base Style:
- Height: 48px
- Padding: 12px 16px
- Border: 1px solid var(--color-border)
- Border-radius: 8px
- Font: Open Sans, 16px
- Transition: border-color 200ms

Date Picker:
- Icon: Calendar icon (right side, 24px)
- Placeholder: "Select date"
- Min date: Today
- Max date: 60 days from now

Time Selector:
- Type: Dropdown
- Options: 5:00 PM - 10:00 PM (30min intervals)
- Icon: Clock icon (right side, 24px)

Party Size:
- Type: Number input with +/- buttons
- Min: 1
- Max: 12
- Default: 2
- Buttons: 32x32px, rounded

**Affordances:**

Input Default:
- Border: 1px solid var(--color-border)
- Background: white

Input Focus:
- Border: 2px solid var(--color-primary)
- Outline: none (custom focus)
- Icon: Turns primary color

Input Hover:
- Border: 1px solid var(--color-primary) (lighter)

Input Disabled:
- Background: #F5F5F5
- Border: 1px solid #E0E0E0
- Cursor: not-allowed
- Opacity: 0.6

**States:**
- Default: All inputs enabled, empty
- Filled: Values entered, submit enabled
- Submitting: All inputs disabled, submit shows spinner
- Success: Form hidden, success message shown
- Error: Invalid inputs have red border + error message below

**Responsive:**
- Desktop/Tablet: 400px centered
- Mobile: Full-width with 16px padding

**Accessibility:**
- Labels: Associated with inputs (for/id)
- Required: aria-required="true"
- Errors: aria-invalid="true" + aria-describedby
- Focus: Visible focus indicator

**Next Step:** Form structure complete. Proceed to Prompt 7 (Form Submit & States).

---

### Prompt 7: Booking Form - Submit & States

**Context:**
From system feedback: User needs clear feedback for all states (submitting, success, error).

**Build:**
Add submit button and implement all form states with proper feedback.

**Specifications:**

Submit Button Default:
- Text: "Reserve Table"
- Width: 100%
- Height: 56px
- Background: var(--color-primary)
- Color: white
- Font: Open Sans, 18px, semibold
- Border: none
- Border-radius: 8px
- Cursor: pointer
- Disabled when: Any required field empty

**Affordances:**

Button Enabled:
- Background: var(--color-primary)
- Shadow: var(--shadow-md)
- Cursor: pointer

Button Hover:
- Background: #E53E3E (lighter red)
- Transform: translateY(-2px)
- Shadow: var(--shadow-lg)

Button Active:
- Transform: scale(0.98)

Button Disabled:
- Background: #D1D5DB (gray)
- Cursor: not-allowed
- No hover effect

**States Implementation:**

**Submitting State:**
- Button text: "Processing..." with spinner
- Button disabled: true
- All inputs disabled: true
- Duration: While async request in flight
- Timeout: Show "Taking longer than usual" after 5s

**Success State:**
- Hide form (fade out)
- Show success message:
  - Icon: Green checkmark animation
  - Heading: "Table Reserved!"
  - Message: "Check your email for confirmation"
  - Email: {user@email.com}
  - CTA: "View Reservation" button
- Duration: Permanent (until user navigates)

**Error States:**

Validation Errors (per field):
- Visual: Red border (2px solid var(--color-error))
- Message: Below field, red text, 14px
- Examples:
  - Date empty: "Please select a date"
  - Date past: "Please select a future date"
  - Time empty: "Please select a time"
  - Party size 0: "Please enter number of guests"
  - Party size > 12: "Max 12 guests per reservation. Call us for larger parties."

Network Error:
- Visual: Red toast notification (top-right)
- Message: "Connection lost. Please check your internet."
- Action: "Retry" button
- Fallback: "Or call us at (555) 123-4567"

No Availability Error:
- Visual: Orange warning banner above form
- Message: "No tables available at this time"
- Suggestion: Show next 3 available times as clickable chips
- Action: Clicking chip auto-populates form
- Alternative: "Add to waitlist" button

**Responsive:**
- Desktop/Tablet: Same as specified
- Mobile: Button touch-friendly (56px height)

**Accessibility:**
- Button: <button type="submit">
- Submitting: aria-busy="true"
- Errors: aria-live="polite" announcements
- Success: Focus moves to success message

**Next Step:** Form complete with all states. Proceed to Prompt 8 (Footer).

---

### Prompt 8: Footer Section

**Context:**
From IA: Footer is Level 4 support information. Should be present but not distracting.

**Build:**
Create footer with restaurant info, social links, and copyright.

**Specifications:**

Footer Container:
- Width: 100%
- Background: #F5F5F4 (light gray)
- Padding: 48px 32px
- Border-top: 1px solid var(--color-border)

Content Layout:
- Desktop: 3 columns (Contact, Hours, Social)
- Tablet: 2 columns (Contact+Hours, Social)
- Mobile: 1 column (stacked)
- Gap: 32px

Column Heading:
- Font: Playfair Display, 20px, semibold
- Color: var(--color-text)
- Margin-bottom: 16px

Column Text:
- Font: Open Sans, 16px, regular
- Color: var(--color-text-muted)
- Line-height: 1.6

Contact Info:
- Address: "123 Main Street, City, ST 12345"
- Phone: "(555) 123-4567" (clickable tel: link)
- Email: "info@mammamiaskitchen.com" (clickable mailto:)

Hours:
- Mon-Thu: 5:00 PM - 10:00 PM
- Fri-Sat: 5:00 PM - 11:00 PM
- Sun: 4:00 PM - 9:00 PM

Social Links:
- Icons: Facebook, Instagram, Twitter
- Size: 32x32px
- Color: var(--color-text-muted)
- Hover: var(--color-primary)
- Gap: 16px

Copyright:
- Text: "© 2026 Mamma Mia's Italian Kitchen. All rights reserved."
- Font: Open Sans, 14px, regular
- Color: var(--color-text-muted)
- Center aligned
- Margin-top: 32px
- Border-top: 1px solid var(--color-border)
- Padding-top: 32px

**Affordances:**

Phone Link:
- Text: Primary color
- Hover: Underline
- Mobile: Triggers call

Email Link:
- Text: Primary color
- Hover: Underline
- Action: Opens email client

Social Icons:
- Default: Muted color
- Hover: Primary color, scale 1.1x
- Cursor: pointer

**Accessibility:**
- Links: Descriptive text (not "click here")
- Icons: aria-label attributes
- Phone: Announced as "Call (555) 123-4567"
- Landmark: <footer> role="contentinfo"

**Next Step:** Footer complete. Proceed to Prompt 9 (Final Polish).

---

### Prompt 9: Final Polish & Refinement

**Context:**
All components built. Now refine interactions, transitions, and edge cases.

**Build:**
Add polish touches that make UI feel professional vs generic.

**Refinements:**

Smooth Scrolling:
- Behavior: smooth
- Applies to: Anchor links, "back to top"

Transitions:
- Duration: 200ms (fast), 300ms (standard), 500ms (slow)
- Easing: ease-in-out
- Properties: transform, opacity, colors

Loading Optimizations:
- Hero image: Priority load
- Below-fold images: Lazy load with intersection observer
- Fonts: Preload Playfair and Open Sans

Hover Enhancements:
- All clickable elements: Cursor pointer
- All cards: Subtle lift effect
- All buttons: Slight color shift

Focus Enhancements:
- Visible focus indicators on all interactive elements
- Focus trap in modals (if any)
- Skip links for keyboard users

Error Prevention:
- Required fields: Show asterisk
- Invalid input: Prevent submission
- Phone format: Auto-format as user types
- Email validation: Check format before submit

Micro-interactions:
- Button click: Subtle scale down (0.98x)
- Form submission: Success checkmark animation
- Toast notifications: Slide in from top-right
- Loading spinners: Smooth rotation

Performance:
- Images: WebP format with PNG fallback
- Icons: SVG (not icon font)
- CSS: Single stylesheet, critical CSS inline
- JS: Defer non-critical scripts

**Testing Checklist:**
- ✅ All interactive elements have hover states
- ✅ All forms have validation
- ✅ All images have alt text
- ✅ All buttons are keyboard accessible
- ✅ All colors meet WCAG contrast ratio
- ✅ Mobile touch targets 44x44px minimum
- ✅ Loading states work correctly
- ✅ Error states display properly
- ✅ Empty states show helpful messages

**Next Step:** Build order complete! Ready for implementation with Figma MCP or RALPH LOOP.

---

## Workflow Steps

When user runs `/build-order homepage`:

### Step 1: Read UX Specification

```typescript
// Read UX spec
const uxSpec = readFile('product/sections/homepage/ux-spec.md');

// Read design tokens
const colors = readFile('product/design-system/colors.json');
const typography = readFile('product/design-system/typography.json');

// Read section spec
const spec = readFile('product/sections/homepage/spec.md');
```

### Step 2: Identify Components

Break UX spec into atomic components:
- What can be built independently?
- What builds on other components?
- What's the logical sequence?

### Step 3: Create Sequential Prompts

For each component:
1. Context (why from UX spec)
2. Build instructions (what to create)
3. Specifications (exact details)
4. Affordances (how it should feel)
5. States (all scenarios)
6. Responsive (all breakpoints)
7. Accessibility (WCAG compliance)

### Step 4: Write Build Order

```typescript
// Write complete build order
writeFile('product/sections/homepage/build-order.md', buildOrder);
```

### Step 5: Save to ByteRover

```bash
brv curit "Build order for homepage: 9 sequential prompts from design tokens to final polish, each with exact specs and all states defined" @product/sections/homepage/build-order.md
```

---

## Quality Checklist

Before completing, verify build order:

- ✅ Each prompt is atomic (focused on one thing)
- ✅ Each prompt has exact specifications (no "configure later")
- ✅ Each prompt includes all states (default, hover, loading, error, empty)
- ✅ Each prompt is ready to paste into builder tool
- ✅ Prompts are in logical sequence (can't skip ahead)
- ✅ Design tokens defined first
- ✅ Layout shell before components
- ✅ All responsive breakpoints specified
- ✅ All accessibility requirements included
- ✅ Final prompt is polish/refinement

---

## Integration with Workflow

This command is the FINAL Design OS step before implementation:

```
/shape-section homepage    (PRD)
         ↓
/shape-ux homepage         (UX Spec)
         ↓
/build-order homepage      (Sequential prompts) ← YOU ARE HERE
         ↓
Figma MCP                  (Paste prompts one by one)
         ↓
RALPH LOOP                 (Paste prompts one by one)
```

---

## Usage in Implementation Phase

### With Figma MCP:

```bash
# Phase 2: Agent reads build order
brv query "homepage build order prompts"

# Agent pastes Prompt 1 into Figma MCP
# Reviews output
# Agent pastes Prompt 2
# Reviews output
# ... repeat for all prompts
```

### With RALPH LOOP:

```bash
# Phase 3: Agent reads build order
brv query "homepage build order prompts"

# Agent creates test from Prompt 3 specs
# Implements component matching exact specs
# All states defined in prompt are tested
# ... repeat for all prompts
```

---

## Notes

- Build order is inspired by real product teams' workflows
- Breaking into steps prevents "context overload" in builder tools
- Each prompt stands alone (builder tools have limited context)
- Exact specifications prevent "agent guessing"
- Result: Professional UI matching UX vision

---

## Success Criteria

You'll know this command worked when:
- ✅ Each prompt can be copy-pasted as-is
- ✅ No placeholders or "configure this later"
- ✅ All states are defined in each prompt
- ✅ Figma MCP/RALPH LOOP can follow prompts sequentially
- ✅ Implementation matches UX spec exactly
- ✅ No generic, vanilla output
- ✅ Client says "This is exactly what I envisioned!"
