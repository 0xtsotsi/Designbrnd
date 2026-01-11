# Figma Design Rules for Design OS Projects

## Document Organization

### Page Structure
- **Page 1: Brand Guidelines** - Color palette, typography scale, design tokens documentation
- **Page 2: Components** - All reusable components (buttons, inputs, cards, navigation, etc.)
- **Page 3+: Screens** - One page per section (Homepage, Menu, About, Contact, etc.)
- **Social Templates** - Social media post/story templates (if applicable)

### Spacing & Layout
- Do NOT put everything on the same coordinates
- Pages should have nice hierarchical structure with auto layouts
- Space elements vertically with proper gaps (never overlap)
- Use 8px grid system: 8, 16, 24, 32, 40, 48, 64, 80px

---

## Component Creation Standards

### Component Creation Process
- Components should be created using create-component tool
- All parts of the component should be ancestors of the component node
- Component properties should be added using `add-component-property` tool
- Component property usage on ancestors should be added by `set-node-component-property-references`

### Component Layout Rules
- If component uses **vertical auto layout**:
  - Component should use fixed width
  - Children should use `layoutSizingHorizontal: FILL`
- If component uses **horizontal auto layout**:
  - Component should use fixed height
  - Children should use `layoutSizingVertical: FILL`

### Auto Layout Requirements
- **Use auto layout for everything!**
- For columns layout: use horizontal auto layout
- For rows layout: use vertical auto layout
- Prefer Frames over Rectangles everywhere
- Input controls should be frames (allows flexibility of setting layout)

### Component Instances
- Consider using `layoutSizingHorizontal: FILL` if component needs full width of container
- Consider using `layoutSizingVertical: FILL` if component needs full height of container

---

## Component Library Standards

### Button Component
**Variants:** Primary, Secondary, Outline
**Sizes:** Small (36px), Medium (44px), Large (52px)
**States:** Default, Hover, Disabled

- Use horizontal auto layout
- Padding: 12px (sm), 16px (md), 20px (lg)
- Border-radius: 8px
- Use component properties for variant selection
- Use color styles (never hard-coded hex values)
- Text should use text styles from brand guidelines

### Input Field Component
**Types:** Text, Email, Password, TextArea
**States:** Default, Focus, Error, Disabled

- Height: 48px (for text inputs)
- Padding: 12px horizontal, 14px vertical
- Border: 1px stroke
- Border-radius: 6px
- Use vertical auto layout for label + input pairing
- Label spacing: 8px gap
- Use component properties for type and state

### Card Component
**Variants:** Default, Elevated, Outlined
**Sections:** Header, Body, Footer

- Use vertical auto layout
- Padding: 24px
- Border-radius: 8px
- Gap between sections: 16px
- Shadow: Use effect styles (0px 2px 8px rgba(0,0,0,0.1) for elevated)
- Allow FILL sizing for content areas

### Navigation Component
**Variants:** Mobile, Desktop
**States:** Default, Sticky

- Desktop: Horizontal auto layout
- Mobile: Vertical auto layout
- Padding: 16px (mobile), 24px (desktop)
- Logo area + menu items + actions
- Use component properties for active states
- Menu items should use hover states

---

## Typography System

### Text Styles Required
Create text styles for all typography:

**Display (Heading Font):**
- Display/H1: 48px, weight 700, line-height 1.2
- Display/H2: 40px, weight 700, line-height 1.2
- Display/H3: 32px, weight 600, line-height 1.3
- Display/H4: 24px, weight 600, line-height 1.4

**Body (Body Font):**
- Body/Large: 18px, weight 400, line-height 1.6
- Body/Medium: 16px, weight 400, line-height 1.5
- Body/Small: 14px, weight 400, line-height 1.5
- Caption: 12px, weight 400, line-height 1.4

**Usage:**
- Always use text styles (never hard-code font settings)
- Use semantic naming (H1 for main headlines, H2 for sections, etc.)
- Mobile: Reduce font sizes by 25-30% (H1: 48px → 32px)

---

## Color System

### Color Variables Required
Create color styles for all brand colors from Design OS tokens:

**Primary Color:**
- Primary/50 through Primary/900 (9 shades)
- Primary/500 as default brand color

**Secondary Color:**
- Secondary/50 through Secondary/900 (9 shades)
- Secondary/500 as default

**Neutral Colors:**
- Neutral/50 through Neutral/900 (stone/gray palette)
- Use for backgrounds, borders, text

**Semantic Colors:**
- Success: Green shades for positive actions
- Error: Red shades for errors/warnings
- Warning: Yellow/orange for caution

### Color Usage Rules
- Use color styles for ALL colors (never use hex codes directly)
- Support light and dark mode variants where applicable
- Backgrounds: Neutral/50 (light), Neutral/900 (dark)
- Text: Neutral/900 (light mode), Neutral/50 (dark mode)
- Borders: Neutral/200 (light), Neutral/700 (dark)

---

## Screen Design Standards

