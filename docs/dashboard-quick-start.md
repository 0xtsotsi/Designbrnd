# Quick Start: Building the Unified Dashboard

This guide provides step-by-step instructions to integrate ShowMe and Plannotator into Design OS as a unified client-facing dashboard.

---

## Prerequisites

- Design OS already installed (current repository)
- Node.js 18+ installed
- Basic knowledge of React and TypeScript

---

## Phase 1: Install Dependencies (30 minutes)

### Step 1: Install Required Packages

```bash
cd /home/user/Designbrnd

# State management and utilities
npm install zustand
npm install @tanstack/react-query
npm install date-fns

# Canvas library for ShowMe integration
npm install fabric
npm install @types/fabric -D

# Animations
npm install framer-motion

# Optional: PDF generation for handoff
npm install jspdf
```

### Step 2: Verify Installation

```bash
npm run dev
# Should start on http://localhost:5173
```

---

## Phase 2: Restructure Project (1 hour)

### Step 1: Create New Directory Structure

```bash
# Create features directory
mkdir -p src/features/{overview,planning,mockups,review,export}
mkdir -p src/components/layout
mkdir -p src/lib/state
mkdir -p src/types
```

### Step 2: Move Existing Components

```bash
# Move existing pages to planning feature
mv src/components/ProductPage.tsx src/features/planning/
mv src/components/DataModelPage.tsx src/features/planning/
mv src/components/DesignPage.tsx src/features/planning/
mv src/components/SectionsPage.tsx src/features/planning/
mv src/components/SectionPage.tsx src/features/planning/
mv src/components/ExportPage.tsx src/features/export/
```

### Step 3: Create Index Files

```bash
# src/features/planning/index.tsx
cat > src/features/planning/index.tsx << 'EOF'
export { ProductPage } from './ProductPage';
export { DataModelPage } from './DataModelPage';
export { DesignPage } from './DesignPage';
export { SectionsPage } from './SectionsPage';
export { SectionPage } from './SectionPage';
EOF
```

---

## Phase 3: Create Dashboard Layout (2 hours)

### Step 1: Create Project Store

Create `src/lib/state/project-store.ts`:

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
}

export const useProjectStore = create<ProjectStore>()(
  persist(
    (set) => ({
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
    }),
    {
      name: 'design-os-project',
    }
  )
);
```

### Step 2: Create Dashboard Component

Create `src/app/Dashboard.tsx`:

```typescript
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { OverviewPage } from '@/features/overview';

export function Dashboard() {
  return (
    <div className="h-screen flex flex-col">
      <header className="border-b">
        <div className="container mx-auto px-4 py-4">
          <h1 className="text-2xl font-bold">Design OS Dashboard</h1>
          <p className="text-sm text-muted-foreground">
            Unified Client Workflow
          </p>
        </div>
      </header>

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
            <div className="p-8">Planning (Coming next)</div>
          </TabsContent>

          <TabsContent value="mockups" className="h-full m-0">
            <div className="p-8">Mockups (Coming next)</div>
          </TabsContent>

          <TabsContent value="review" className="h-full m-0">
            <div className="p-8">Review (Coming next)</div>
          </TabsContent>

          <TabsContent value="export" className="h-full m-0">
            <div className="p-8">Export (Coming next)</div>
          </TabsContent>
        </div>
      </Tabs>
    </div>
  );
}
```

### Step 3: Create Overview Page

Create `src/features/overview/OverviewPage.tsx`:

```typescript
import { useProjectStore } from '@/lib/state/project-store';
import { Button } from '@/components/ui/button';
import { Card } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { useState } from 'react';

