# Unified Client Dashboard Architecture
## Design OS + ShowMe + Plannotator Integration

---

## Vision

Create a single web application where you can work with clients side-by-side, having all tools (Design OS workflow, ShowMe visual mockups, and Plannotator plan review) accessible in one unified interface.

---

## Current State Analysis

### Design OS (Existing)
- **Tech Stack:** React 19 + Vite + React Router + Tailwind + shadcn/ui
- **Current Routes:**
  - `/` - Product overview
  - `/data-model` - Data model visualization
  - `/design` - Design system tokens
  - `/sections` - Section list
  - `/sections/:id` - Section detail
  - `/export` - Export package
- **Runs on:** `http://localhost:5173` (Vite dev server)

### ShowMe (To Integrate)
- **Tech Stack:** TypeScript + Bun + Vite
- **Purpose:** Visual mockup and annotation tool
- **Features:** Canvas drawing, screenshot annotation, precise coordinates
- **Current:** Separate `/showme` skill opens browser window
- **Runs on:** `http://localhost:3000` (configurable)

### Plannotator (To Integrate)
- **Tech Stack:** Web-based annotation tool
- **Purpose:** Review and annotate AI-generated implementation plans
- **Features:** Mark deletions, insertions, replacements, comments
- **Current:** Separate tool
- **Runs on:** Standalone web interface

---

## Proposed Architecture

### Unified Dashboard Structure

```
┌─────────────────────────────────────────────────────────────────┐
│                     DESIGN OS DASHBOARD                         │
│                  (Client-Facing Application)                    │
└─────────────────────────────────────────────────────────────────┘
│
├─ Main Navigation (Horizontal Tabs)
│  ├─ 📋 Overview       → Project dashboard
│  ├─ 🎯 Planning       → Design OS workflow
│  ├─ 🎨 Mockups        → ShowMe integration
│  ├─ 📐 Review         → Plannotator integration
│  └─ 📦 Export         → Handoff package
│
├─ Planning Tab (Design OS - Existing + Enhanced)
│  ├─ Product Vision    → /product-vision results
│  ├─ Roadmap           → /product-roadmap results
│  ├─ Data Model        → /data-model visualization
│  ├─ Design Tokens     → /design-tokens (colors, typography)
│  ├─ Sections          → /shape-section for each section
│  └─ Sample Data       → /sample-data generated content
│
├─ Mockups Tab (ShowMe - New Integration)
│  ├─ Canvas Interface  → Full ShowMe functionality
│  ├─ Screenshot Upload → Paste/import screenshots
│  ├─ Annotation Tools  → Pins, areas, arrows, drawing
│  ├─ Multi-Page        → Support for multiple screens
│  └─ Export Feedback   → Send annotations to AI
│
├─ Review Tab (Plannotator - New Integration)
│  ├─ Plan Viewer       → Display implementation plans
│  ├─ Annotation Panel  → Mark deletions, insertions, comments
│  ├─ Side-by-side      → Plan vs. Mockup comparison
│  └─ Approval Flow     → Approve/request changes
│
└─ Export Tab (Enhanced)
   ├─ Package Preview   → Show export contents
   ├─ Download          → product-plan.zip
   └─ Handoff Checklist → Ensure all assets ready
```

---

## Technical Implementation Plan

### Phase 1: Foundation Setup

#### 1.1 Update Project Structure

