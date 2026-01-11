# Vibe Kanban Integration Plan
## Bringing Developer-Centric Project Management to Design OS

---

## Executive Summary

This plan outlines how to integrate **Vibe Kanban's design philosophy** and workflow patterns into the Design OS unified dashboard, creating a visually stunning, developer-centric project management layer for consulting workflows.

**Goal**: Transform the Design OS dashboard from a documentation-first tool into a **visual workflow management system** that clients can see, interact with, and approve in real-time.

---

## Part 1: Vibe Kanban Analysis

### What Makes Vibe Kanban Special?

#### 1. **Design Language ("The Vibe")**
```
Deep Dark Mode: #000000 backgrounds, #fafafa text
Minimalist Cards: No heavy shadows, subtle hover effects
Monochrome Palette: Zinc/Slate grays with accent colors for status
Developer Typography: JetBrains Mono for data, Inter for UI
Phosphor Icons: Consistent, minimal iconography
```

#### 2. **UX Philosophy**
- **Inline Editing**: Click-to-edit, no modal dialogs
- **Keyboard First**: Cmd+K search, shortcuts for everything
- **Flow State**: Side panels instead of modals (stay in context)
- **Visual Progress**: Micro-interactions, progress indicators
- **Git Integration**: Tasks map to branches/worktrees

#### 3. **Architecture Principles**
- **Local-First**: State derived from filesystem
- **Monorepo**: Frontend (React/TS) + Backend (Rust)
- **Horizontal Scrolling**: Infinite lanes, no pagination
- **Real-time**: Live updates, no refresh needed

---

## Part 2: Design OS + Vibe Kanban = "Design OS Pro"

### The Core Insight

**Current Design OS**: Linear, documentation-driven workflow
- Product Vision → Roadmap → Data Model → Design Tokens → Export

**With Vibe Kanban**: Visual, parallel, client-collaborative workflow
- Drag cards between stages
- See all work in progress simultaneously
- Client participates by moving cards
- Real-time progress tracking

### Proposed Hybrid System: "Visual Workflow Dashboard"

```
┌─────────────────────────────────────────────────────────────────┐
│                    DESIGN OS DASHBOARD                          │
│                  (Vibe-Inspired Dark Theme)                     │
└─────────────────────────────────────────────────────────────────┘

┌──────────┬──────────────────────────────────────────────────────┐
│  SIDEBAR │                 MAIN BOARD AREA                      │
│  (64px)  │                                                      │
│          │  ┌───────────────────────────────────────────────┐  │
│  📋      │  │  Discovery → Design → Planning → Build → ✓   │  │
│  🎨      │  │  ┌─────┐  ┌─────┐  ┌─────┐  ┌─────┐  ┌─────┐│  │
│  📐      │  │  │Card │  │Card │  │Card │  │Card │  │Card ││  │
│  🔧      │  │  │Card │  │Card │  │     │  │     │  │     ││  │
│  ⚙️      │  │  │Card │  │     │  │     │  │     │  │     ││  │
│          │  │  └─────┘  └─────┘  └─────┘  └─────┘  └─────┘│  │
│          │  └───────────────────────────────────────────────┘  │
│          │                                                      │
└──────────┴──────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────┐
│              CONTEXT PANEL (Slide from right)                    │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │  Card Title: "Homepage Hero Section"                       │ │
│  │  ─────────────────────────────────────────────────────────  │ │
│  │  📝 Description (Markdown)                                 │ │
│  │  🎨 Mockups (ShowMe integration)                           │ │
│  │  📐 Implementation Plan (Plannotator)                      │ │
│  │  💬 Activity Feed                                          │ │
│  │  ✅ Checklist: [x] Vision [ ] Design [ ] Build            │ │
│  └────────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────────┘
```

---

## Part 3: Workflow Mapping

### Design OS Consulting Workflow → Kanban Lanes

| **Kanban Lane** | **Design OS Phase** | **Card Types** | **Exit Criteria** |
|-----------------|---------------------|----------------|-------------------|
| **📝 Discovery** | Product Vision | Vision, Roadmap, Goals | Client approves vision doc |
| **🎨 Design** | Design System | Colors, Typography, Mockups | Design tokens finalized |
| **📐 Planning** | Architecture | Data Model, Sections, Specs | Implementation plan approved |
| **🔨 Build** | Implementation | Components, Features | Tests pass, review complete |
| **✅ Done** | Delivered | Completed work | Client sign-off |