export function OverviewPage() {
  const { currentProject, createProject } = useProjectStore();
  const [showCreateForm, setShowCreateForm] = useState(false);
  const [projectName, setProjectName] = useState('');
  const [clientName, setClientName] = useState('');

  const handleCreate = () => {
    if (projectName && clientName) {
      createProject(projectName, clientName);
      setShowCreateForm(false);
      setProjectName('');
      setClientName('');
    }
  };

  if (!currentProject) {
    return (
      <div className="p-8 max-w-2xl mx-auto">
        <h1 className="text-3xl font-bold mb-4">Welcome to Design OS</h1>
        <p className="text-muted-foreground mb-6">
          Create a new project to get started with your client workflow.
        </p>

        {!showCreateForm ? (
          <Button onClick={() => setShowCreateForm(true)} size="lg">
            + New Project
          </Button>
        ) : (
          <Card className="p-6">
            <h2 className="text-xl font-semibold mb-4">Create New Project</h2>
            <div className="space-y-4">
              <div>
                <Label htmlFor="projectName">Project Name</Label>
                <Input
                  id="projectName"
                  value={projectName}
                  onChange={(e) => setProjectName(e.target.value)}
                  placeholder="E.g., Restaurant Website"
                />
              </div>

              <div>
                <Label htmlFor="clientName">Client Name</Label>
                <Input
                  id="clientName"
                  value={clientName}
                  onChange={(e) => setClientName(e.target.value)}
                  placeholder="E.g., Antonio's Italian Kitchen"
                />
              </div>

              <div className="flex gap-2">
                <Button onClick={handleCreate}>Create Project</Button>
                <Button
                  variant="outline"
                  onClick={() => setShowCreateForm(false)}
                >
                  Cancel
                </Button>
              </div>
            </div>
          </Card>
        )}
      </div>
    );
  }

  return (
    <div className="p-8">
      <div className="max-w-6xl mx-auto space-y-6">
        <div>
          <h1 className="text-3xl font-bold">{currentProject.name}</h1>
          <p className="text-muted-foreground">
            Client: {currentProject.clientName}
          </p>
        </div>

        <Card className="p-6">
          <h2 className="text-xl font-semibold mb-2">Current Phase</h2>
          <p className="text-2xl font-bold capitalize">
            {currentProject.currentPhase}
          </p>
        </Card>

        <div className="grid grid-cols-3 gap-4">
          <Card className="p-6">
            <h3 className="font-semibold mb-2">📋 Planning</h3>
            <p className="text-sm text-muted-foreground mb-4">
              Define product vision and requirements
            </p>
          </Card>

          <Card className="p-6">
            <h3 className="font-semibold mb-2">🎨 Mockups</h3>
            <p className="text-sm text-muted-foreground mb-4">
              Create visual mockups with annotations
            </p>
          </Card>

          <Card className="p-6">
            <h3 className="font-semibold mb-2">📐 Review</h3>
            <p className="text-sm text-muted-foreground mb-4">
              Review and approve implementation plans
            </p>
          </Card>
        </div>
      </div>
    </div>
  );
}
```

Create `src/features/overview/index.tsx`:

```typescript
export { OverviewPage } from './OverviewPage';
```

### Step 4: Update Main App

Update `src/App.tsx`:

```typescript
import { Dashboard } from './app/Dashboard';
import './index.css';

function App() {
  return <Dashboard />;
}

export default App;
```

### Step 5: Test Dashboard

```bash
npm run dev
# Open http://localhost:5173
# Should see new dashboard with tabs
# Create a test project
```

---

## Phase 4: Add ShowMe Integration (3 hours)

### Step 1: Create Mockups Store

Create `src/lib/state/mockups-store.ts`:

```typescript
import { create } from 'zustand';

export interface Annotation {
  number: number;
  x: number;
  y: number;
  feedback: string;
}

export interface Page {
  id: string;
  name: string;
  imageUrl?: string;
  annotations: Annotation[];
}

interface MockupsStore {
  pages: Page[];
  currentPageId: string | null;
  addPage: (name: string, imageUrl?: string) => void;
  setCurrentPage: (pageId: string) => void;
  addAnnotation: (annotation: Annotation) => void;
}

export const useMockupsStore = create<MockupsStore>((set, get) => ({
  pages: [],
  currentPageId: null,

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
    }));
  },

  setCurrentPage: (pageId) => {
    set({ currentPageId: pageId });
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
}));
```

### Step 2: Create Simple Mockups Page (MVP)

Create `src/features/mockups/MockupsPage.tsx`:

```typescript
import { useState } from 'react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Card } from '@/components/ui/card';
import { useMockupsStore } from '@/lib/state/mockups-store';