```
Designbrnd/
├── src/
│   ├── app/                         # Main application
│   │   ├── App.tsx                  # Root component
│   │   ├── Dashboard.tsx            # Main dashboard layout (NEW)
│   │   └── ProjectProvider.tsx     # Global project state (NEW)
│   │
│   ├── features/                    # Feature modules (NEW)
│   │   ├── planning/                # Design OS workflow
│   │   │   ├── ProductPage.tsx      # (move from components/)
│   │   │   ├── DataModelPage.tsx
│   │   │   ├── DesignPage.tsx
│   │   │   ├── SectionsPage.tsx
│   │   │   └── index.tsx
│   │   │
│   │   ├── mockups/                 # ShowMe integration (NEW)
│   │   │   ├── MockupsPage.tsx      # Main mockups interface
│   │   │   ├── Canvas.tsx           # Drawing canvas
│   │   │   ├── AnnotationTools.tsx  # Toolbar
│   │   │   ├── PageManager.tsx      # Multi-page support
│   │   │   └── index.tsx
│   │   │
│   │   ├── review/                  # Plannotator integration (NEW)
│   │   │   ├── ReviewPage.tsx       # Plan review interface
│   │   │   ├── PlanViewer.tsx       # Display plans
│   │   │   ├── AnnotationPanel.tsx  # Annotation tools
│   │   │   └── index.tsx
│   │   │
│   │   ├── overview/                # Dashboard overview (NEW)
│   │   │   ├── OverviewPage.tsx     # Project status
│   │   │   ├── WorkflowProgress.tsx # Visual workflow tracker
│   │   │   └── index.tsx
│   │   │
│   │   └── export/
│   │       ├── ExportPage.tsx       # (move from components/)
│   │       └── index.tsx
│   │
│   ├── components/
│   │   ├── ui/                      # shadcn/ui components (existing)
│   │   ├── layout/                  # Layout components (NEW)
│   │   │   ├── Navbar.tsx           # Top navigation
│   │   │   ├── Tabs.tsx             # Main tabs
│   │   │   └── Sidebar.tsx          # Optional sidebar
│   │   └── shared/                  # Shared components
│   │
│   ├── lib/
│   │   ├── loaders/                 # Data loaders (existing)
│   │   ├── state/                   # State management (NEW)
│   │   │   ├── project-store.ts     # Project state (Zustand)
│   │   │   ├── mockups-store.ts     # Mockups state
│   │   │   └── review-store.ts      # Review state
│   │   └── utils/
│   │
│   └── types/
│       ├── product.ts               # (existing)
│       ├── mockups.ts               # (NEW)
│       └── review.ts                # (NEW)
│
├── public/
│   └── client-assets/               # Client-specific assets (NEW)
│
└── product/                         # Client project data (existing)
```

#### 1.2 Add Dependencies

```bash
npm install zustand                   # State management
npm install @tanstack/react-query     # Data fetching
npm install fabric                    # Canvas library (for ShowMe)
npm install react-pdf                 # PDF viewing (for plan review)
npm install framer-motion             # Animations
npm install date-fns                  # Date utilities
```

---

### Phase 2: Dashboard Layout

#### 2.1 Create Main Dashboard Component

**File:** `src/app/Dashboard.tsx`

```typescript
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { OverviewPage } from '@/features/overview';
import { PlanningFeature } from '@/features/planning';
import { MockupsPage } from '@/features/mockups';
import { ReviewPage } from '@/features/review';
import { ExportPage } from '@/features/export';

export function Dashboard() {
  return (
    <div className="h-screen flex flex-col">
      {/* Header */}
      <header className="border-b">
        <div className="container mx-auto px-4 py-4 flex items-center justify-between">
          <div>
            <h1 className="text-2xl font-bold">Design OS</h1>
            <p className="text-sm text-muted-foreground">
              Client Dashboard
            </p>
          </div>
          <div className="flex items-center gap-4">
            <ProjectSelector />
            <ClientInfo />
          </div>
        </div>
      </header>

      {/* Main Tabs */}
      <Tabs defaultValue="overview" className="flex-1 flex flex-col">
        <TabsList className="border-b px-4">
          <TabsTrigger value="overview">📋 Overview</TabsTrigger>
          <TabsTrigger value="planning">🎯 Planning</TabsTrigger>
          <TabsTrigger value="mockups">🎨 Mockups</TabsTrigger>
          <TabsTrigger value="review">📐 Review</TabsTrigger>
          <TabsTrigger value="export">📦 Export</TabsTrigger>
        </TabsList>

        <div className="flex-1 overflow-auto">
          <TabsContent value="overview" className="h-full m-0">
            <OverviewPage />
          </TabsContent>

          <TabsContent value="planning" className="h-full m-0">
            <PlanningFeature />
          </TabsContent>

          <TabsContent value="mockups" className="h-full m-0">
            <MockupsPage />
          </TabsContent>

          <TabsContent value="review" className="h-full m-0">
            <ReviewPage />
          </TabsContent>

          <TabsContent value="export" className="h-full m-0">
            <ExportPage />
          </TabsContent>
        </div>
      </Tabs>
    </div>
  );
}
```

#### 2.2 Create Project State Management

**File:** `src/lib/state/project-store.ts`