### Example: "Restaurant Website Project"

```
┌─────────────────────────────────────────────────────────────────┐
│ Lane: 📝 Discovery                                              │
├─────────────────────────────────────────────────────────────────┤
│ [Card] Product Vision                                           │
│   └─ Status: In Progress                                        │
│   └─ Assignee: You + Client                                     │
│   └─ Checklist: [x] Business goals [ ] Target audience          │
│                                                                  │
│ [Card] Competitor Research                                      │
│   └─ Status: To Do                                              │
│   └─ Notes: 3 competitors identified                            │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│ Lane: 🎨 Design                                                 │
├─────────────────────────────────────────────────────────────────┤
│ [Card] Color Palette                                            │
│   └─ Status: Ready for Review                                   │
│   └─ Preview: 🟥 #DC2626  🟨 #F59E0B                            │
│   └─ ShowMe: [View Mockup] →                                    │
│                                                                  │
│ [Card] Homepage Mockup                                          │
│   └─ Status: In Design                                          │
│   └─ ShowMe: 3 annotations pending                              │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│ Lane: 📐 Planning                                               │
├─────────────────────────────────────────────────────────────────┤
│ [Card] Menu Component Spec                                      │
│   └─ Status: Awaiting Plan Review                               │
│   └─ Plannotator: 2 comments to resolve                         │
│   └─ Dependencies: Color Palette ✓, Typography ✓                │
└─────────────────────────────────────────────────────────────────┘
```

---

## Part 4: Technical Architecture

### 4.1 Design System (Vibe Theme)

**File**: `src/styles/vibe-theme.ts`

```typescript
export const vibeTheme = {
  colors: {
    background: {
      primary: '#000000',    // Pure black
      secondary: '#09090b',  // Zinc-950
      tertiary: '#18181b',   // Zinc-900
    },
    border: {
      default: '#27272a',    // Zinc-800
      hover: '#3f3f46',      // Zinc-700
      active: '#52525b',     // Zinc-600
    },
    text: {
      primary: '#fafafa',    // Zinc-50
      secondary: '#a1a1aa',  // Zinc-400
      tertiary: '#71717a',   // Zinc-500
    },
    accent: {
      blue: '#3b82f6',       // Task in progress
      green: '#22c55e',      // Completed
      yellow: '#eab308',     // Needs attention
      red: '#ef4444',        // Blocked
    },
  },
  typography: {
    ui: 'Inter, system-ui, sans-serif',
    mono: 'JetBrains Mono, Fira Code, monospace',
  },
  spacing: {
    lane: '320px',           // Fixed lane width
    card: '280px',           // Card max-width
    gap: '12px',             // Card spacing
  },
  animations: {
    cardHover: '150ms ease',
    dragTransition: '200ms cubic-bezier(0.2, 0, 0, 1)',
  },
};
```

**Tailwind Config**: `tailwind.config.js`

```javascript
module.exports = {
  theme: {
    extend: {
      colors: {
        vibe: {
          bg: {
            primary: '#000000',
            secondary: '#09090b',
            tertiary: '#18181b',
          },
          border: {
            DEFAULT: '#27272a',
            hover: '#3f3f46',
            active: '#52525b',
          },
          text: {
            primary: '#fafafa',
            secondary: '#a1a1aa',
            tertiary: '#71717a',
          },
        },
      },
      fontFamily: {
        ui: ['Inter', 'system-ui', 'sans-serif'],
        mono: ['JetBrains Mono', 'Fira Code', 'monospace'],
      },
    },
  },
};
```

---

### 4.2 Component Architecture