export function MockupsPage() {
  const { pages, currentPageId, addPage, setCurrentPage, addAnnotation } =
    useMockupsStore();
  const [imageUrl, setImageUrl] = useState('');
  const [feedback, setFeedback] = useState('');

  const currentPage = pages.find((p) => p.id === currentPageId);

  return (
    <div className="h-full flex">
      {/* Sidebar */}
      <div className="w-64 border-r p-4">
        <h3 className="font-semibold mb-4">Pages</h3>

        <Button
          onClick={() => {
            const name = prompt('Page name:');
            if (name) addPage(name);
          }}
          className="w-full mb-4"
          size="sm"
        >
          + New Page
        </Button>

        <div className="space-y-2">
          {pages.map((page) => (
            <Button
              key={page.id}
              variant={page.id === currentPageId ? 'default' : 'outline'}
              onClick={() => setCurrentPage(page.id)}
              className="w-full justify-start"
              size="sm"
            >
              {page.name}
            </Button>
          ))}
        </div>
      </div>

      {/* Main area */}
      <div className="flex-1 p-8 overflow-auto">
        {!currentPage ? (
          <div className="text-center text-muted-foreground mt-12">
            Create a new page to get started
          </div>
        ) : (
          <div className="max-w-4xl mx-auto">
            <h2 className="text-2xl font-bold mb-4">{currentPage.name}</h2>

            {/* Image upload */}
            <Card className="p-4 mb-6">
              <label className="block text-sm font-medium mb-2">
                Screenshot URL
              </label>
              <div className="flex gap-2">
                <Input
                  value={imageUrl}
                  onChange={(e) => setImageUrl(e.target.value)}
                  placeholder="Paste image URL or upload screenshot"
                />
                <Button
                  onClick={() => {
                    // TODO: Handle image upload
                  }}
                >
                  Upload
                </Button>
              </div>
            </Card>

            {/* Mockup display */}
            {currentPage.imageUrl && (
              <div className="mb-6 border rounded-lg overflow-hidden">
                <img
                  src={currentPage.imageUrl}
                  alt={currentPage.name}
                  className="w-full"
                />
              </div>
            )}

            {/* Annotations */}
            <Card className="p-4">
              <h3 className="font-semibold mb-4">Annotations</h3>

              <div className="space-y-4 mb-4">
                {currentPage.annotations.map((ann) => (
                  <div key={ann.number} className="border-l-4 border-red-500 pl-4">
                    <div className="font-semibold">
                      [{ann.number}] Position: ({ann.x}, {ann.y})
                    </div>
                    <div className="text-sm text-muted-foreground">
                      {ann.feedback}
                    </div>
                  </div>
                ))}
              </div>

              <div className="space-y-2">
                <label className="block text-sm font-medium">
                  Add Annotation
                </label>
                <Textarea
                  value={feedback}
                  onChange={(e) => setFeedback(e.target.value)}
                  placeholder="Describe what you want to change..."
                  rows={3}
                />
                <Button
                  onClick={() => {
                    if (feedback) {
                      addAnnotation({
                        number: currentPage.annotations.length + 1,
                        x: 100, // TODO: Get from canvas click
                        y: 100,
                        feedback,
                      });
                      setFeedback('');
                    }
                  }}
                >
                  Add Annotation
                </Button>
              </div>
            </Card>
          </div>
        )}
      </div>
    </div>
  );
}
```

Create `src/features/mockups/index.tsx`:

```typescript
export { MockupsPage } from './MockupsPage';
```

### Step 3: Update Dashboard to Include Mockups

Update `src/app/Dashboard.tsx`:

```typescript
import { MockupsPage } from '@/features/mockups';

// ... in TabsContent
<TabsContent value="mockups" className="h-full m-0">
  <MockupsPage />
