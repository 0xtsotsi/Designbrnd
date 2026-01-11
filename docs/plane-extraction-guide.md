# Plane Extraction Guide for Designbrnd
## Reverse Engineering Plane.so for Maximum Value

---

## Overview

[Plane](https://github.com/makeplane/plane) is an open-source Jira alternative with **Apache 2.0 license** - 100% legal to clone, study, and extract patterns!

**Cloned Repository:** `/tmp/plane-source/`

---

## 🎯 Tech Stack (Perfect Match!)

### Frontend
- ✅ **React** + **Vite** (same as Designbrnd!)
- ✅ **TypeScript** (same as yours)
- ✅ **React Router** (you use React Router DOM)
- ✅ **Tailwind CSS** (confirmed - they have tailwind-config package)
- ✅ **@atlaskit/pragmatic-drag-and-drop** (for Kanban DnD)
- ✅ **MobX** (state management - different from your Zustand, but patterns apply)
- ✅ **Lucide React** (same icons!)

### Backend
- Python + Django
- PostgreSQL + Redis

**Key Insight:** Their frontend stack is nearly IDENTICAL to yours, making code extraction extremely easy!

---

## 📦 Repository Structure

```
plane-source/
├── apps/
│   ├── web/              ← Main web app (START HERE)
│   │   └── core/components/issues/issue-layouts/
│   │       ├── kanban/   ← 🎯 KANBAN BOARD IMPLEMENTATION
│   │       ├── list/     ← List view
│   │       ├── calendar/ ← Calendar view
│   │       └── gantt/    ← Gantt chart
│   ├── admin/            ← Admin interface
│   └── space/            ← Public space
│
└── packages/
    ├── ui/               ← 🎯 UI COMPONENT LIBRARY
    ├── hooks/            ← 🎯 CUSTOM REACT HOOKS
    ├── tailwind-config/  ← 🎯 TAILWIND CONFIGURATION
    ├── types/            ← TypeScript types
    ├── utils/            ← Utility functions
    ├── editor/           ← Rich text editor
    └── constants/        ← Constants
```

---

## 🔥 High-Value Components to Extract

### 1. **Kanban Board System** (PRIORITY #1)

**Location:** `/tmp/plane-source/apps/web/core/components/issues/issue-layouts/kanban/`

**Files to study:**
```typescript
✅ base-kanban-root.tsx       // Main Kanban container
✅ block.tsx                   // Card/Issue component (uses @atlaskit DnD)
✅ blocks-list.tsx             // List of cards in a column
✅ kanban-group.tsx            // Column/Lane component
✅ swimlanes.tsx               // Horizontal grouping
✅ headers/group-by-card.tsx   // Column headers
✅ default.tsx                 // Default Kanban layout
```

**What to steal:**
- **Drag-and-drop logic** using @atlaskit/pragmatic-drag-and-drop
- **Card component structure** with all states (hover, drag, selected)
- **Column virtualization** for performance
- **Keyboard navigation** implementation
- **Quick actions** dropdown on cards
- **Inline editing** patterns

**Key Pattern Found:**
```typescript
// From block.tsx (line 3-4)
import { combine } from "@atlaskit/pragmatic-drag-and-drop/combine";
import { draggable, dropTargetForElements } from "@atlaskit/pragmatic-drag-and-drop/element/adapter";

// They use Atlaskit's DnD library!
// This is the SAME library Atlassian uses for Jira
```

---

### 2. **UI Component Library**

**Location:** `/tmp/plane-source/packages/ui/src/`

**Components available:**
```
✅ form-fields/
   - input.tsx
   - textarea.tsx
   - checkbox.tsx
   - password/
   - input-color-picker.tsx

✅ avatar/
   - avatar.tsx
   - avatar-group.tsx

✅ badge/
   - badge.tsx

✅ popovers/
   - popover.tsx
   - popover-menu.tsx

✅ tables/
   - table.tsx

✅ tag/
   - tag.tsx

... and more!
```

**Extraction strategy:**
1. Copy component structure (props interface)
2. Adapt styling to Vibe aesthetic
3. Replace their Tailwind classes with yours
4. Keep accessibility patterns

---

### 3. **Tailwind Configuration**

**Location:** `/tmp/plane-source/packages/tailwind-config/`

**What to extract:**
- Color palette organization
- Custom utilities
- Plugin configurations
- Theme structure

---

### 4. **Custom Hooks**

**Location:** `/tmp/plane-source/packages/hooks/src/`

**Valuable hooks to steal:**
```typescript
✅ useOutsideClickDetector  // Close popovers/modals
✅ useDebounce             // Debounce inputs
✅ useInfiniteScroll       // Pagination
✅ useKeyPress             // Keyboard shortcuts
... explore more!
```

---

### 5. **State Management Patterns**

**Location:** `/tmp/plane-source/apps/web/core/store/`

**What to study:**
- Issue store architecture
- Optimistic updates
- Cache invalidation
- Real-time sync patterns

**Adapt to your Zustand:**
```typescript
// Plane uses MobX observables
// Study their store structure, implement with Zustand

// Example from Plane (MobX):
@observable issues: IIssueMap = {};

// Your version (Zustand):
interface BoardStore {
  issues: Map<string, Issue>;
  // ... same methods, different implementation
}
```

---

## 🚀 Step-by-Step Extraction Plan

### **Phase 1: Study Kanban Architecture (Day 1-2)**

```bash
# 1. Study main Kanban component
cat /tmp/plane-source/apps/web/core/components/issues/issue-layouts/kanban/base-kanban-root.tsx

# 2. Study card component
cat /tmp/plane-source/apps/web/core/components/issues/issue-layouts/kanban/block.tsx

# 3. Study lane/column component
cat /tmp/plane-source/apps/web/core/components/issues/issue-layouts/kanban/kanban-group.tsx

# 4. Extract drag-and-drop patterns
grep -r "draggable\|dropTarget" /tmp/plane-source/apps/web/core/components/issues/issue-layouts/kanban/
```

**Document findings:**
- How they structure board state
- Drag event handling
- Drop zone detection
- Visual feedback during drag

---

### **Phase 2: Extract UI Components (Day 3-4)**

```bash
# Copy component structure
cd /tmp/plane-source/packages/ui/src

# Study each component
for dir in */; do
  echo "=== $dir ==="
  find "$dir" -name "*.tsx" -exec head -50 {} \;
done
```

**For each component:**
1. Read TypeScript interface
2. Copy props structure
3. Note accessibility patterns
4. Adapt styling to Vibe aesthetic

**Example - Extracting Badge component:**

```typescript
// 1. Read Plane's badge
cat /tmp/plane-source/packages/ui/src/badge/badge.tsx

// 2. Create your version
// File: src/components/ui/badge.tsx

import { cn } from '@/lib/utils';
import { cva, type VariantProps } from 'class-variance-authority';

// ✅ Stolen from Plane: variant structure
const badgeVariants = cva(
  'inline-flex items-center rounded-full px-2 py-0.5 text-xs font-medium transition-colors',
  {
    variants: {
      variant: {
        // ✅ Adapted to Vibe aesthetic
        default: 'bg-stone-800 text-stone-300 border border-stone-700',
        primary: 'bg-cyan-500/20 text-cyan-400 border border-cyan-500/30',
        success: 'bg-green-500/20 text-green-400 border border-green-500/30',
        warning: 'bg-yellow-500/20 text-yellow-400 border border-yellow-500/30',
        danger: 'bg-red-500/20 text-red-400 border border-red-500/30',
      },
    },
    defaultVariants: {
      variant: 'default',
    },
  }
);

// ✅ Stolen from Plane: component structure
export interface BadgeProps
  extends React.HTMLAttributes<HTMLDivElement>,
    VariantProps<typeof badgeVariants> {}

export function Badge({ className, variant, ...props }: BadgeProps) {
  return (
    <div className={cn(badgeVariants({ variant }), className)} {...props} />
  );
}
```

---

### **Phase 3: Implement Drag-and-Drop (Day 5-7)**

**Install the same DnD library:**

```bash
cd /home/user/Designbrnd
npm install @atlaskit/pragmatic-drag-and-drop
```

**Extract Plane's DnD patterns:**

```typescript
// Study their implementation
// File: /tmp/plane-source/apps/web/core/components/issues/issue-layouts/kanban/block.tsx

// They use:
import { combine } from "@atlaskit/pragmatic-drag-and-drop/combine";
import { draggable, dropTargetForElements } from "@atlaskit/pragmatic-drag-and-drop/element/adapter";

// Extract their drag setup (lines 140-180 in block.tsx)
// Copy to your Card component
```

**Implement in Designbrnd:**

```typescript
// File: src/components/kanban/Card.tsx

import { useRef, useEffect } from 'react';
import { combine } from '@atlaskit/pragmatic-drag-and-drop/combine';
import { draggable, dropTargetForElements } from '@atlaskit/pragmatic-drag-and-drop/element/adapter';

export function Card({ id, title, description, onDragStart, onDrop }: CardProps) {
  const cardRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const element = cardRef.current;
    if (!element) return;

    // ✅ Stolen from Plane's block.tsx implementation
    return combine(
      draggable({
        element,
        getInitialData: () => ({ id, type: 'card' }),
        onDragStart: () => {
          onDragStart?.(id);
        },
      }),
      dropTargetForElements({
        element,
        onDrop: (args) => {
          const draggedId = args.source.data.id as string;
          onDrop?.(draggedId, id);
        },
      })
    );
  }, [id, onDragStart, onDrop]);

  return (
    <div
      ref={cardRef}
      className="bg-zinc-900 border border-zinc-800 rounded-lg p-4 hover:bg-zinc-800 transition-all cursor-grab active:cursor-grabbing"
    >
      <h3 className="font-semibold text-sm text-zinc-100">{title}</h3>
      {description && (
        <p className="text-xs text-zinc-400 mt-2">{description}</p>
      )}
    </div>
  );
}
```

---

### **Phase 4: Extract State Management (Day 8-10)**

**Study Plane's store structure:**

```bash
# Find issue store
cat /tmp/plane-source/apps/web/core/store/issue/project/issue.store.ts

# Study their action methods
grep -A 10 "updateIssue\|addIssue\|deleteIssue" /tmp/plane-source/apps/web/core/store/issue/
```

**Adapt to Zustand:**

```typescript
// File: src/lib/state/board-store.ts

import { create } from 'zustand';
import { persist } from 'zustand/middleware';

// ✅ Stolen from Plane: state structure
interface BoardStore {
  // Issues map (same as Plane's structure)
  issues: Map<string, Issue>;
  lanes: Lane[];

  // ✅ Stolen from Plane: action patterns
  updateIssue: (issueId: string, updates: Partial<Issue>) => void;
  moveIssue: (issueId: string, toLaneId: string) => void;
  addIssue: (laneId: string, issue: Partial<Issue>) => void;
  deleteIssue: (issueId: string) => void;

  // ✅ Stolen from Plane: optimistic updates
  optimisticUpdate: (issueId: string, updates: Partial<Issue>) => void;
}

export const useBoardStore = create<BoardStore>()(
  persist(
    (set, get) => ({
      issues: new Map(),
      lanes: [],

      // ✅ Implementation inspired by Plane's patterns
      updateIssue: (issueId, updates) => {
        set((state) => {
          const newIssues = new Map(state.issues);
          const issue = newIssues.get(issueId);
          if (issue) {
            newIssues.set(issueId, { ...issue, ...updates });
          }
          return { issues: newIssues };
        });
      },

      moveIssue: (issueId, toLaneId) => {
        // ✅ Copy Plane's move logic
        const issue = get().issues.get(issueId);
        if (!issue) return;

        // Optimistic update
        get().optimisticUpdate(issueId, { status: toLaneId });

        // API call (add later)
        // api.moveIssue(issueId, toLaneId).catch(() => {
        //   // Revert on error
        // });
      },

      // ... rest of implementation
    }),
    { name: 'board-store' }
  )
);
```

---

### **Phase 5: Polish & Integrate (Day 11-14)**

**Extract visual patterns:**

```bash
# Find their CSS/Tailwind patterns
grep -r "className" /tmp/plane-source/apps/web/core/components/issues/issue-layouts/kanban/ | head -50

# Study their animation timings
grep -r "transition\|duration\|ease" /tmp/plane-source/packages/ui/src/
```

**Adapt to Vibe aesthetic:**
- Replace their colors with yours (#000000 backgrounds)
- Keep their spacing/layout
- Copy their hover states timing
- Steal their micro-interactions

---

## 💎 Specific Patterns to Steal

### **Pattern 1: Card Quick Actions**

**From Plane's block.tsx:**
```typescript
// They have a "more actions" button on each card
const customActionButton = (
  <div
    ref={menuActionRef}
    className={`... cursor-pointer rounded-sm p-1 ...`}
    onClick={() => setIsMenuActive(!isMenuActive)}
  >
    <MoreHorizontal className="h-3.5 w-3.5" />
  </div>
);

// ✅ Steal this pattern for Designbrnd cards
```

---

### **Pattern 2: Render Optimization**

**From Plane's block.tsx (line 19):**
```typescript
import RenderIfVisible from "@/components/core/render-if-visible-HOC";

// They virtualize cards for performance!
// Only render cards that are in viewport

// ✅ Steal this HOC pattern for large boards
```

---

### **Pattern 3: Issue Identifier**

**From Plane's components:**
```typescript
// They show "PROJ-123" style identifiers
<IssueIdentifier
  issueId={issue.id}
  projectId={issue.project_id}
  className="text-xs"
/>

// ✅ Steal for Designbrnd cards
```

---

### **Pattern 4: Properties Display**

**From Plane:**
```typescript
// They have a flexible properties display system
<IssueProperties
  issue={issue}
  displayProperties={displayProperties}
  isReadOnly={isReadOnly}
/>

// Displays: assignee, priority, labels, due date, etc.
// ✅ Copy this pattern
```

---

## 📋 Complete Extraction Checklist

### **Kanban Board:**
- [ ] Clone Plane repository to `/tmp/plane-source/`
- [ ] Study base-kanban-root.tsx architecture
- [ ] Extract block.tsx (card) component patterns
- [ ] Copy kanban-group.tsx (lane) structure
- [ ] Study drag-and-drop implementation
- [ ] Extract keyboard navigation logic
- [ ] Copy quick actions dropdown pattern
- [ ] Study virtualization/performance optimizations

### **UI Components:**
- [ ] Extract Badge component patterns
- [ ] Copy Avatar/AvatarGroup structure
- [ ] Study Popover/PopoverMenu implementation
- [ ] Extract Input/Textarea patterns
- [ ] Copy Table component (if needed)
- [ ] Study Tag/Label component
- [ ] Extract form field patterns

### **State Management:**
- [ ] Study MobX store architecture
- [ ] Extract action method patterns
- [ ] Copy optimistic update logic
- [ ] Study cache invalidation patterns
- [ ] Extract real-time sync approaches

### **Hooks:**
- [ ] Extract useOutsideClickDetector
- [ ] Copy useDebounce implementation
- [ ] Study useKeyPress for shortcuts
- [ ] Extract useInfiniteScroll (if applicable)
- [ ] Copy other custom hooks

### **Styling & Design:**
- [ ] Study Tailwind config structure
- [ ] Extract color organization patterns
- [ ] Copy spacing system
- [ ] Study animation timings
- [ ] Extract responsive breakpoints

---

## 🔧 Tools for Extraction

### **Search patterns:**

```bash
# Find all Kanban components
find /tmp/plane-source/apps/web -name "*kanban*" -o -name "*board*"

# Find drag-and-drop usage
grep -r "draggable\|dropTarget" /tmp/plane-source/apps/web

# Find state management
find /tmp/plane-source/apps/web -name "*store*"

# Find hooks
ls /tmp/plane-source/packages/hooks/src/

# Extract all component props
grep -r "interface.*Props" /tmp/plane-source/packages/ui/src/
```

### **Copy component template:**

```bash
# Quick script to copy component structure
component_name="Button"
mkdir -p ~/plane-extraction/$component_name
cp /tmp/plane-source/packages/ui/src/*/button* ~/plane-extraction/$component_name/
```

---

## ⚡ Quick Wins (Implement Today)

### **1. Install Their DnD Library**

```bash
cd /home/user/Designbrnd
npm install @atlaskit/pragmatic-drag-and-drop
```

### **2. Copy Card Hover Effect**

```typescript
// From Plane's block.tsx
className="hover:bg-layer-1" // Their pattern

// Your version (Vibe aesthetic)
className="hover:bg-zinc-800 transition-all duration-150"
```

### **3. Extract Keyboard Shortcuts**

```bash
# Find their shortcuts
grep -r "onKeyDown\|keyCode\|key ===" /tmp/plane-source/apps/web/core/components/issues/
```

---

## 🎨 Adaptation Guide: Plane → Designbrnd

| Plane Pattern | Adapt to Designbrnd |
|---------------|---------------------|
| `bg-layer-1` | `bg-zinc-900` |
| `text-primary` | `text-zinc-100` |
| `text-secondary` | `text-zinc-400` |
| `border-border` | `border-zinc-800` |
| MobX stores | Zustand stores |
| Next.js patterns | React Router patterns |
| Their spacing | Keep spacing system |
| Their animations | Keep timing, adjust colors |

---

## 🚀 Implementation Timeline

### **Week 1: Exploration**
- Day 1-2: Clone and study Kanban architecture
- Day 3-4: Extract UI component patterns
- Day 5-7: Study drag-and-drop implementation

### **Week 2: Implementation**
- Day 8-10: Build Kanban board with stolen patterns
- Day 11-12: Implement drag-and-drop
- Day 13-14: Add card components

### **Week 3: Polish**
- Day 15-17: Apply Vibe aesthetic
- Day 18-19: Add keyboard shortcuts
- Day 20-21: Performance optimization

---

## 📚 Resources

**Official Plane Resources:**
- Repository: https://github.com/makeplane/plane
- Website: https://plane.so/
- Tech stack article: [Building Plane with Next.js + Django](https://dev.to/vihar/we-built-plane-open-source-project-management-tool-nextjs-django-3hke)

**Cloned Source:**
- Location: `/tmp/plane-source/`
- Kanban: `/tmp/plane-source/apps/web/core/components/issues/issue-layouts/kanban/`
- UI Library: `/tmp/plane-source/packages/ui/src/`

---

## ⚖️ Legal Summary

**✅ 100% Legal (Apache 2.0 License):**
- Clone the repository
- Study all source code
- Extract patterns and logic
- Adapt components
- Use in commercial project (Designbrnd)
- Modify and distribute

**⚠️ Required:**
- Include Apache 2.0 license notice if using code directly
- Attribute Plane if using substantial portions

**❌ Not Allowed:**
- Copying their brand/logo
- Claiming it's your original work
- Removing license headers

---

## 🎯 Next Steps

1. **Start exploration today:**
   ```bash
   cd /tmp/plane-source
   code apps/web/core/components/issues/issue-layouts/kanban/
   ```

2. **Document findings:**
   Create `~/plane-extraction-notes.md` as you explore

3. **Begin implementation:**
   Start with Card component using their patterns

4. **Iterate:**
   Extract → Adapt → Implement → Test → Repeat

---

**Ready to start extracting?** Plane is your open-source goldmine! 💎