```typescript
import { create } from 'zustand';
import { persist } from 'zustand/middleware';

interface Project {
  id: string;
  name: string;
  clientName: string;
  createdAt: Date;
  updatedAt: Date;
  currentPhase: 'planning' | 'mockups' | 'review' | 'implementation';
}

interface ProjectStore {
  currentProject: Project | null;
  projects: Project[];

  setCurrentProject: (project: Project) => void;
  createProject: (name: string, clientName: string) => void;
  updateProject: (id: string, updates: Partial<Project>) => void;

  // Phase tracking
  completePhase: (phase: string) => void;
  isPhaseComplete: (phase: string) => boolean;
}

export const useProjectStore = create<ProjectStore>()(
  persist(
    (set, get) => ({
      currentProject: null,
      projects: [],

      setCurrentProject: (project) => set({ currentProject: project }),

      createProject: (name, clientName) => {
        const newProject: Project = {
          id: crypto.randomUUID(),
          name,
          clientName,
          createdAt: new Date(),
          updatedAt: new Date(),
          currentPhase: 'planning',
        };

        set((state) => ({
          projects: [...state.projects, newProject],
          currentProject: newProject,
        }));
      },

      updateProject: (id, updates) => {
        set((state) => ({
          projects: state.projects.map((p) =>
            p.id === id ? { ...p, ...updates, updatedAt: new Date() } : p
          ),
          currentProject:
            state.currentProject?.id === id
              ? { ...state.currentProject, ...updates, updatedAt: new Date() }
              : state.currentProject,
        }));
      },

      completePhase: (phase) => {
        const { currentProject } = get();
        if (!currentProject) return;

        // Auto-advance to next phase
        const phaseOrder = ['planning', 'mockups', 'review', 'implementation'];
        const currentIndex = phaseOrder.indexOf(currentProject.currentPhase);
        const nextPhase = phaseOrder[currentIndex + 1] || currentProject.currentPhase;

        get().updateProject(currentProject.id, { currentPhase: nextPhase as any });
      },

      isPhaseComplete: (phase) => {
        // Check if phase has required files/data
        // This will integrate with Design OS loaders
        return false; // Implement based on file existence
      },
    }),
    {
      name: 'design-os-project',
    }
  )
);
```

---

### Phase 3: ShowMe Integration

#### 3.1 ShowMe Canvas Component

**File:** `src/features/mockups/Canvas.tsx`

```typescript
import { useEffect, useRef, useState } from 'react';
import { fabric } from 'fabric';
import { Button } from '@/components/ui/button';
import { useMockupsStore } from '@/lib/state/mockups-store';

export function Canvas() {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const fabricRef = useRef<fabric.Canvas | null>(null);
  const [tool, setTool] = useState<'select' | 'pin' | 'area' | 'arrow' | 'pen'>('select');

  const { annotations, addAnnotation, currentPage } = useMockupsStore();

  useEffect(() => {
    if (!canvasRef.current) return;

    // Initialize Fabric.js canvas
    const canvas = new fabric.Canvas(canvasRef.current, {
      width: 1440,
      height: 900,
      backgroundColor: '#ffffff',
    });

    fabricRef.current = canvas;

    // Load current page's image/content
    if (currentPage?.imageUrl) {
      fabric.Image.fromURL(currentPage.imageUrl, (img) => {
        canvas.setBackgroundImage(img, canvas.renderAll.bind(canvas), {
          scaleX: canvas.width! / img.width!,
          scaleY: canvas.height! / img.height!,
        });
      });
    }

    return () => {
      canvas.dispose();
    };
  }, [currentPage]);

  const handleToolChange = (newTool: typeof tool) => {
    setTool(newTool);
    const canvas = fabricRef.current;
    if (!canvas) return;

    // Configure canvas for selected tool
    switch (newTool) {
      case 'select':
        canvas.isDrawingMode = false;
        canvas.selection = true;
        break;
      case 'pen':
        canvas.isDrawingMode = true;
        canvas.freeDrawingBrush.color = '#dc2626';
        canvas.freeDrawingBrush.width = 3;
        break;
      case 'pin':
        // Add click handler for numbered pins
        canvas.on('mouse:down', handleAddPin);
        break;
      // ... other tools
    }
  };

  const handleAddPin = (e: fabric.IEvent) => {
    if (tool !== 'pin' || !e.pointer) return;

    const pinNumber = annotations.length + 1;

    // Create pin marker
    const circle = new fabric.Circle({
      radius: 20,
      fill: '#dc2626',
      left: e.pointer.x - 20,
      top: e.pointer.y - 20,
    });

    const text = new fabric.Text(pinNumber.toString(), {
      fontSize: 16,
      fill: '#ffffff',
      left: e.pointer.x - 6,
      top: e.pointer.y - 10,
    });

    const group = new fabric.Group([circle, text], {
      left: e.pointer.x - 20,
      top: e.pointer.y - 20,
    });

    fabricRef.current?.add(group);

    // Prompt for annotation feedback
    addAnnotation({
      number: pinNumber,
      x: e.pointer.x,
      y: e.pointer.y,
      feedback: '', // Will be filled via dialog
    });
  };

  return (
    <div className="flex flex-col h-full">
      {/* Toolbar */}
      <div className="border-b p-4 flex gap-2">
        <Button
          variant={tool === 'select' ? 'default' : 'outline'}
          onClick={() => handleToolChange('select')}
        >
          Select
        </Button>
        <Button
          variant={tool === 'pin' ? 'default' : 'outline'}
          onClick={() => handleToolChange('pin')}
        >
          Pin
        </Button>
        <Button
          variant={tool === 'area' ? 'default' : 'outline'}
          onClick={() => handleToolChange('area')}
        >
          Area
        </Button>
        <Button
          variant={tool === 'arrow' ? 'default' : 'outline'}
          onClick={() => handleToolChange('arrow')}
        >
          Arrow
        </Button>
        <Button
          variant={tool === 'pen' ? 'default' : 'outline'}
          onClick={() => handleToolChange('pen')}
        >
          Draw
        </Button>

        <div className="flex-1" />

        <Button onClick={handleExportAnnotations}>
          Export to Claude
        </Button>
      </div>

      {/* Canvas */}
      <div className="flex-1 p-4 overflow-auto bg-gray-100">
        <div className="mx-auto" style={{ width: 1440 }}>
          <canvas ref={canvasRef} />
        </div>
      </div>
    </div>
  );
}
```