```
src/
├── features/
│   ├── board/                      # Kanban Board (NEW)
│   │   ├── KanbanBoard.tsx         # Main board container
│   │   ├── Lane.tsx                # Column component
│   │   ├── Card.tsx                # Task card
│   │   ├── CardDetail.tsx          # Side panel detail view
│   │   ├── AddCardButton.tsx       # Inline add button
│   │   └── EmptyState.tsx          # Ghost cards for empty lanes
│   │
│   ├── board-integrations/         # Tool integrations (NEW)
│   │   ├── ShowMePreview.tsx       # Embed ShowMe mockups in cards
│   │   ├── PlannotatorPreview.tsx  # Embed plan reviews in cards
│   │   ├── DesignTokensPreview.tsx # Show color/font previews
│   │   └── ActivityFeed.tsx        # Timeline of changes
│   │
│   ├── planning/                   # Design OS existing
│   ├── mockups/                    # ShowMe integration
│   └── review/                     # Plannotator integration
│
├── lib/
│   ├── state/
│   │   ├── board-store.ts          # Kanban board state (NEW)
│   │   ├── card-store.ts           # Individual card state (NEW)
│   │   └── integration-store.ts    # Links to ShowMe/Plannotator (NEW)
│   │
│   └── dnd/                        # Drag-and-drop (NEW)
│       ├── useDragAndDrop.ts       # DnD hook
│       └── dnd-context.tsx         # DnD provider
│
└── types/
    ├── board.ts                    # Kanban types (NEW)
    └── card.ts                     # Card types (NEW)
```

---

### 4.3 Data Model

**File**: `src/types/board.ts`

```typescript
export type CardStatus =
  | 'discovery'
  | 'design'
  | 'planning'
  | 'build'
  | 'done';

export type CardPriority = 'low' | 'medium' | 'high' | 'urgent';

export interface Card {
  id: string;
  title: string;
  description: string; // Markdown
  status: CardStatus;
  priority: CardPriority;

  // Metadata
  createdAt: Date;
  updatedAt: Date;
  createdBy: string;
  assignee?: string;

  // Integration references
  showMePageId?: string;        // Link to ShowMe mockup
  plannotatorPlanId?: string;   // Link to Plannotator plan
  designOsSection?: string;     // Link to Design OS section

  // Progress tracking
  checklist: ChecklistItem[];
  tags: string[];
  dependencies: string[];       // IDs of blocking cards

  // Activity
  comments: Comment[];
  attachments: Attachment[];

  // Git integration (optional)
  gitBranch?: string;
  gitCommits?: string[];
}

export interface ChecklistItem {
  id: string;
  text: string;
  completed: boolean;
}

export interface Comment {
  id: string;
  author: string;
  text: string;
  createdAt: Date;
}

export interface Lane {
  id: CardStatus;
  title: string;
  icon: string;
  cards: Card[];
  color: string;
}

export interface Board {
  id: string;
  projectId: string;
  lanes: Lane[];
}
```

---

### 4.4 State Management

**File**: `src/lib/state/board-store.ts`