### Desktop Layouts (1440px width)
- Container max-width: 1280px
- Horizontal padding: 80px
- Section vertical spacing: 80px
- Use horizontal auto layout for multi-column sections
- Grid columns: 12-column grid, 24px gutters

### Mobile Layouts (375px width)
- Horizontal padding: 16px
- Section vertical spacing: 48px
- Stack all columns to single column (vertical auto layout)
- Touch targets: Minimum 44x44px for buttons/links

### Responsive Patterns
- Desktop multi-column → Mobile single column
- Horizontal navigation → Vertical hamburger menu
- Large hero images → Smaller, optimized images
- Reduce font sizes (see Typography section)

---

## Common Screen Sections

### Hero Section
- Height: 600px (desktop), 400px (mobile)
- Background image with overlay (40% black for text readability)
- Centered content: Headline (H1), Subheadline (Body/Large), CTA (Button/Large)
- Use vertical auto layout for text stacking (24px gaps)

### Content Grid (3-column)
- Desktop: Horizontal auto layout, 3 items, 24px gap
- Mobile: Vertical auto layout, 1 item, 24px gap
- Each item: Card component with image, title (H3), description, CTA

### Testimonial Section
- 2-column layout (desktop), 1-column (mobile)
- Card components with quote, author name, rating
- Gap: 32px between cards

### Footer CTA Section
- Background: Primary color
- Centered content: Headline (H2), CTA (Button/Large)
- Padding: 64px vertical, 80px horizontal

---

## Social Media Templates

### Instagram Post (1080x1080)
- Use vertical auto layout
- Padding: 60px
- Include brand colors and typography
- Clear areas for image, headline, description
- Logo placement: Top-left or bottom-right

### Instagram Story (1080x1920)
- Safe zones: 250px top, 250px bottom
- Use vertical auto layout
- Content centered in safe zone
- Touch targets for interaction: 44px minimum

### Facebook Cover (1200x630)
- Horizontal auto layout
- Logo + brand message + CTA
- Account for profile picture overlap (left side)

---

## Naming Conventions

### Components
- Use PascalCase: `ButtonPrimary`, `CardElevated`, `InputText`
- Descriptive and semantic names

### Frames & Layers
- Use kebab-case: `hero-section`, `featured-dishes-grid`, `cta-button`
- Clear, descriptive names for easy navigation

### Component Properties
- Use camelCase: `buttonVariant`, `inputState`, `cardSize`
- Boolean properties: `isDisabled`, `hasIcon`, `isActive`

---

## Quality Checklist

Before marking design complete, verify:

- [ ] All components use auto layout
- [ ] All colors use color styles (no hard-coded hex)
- [ ] All text uses text styles (no hard-coded fonts)
- [ ] Components organized on "Components" page
- [ ] Screens organized on separate pages
- [ ] Desktop (1440px) and Mobile (375px) versions created
- [ ] Proper spacing (8px grid system)
- [ ] No overlapping elements
- [ ] Component properties set up correctly
- [ ] Component instances used (not duplicates)
- [ ] Naming conventions followed
- [ ] Responsive layouts tested (FILL sizing where needed)

---

## Integration with Design OS

### Design Token Sync
- Import colors from `design-system/colors.json`
- Import typography from `design-system/typography.json`
- Maintain consistency between Design OS and Figma

### Component Matching
- Figma components should match Design OS `/design-screen` outputs
- Use same naming conventions
- Same variant structure (Primary/Secondary, Small/Medium/Large)

### Handoff to Development
- Enable Figma Dev Mode for developer access
- Export assets in @1x, @2x, @3x for responsive images
- Document component properties for developer reference
- Provide CSS variable names matching design tokens

---

## Performance & Best Practices

### File Organization
- Keep components library clean and organized
- Archive unused components
- Use clear naming for easy search
- Group related components (Forms, Navigation, Cards, etc.)

### Prototyping
- Add basic interactions for user flow testing
- Link screens together for client review
- Use overlays for modals/dropdowns
- Prototype mobile navigation (hamburger menu)

### Collaboration
- Use comments for client feedback
- Version control for design iterations
- Share links with "View Only" for client review
- Share links with "Can Edit" for team collaboration

---

## Example AI Prompts

### Create Component Library
```
Using the design tokens from colors.json and typography.json, create a complete
component library on the "Components" page with Button, Input, Card, and
Navigation components. Follow all rules in claude.md for auto layout,
component properties, and naming conventions.
```

### Create Screen Design
```
Using the approved component library and the homepage spec from
product/sections/homepage/spec.md, create a homepage design on the
"Screens/Homepage" page. Include hero section, content grid, testimonials,
and footer CTA. Create both desktop (1440px) and mobile (375px) versions.
Follow all spacing and layout rules from claude.md.
```

### Iterate on Design
```
Update the homepage hero section: increase height to 800px, change CTA
button to Secondary variant, and add a second CTA button (Outline variant).
Maintain proper spacing using auto layout.
```

---

**Token Count Target:** ~2,450 tokens
**Last Updated:** 2026-01-10
**For:** Design OS + Figma MCP Workflow