#### 3.2 Mockups Store

**File:** `src/lib/state/mockups-store.ts`

```typescript
import { create } from 'zustand';

interface Annotation {
  number: number;
  x: number;
  y: number;
  feedback: string;
}

interface Page {
  id: string;
  name: string;
  imageUrl?: string;
  annotations: Annotation[];
}

interface MockupsStore {
  pages: Page[];
  currentPageId: string | null;
  currentPage: Page | null;

  addPage: (name: string, imageUrl?: string) => void;
  setCurrentPage: (pageId: string) => void;
  addAnnotation: (annotation: Annotation) => void;
  updateAnnotation: (number: number, feedback: string) => void;
  exportToClaudeFormat: () => string;
}

export const useMockupsStore = create<MockupsStore>((set, get) => ({
  pages: [],
  currentPageId: null,
  currentPage: null,

  addPage: (name, imageUrl) => {
    const newPage: Page = {
      id: crypto.randomUUID(),
      name,
      imageUrl,
      annotations: [],
    };

    set((state) => ({
      pages: [...state.pages, newPage],
      currentPageId: newPage.id,
      currentPage: newPage,
    }));
  },

  setCurrentPage: (pageId) => {
    const page = get().pages.find((p) => p.id === pageId);
    set({ currentPageId: pageId, currentPage: page || null });
  },

  addAnnotation: (annotation) => {
    const { currentPageId } = get();
    if (!currentPageId) return;

    set((state) => ({
      pages: state.pages.map((page) =>
        page.id === currentPageId
          ? { ...page, annotations: [...page.annotations, annotation] }
          : page
      ),
    }));
  },

  updateAnnotation: (number, feedback) => {
    const { currentPageId } = get();
    if (!currentPageId) return;

    set((state) => ({
      pages: state.pages.map((page) =>
        page.id === currentPageId
          ? {
              ...page,
              annotations: page.annotations.map((ann) =>
                ann.number === number ? { ...ann, feedback } : ann
              ),
            }
          : page
      ),
    }));
  },

  exportToClaudeFormat: () => {
    const { currentPage } = get();
    if (!currentPage) return '';

    // Format annotations for Claude
    const annotationsText = currentPage.annotations
      .map(
        (ann) =>
          `[${ann.number}] Position: (${ann.x}, ${ann.y})\n    ${ann.feedback}`
      )
      .join('\n\n');

    return `# Mockup Annotations: ${currentPage.name}\n\n${annotationsText}`;
  },
}));
```

---

### Phase 4: Plannotator Integration

#### 4.1 Plan Review Component

**File:** `src/features/review/PlanViewer.tsx`

```typescript
import { useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import { Button } from '@/components/ui/button';
import { Textarea } from '@/components/ui/textarea';

interface PlanSection {
  id: string;
  title: string;
  content: string;
  annotations: PlanAnnotation[];
}

interface PlanAnnotation {
  type: 'delete' | 'insert' | 'replace' | 'comment';
  lineNumber: number;
  content: string;
  comment?: string;
}

export function PlanViewer() {
  const [selectedSection, setSelectedSection] = useState<string | null>(null);
  const [annotations, setAnnotations] = useState<PlanAnnotation[]>([]);

  // Load implementation plan from /export-product output
  const { data: plan } = useQuery({
    queryKey: ['implementation-plan'],
    queryFn: async () => {
      // Read from product-plan/ directory
      const response = await fetch('/api/plan');
      return response.json();
    },
  });

  const handleAddAnnotation = (
    type: PlanAnnotation['type'],
    lineNumber: number,
    content: string
  ) => {
    setAnnotations([
      ...annotations,
      {
        type,
        lineNumber,
        content,
      },
    ]);
  };

  const handleApprove = () => {
    // Send approved plan with annotations to implementation phase
    console.log('Approved plan with annotations:', annotations);
  };

  return (
    <div className="h-full flex">
      {/* Plan content */}
      <div className="flex-1 p-8 overflow-auto">
        <div className="max-w-4xl mx-auto">
          <h1 className="text-3xl font-bold mb-4">Implementation Plan</h1>

          {/* Render plan sections with line numbers */}
          <div className="space-y-8">
            {plan?.sections.map((section: PlanSection) => (
              <div key={section.id} className="border rounded-lg p-6">
                <h2 className="text-xl font-semibold mb-4">{section.title}</h2>
                <pre className="text-sm font-mono whitespace-pre-wrap">
                  {section.content.split('\n').map((line, i) => (
                    <div
                      key={i}
                      className="hover:bg-gray-100 px-2 py-1 cursor-pointer group"
                      onClick={() => {
                        // Show annotation toolbar
                      }}
                    >
                      <span className="text-gray-400 mr-4">{i + 1}</span>
                      <span>{line}</span>
                      <span className="opacity-0 group-hover:opacity-100 ml-2">
                        ✏️
                      </span>
                    </div>
                  ))}
                </pre>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Annotations sidebar */}
      <div className="w-80 border-l p-4 overflow-auto">
        <h3 className="font-semibold mb-4">Annotations</h3>

        <div className="space-y-4">
          {annotations.map((ann, i) => (
            <div key={i} className="border rounded p-3">
              <div className="text-xs text-muted-foreground mb-1">
                Line {ann.lineNumber} • {ann.type}
              </div>
              <div className="text-sm">{ann.content}</div>
            </div>
          ))}
        </div>

        <div className="mt-6 pt-6 border-t">
          <Button onClick={handleApprove} className="w-full">
            Approve Plan
          </Button>
        </div>
      </div>
    </div>
  );
}
```

---

### Phase 5: Overview Dashboard

#### 5.1 Workflow Progress Component

**File:** `src/features/overview/WorkflowProgress.tsx`

```typescript
import { CheckCircle2, Circle } from 'lucide-react';
import { useProjectStore } from '@/lib/state/project-store';

const WORKFLOW_STEPS = [
  { id: 'vision', label: 'Product Vision', phase: 'planning' },
  { id: 'roadmap', label: 'Roadmap', phase: 'planning' },
  { id: 'data-model', label: 'Data Model', phase: 'planning' },
  { id: 'design-tokens', label: 'Design Tokens', phase: 'planning' },
  { id: 'mockups', label: 'Visual Mockups', phase: 'mockups' },
  { id: 'review', label: 'Plan Review', phase: 'review' },
  { id: 'implementation', label: 'Implementation', phase: 'implementation' },
];

export function WorkflowProgress() {
  const { currentProject, isPhaseComplete } = useProjectStore();

  return (
    <div className="space-y-4">
      <h2 className="text-xl font-semibold">Workflow Progress</h2>

      <div className="space-y-2">
        {WORKFLOW_STEPS.map((step) => {
          const isComplete = isPhaseComplete(step.id);
          const isCurrent =
            currentProject?.currentPhase === step.phase && !isComplete;

          return (
            <div
              key={step.id}
              className={`flex items-center gap-3 p-3 rounded-lg ${
                isCurrent ? 'bg-blue-50 border border-blue-200' : ''
              }`}
            >
              {isComplete ? (
                <CheckCircle2 className="text-green-600" />
              ) : (
                <Circle className="text-gray-300" />
              )}
              <span
                className={`flex-1 ${
                  isComplete ? 'text-gray-500 line-through' : ''
                } ${isCurrent ? 'font-semibold' : ''}`}
              >
                {step.label}
              </span>
            </div>
          );
        })}
      </div>
    </div>
  );
}
```

#### 5.2 Overview Page

**File:** `src/features/overview/OverviewPage.tsx`

```typescript
import { useProjectStore } from '@/lib/state/project-store';
import { WorkflowProgress } from './WorkflowProgress';
import { Card } from '@/components/ui/card';

export function OverviewPage() {
  const { currentProject } = useProjectStore();

  if (!currentProject) {
    return (
      <div className="p-8">
        <h1 className="text-3xl font-bold mb-4">Welcome to Design OS</h1>
        <p className="text-muted-foreground mb-6">
          Create a new project to get started.
        </p>
        <CreateProjectButton />
      </div>
    );
  }

  return (
    <div className="p-8">
      <div className="max-w-6xl mx-auto space-y-6">
        {/* Project Header */}
        <div>
          <h1 className="text-3xl font-bold">{currentProject.name}</h1>
          <p className="text-muted-foreground">
            Client: {currentProject.clientName}
          </p>
        </div>

        {/* Current Phase */}
        <Card className="p-6">
          <h2 className="text-xl font-semibold mb-2">Current Phase</h2>
          <p className="text-2xl font-bold capitalize">
            {currentProject.currentPhase}
          </p>
        </Card>

        {/* Workflow Progress */}
        <Card className="p-6">
          <WorkflowProgress />
        </Card>

        {/* Quick Actions */}
        <div className="grid grid-cols-3 gap-4">
          <Card className="p-6">
            <h3 className="font-semibold mb-2">📋 Planning</h3>
            <p className="text-sm text-muted-foreground mb-4">
              Define product vision and requirements
            </p>
            <Button variant="outline" size="sm">
              Go to Planning →
            </Button>
          </Card>

          <Card className="p-6">
            <h3 className="font-semibold mb-2">🎨 Mockups</h3>
            <p className="text-sm text-muted-foreground mb-4">
              Create visual mockups with annotations
            </p>
            <Button variant="outline" size="sm">
              Go to Mockups →
            </Button>
          </Card>

          <Card className="p-6">
            <h3 className="font-semibold mb-2">📐 Review</h3>
            <p className="text-sm text-muted-foreground mb-4">
              Review and approve implementation plans
            </p>
            <Button variant="outline" size="sm">
              Go to Review →
            </Button>
          </Card>
        </div>
      </div>
    </div>
  );
}
```

---

## Client-Facing Workflow

### Session with Client Present

```
Step 1: Open Dashboard
$ npm run dev
→ Opens http://localhost:5173
→ Shows unified dashboard

Step 2: Create/Select Project
→ Click "New Project"
→ Enter: Project Name, Client Name
→ Dashboard initializes

Step 3: Planning Phase (Together with Client)
→ Navigate to "Planning" tab
→ Sub-tabs: Vision | Roadmap | Data Model | Design | Sections
→ Work through each step with client input
→ AI prompts appear in chat panel (integrated Claude)
→ Results save automatically to product/ directory

Step 4: Mockups Phase (Visual Collaboration)
→ Navigate to "Mockups" tab
→ Paste screenshot or start with blank canvas
→ Client points to screen: "I want the hero section here"
→ You add pin annotation with client's feedback
→ Export annotations → Feed to Claude for Figma design

Step 5: Review Phase (Approval Workflow)
→ Navigate to "Review" tab
→ Display implementation plan from /export-product
→ Client reviews side-by-side with mockups
→ Add annotations for changes
→ Client clicks "Approve Plan"

Step 6: Export & Handoff
→ Navigate to "Export" tab
→ Download product-plan.zip
→ Checklist: ✅ Vision, ✅ Mockups, ✅ Approved Plan
→ Hand off to implementation (or AI agent)
```

---

## Technical Enhancements

### 1. Real-time Collaboration (Optional Future Enhancement)

```typescript
// Add WebSocket support for multi-user sessions
npm install socket.io-client

// src/lib/collaboration/socket.ts
export function useCollaboration() {
  const socket = io('http://localhost:3001');

  // Sync annotations in real-time
  socket.on('annotation-added', (annotation) => {
    useMockupsStore.getState().addAnnotation(annotation);
  });

  return { socket };
}
```

### 2. Claude Integration Panel

```typescript
// src/components/layout/ClaudePanel.tsx
// Add a collapsible panel with Claude chat
// Auto-populates prompts based on current tab
// Example: In Planning tab, suggests "/product-vision"

export function ClaudePanel() {
  const [messages, setMessages] = useState([]);

  const sendToClaudeCode = (prompt: string) => {
    // Integration with Claude Code CLI
    // Could use MCP server or direct CLI calls
  };

  return (
    <div className="fixed right-0 top-0 h-screen w-96 border-l bg-background">
      {/* Chat interface with Claude */}
    </div>
  );
}
```

### 3. PDF Export for Client Handoff

```typescript
// Generate PDF documentation from all phases
npm install jspdf

// src/lib/export/pdf-generator.ts
export async function generateClientHandoffPDF() {
  const doc = new jsPDF();

  // Page 1: Product Vision
  // Page 2: Roadmap
  // Page 3: Design System
  // Page 4: Mockup Screenshots
  // Page 5: Approved Plan

  return doc.save('client-handoff.pdf');
}
```

---

## Deployment Options

### Option 1: Local Development (Current)

```bash
# Run on consultant's laptop
npm run dev
# Open with client at http://localhost:5173
```

**Pros:** No hosting costs, works offline, full control
**Cons:** Only accessible on your machine

---

### Option 2: Desktop App (Electron)

```bash
npm install -D electron electron-builder

# Package as desktop app
npm run build:electron
```

**Pros:** Professional, portable, works offline
**Cons:** Requires packaging for each OS

---

### Option 3: Cloud Deployment

```bash
# Deploy to Vercel/Netlify
npm run build
vercel deploy

# Or Docker container
docker build -t design-os-dashboard .
docker run -p 3000:3000 design-os-dashboard
```

**Pros:** Accessible from anywhere, collaborative
**Cons:** Requires hosting, monthly cost ($10-50)

---

## Implementation Timeline

### Week 1: Foundation
- [ ] Restructure project (features/ pattern)
- [ ] Add state management (Zustand stores)
- [ ] Create Dashboard layout with tabs
- [ ] Migrate existing Design OS pages

### Week 2: ShowMe Integration
- [ ] Install Fabric.js for canvas
- [ ] Build Canvas component
- [ ] Add annotation tools (pins, areas, arrows)
- [ ] Implement multi-page support
- [ ] Create export to Claude format

### Week 3: Plannotator Integration
- [ ] Build PlanViewer component
- [ ] Add annotation system (delete/insert/replace)
- [ ] Create side-by-side comparison view
- [ ] Implement approval workflow

### Week 4: Overview & Polish
- [ ] Create Overview dashboard
- [ ] Build WorkflowProgress tracker
- [ ] Add project management (create/switch)
- [ ] Polish UI/UX with animations
- [ ] Add keyboard shortcuts

### Week 5: Integration & Testing
- [ ] Integrate Claude Code (MCP or CLI)
- [ ] Test full workflow end-to-end
- [ ] Add PDF export feature
- [ ] Create client demo project
- [ ] Documentation and training materials

---

## Success Metrics

After implementation, you'll have:

✅ **Single unified application** - One URL, all tools
✅ **Client-facing interface** - Professional, easy to use
✅ **Complete workflow** - Planning → Mockups → Review → Export
✅ **Real-time collaboration** - Work with client side-by-side
✅ **Persistent state** - Save/resume projects
✅ **Professional handoff** - Export package with all assets

---

## Next Steps

1. **Review this architecture** - Ensure it meets your needs
2. **Choose deployment option** - Local dev, desktop app, or cloud?
3. **Start Phase 1** - Restructure and create dashboard
4. **Iterate with first client** - Test workflow and refine

---

**Questions to Consider:**

1. Do you want real-time collaboration (multiple users)?
2. Desktop app or web-based?
3. Should Claude integration be in-app or separate window?
4. Need offline mode?
5. Multi-tenant (multiple consultants using same instance)?

Let me know your preferences, and I can refine the architecture accordingly!