```typescript
import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import type { Board, Card, CardStatus } from '@/types/board';

interface BoardStore {
  board: Board | null;
  selectedCardId: string | null;

  // Board operations
  initializeBoard: (projectId: string) => void;

  // Card operations
  addCard: (laneId: CardStatus, card: Partial<Card>) => void;
  updateCard: (cardId: string, updates: Partial<Card>) => void;
  deleteCard: (cardId: string) => void;
  moveCard: (cardId: string, toLane: CardStatus) => void;

  // Selection
  selectCard: (cardId: string | null) => void;

  // Checklist
  toggleChecklistItem: (cardId: string, itemId: string) => void;
  addChecklistItem: (cardId: string, text: string) => void;

  // Comments
  addComment: (cardId: string, text: string, author: string) => void;

  // Integration helpers
  linkShowMePage: (cardId: string, pageId: string) => void;
  linkPlannotatorPlan: (cardId: string, planId: string) => void;
}

export const useBoardStore = create<BoardStore>()(
  persist(
    (set, get) => ({
      board: null,
      selectedCardId: null,

      initializeBoard: (projectId) => {
        const newBoard: Board = {
          id: crypto.randomUUID(),
          projectId,
          lanes: [
            {
              id: 'discovery',
              title: 'Discovery',
              icon: '📝',
              cards: [],
              color: '#3b82f6'
            },
            {
              id: 'design',
              title: 'Design',
              icon: '🎨',
              cards: [],
              color: '#8b5cf6'
            },
            {
              id: 'planning',
              title: 'Planning',
              icon: '📐',
              cards: [],
              color: '#eab308'
            },
            {
              id: 'build',
              title: 'Build',
              icon: '🔨',
              cards: [],
              color: '#f97316'
            },
            {
              id: 'done',
              title: 'Done',
              icon: '✅',
              cards: [],
              color: '#22c55e'
            },
          ],
        };

        set({ board: newBoard });
      },

      addCard: (laneId, cardData) => {
        const board = get().board;
        if (!board) return;

        const newCard: Card = {
          id: crypto.randomUUID(),
          title: cardData.title || 'Untitled',
          description: cardData.description || '',
          status: laneId,
          priority: cardData.priority || 'medium',
          createdAt: new Date(),
          updatedAt: new Date(),
          createdBy: 'current-user', // TODO: Auth
          checklist: [],
          tags: [],
          dependencies: [],
          comments: [],
          attachments: [],
          ...cardData,
        };

        set((state) => ({
          board: {
            ...state.board!,
            lanes: state.board!.lanes.map((lane) =>
              lane.id === laneId
                ? { ...lane, cards: [...lane.cards, newCard] }
                : lane
            ),
          },
        }));
      },

      moveCard: (cardId, toLane) => {
        const board = get().board;
        if (!board) return;

        let cardToMove: Card | null = null;

        set((state) => ({
          board: {
            ...state.board!,
            lanes: state.board!.lanes.map((lane) => {
              // Remove card from old lane
              const filtered = lane.cards.filter((card) => {
                if (card.id === cardId) {
                  cardToMove = { ...card, status: toLane, updatedAt: new Date() };
                  return false;
                }
                return true;
              });

              // Add to new lane
              if (lane.id === toLane && cardToMove) {
                return { ...lane, cards: [...filtered, cardToMove] };
              }

              return { ...lane, cards: filtered };
            }),
          },
        }));
      },

      selectCard: (cardId) => {
        set({ selectedCardId: cardId });
      },

      toggleChecklistItem: (cardId, itemId) => {
        set((state) => ({
          board: {
            ...state.board!,
            lanes: state.board!.lanes.map((lane) => ({
              ...lane,
              cards: lane.cards.map((card) =>
                card.id === cardId
                  ? {
                      ...card,
                      checklist: card.checklist.map((item) =>
                        item.id === itemId
                          ? { ...item, completed: !item.completed }
                          : item
                      ),
                    }
                  : card
              ),
            })),
          },
        }));
      },

      linkShowMePage: (cardId, pageId) => {
        get().updateCard(cardId, { showMePageId: pageId });
      },

      linkPlannotatorPlan: (cardId, planId) => {
        get().updateCard(cardId, { plannotatorPlanId: planId });
      },

      updateCard: (cardId, updates) => {
        set((state) => ({
          board: {
            ...state.board!,
            lanes: state.board!.lanes.map((lane) => ({
              ...lane,
              cards: lane.cards.map((card) =>
                card.id === cardId
                  ? { ...card, ...updates, updatedAt: new Date() }
                  : card
              ),
            })),
          },
        }));
      },

      deleteCard: (cardId) => {
        set((state) => ({
          board: {
            ...state.board!,
            lanes: state.board!.lanes.map((lane) => ({
              ...lane,
              cards: lane.cards.filter((card) => card.id !== cardId),
            })),
          },
        }));
      },

      addChecklistItem: (cardId, text) => {
        set((state) => ({
          board: {
            ...state.board!,
            lanes: state.board!.lanes.map((lane) => ({
              ...lane,
              cards: lane.cards.map((card) =>
                card.id === cardId
                  ? {
                      ...card,
                      checklist: [
                        ...card.checklist,
                        {
                          id: crypto.randomUUID(),
                          text,
                          completed: false,
                        },
                      ],
                    }
                  : card
              ),
            })),
          },
        }));
      },

      addComment: (cardId, text, author) => {
        set((state) => ({
          board: {
            ...state.board!,
            lanes: state.board!.lanes.map((lane) => ({
              ...lane,
              cards: lane.cards.map((card) =>
                card.id === cardId
                  ? {
                      ...card,
                      comments: [
                        ...card.comments,
                        {
                          id: crypto.randomUUID(),
                          author,
                          text,
                          createdAt: new Date(),
                        },
                      ],
                    }
                  : card
              ),
            })),
          },
        }));
      },
    }),
    {
      name: 'design-os-board',
    }
  )
);
```

---

## Part 5: Integration with Existing Tools

### 5.1 ShowMe Integration in Cards

**Concept**: Cards can have mockups attached. Clicking shows ShowMe canvas.

