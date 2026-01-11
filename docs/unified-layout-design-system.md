# Unified Layout & Design System
## Vibe Kanban Aesthetic + AutoMaker Sidebar Navigation

---

## Overview

This document defines the **complete UI/UX specification** for Designbrnd, combining:
- **Vibe Kanban design philosophy**: Deep dark theme, developer-centric aesthetics
- **AutoMaker-style sidebar**: Collapsible navigation with tool integration
- **Unified layout system**: Consistent spacing, typography, and components

---

## Part 1: Design Philosophy

### Visual Identity: "Developer-First Dark Minimalism"

**Core Principles:**
1. **Deep Dark Mode** - Pure black backgrounds (#000000) with high-contrast text
2. **Typography Hierarchy** - JetBrains Mono for data, Inter for UI
3. **Minimalist Cards** - Subtle borders, no heavy shadows, micro-interactions
4. **Monochrome Base** - Zinc/Slate grays with strategic accent colors
5. **Spatial Clarity** - Generous whitespace, clear visual hierarchy

**Inspiration:**
- Vibe Kanban's developer-centric workflow management
- AutoMaker's clean sidebar navigation
- Linear's polished dark UI
- Vercel's minimalist design system

---

## Part 2: Color System

### Base Theme: "Midnight" (Default)

```typescript
export const designbrndTheme = {
  colors: {
    // Backgrounds
    bg: {
      primary: '#000000',      // Pure black - main background
      secondary: '#09090b',    // Zinc-950 - cards, panels
      tertiary: '#18181b',     // Zinc-900 - hover states
      elevated: '#27272a',     // Zinc-800 - modals, popovers
    },

    // Borders
    border: {
      default: '#27272a',      // Zinc-800 - default borders
      hover: '#3f3f46',        // Zinc-700 - hover state
      active: '#52525b',       // Zinc-600 - active state
      subtle: '#18181b',       // Zinc-900 - very subtle dividers
    },

    // Text
    text: {
      primary: '#fafafa',      // Zinc-50 - headings, important text
      secondary: '#a1a1aa',    // Zinc-400 - body text
      tertiary: '#71717a',     // Zinc-500 - muted text
      disabled: '#52525b',     // Zinc-600 - disabled state
    },

    // Accents (Status & Actions)
    accent: {
      primary: '#06b6d4',      // Cyan-500 - primary actions, links
      blue: '#3b82f6',         // Blue-500 - in progress
      green: '#22c55e',        // Green-500 - success, completed
      yellow: '#eab308',       // Yellow-500 - warning, needs attention
      red: '#ef4444',          // Red-500 - error, blocked
      purple: '#8b5cf6',       // Purple-500 - design phase
      orange: '#f97316',       // Orange-500 - build phase
    },

    // Sidebar Specific
    sidebar: {
      bg: '#0a0f1a',           // Slightly blue-tinted black
      border: '#1e293b',       // Slate-800 - sidebar border
      itemHover: '#1e293b',    // Slate-800 - item hover
      itemActive: '#334155',   // Slate-700 - active item
      headerBg: '#0a0f1a',     // Same as sidebar bg
    },
  },
};
```

### Additional Themes (Switchable)

**Slate Theme** - Cool grays
```typescript
bg: { primary: '#0f172a', secondary: '#1e293b', tertiary: '#334155' }
```

**Obsidian Theme** - Warm blacks
```typescript
bg: { primary: '#0a0a0a', secondary: '#171717', tertiary: '#262626' }
```

**Ocean Theme** - Blue-tinted darks
```typescript
bg: { primary: '#001a2e', secondary: '#002a4a', tertiary: '#003d66' }
```

**Forest Theme** - Green-tinted darks
```typescript
bg: { primary: '#001a0a', secondary: '#002a14', tertiary: '#003d1f' }
```

---

## Part 3: Typography System

### Font Stack

```css
/* UI Text - Sans Serif */
--font-ui: 'Inter', system-ui, -apple-system, sans-serif;

/* Code/Data - Monospace */
--font-mono: 'JetBrains Mono', 'Fira Code', 'Consolas', monospace;

/* Display - For large headings (optional) */
--font-display: 'Inter', sans-serif;
```

### Type Scale

```typescript
export const typography = {
  // Display (Marketing, landing pages)
  display: {
    fontSize: '4.5rem',      // 72px
    lineHeight: 1.1,
    fontWeight: 700,
    letterSpacing: '-0.02em',
    fontFamily: 'var(--font-display)',
  },

  // Headings
  h1: {
    fontSize: '2.25rem',     // 36px
    lineHeight: 1.2,
    fontWeight: 600,
    letterSpacing: '-0.01em',
    fontFamily: 'var(--font-ui)',
  },
  h2: {
    fontSize: '1.875rem',    // 30px
    lineHeight: 1.3,
    fontWeight: 600,
    letterSpacing: '-0.01em',
  },
  h3: {
    fontSize: '1.5rem',      // 24px
    lineHeight: 1.4,
    fontWeight: 600,
  },
  h4: {
    fontSize: '1.25rem',     // 20px
    lineHeight: 1.5,
    fontWeight: 600,
  },
  h5: {
    fontSize: '1.125rem',    // 18px
    lineHeight: 1.5,
    fontWeight: 600,
  },

  // Body text
  body: {
    fontSize: '1rem',        // 16px
    lineHeight: 1.6,
    fontWeight: 400,
    fontFamily: 'var(--font-ui)',
  },
  bodySmall: {
    fontSize: '0.875rem',    // 14px
    lineHeight: 1.5,
    fontWeight: 400,
  },

  // UI elements
  label: {
    fontSize: '0.875rem',    // 14px
    lineHeight: 1.4,
    fontWeight: 500,
    letterSpacing: '0.01em',
  },
  caption: {
    fontSize: '0.75rem',     // 12px
    lineHeight: 1.4,
    fontWeight: 400,
    letterSpacing: '0.02em',
  },

  // Code/Data
  code: {
    fontSize: '0.875rem',    // 14px
    lineHeight: 1.7,
    fontWeight: 400,
    fontFamily: 'var(--font-mono)',
  },
  codeInline: {
    fontSize: '0.875em',     // 87.5% of parent
    fontFamily: 'var(--font-mono)',
    backgroundColor: 'var(--color-bg-secondary)',
    padding: '0.125rem 0.375rem',
    borderRadius: '0.25rem',
  },
};
```

### Usage Guidelines

**Use JetBrains Mono for:**
- Code blocks
- JSON/data displays
- Terminal output
- File paths
- Technical IDs
- Timestamps (HH:MM:SS format)

**Use Inter for:**
- All UI text
- Navigation labels
- Button text
- Form inputs
- Headings
- Body copy
- Descriptions

---

## Part 4: Layout System

### Master Layout Structure

```
┌─────────────────────────────────────────────────────────────────────┐
│                        DESIGNBRND APPLICATION                        │
└─────────────────────────────────────────────────────────────────────┘

┌──────────────┬───────────────────────────────────────────────────────┐
│   SIDEBAR    │              MAIN CONTENT AREA                        │
│   (224px)    │                                                       │
│  Collapsed:  │                                                       │
│   (64px)     │                                                       │
│              │  ┌─────────────────────────────────────────────────┐ │
│              │  │  Page Header (if applicable)                    │ │
│  ┌────────┐  │  └─────────────────────────────────────────────────┘ │
│  │ Logo   │  │                                                       │
│  │ Brand  │  │  ┌─────────────────────────────────────────────────┐ │
│  └────────┘  │  │                                                 │ │
│              │  │                                                 │ │
│  [+ New]     │  │          Main Content                           │ │
│  [Folders]   │  │                                                 │ │
│              │  │          (Kanban Board, Forms, etc.)            │ │
│  ┌────────┐  │  │                                                 │ │
│  │Project │  │  │                                                 │ │
│  └────────┘  │  │                                                 │ │
│              │  └─────────────────────────────────────────────────┘ │
│  PROJECT     │                                                       │
│  • Kanban    │                                                       │
│              │                                                       │
│  TOOLS       │                                                       │
│  • Plannot.. │                                                       │
│  • ShowMe    │                                                       │
│  • Beads     │                                                       │
│  • Design OS │                                                       │
│  • Terminal  │                                                       │
│              │                                                       │
│  ┌────────┐  │                                                       │
│  │ Wiki   │  │                                                       │
│  │ Agents │  │                                                       │
│  │ Settings│  │                                                       │
│  └────────┘  │                                                       │
└──────────────┴───────────────────────────────────────────────────────┘
```

### Spacing System

```typescript
export const spacing = {
  // Base unit: 4px (0.25rem)
  0: '0',
  1: '0.25rem',    // 4px
  2: '0.5rem',     // 8px
  3: '0.75rem',    // 12px
  4: '1rem',       // 16px
  5: '1.25rem',    // 20px
  6: '1.5rem',     // 24px
  8: '2rem',       // 32px
  10: '2.5rem',    // 40px
  12: '3rem',      // 48px
  16: '4rem',      // 64px
  20: '5rem',      // 80px
  24: '6rem',      // 96px

  // Layout-specific
  sidebar: {
    expanded: '14rem',     // 224px (w-56)
    collapsed: '4rem',     // 64px (w-16)
  },
  kanban: {
    lane: '20rem',         // 320px
    card: '17.5rem',       // 280px
    gap: '0.75rem',        // 12px
  },
  header: {
    height: '3.5rem',      // 56px
  },
};
```

### Breakpoints

```typescript
export const breakpoints = {
  sm: '640px',     // Small devices
  md: '768px',     // Tablets
  lg: '1024px',    // Desktops
  xl: '1280px',    // Large desktops
  '2xl': '1536px', // Extra large screens
};
```

---

## Part 5: Sidebar Navigation (AutoMaker Style)

### Sidebar Structure

```typescript
interface SidebarSection {
  id: string;
  title: string;
  items: SidebarItem[];
}

interface SidebarItem {
  id: string;
  label: string;
  icon: LucideIcon;
  path: string;
  badge?: number;
  active?: boolean;
}

const sidebarSections: SidebarSection[] = [
  {
    id: 'project',
    title: 'PROJECT',
    items: [
      { id: 'kanban', label: 'Kanban Board', icon: Kanban, path: '/kanban' },
    ],
  },
  {
    id: 'tools',
    title: 'TOOLS',
    items: [
      { id: 'plannotator', label: 'Plannotator', icon: FileCheck, path: '/plannotator' },
      { id: 'showme', label: 'ShowMe', icon: Image, path: '/showme' },
      { id: 'beads', label: 'Beads', icon: ListChecks, path: '/beads' },
      { id: 'design-os', label: 'Design OS', icon: Layers, path: '/' },
      { id: 'terminal', label: 'Terminal', icon: Terminal, path: '/terminal' },
    ],
  },
  {
    id: 'bottom',
    title: 'BOTTOM SECTION',
    items: [
      { id: 'wiki', label: 'Wiki', icon: BookOpen, path: '/wiki' },
      { id: 'agents', label: 'Running Agents', icon: Zap, path: '/agents', badge: 1 },
      { id: 'settings', label: 'Settings', icon: Settings, path: '/settings' },
    ],
  },
];
```

### Sidebar Components

```
Sidebar/
├── Header
│   ├── Logo (Cyan icon + "designbrnd." text)
│   ├── Notification Badge (Red dot with count)
│   └── Settings Icon
│
├── Action Buttons
│   ├── + New Button (Primary CTA)
│   └── Folder Count (Shows "5")
│
├── Current Project Display
│   ├── Project Icon (Folder icon, cyan)
│   ├── Project Name ("Designbrnd Project")
│   ├── Dropdown Arrow
│   └── More Options (⋮)
│
├── Navigation Sections (Scrollable)
│   ├── PROJECT Section
│   │   └── Kanban Board
│   │
│   └── TOOLS Section
│       ├── Plannotator
│       ├── ShowMe
│       ├── Beads
│       ├── Design OS
│       └── Terminal
│
└── Bottom Section (Fixed at bottom)
    ├── Wiki
    ├── Running Agents (with badge)
    ├── Settings
    └── Theme Selector (Palette icon)
```

### Sidebar States

**Expanded (Default):**
- Width: 224px (14rem, w-56)
- Shows full text labels
- Icons + text horizontally aligned

**Collapsed:**
- Width: 64px (4rem, w-16)
- Icons only
- Tooltips on hover
- Keyboard shortcut: `Cmd/Ctrl + B`

**Active State:**
- Background: `bg-stone-800` or theme-specific active color
- Text: `text-white` or `text-cyan-400` (for PROJECT items)
- Left border accent (optional): 2px cyan line

**Hover State:**
- Background: `bg-stone-800/50`
- Smooth transition: 150ms ease

---

## Part 6: Kanban Board Layout

### Board Structure

```
┌──────────────────────────────────────────────────────────────────────┐
│  Kanban Board Header                                                 │
│  ┌────────────────┬─────────────────┬──────────────────────────┐    │
│  │ Project Name   │ View Options    │ Search, Filter, +New     │    │
│  └────────────────┴─────────────────┴──────────────────────────┘    │
└──────────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────────┐
│  Lanes Container (Horizontal Scroll)                                 │
│                                                                       │
│  ┌────────┐  ┌────────┐  ┌────────┐  ┌────────┐  ┌────────┐       │
│  │📝      │  │🎨      │  │📐      │  │🔨      │  │✅      │       │
│  │Discov. │  │Design  │  │Planning│  │Build   │  │Done    │       │
│  │(3)     │  │(5)     │  │(2)     │  │(4)     │  │(12)    │       │
│  ├────────┤  ├────────┤  ├────────┤  ├────────┤  ├────────┤       │
│  │┌──────┐│  │┌──────┐│  │┌──────┐│  │┌──────┐│  │┌──────┐│       │
│  ││ Card ││  ││ Card ││  ││ Card ││  ││ Card ││  ││ Card ││       │
│  │└──────┘│  │└──────┘│  │└──────┘│  │└──────┘│  │└──────┘│       │
│  │┌──────┐│  │┌──────┐│  │┌──────┐│  │┌──────┐│  │┌──────┐│       │
│  ││ Card ││  ││ Card ││  │└──────┘│  ││ Card ││  ││ Card ││       │
│  │└──────┘│  │└──────┘│            │  │└──────┘│  │└──────┘│       │
│  │┌──────┐│  │┌──────┐│            │  │┌──────┐│  │        │       │
│  ││ Card ││  ││ Card ││            │  ││ Card ││  │        │       │
│  │└──────┘│  │└──────┘│            │  │└──────┘│  │        │       │
│  │        │  │┌──────┐│            │  │┌──────┐│  │        │       │
│  │        │  ││ Card ││            │  ││ Card ││  │        │       │
│  │        │  │└──────┘│            │  │└──────┘│  │        │       │
│  │        │  │┌──────┐│            │  │        │  │        │       │
│  │ +Add   │  ││ Card ││            │  │ +Add   │  │        │       │
│  │        │  │└──────┘│            │  │        │  │        │       │
│  │        │  │ +Add   │            │  │        │  │        │       │
│  └────────┘  └────────┘  └────────┘  └────────┘  └────────┘       │
└──────────────────────────────────────────────────────────────────────┘
```

### Lane Specifications

**Dimensions:**
- Width: 320px (20rem) - Fixed
- Padding: 12px (0.75rem)
- Gap between lanes: 16px (1rem)
- Border: 1px solid `border-default` (#27272a)
- Border radius: 8px (0.5rem)
- Background: `bg-secondary` (#09090b)

**Lane Header:**
- Height: 48px (3rem)
- Icon: 24px (1.5rem)
- Title: Font size 14px, font-weight 600
- Card count: Font size 12px, muted color

**Lane Colors (Border top accent):**
- Discovery: Blue (#3b82f6) - 2px top border
- Design: Purple (#8b5cf6)
- Planning: Yellow (#eab308)
- Build: Orange (#f97316)
- Done: Green (#22c55e)

---

## Part 7: Card Component Design

### Card Structure

```
┌─────────────────────────────────────────┐
│  Card Title (1-2 lines, truncate)      │ ← 16px font, semibold
│  ─────────────────────────────────────  │
│  Description preview (3 lines max...)   │ ← 14px font, muted
│                                         │
│  ┌──────────┐  ┌──────────┐           │
│  │🎨 Mockup │  │📐 Plan   │           │ ← Integration badges
│  └──────────┘  └──────────┘           │
│                                         │
│  ☑ 3/5 tasks completed  ───────── 60% │ ← Progress bar
│                                         │
│  🏷 design  🏷 urgent   👤 @you       │ ← Tags + assignee
│  ────────────────────────────────────  │
│  Updated 2h ago                        │ ← Timestamp
└─────────────────────────────────────────┘
```

### Card Specifications

**Dimensions:**
- Width: 280px (fills lane width minus padding)
- Min height: 120px
- Max height: Auto (with scroll if very long)
- Padding: 16px (1rem)
- Margin bottom: 12px (0.75rem) - gap between cards
- Border: 1px solid `border-default`
- Border radius: 6px (0.375rem)
- Background: `bg-tertiary` (#18181b)

**States:**
- Default: border-default
- Hover: border-hover, scale(1.02), shadow-sm
- Dragging: opacity-50, border-accent-primary
- Active/Selected: border-accent-primary (2px)

**Typography:**
- Title: 16px (1rem), font-weight 600, line-clamp-2
- Description: 14px (0.875rem), text-secondary, line-clamp-3
- Meta text: 12px (0.75rem), text-tertiary

**Interactive Elements:**
- Entire card is clickable → Opens detail panel
- Hover shows quick actions (Edit, Delete, Move)
- Drag handle (⋮⋮) appears on hover

---

## Part 8: Component Library

### Buttons

```typescript
// Button Variants
const buttonVariants = {
  // Primary - Main CTAs
  primary: {
    bg: 'bg-cyan-500',
    hover: 'hover:bg-cyan-600',
    text: 'text-white',
    border: 'border-transparent',
  },

  // Secondary - Less prominent actions
  secondary: {
    bg: 'bg-stone-800',
    hover: 'hover:bg-stone-700',
    text: 'text-stone-200',
    border: 'border-stone-700',
  },

  // Ghost - Minimal, icon buttons
  ghost: {
    bg: 'bg-transparent',
    hover: 'hover:bg-stone-800',
    text: 'text-stone-400',
    border: 'border-transparent',
  },

  // Outline - Borders, secondary actions
  outline: {
    bg: 'bg-transparent',
    hover: 'hover:bg-stone-800',
    text: 'text-stone-300',
    border: 'border-stone-700',
  },

  // Danger - Destructive actions
  danger: {
    bg: 'bg-red-500',
    hover: 'hover:bg-red-600',
    text: 'text-white',
    border: 'border-transparent',
  },
};

// Button Sizes
const buttonSizes = {
  sm: 'h-8 px-3 text-sm',        // 32px height
  md: 'h-10 px-4 text-base',     // 40px height (default)
  lg: 'h-12 px-6 text-lg',       // 48px height
  icon: 'h-10 w-10',             // Square icon button
};
```

### Inputs

```typescript
const inputStyles = {
  base: 'w-full bg-stone-900 border border-stone-700 rounded-md px-3 py-2 text-sm text-stone-100 placeholder:text-stone-500 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:border-transparent',
  error: 'border-red-500 focus:ring-red-500',
  disabled: 'opacity-50 cursor-not-allowed',
};
```

### Badges

```typescript
const badgeVariants = {
  default: 'bg-stone-800 text-stone-300 border-stone-700',
  primary: 'bg-cyan-500/20 text-cyan-400 border-cyan-500/30',
  success: 'bg-green-500/20 text-green-400 border-green-500/30',
  warning: 'bg-yellow-500/20 text-yellow-400 border-yellow-500/30',
  danger: 'bg-red-500/20 text-red-400 border-red-500/30',
  purple: 'bg-purple-500/20 text-purple-400 border-purple-500/30',
};
```

---

## Part 9: Animations & Transitions

### Standard Transitions

```css
/* Default transition for interactive elements */
.transition-default {
  transition: all 150ms cubic-bezier(0.4, 0, 0.2, 1);
}

/* Slower transition for layout changes */
.transition-layout {
  transition: all 200ms cubic-bezier(0.4, 0, 0.2, 1);
}

/* Fast transitions for micro-interactions */
.transition-fast {
  transition: all 100ms cubic-bezier(0.4, 0, 0.2, 1);
}
```

### Micro-interactions

**Card Hover:**
```css
.card {
  transition: transform 150ms ease, box-shadow 150ms ease;
}
.card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
}
```

**Button Press:**
```css
.button:active {
  transform: scale(0.98);
}
```

**Sidebar Toggle:**
```css
.sidebar {
  transition: width 200ms cubic-bezier(0.4, 0, 0.2, 1);
}
```

**Drag and Drop:**
```css
.card-dragging {
  opacity: 0.5;
  transition: opacity 200ms ease;
}
.lane-drop-target {
  background: rgba(6, 182, 212, 0.1);
  border: 2px dashed #06b6d4;
}
```

---

## Part 10: Responsive Design

### Mobile (< 640px)

- Sidebar collapses to bottom navigation bar
- Kanban lanes stack vertically
- Cards full width
- Detail panels become full-screen modals

### Tablet (640px - 1024px)

- Sidebar remains visible but collapsed by default
- Kanban lanes scroll horizontally (2-3 visible)
- Cards maintain fixed width
- Detail panels slide in from right (50% width)

### Desktop (> 1024px)

- Full sidebar (expanded by default)
- Kanban board shows 3-4 lanes simultaneously
- Detail panels slide in from right (600px width)
- Optimal viewing experience

---

## Part 11: Implementation Checklist

### Phase 1: Foundation (Week 1)
- [ ] Set up Tailwind config with Vibe color palette
- [ ] Add JetBrains Mono and Inter fonts
- [ ] Create design tokens (colors, spacing, typography)
- [ ] Build base component library (Button, Input, Badge, Card)
- [ ] Implement dark theme CSS variables

### Phase 2: Sidebar Navigation (Week 1-2)
- [ ] Build Sidebar component with expand/collapse
- [ ] Add navigation items with icons (Plannotator, ShowMe, Beads, etc.)
- [ ] Implement active state highlighting
- [ ] Add + New button and project selector
- [ ] Create theme selector modal
- [ ] Add keyboard shortcut (Cmd+B to toggle)

### Phase 3: Kanban Board (Week 2-3)
- [ ] Install @dnd-kit for drag-and-drop
- [ ] Build KanbanBoard container component
- [ ] Create Lane component with header and card list
- [ ] Build Card component with all states
- [ ] Implement Zustand board store
- [ ] Add drag-and-drop functionality

### Phase 4: Card Detail Panel (Week 3-4)
- [ ] Create CardDetail slide-over component
- [ ] Add markdown description editor
- [ ] Build checklist UI with progress bar
- [ ] Implement comment system
- [ ] Add tags and assignee UI
- [ ] Create activity feed timeline

### Phase 5: Tool Integration (Week 4-5)
- [ ] Build ShowMePreview component
- [ ] Build PlannotatorPreview component
- [ ] Add Design OS section links
- [ ] Implement Beads task tracking integration
- [ ] Connect all tools to card data model

### Phase 6: Polish & Responsive (Week 5-6)
- [ ] Add loading states and skeletons
- [ ] Implement empty states
- [ ] Create responsive layouts (mobile, tablet)
- [ ] Add error handling and validation
- [ ] Optimize animations and performance
- [ ] Add keyboard shortcuts guide
- [ ] Write documentation

---

## Part 12: File Structure

```
Designbrnd/
├── src/
│   ├── components/
│   │   ├── layout/
│   │   │   ├── Sidebar.tsx              ✅ Main sidebar
│   │   │   ├── SidebarNav.tsx           ✅ Navigation items
│   │   │   ├── SidebarToggle.tsx        ✅ Collapse button
│   │   │   ├── SidebarFooter.tsx        ✅ Bottom section
│   │   │   └── AppLayout.tsx            ✅ Master layout
│   │   │
│   │   ├── kanban/
│   │   │   ├── KanbanBoard.tsx          🔲 Board container
│   │   │   ├── Lane.tsx                 🔲 Column component
│   │   │   ├── Card.tsx                 🔲 Task card
│   │   │   ├── CardDetail.tsx           🔲 Detail panel
│   │   │   └── AddCardButton.tsx        🔲 Inline add
│   │   │
│   │   ├── integrations/
│   │   │   ├── ShowMePreview.tsx        🔲 ShowMe embed
│   │   │   ├── PlannotatorPreview.tsx   🔲 Plannotator embed
│   │   │   └── ActivityFeed.tsx         🔲 Timeline
│   │   │
│   │   └── ui/
│   │       ├── button.tsx               ✅ Button variants
│   │       ├── input.tsx                ✅ Input field
│   │       ├── badge.tsx                ✅ Badge component
│   │       ├── card.tsx                 ✅ Card wrapper
│   │       ├── dialog.tsx               ✅ Modal
│   │       └── tabs.tsx                 ✅ Tab component
│   │
│   ├── lib/
│   │   ├── state/
│   │   │   ├── sidebar-store.ts         ✅ Sidebar state
│   │   │   ├── theme-store.ts           ✅ Theme state
│   │   │   └── board-store.ts           🔲 Kanban state
│   │   │
│   │   └── themes/
│   │       ├── themes.ts                ✅ Theme definitions
│   │       └── vibe-theme.ts            🔲 Vibe config
│   │
│   ├── styles/
│   │   ├── globals.css                  ✅ Global styles
│   │   └── vibe.css                     🔲 Vibe-specific
│   │
│   └── types/
│       ├── board.ts                     🔲 Kanban types
│       └── card.ts                      🔲 Card types
│
├── docs/
│   ├── unified-layout-design-system.md  ✅ This document
│   ├── sidebar-theme-system.md          ✅ Sidebar spec
│   └── vibe-kanban-integration-plan.md  ✅ Kanban spec
│
└── tailwind.config.js                   ✅ Vibe palette

Legend:
✅ Implemented
🔲 To be implemented
```

---

## Part 13: Quick Reference

### Colors (CSS Variables)

```css
:root {
  /* Backgrounds */
  --bg-primary: #000000;
  --bg-secondary: #09090b;
  --bg-tertiary: #18181b;

  /* Borders */
  --border-default: #27272a;
  --border-hover: #3f3f46;

  /* Text */
  --text-primary: #fafafa;
  --text-secondary: #a1a1aa;
  --text-tertiary: #71717a;

  /* Accents */
  --accent-primary: #06b6d4;
  --accent-success: #22c55e;
  --accent-warning: #eab308;
  --accent-danger: #ef4444;

  /* Fonts */
  --font-ui: 'Inter', sans-serif;
  --font-mono: 'JetBrains Mono', monospace;
}
```

### Common Patterns

**Full-width dark container:**
```tsx
<div className="bg-black min-h-screen text-white">
```

**Card with hover effect:**
```tsx
<div className="bg-zinc-900 border border-zinc-800 rounded-lg p-4 hover:bg-zinc-800 hover:border-zinc-700 transition-default">
```

**Sidebar navigation item:**
```tsx
<button className="w-full flex items-center gap-3 px-3 py-2 rounded text-sm text-zinc-400 hover:text-white hover:bg-zinc-800 transition-default">
  <Icon className="w-4 h-4" />
  <span>Label</span>
</button>
```

**Monospace data display:**
```tsx
<code className="font-mono text-sm bg-zinc-900 px-2 py-1 rounded text-cyan-400">
  value
</code>
```

---

## Conclusion

This unified design system combines the best of Vibe Kanban's developer-centric aesthetics with AutoMaker's clean navigation, creating a cohesive, modern interface for Designbrnd.

**Key Takeaways:**
- Deep dark theme (#000000) with high contrast
- JetBrains Mono for code, Inter for UI
- Collapsible sidebar with tool integration
- Kanban-style visual workflow
- Minimalist cards with smooth interactions
- Consistent spacing and typography

**Next Steps:**
1. Review and approve this design system
2. Begin Phase 1 implementation
3. Build component library
4. Implement sidebar navigation
5. Create Kanban board
6. Integrate tools (Plannotator, ShowMe, Beads)

Ready to build! 🚀