</TabsContent>
```

### Step 4: Test Mockups Tab

```bash
npm run dev
# Navigate to Mockups tab
# Create a page
# Add annotations
```

---

## Phase 5: Add Review Integration (2 hours)

### Step 1: Create Simple Review Page

Create `src/features/review/ReviewPage.tsx`:

```typescript
import { Card } from '@/components/ui/card';
import { Button } from '@/components/ui/button';

export function ReviewPage() {
  return (
    <div className="p-8">
      <div className="max-w-4xl mx-auto">
        <h1 className="text-3xl font-bold mb-4">Implementation Plan Review</h1>

        <Card className="p-6 mb-6">
          <h2 className="text-xl font-semibold mb-4">Plan Status</h2>
          <p className="text-muted-foreground">
            No implementation plan generated yet. Export your product to
            generate a plan.
          </p>
        </Card>

        <div className="space-y-4">
          <h3 className="font-semibold">How to use this tool:</h3>
          <ol className="list-decimal list-inside space-y-2 text-muted-foreground">
            <li>Complete planning phase</li>
            <li>Export product plan</li>
            <li>Review generated implementation steps</li>
            <li>Add annotations for changes</li>
            <li>Approve plan for implementation</li>
          </ol>
        </div>
      </div>
    </div>
  );
}
```

Create `src/features/review/index.tsx`:

```typescript
export { ReviewPage } from './ReviewPage';
```

### Step 2: Update Dashboard

Update `src/app/Dashboard.tsx`:

```typescript
import { ReviewPage } from '@/features/review';

// ... in TabsContent
<TabsContent value="review" className="h-full m-0">
  <ReviewPage />
</TabsContent>
```

---

## Phase 6: Final Testing & Polish (1 hour)

### Step 1: Add Keyboard Shortcuts

Create `src/hooks/useKeyboardShortcuts.ts`:

```typescript
import { useEffect } from 'react';

export function useKeyboardShortcuts(
  onTabChange: (tab: string) => void
) {
  useEffect(() => {
    const handler = (e: KeyboardEvent) => {
      if (e.ctrlKey || e.metaKey) {
        switch (e.key) {
          case '1':
            e.preventDefault();
            onTabChange('overview');
            break;
          case '2':
            e.preventDefault();
            onTabChange('planning');
            break;
          case '3':
            e.preventDefault();
            onTabChange('mockups');
            break;
          case '4':
            e.preventDefault();
            onTabChange('review');
            break;
          case '5':
            e.preventDefault();
            onTabChange('export');
            break;
        }
      }
    };

    window.addEventListener('keydown', handler);
    return () => window.removeEventListener('keydown', handler);
  }, [onTabChange]);
}
```

### Step 2: Test Complete Workflow

1. Create a new project
2. Navigate through all tabs
3. Create a mockup page
4. Add annotations
5. Verify state persists on refresh

---

## Next Steps After MVP

### Enhance ShowMe Integration
- Add Fabric.js canvas for drawing
- Implement drag-and-drop image upload
- Add more annotation tools (arrows, areas)
- Export to Claude-ready format

### Enhance Review Integration
- Parse implementation plans from `/export-product`
- Add inline annotation UI
- Side-by-side comparison with mockups
- Approval workflow with signatures

### Add Planning Integration
- Embed existing Design OS pages
- Add progress tracking
- Auto-save functionality
- Export to Figma MCP format

---

## Troubleshooting

### Issue: Tabs not switching
**Solution:** Check that all Tab components have unique values

### Issue: State not persisting
**Solution:** Verify Zustand persist is configured correctly

### Issue: Images not loading
**Solution:** Check CORS settings for external images, use local uploads

---

## Resources

- [Zustand Docs](https://docs.pmnd.rs/zustand)
- [Fabric.js Docs](http://fabricjs.com/docs/)
- [shadcn/ui Components](https://ui.shadcn.com/)
- [React Router Docs](https://reactrouter.com/)

---

**Estimated Total Time: 8-10 hours for MVP**

After completing this quick start, you'll have a functional unified dashboard that you can demo to clients and iteratively enhance!