```typescript
// src/features/board-integrations/ShowMePreview.tsx
import { useMockupsStore } from '@/lib/state/mockups-store';
import { Button } from '@/components/ui/button';

interface ShowMePreviewProps {
  pageId?: string;
  onCreateMockup: () => void;
}

export function ShowMePreview({ pageId, onCreateMockup }: ShowMePreviewProps) {
  const { pages } = useMockupsStore();
  const page = pages.find(p => p.id === pageId);

  if (!page) {
    return (
      <div className="border border-dashed border-vibe-border rounded-lg p-4">
        <p className="text-sm text-vibe-text-secondary mb-2">
          No mockup attached
        </p>
        <Button
          onClick={onCreateMockup}
          variant="outline"
          size="sm"
        >
          + Create Mockup
        </Button>
      </div>
    );
  }

  return (
    <div className="space-y-2">
      <div className="flex items-center justify-between">
        <span className="text-sm font-medium">{page.name}</span>
        <span className="text-xs text-vibe-text-secondary">
          {page.annotations.length} annotations
        </span>
      </div>

      {page.imageUrl && (
        <div className="border border-vibe-border rounded overflow-hidden">
          <img
            src={page.imageUrl}
            alt={page.name}
            className="w-full h-32 object-cover"
          />
        </div>
      )}

      <Button variant="ghost" size="sm">
        View in ShowMe →
      </Button>
    </div>
  );
}
```

### 5.2 Plannotator Integration in Cards

**Concept**: Cards in "Planning" lane can link to implementation plans.

```typescript
// src/features/board-integrations/PlannotatorPreview.tsx
interface PlannotatorPreviewProps {
  planId?: string;
  onCreatePlan: () => void;
}

export function PlannotatorPreview({ planId, onCreatePlan }: PlannotatorPreviewProps) {
  if (!planId) {
    return (
      <div className="border border-dashed border-vibe-border rounded-lg p-4">
        <p className="text-sm text-vibe-text-secondary mb-2">
          No plan generated
        </p>
        <Button onClick={onCreatePlan} variant="outline" size="sm">
          Generate Plan
        </Button>
      </div>
    );
  }

  return (
    <div className="space-y-2">
      <div className="flex items-center justify-between">
        <span className="text-sm font-medium">Implementation Plan</span>
        <span className="text-xs text-green-500">✓ Approved</span>
      </div>

      <div className="text-xs text-vibe-text-secondary">
        <div>• 12 implementation steps</div>
        <div>• 2 annotations resolved</div>
      </div>

      <Button variant="ghost" size="sm">
        Review Plan →
      </Button>
    </div>
  );
}
```

### 5.3 Unified Card Detail Panel

**File**: `src/features/board/CardDetail.tsx`

```typescript
import { ShowMePreview } from '../board-integrations/ShowMePreview';
import { PlannotatorPreview } from '../board-integrations/PlannotatorPreview';
import { ActivityFeed } from '../board-integrations/ActivityFeed';
import { useBoardStore } from '@/lib/state/board-store';

export function CardDetail() {
  const { board, selectedCardId, updateCard } = useBoardStore();

  const card = board?.lanes
    .flatMap(lane => lane.cards)
    .find(c => c.id === selectedCardId);

  if (!card) return null;

  return (
    <div className="fixed right-0 top-0 h-screen w-[600px] bg-vibe-bg-secondary border-l border-vibe-border overflow-auto">
      <div className="p-6 space-y-6">
        {/* Header */}
        <div>
          <input
            className="text-2xl font-bold bg-transparent border-none w-full"
            value={card.title}
            onChange={(e) => updateCard(card.id, { title: e.target.value })}
          />
        </div>

        {/* Tabs */}
        <Tabs defaultValue="details">
          <TabsList>
            <TabsTrigger value="details">Details</TabsTrigger>
            <TabsTrigger value="mockups">Mockups</TabsTrigger>
            <TabsTrigger value="plan">Plan</TabsTrigger>
            <TabsTrigger value="activity">Activity</TabsTrigger>
          </TabsList>

          <TabsContent value="details">
            <div className="space-y-4">
              <div>
                <label className="text-sm font-medium">Description</label>
                <Textarea
                  value={card.description}
                  onChange={(e) => updateCard(card.id, { description: e.target.value })}
                  className="font-mono text-sm"
                  rows={6}
                />
              </div>

              <div>
                <label className="text-sm font-medium">Checklist</label>
                {/* Checklist component */}
              </div>
            </div>
          </TabsContent>

          <TabsContent value="mockups">
            <ShowMePreview
              pageId={card.showMePageId}
              onCreateMockup={() => {/* Navigate to ShowMe */}}
            />
          </TabsContent>

          <TabsContent value="plan">
            <PlannotatorPreview
              planId={card.plannotatorPlanId}
              onCreatePlan={() => {/* Generate plan */}}
            />
          </TabsContent>

          <TabsContent value="activity">
            <ActivityFeed cardId={card.id} />
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}
```

---

## Part 6: Implementation Roadmap

### **Phase 1: Vibe Design System** (Week 1)
**Goal**: Apply Vibe aesthetic to entire Design OS dashboard

- [ ] Configure Tailwind with Vibe color palette
- [ ] Update all existing components to use Vibe theme
- [ ] Add JetBrains Mono font
- [ ] Install Phosphor Icons
- [ ] Create dark mode variants for all pages
- [ ] Add micro-interactions (150ms transitions)

**Deliverable**: Design OS dashboard with Vibe visual language

---

### **Phase 2: Kanban Board Foundation** (Week 2)
**Goal**: Build basic Kanban board with drag-and-drop

- [ ] Install `@dnd-kit/core` for drag-and-drop
- [ ] Create `KanbanBoard` component
- [ ] Build `Lane` component (vertical card stack)
- [ ] Build `Card` component (minimal design)
- [ ] Implement `board-store` with Zustand
- [ ] Add keyboard shortcuts (Cmd+K, N for new card)

**Deliverable**: Functional Kanban board with 5 lanes

---

### **Phase 3: Card Detail System** (Week 3)
**Goal**: Build side-panel card details

- [ ] Create `CardDetail` slide-over component
- [ ] Add markdown editor for descriptions
- [ ] Build checklist UI
- [ ] Add comment system
- [ ] Implement activity feed
- [ ] Add card priority/tags UI

**Deliverable**: Rich card detail experience

---

### **Phase 4: Tool Integration** (Week 4)
**Goal**: Connect ShowMe and Plannotator to cards

- [ ] Create `ShowMePreview` component
- [ ] Create `PlannotatorPreview` component
- [ ] Add "Link Mockup" flow (card → ShowMe)
- [ ] Add "Generate Plan" flow (card → Plannotator)
- [ ] Update stores to maintain references
- [ ] Build navigation between tools

**Deliverable**: Unified workflow across all tools

---

### **Phase 5: Client Collaboration** (Week 5)
**Goal**: Make board client-friendly

- [ ] Add project overview dashboard
- [ ] Build progress visualization (% complete per lane)
- [ ] Add client comment mode (read-only with comments)
- [ ] Create export/print view
- [ ] Add keyboard shortcuts guide
- [ ] Polish empty states and onboarding

**Deliverable**: Client-ready collaborative board

---

### **Phase 6: Advanced Features** (Week 6+)
**Goal**: Optional enhancements

- [ ] Git branch integration (auto-create on card move)
- [ ] Real-time collaboration (WebSockets)
- [ ] Card templates (for common workflows)
- [ ] Time tracking per card
- [ ] Export to Linear/Jira format
- [ ] Mobile-responsive view

**Deliverable**: Production-ready system

---

## Part 7: Success Metrics

### Before (Current Design OS)
- ❌ Linear workflow (must complete in order)
- ❌ No visual progress tracking
- ❌ Client can't see work in progress
- ❌ Tools are disconnected
- ❌ Documentation-heavy

### After (Vibe-Inspired Design OS)
- ✅ **Visual workflow**: Drag cards between stages
- ✅ **Real-time progress**: See 40% in Design, 30% in Planning
- ✅ **Client collaboration**: Client moves cards, adds comments
- ✅ **Tool integration**: Mockups and plans embedded in cards
- ✅ **Developer UX**: Keyboard shortcuts, inline editing
- ✅ **Beautiful**: Vibe dark theme, smooth animations

---

## Part 8: Example Client Session

### Scenario: First Meeting with Restaurant Client

```
1. Open Dashboard → Create Project "Antonio's Restaurant"

2. Board initializes with 5 empty lanes

3. You create first card in Discovery lane:
   "Product Vision - Restaurant Website"

4. With client, you discuss goals and add checklist:
   [ ] Italian fine dining concept
   [ ] Online reservations
   [ ] Menu showcase
   [ ] Instagram integration

5. Client sees card move from Discovery → Design

6. You create "Color Palette" card in Design lane
   → Click "Create Mockup" → Opens ShowMe
   → Client picks colors by pointing at screen
   → You add annotations
   → Card now shows mockup preview

7. You create "Homepage" card in Planning lane
   → Click "Generate Plan" → Runs /export-product
   → Plan appears in card
   → Client reviews and approves
   → Card moves to Build lane

8. End of session: Client sees board with 8 cards
   across all stages, understands progress visually
```

---

## Part 9: Technical Decisions

### Why NOT Full Rust Backend?

**Original Vibe Kanban**: Rust (Axum) + React + SQLite + Git

**Our Choice**: React + Zustand + LocalStorage (+ Optional Node.js API)

**Rationale**:
1. **Faster to build**: 2 weeks vs. 2 months
2. **Simpler stack**: Frontend-only initially
3. **Easier to maintain**: No Rust compilation
4. **Client-friendly**: Runs on consultant's laptop
5. **Iterative**: Can add backend later if needed

### When to Add Backend?

Add Rust/Node backend when:
- Need multi-user real-time collaboration
- Want cloud sync across devices
- Require Git automation
- Need audit logs for compliance
- Have 100+ cards (performance)

---

## Part 10: File Structure After Implementation

```
Designbrnd/
├── src/
│   ├── app/
│   │   ├── App.tsx
│   │   └── Dashboard.tsx                    # Vibe-themed tabs
│   │
│   ├── features/
│   │   ├── board/                           # NEW: Kanban Board
│   │   │   ├── KanbanBoard.tsx
│   │   │   ├── Lane.tsx
│   │   │   ├── Card.tsx
│   │   │   ├── CardDetail.tsx
│   │   │   ├── AddCardButton.tsx
│   │   │   └── index.tsx
│   │   │
│   │   ├── board-integrations/              # NEW: Tool bridges
│   │   │   ├── ShowMePreview.tsx
│   │   │   ├── PlannotatorPreview.tsx
│   │   │   ├── ActivityFeed.tsx
│   │   │   └── index.tsx
│   │   │
│   │   ├── overview/                        # Enhanced with board preview
│   │   ├── planning/                        # Design OS (Vibe-themed)
│   │   ├── mockups/                         # ShowMe (Vibe-themed)
│   │   └── review/                          # Plannotator (Vibe-themed)
│   │
│   ├── components/
│   │   ├── ui/                              # shadcn (Vibe-themed)
│   │   └── layout/
│   │       ├── Navbar.tsx                   # Vibe design
│   │       └── Sidebar.tsx                  # Icon-based, 64px
│   │
│   ├── lib/
│   │   ├── state/
│   │   │   ├── board-store.ts               # NEW
│   │   │   ├── project-store.ts
│   │   │   ├── mockups-store.ts
│   │   │   └── review-store.ts
│   │   │
│   │   └── dnd/                             # NEW: Drag-and-drop
│   │       ├── useDragAndDrop.ts
│   │       └── dnd-context.tsx
│   │
│   ├── styles/
│   │   ├── vibe-theme.ts                    # NEW: Theme config
│   │   └── globals.css                      # Updated for dark mode
│   │
│   └── types/
│       ├── board.ts                         # NEW
│       └── card.ts                          # NEW
│
├── tailwind.config.js                       # Updated with Vibe palette
└── package.json                             # + @dnd-kit/core
```

---

## Part 11: Next Steps

### Immediate Actions

1. **Review this plan** with your team/stakeholders
2. **Choose scope**: MVP (Phase 1-3) or Full (Phase 1-6)?
3. **Set timeline**: When do you need this?
4. **First prototype**: Should I build Phase 1 now?

### Questions to Answer

1. **Git integration**: Do you want cards to auto-create Git branches?
2. **Multi-user**: Single consultant or team collaboration?
3. **Data storage**: LocalStorage OK or need database?
4. **Deployment**: Desktop app, web app, or both?
5. **Client access**: View-only or full collaboration?

---

## Conclusion

This plan transforms Design OS from a **documentation tool** into a **visual workflow management system** using Vibe Kanban's design philosophy.

**The Result**: A beautiful, dark-themed, developer-centric dashboard where you and your clients can collaborate visually on every phase of a project—from discovery to delivery.

**Estimated Timeline**: 6 weeks for full implementation, 2 weeks for MVP.

**Next Step**: Tell me if you want to proceed, and I'll start building Phase 1!

---

**Ready to build? Let me know!** 🚀
