# Revised E2E System Architecture
## Complete Integration: plane → designbrnd → plannotator → Figma MCP → RALPH LOOP → b0t → ByteRover → Reflect

**Version**: 2.0
**Last Updated**: 2026-01-13
**Status**: Ready for Implementation

---

## Executive Summary

### The Complete System

A fully automated AI-powered workflow from portfolio planning to production deployment, with **human-in-the-loop approval** gates and **persistent memory** across all phases.

### All Tools & Their Roles

| Tool | Role | Type |
|------|------|------|
| **plane** | Portfolio management | Planning |
| **designbrnd** | Project workspace + Design OS | Planning + Design |
| **plannotator** | Visual plan review/approval | Quality Gate |
| **Figma MCP** | Design extraction | Design |
| **RALPH LOOP** | TDD implementation | Development |
| **b0t (workflow-cluster)** | Automation executor (140 modules) | Execution Engine |
| **ByteRover (Beads)** | Memory system | Context Layer |
| **Reflect** | Meta-learning | Intelligence Layer |

---

## Part 1: System Flow (High-Level)

### Complete E2E Journey

```
📊 PORTFOLIO LEVEL (plane)
│
├─ Portfolio planning & prioritization
├─ Store in ByteRover: Project priorities, client context
│
↓ Triggers b0t workflow: "project-initialization"
│
├─────────────────────────────────────────────────┐
│ 🎨 PROJECT LEVEL (designbrnd + Design OS)      │
│                                                  │
│ Phase 1: Product Planning                       │
│   ├─ /product-vision                           │
│   ├─ /product-roadmap                          │
│   ├─ /data-model                               │
│   ├─ /design-tokens                            │
│   └─ /design-shell                             │
│                                                  │
│ ↓ Store all in ByteRover                       │
│                                                  │
│ Phase 2: Section Design                         │
│   ├─ /shape-section                            │
│   ├─ /shape-ux                                 │
│   └─ /build-order                              │
│                                                  │
│ ↓ Creates implementation plan                   │
└─────────────────────────────────────────────────┘
         │
         ↓ Plan created, needs approval
         │
┌─────────────────────────────────────────────────┐
│ 📐 APPROVAL GATE (plannotator)                  │
│                                                  │
│ Opens browser UI:                                │
│   ├─ Developer reviews plan visually           │
│   ├─ Can annotate, comment, markup             │
│   ├─ Can attach images with pen/arrow tools    │
│   └─ Decision: Approve or Request Changes      │
│                                                  │
│ IF "Request Changes":                           │
│   └─ Feedback sent back to Claude Code         │
│      └─ Revise plan, re-submit to plannotator  │
│                                                  │
│ IF "Approve":                                   │
│   └─ Plan stored in ByteRover                  │
│      └─ Triggers next phase                     │
└─────────────────────────────────────────────────┘
         │
         ↓ Plan approved
         │
┌─────────────────────────────────────────────────┐
│ 🎨 DESIGN EXTRACTION (Figma MCP)                │
│                                                  │
│ b0t workflow: "design-extraction"               │
│   ├─ Query ByteRover for approved plan         │
│   ├─ Extract components from Figma             │
│   ├─ Query ByteRover for component library     │
│   ├─ Query ByteRover for design tokens         │
│   └─ Generate component code                    │
│                                                  │
│ ↓ Store extracted design in ByteRover          │
└─────────────────────────────────────────────────┘
         │
         ↓ Code generated
         │
┌─────────────────────────────────────────────────┐
│ 🧪 TEST-DRIVEN DEVELOPMENT (RALPH LOOP)         │
│                                                  │
│ b0t workflow: "test-and-implement"              │
│   ├─ Query ByteRover for test strategy         │
│   ├─ Write tests first                          │
│   ├─ Implement code                             │
│   ├─ Run tests + visual verification           │
│   └─ Store results in ByteRover                │
│                                                  │
│ IF tests fail:                                  │
│   └─ Iterate until passing                      │
│                                                  │
│ IF tests pass:                                  │
│   └─ Store success in ByteRover                │
│      └─ Triggers deployment phase               │
└─────────────────────────────────────────────────┘
         │
         ↓ Tests passing
         │
┌─────────────────────────────────────────────────┐
│ 🚀 DEPLOYMENT (b0t + Digital Ocean)             │
│                                                  │
│ b0t workflow: "deploy-to-production"            │
│   ├─ Query ByteRover for deploy config         │
│   ├─ Query ByteRover for auto-deploy setting   │
│   ├─ Build production bundle                    │
│   ├─ Deploy to Digital Ocean (npm package)     │
│   └─ Store live URL in ByteRover               │
│                                                  │
│ ↓ Deployment complete                           │
└─────────────────────────────────────────────────┘
         │
         ↓ Production live
         │
┌─────────────────────────────────────────────────┐
│ 🧠 META-LEARNING (Reflect)                      │
│                                                  │
│ b0t workflow: "analyze-and-learn"               │
│   ├─ Query ByteRover for all project events    │
│   ├─ Analyze patterns across projects          │
│   ├─ Identify successful strategies             │
│   ├─ Generate improved skills                   │
│   └─ Store learnings in ~/.claude/skills/      │
│                                                  │
│ ↓ System gets smarter over time                 │
└─────────────────────────────────────────────────┘
```

---

## Part 2: Tool Deep-Dive

### 2.1 plane (Portfolio Management)

**Purpose**: Manage multiple client projects, set priorities

**Capabilities**:
- Portfolio overview
- Client project tracking
- Priority management
- Resource allocation

**ByteRover Integration**:
```bash
# Store portfolio context
brv curit "Client A: Dashboard redesign, Priority: HIGH" portfolio/clientA.md
brv curit "Client B: Marketing site, Priority: MEDIUM" portfolio/clientB.md

# Query for decision-making
brv query "high priority projects"
# Returns: ClientA Dashboard
```

**b0t Integration**:
```javascript
// plane triggers b0t workflow when project prioritized
await b0t.executeWorkflow('project-initialization', {
  projectId: 'clientA-dashboard',
  priority: 'HIGH',
  client: 'Client A'
})
```

---

### 2.2 designbrnd (Project Workspace + Design OS)

**Purpose**: Project-specific workspace with Design OS planning workflow

**Design OS Workflow**:
1. `/product-vision` → Define product
2. `/product-roadmap` → Break into sections
3. `/data-model` → Define entities
4. `/design-tokens` → Choose colors/typography
5. `/design-shell` → Design navigation
6. `/shape-section <name>` → Design specific sections
7. `/shape-ux <section>` → Generate UX specification
8. `/build-order <section>` → Generate implementation prompts

**ByteRover Integration**:
```bash
# Every command stores results
brv curit "Product vision for dashboard" product/product-overview.md
brv curit "Roadmap with 5 sections" product/product-roadmap.md
brv curit "Data model: User, Project, Task" product/data-model/data-model.md
brv curit "Design tokens: blue primary, slate neutral" product/design-system/colors.json
brv curit "UX spec for authentication section" docs/ux-spec-auth.md
brv curit "Build order: 9 atomic prompts for homepage" docs/build-order-homepage.md
```

**Output**: Comprehensive plan ready for approval

---

### 2.3 plannotator (Visual Plan Review)

**Purpose**: Human-in-the-loop quality gate BEFORE implementation

**How It Works**:
1. AI agent completes planning (Design OS phase)
2. plannotator opens browser UI
3. Developer reviews plan visually
4. Can annotate:
   - Delete sections
   - Insert new requirements
   - Replace text
   - Add comments
   - Attach images with markup tools (pen, arrow, circle)
5. Decision:
   - **Approve** → Plan locked, implementation proceeds
   - **Request Changes** → Structured feedback sent to agent

**Integration Pattern**:
```typescript
// After Design OS completes
const plan = {
  productVision: readFile('product/product-overview.md'),
  roadmap: readFile('product/product-roadmap.md'),
  uxSpecs: readFile('docs/ux-spec-*.md'),
  buildOrders: readFile('docs/build-order-*.md')
}

// Send to plannotator
const approval = await plannotator.review(plan)

if (approval.status === 'approved') {
  // Store approval in ByteRover
  await curit('Plan approved by developer', approval)

  // Trigger next phase
  await b0t.executeWorkflow('design-extraction', {
    projectId: 'clientA-dashboard',
    approvedPlan: plan
  })
} else {
  // Handle feedback
  console.log('Developer feedback:', approval.feedback)
  // Agent revises plan based on feedback
}
```

**ByteRover Integration**:
```bash
# Store approval
brv curit "Plan approved with 2 annotation comments" approvals/plan-v1.md

# Store feedback if changes requested
brv curit "Requested changes: Add password reset flow" feedback/plan-v1-feedback.md
```

---

### 2.4 Figma MCP (Design Extraction)

**Purpose**: Extract component designs from Figma, generate code

**b0t Workflow**:
```json
{
  "name": "design-extraction",
  "trigger": {
    "type": "workflow",
    "source": "plannotator-approval"
  },
  "steps": [
    {
      "id": "query-context",
      "module": "byterover",
      "function": "query",
      "params": {
        "questions": [
          "approved plan",
          "component library choice",
          "design tokens"
        ]
      }
    },
    {
      "id": "extract-figma",
      "module": "figma",
      "function": "extractComponents",
      "params": {
        "figmaUrl": "{{ context.figmaUrl }}",
        "components": "{{ steps.query-context.plan.components }}"
      }
    },
    {
      "id": "generate-code",
      "module": "codegen",
      "function": "generateFromDesign",
      "params": {
        "design": "{{ steps.extract-figma.output }}",
        "library": "{{ steps.query-context.componentLibrary }}",
        "tokens": "{{ steps.query-context.designTokens }}"
      }
    },
    {
      "id": "store-result",
      "module": "byterover",
      "function": "curit",
      "params": {
        "description": "Generated code from Figma design",
        "files": "{{ steps.generate-code.files }}"
      }
    }
  ]
}
```

**ByteRover Context**:
- Queries for approved plan
- Queries for component library
- Queries for design tokens
- Stores generated code

---

### 2.5 RALPH LOOP (Test-Driven Development)

**Purpose**: Implement features with TDD + visual verification

**b0t Workflow**:
```json
{
  "name": "test-and-implement",
  "trigger": {
    "type": "workflow",
    "source": "design-extraction-complete"
  },
  "steps": [
    {
      "id": "query-strategy",
      "module": "byterover",
      "function": "query",
      "params": {
        "question": "test strategy for {{ context.feature }}"
      }
    },
    {
      "id": "write-tests",
      "module": "ralphloop",
      "function": "writeTests",
      "params": {
        "feature": "{{ context.feature }}",
        "strategy": "{{ steps.query-strategy.strategy }}"
      }
    },
    {
      "id": "implement",
      "module": "ralphloop",
      "function": "implement",
      "params": {
        "tests": "{{ steps.write-tests.output }}",
        "specs": "{{ context.generatedCode }}"
      }
    },
    {
      "id": "run-tests",
      "module": "ralphloop",
      "function": "runTests",
      "params": {
        "testFiles": "{{ steps.write-tests.files }}"
      }
    },
    {
      "id": "visual-verify",
      "module": "ralphloop",
      "function": "visualVerification",
      "params": {
        "component": "{{ context.feature }}",
        "designReference": "{{ context.figmaExport }}"
      }
    },
    {
      "id": "store-results",
      "module": "byterover",
      "function": "curit",
      "params": {
        "description": "Tests {{ steps.run-tests.passed ? 'PASSED' : 'FAILED' }}",
        "content": "{{ steps.run-tests }}"
      }
    },
    {
      "id": "conditional-deploy",
      "module": "workflow",
      "function": "triggerWorkflow",
      "params": {
        "workflowId": "deploy-to-production",
        "condition": "{{ steps.run-tests.passed && steps.visual-verify.passed }}",
        "context": {
          "feature": "{{ context.feature }}",
          "build": "{{ steps.implement.output }}"
        }
      }
    }
  ]
}
```

---

### 2.6 b0t (workflow-cluster) - Automation Executor

**What b0t Actually Is**:
- **140 modules** across 16 categories (AI, business, communication, e-commerce, devtools, etc.)
- **900+ functions** available to workflows
- **BullMQ** execution engine (157k ops/min)
- **Multi-tenant** with organization isolation
- **Resilient** (circuit breakers, rate limiting, retries)

**b0t's Role in System**:
```
b0t IS NOT the orchestrator
b0t IS the execution engine

┌──────────────────────────────────────┐
│   ByteRover (Orchestrator Brain)     │
│   - Receives events                   │
│   - Queries memory for context        │
│   - Decides what workflows to run     │
└────────────┬─────────────────────────┘
             │
             ↓ "Execute design-extraction workflow"
             │
┌────────────┴─────────────────────────┐
│   b0t (Execution Muscle)             │
│   - Runs workflow steps               │
│   - Uses 140 modules                  │
│   - Handles errors/retries            │
│   - Returns results                   │
└──────────────────────────────────────┘
```

**Module Categories** (from exploration):
- **ai/**: Claude, OpenAI, Cohere, Vector DBs
- **business/**: Salesforce, HubSpot, QuickBooks
- **communication/**: Slack, Discord, Gmail
- **devtools/**: GitHub, GitLab, DigitalOcean
- **ecommerce/**: Shopify, Stripe
- **utilities/**: HTTP, scraping, CSV/JSON

**Adding Digital Ocean Module**:
```typescript
// src/modules/devtools/digitalocean.ts
import axios from 'axios'
import { circuitBreaker, rateLimiter } from '@/lib/resilience'

const client = axios.create({
  baseURL: 'https://api.digitalocean.com/v2',
  headers: {
    'Authorization': `Bearer ${process.env.DIGITALOCEAN_API_TOKEN}`
  }
})

export async function deployApp(options: {
  appName: string
  gitRepo: string
  region: string
  envVars: Record<string, string>
}) {
  const app = await client.post('/apps', {
    spec: {
      name: options.appName,
      region: options.region,
      services: [{
        github: { repo: options.gitRepo },
        envs: Object.entries(options.envVars).map(([k, v]) =>
          ({ key: k, value: v })
        )
      }]
    }
  })
  return app.data
}

export async function getDeploymentStatus(appId: string) {
  const app = await client.get(`/apps/${appId}`)
  return app.data
}
```

**Then it's immediately available in workflows**:
```json
{
  "id": "deploy",
  "module": "digitalocean",
  "function": "deployApp",
  "params": {
    "appName": "{{ context.appName }}",
    "gitRepo": "{{ context.repo }}",
    "region": "nyc3",
    "envVars": "{{ context.envVars }}"
  }
}
```

---

### 2.7 ByteRover (Beads) - Memory System

**Purpose**: Persistent context across all workflow phases

**Storage Architecture**:
```
.beads/
├── portfolio/
│   ├── clientA-context.md
│   └── clientB-context.md
├── planning/
│   ├── product-vision.md
│   ├── roadmap.md
│   └── data-model.md
├── approvals/
│   ├── plan-v1-approved.md
│   └── plan-v2-feedback.md
├── design/
│   ├── extracted-components.md
│   └── generated-code.md
├── implementation/
│   ├── test-results.md
│   └── visual-verification.md
├── deployment/
│   ├── config.md
│   ├── history.md
│   └── live-urls.md
└── patterns/
    └── learned-strategies.md
```

**CLI Commands**:
```bash
# Initialize
brv init

# Store memory
brv curit "Description" file1 file2

# Query memory
brv query "question"

# Generate auto-rules
brv gen-rules

# Deploy (uses memory)
brv deploy
```

**Integration with Every Tool**:
```typescript
// Every tool queries ByteRover for context
const context = await byterover.query('relevant context')

// Every tool stores results in ByteRover
await byterover.curit('description', results)

// Example flow:
// 1. plane stores project priority
// 2. designbrnd queries priority, stores plan
// 3. plannotator queries plan, stores approval
// 4. Figma MCP queries approval, stores code
// 5. RALPH LOOP queries code, stores tests
// 6. b0t queries tests, stores deployment
// 7. Reflect queries everything, stores learnings
```

---

### 2.8 Reflect (Meta-Learning)

**Purpose**: Learn patterns across projects, improve agent behavior

**How It Works**:
1. Triggered after significant milestones (e.g., every 5 deployments)
2. Queries ByteRover for project history
3. Analyzes patterns:
   - Which component libraries lead to faster development?
   - Which test strategies catch more bugs?
   - Which UX patterns get approved faster?
4. Generates improved skills stored in `~/.claude/skills/`
5. Next projects benefit from learnings

**b0t Workflow**:
```json
{
  "name": "analyze-and-learn",
  "trigger": {
    "type": "event",
    "event": "deployment.completed",
    "condition": "deploymentCount % 5 === 0"
  },
  "steps": [
    {
      "id": "query-history",
      "module": "byterover",
      "function": "query",
      "params": {
        "question": "all project events last 30 days"
      }
    },
    {
      "id": "analyze-patterns",
      "module": "reflect",
      "function": "analyzeEventStream",
      "params": {
        "events": "{{ steps.query-history.events }}"
      }
    },
    {
      "id": "generate-skills",
      "module": "reflect",
      "function": "generateSkills",
      "params": {
        "patterns": "{{ steps.analyze-patterns.patterns }}"
      }
    },
    {
      "id": "store-learnings",
      "module": "byterover",
      "function": "curit",
      "params": {
        "description": "Detected patterns and generated skills",
        "content": "{{ steps.generate-skills.output }}"
      }
    }
  ]
}
```

**Example Learnings**:
```bash
# Reflect discovers:
"Projects using shadcn/ui + TypeScript deploy 40% faster"
"Authentication features always need password reset flow"
"Visual verification catches 80% of design mismatches"

# Stores as skills in ~/.claude/skills/
# Next projects automatically use these insights
```

---

## Part 3: Per-Client/Project Isolation

### Isolation Architecture

**Each client project is completely isolated**:

```
/home/user/
├── ClientA-Dashboard/
│   ├── .beads/                    ← ClientA memories only
│   │   ├── planning/
│   │   ├── approvals/
│   │   ├── design/
│   │   ├── implementation/
│   │   └── deployment/
│   ├── .claude/                   ← ClientA agent config
│   │   ├── custom_instructions.md
│   │   └── commands/
│   ├── .workflows/                ← ClientA-specific workflows
│   │   └── deploy-config.json
│   ├── product/                   ← Design OS outputs
│   ├── docs/                      ← Plans, specs
│   └── src/                       ← Code
│
├── ClientB-Marketing/
│   ├── .beads/                    ← ClientB memories (isolated)
│   ├── .claude/                   ← ClientB config (different)
│   ├── .workflows/                ← ClientB workflows
│   ├── product/
│   ├── docs/
│   └── src/
│
└── ClientC-ECommerce/
    └── ... (completely separate)
```

### b0t Multi-Tenancy

**b0t workflows scoped by projectId**:
```typescript
// Execute workflow for specific project
await b0t.executeWorkflow('design-extraction', {
  projectId: 'clientA-dashboard'  // Isolates to ClientA
})

// b0t internals:
function executeWorkflow(workflowId: string, context: WorkflowContext) {
  // Filter by projectId
  const projectMemories = await byterover.query(
    `${context.projectId} memories`
  )

  // Execute with project-specific context
  return execute(workflowId, { ...context, memories: projectMemories })
}
```

### ByteRover Namespacing

**Memories scoped per project**:
```bash
# ClientA
cd /home/user/ClientA-Dashboard
brv curit "Component library: shadcn/ui" config.md
# Stored in: ClientA-Dashboard/.beads/

# ClientB
cd /home/user/ClientB-Marketing
brv curit "Component library: Material-UI" config.md
# Stored in: ClientB-Marketing/.beads/

# Queries are scoped
cd /home/user/ClientA-Dashboard
brv query "component library"
# Returns: "shadcn/ui" (from ClientA memories only)

cd /home/user/ClientB-Marketing
brv query "component library"
# Returns: "Material-UI" (from ClientB memories only)
```

---

## Part 4: Complete Workflow Examples

### Example 1: New Dashboard Project

**Step 1: Portfolio Planning (plane)**
```bash
# In plane tool
User: "Add new project: ClientA Dashboard, Priority: HIGH"

# plane stores in ByteRover
brv curit "ClientA Dashboard project, Priority HIGH" portfolio/clientA.md

# plane triggers b0t
await b0t.executeWorkflow('project-initialization', {
  projectId: 'clientA-dashboard',
  client: 'ClientA',
  priority: 'HIGH'
})
```

**Step 2: Project Setup (b0t workflow)**
```json
{
  "name": "project-initialization",
  "steps": [
    {
      "id": "create-directory",
      "module": "filesystem",
      "function": "createDirectory",
      "params": {
        "path": "/home/user/ClientA-Dashboard"
      }
    },
    {
      "id": "init-byterover",
      "module": "bash",
      "function": "exec",
      "params": {
        "command": "cd /home/user/ClientA-Dashboard && brv init"
      }
    },
    {
      "id": "init-git",
      "module": "git",
      "function": "init",
      "params": {
        "path": "/home/user/ClientA-Dashboard"
      }
    },
    {
      "id": "store-context",
      "module": "byterover",
      "function": "curit",
      "params": {
        "description": "Project initialized for ClientA Dashboard",
        "content": "{{ context }}"
      }
    }
  ]
}
```

**Step 3: Design OS Planning (designbrnd)**
```bash
# Developer uses Design OS commands
/product-vision
# Output stored: product/product-overview.md

/product-roadmap
# Output stored: product/product-roadmap.md

/data-model
# Output stored: product/data-model/data-model.md

/design-tokens
# Output stored: product/design-system/

/design-shell
# Output stored: product/shell/

/shape-section dashboard
# Output stored: docs/section-dashboard.md

/shape-ux dashboard
# Output stored: docs/ux-spec-dashboard.md

/build-order dashboard
# Output stored: docs/build-order-dashboard.md

# All automatically stored in ByteRover via brv curit
```

**Step 4: Plan Approval (plannotator)**
```typescript
// Claude Code triggers plannotator after Design OS complete
const plan = {
  productVision: readFile('product/product-overview.md'),
  roadmap: readFile('product/product-roadmap.md'),
  dataModel: readFile('product/data-model/data-model.md'),
  uxSpec: readFile('docs/ux-spec-dashboard.md'),
  buildOrder: readFile('docs/build-order-dashboard.md')
}

// Opens browser UI for visual review
const review = await plannotator.review({
  projectId: 'clientA-dashboard',
  plan: plan
})

// Developer annotates in browser:
// - Adds comment: "Include password reset in auth section"
// - Approves plan

// Approval stored in ByteRover
await curit('Plan approved with 1 annotation', {
  status: 'approved',
  annotations: review.annotations
})
```

**Step 5: Design Extraction (Figma MCP via b0t)**
```bash
# b0t workflow triggered by approval
await b0t.executeWorkflow('design-extraction', {
  projectId: 'clientA-dashboard',
  figmaUrl: 'figma.com/file/abc123'
})

# Workflow steps:
# 1. Query ByteRover for approved plan
# 2. Query ByteRover for component library (returns: shadcn/ui)
# 3. Query ByteRover for design tokens
# 4. Extract components from Figma
# 5. Generate code using shadcn/ui + tokens
# 6. Store generated code in ByteRover
```

**Step 6: TDD Implementation (RALPH LOOP via b0t)**
```bash
# b0t workflow triggered by design extraction complete
await b0t.executeWorkflow('test-and-implement', {
  projectId: 'clientA-dashboard',
  feature: 'dashboard'
})

# Workflow steps:
# 1. Query ByteRover for test strategy
# 2. Write tests first
# 3. Implement code to pass tests
# 4. Run tests
# 5. Visual verification (screenshot vs Figma)
# 6. Store results in ByteRover (PASSED)
# 7. If passed, trigger deployment
```

**Step 7: Deployment (b0t + Digital Ocean)**
```bash
# b0t workflow triggered by tests passing
await b0t.executeWorkflow('deploy-to-production', {
  projectId: 'clientA-dashboard'
})

# Workflow steps:
# 1. Query ByteRover for auto-deploy setting (returns: true)
# 2. Query ByteRover for DO deployment config
# 3. Build production bundle (npm run build)
# 4. Deploy to Digital Ocean via module
# 5. Wait for deployment complete
# 6. Store live URL in ByteRover

# Result stored:
brv curit "Deployed to production" {
  url: "https://clienta-dashboard.ondigitalocean.app",
  timestamp: "2026-01-13T14:30:00Z",
  commit: "abc123def"
}
```

**Step 8: Meta-Learning (Reflect via b0t)**
```bash
# After 5 successful deployments, Reflect analyzes
await b0t.executeWorkflow('analyze-and-learn', {
  scope: 'last-5-deployments'
})

# Workflow steps:
# 1. Query ByteRover for all deployment events
# 2. Analyze patterns:
#    - Average time: design → production = 4 hours
#    - shadcn/ui projects: 30% faster than MUI
#    - plannotator approvals: average 2 annotations
# 3. Generate improved skills
# 4. Store in ~/.claude/skills/

# Future projects automatically benefit from these learnings
```

---

## Part 5: b0t Workflow Library

### Core Workflows

**1. project-initialization.json**
```json
{
  "name": "Project Initialization",
  "trigger": { "type": "manual" },
  "steps": [
    { "id": "create-dir", "module": "filesystem", "function": "createDirectory" },
    { "id": "init-byterover", "module": "bash", "function": "exec" },
    { "id": "init-git", "module": "git", "function": "init" },
    { "id": "store", "module": "byterover", "function": "curit" }
  ]
}
```

**2. design-extraction.json**
```json
{
  "name": "Design Extraction",
  "trigger": { "type": "workflow", "source": "plannotator-approval" },
  "steps": [
    { "id": "query-plan", "module": "byterover", "function": "query" },
    { "id": "query-library", "module": "byterover", "function": "query" },
    { "id": "extract-figma", "module": "figma", "function": "extractComponents" },
    { "id": "generate-code", "module": "codegen", "function": "generate" },
    { "id": "store", "module": "byterover", "function": "curit" }
  ]
}
```

**3. test-and-implement.json**
```json
{
  "name": "Test and Implement",
  "trigger": { "type": "workflow", "source": "design-extraction-complete" },
  "steps": [
    { "id": "query-strategy", "module": "byterover", "function": "query" },
    { "id": "write-tests", "module": "ralphloop", "function": "writeTests" },
    { "id": "implement", "module": "ralphloop", "function": "implement" },
    { "id": "run-tests", "module": "ralphloop", "function": "runTests" },
    { "id": "visual-verify", "module": "ralphloop", "function": "visualVerification" },
    { "id": "store", "module": "byterover", "function": "curit" },
    { "id": "trigger-deploy", "module": "workflow", "function": "triggerWorkflow",
      "condition": "{{ steps['run-tests'].passed }}" }
  ]
}
```

**4. deploy-to-production.json**
```json
{
  "name": "Deploy to Production",
  "trigger": { "type": "workflow", "source": "tests-passed" },
  "steps": [
    { "id": "query-config", "module": "byterover", "function": "query" },
    { "id": "query-auto-deploy", "module": "byterover", "function": "query" },
    { "id": "build", "module": "bash", "function": "exec", "params": { "command": "npm run build" }},
    { "id": "deploy", "module": "digitalocean", "function": "deployApp" },
    { "id": "wait", "module": "digitalocean", "function": "waitForDeployment" },
    { "id": "store", "module": "byterover", "function": "curit" },
    { "id": "notify", "module": "slack", "function": "postMessage",
      "params": { "channel": "#deploys", "text": "🚀 Deployed: {{ steps.deploy.liveUrl }}" }}
  ]
}
```

**5. analyze-and-learn.json**
```json
{
  "name": "Analyze and Learn",
  "trigger": { "type": "event", "event": "deployment.completed", "condition": "count % 5 === 0" },
  "steps": [
    { "id": "query-events", "module": "byterover", "function": "query" },
    { "id": "analyze", "module": "reflect", "function": "analyzeEventStream" },
    { "id": "generate-skills", "module": "reflect", "function": "generateSkills" },
    { "id": "store", "module": "byterover", "function": "curit" }
  ]
}
```

---

## Part 6: Deployment Configuration

### Digital Ocean Module Setup

**1. Add to b0t modules**:
```typescript
// workflow-cluster/src/modules/devtools/digitalocean.ts

import axios from 'axios'
import { circuitBreaker, rateLimiter } from '@/lib/resilience'
import { logger } from '@/lib/logger'

const client = axios.create({
  baseURL: 'https://api.digitalocean.com/v2',
  headers: {
    'Authorization': `Bearer ${process.env.DIGITALOCEAN_API_TOKEN}`,
    'Content-Type': 'application/json'
  }
})

// Circuit breaker: 20 second timeout
// Rate limiter: 5000 requests per hour (DO limit)
const makeRequest = circuitBreaker(
  rateLimiter(
    async <T>(method: string, path: string, data?: any): Promise<T> => {
      try {
        const response = await client({ method, url: path, data })
        logger.info({ method, path }, 'DigitalOcean API call succeeded')
        return response.data
      } catch (error) {
        logger.error({ method, path, error }, 'DigitalOcean API call failed')
        throw error
      }
    },
    { points: 5000, duration: 3600 }
  ),
  { timeout: 20000 }
)

export async function deployApp(options: {
  appName: string
  gitRepo: string
  branch: string
  region: string
  buildCommand: string
  runCommand: string
  envVars: Record<string, string>
}) {
  return await makeRequest('POST', '/apps', {
    spec: {
      name: options.appName,
      region: options.region,
      services: [{
        name: 'web',
        github: {
          repo: options.gitRepo,
          branch: options.branch,
          deploy_on_push: true
        },
        build_command: options.buildCommand,
        run_command: options.runCommand,
        environment_slug: 'node-js',
        instance_count: 1,
        instance_size_slug: 'basic-xxs',
        envs: Object.entries(options.envVars).map(([key, value]) => ({
          key,
          value,
          scope: 'RUN_AND_BUILD_TIME'
        }))
      }]
    }
  })
}

export async function getApp(appId: string) {
  return await makeRequest('GET', `/apps/${appId}`)
}

export async function waitForDeployment(appId: string, maxWaitMs = 600000) {
  const startTime = Date.now()

  while (Date.now() - startTime < maxWaitMs) {
    const app = await getApp(appId)

    if (app.phase === 'ACTIVE') {
      return app
    }

    if (app.phase === 'ERROR') {
      throw new Error('Deployment failed')
    }

    // Wait 10 seconds before checking again
    await new Promise(resolve => setTimeout(resolve, 10000))
  }

  throw new Error('Deployment timeout (10 minutes)')
}

export async function deleteApp(appId: string) {
  return await makeRequest('DELETE', `/apps/${appId}`)
}
```

**2. Export module**:
```typescript
// workflow-cluster/src/modules/devtools/index.ts
export * as github from './github'
export * as gitlab from './gitlab'
export * as digitalocean from './digitalocean'  // ADD THIS
```

**3. Module immediately available in workflows**:
```json
{
  "id": "deploy",
  "module": "digitalocean",
  "function": "deployApp",
  "params": {
    "appName": "{{ context.appName }}",
    "gitRepo": "{{ context.repo }}",
    "branch": "main",
    "region": "nyc3",
    "buildCommand": "npm run build",
    "runCommand": "npm start",
    "envVars": "{{ context.envVars }}"
  }
}
```

### ByteRover Deployment Config

**Store once per project**:
```bash
# ClientA Dashboard
cd /home/user/ClientA-Dashboard
brv curit "Digital Ocean deployment config" << 'EOF'
# Digital Ocean App Configuration

## App Settings
- App Name: clienta-dashboard-prod
- Region: nyc (New York)
- GitHub Repo: 0xtsotsi/clienta-dashboard
- Branch: main

## Build Settings
- Build Command: npm run build
- Run Command: npm start
- Environment: Node.js 20

## Auto-Deploy
- Enabled: true
- Test Threshold: 80% coverage

## Environment Variables
(Set in DO console, not stored in code)
- DATABASE_URL
- API_KEY
- NODE_ENV=production
EOF
```

**Query in workflow**:
```typescript
// b0t workflow step
{
  "id": "query-config",
  "module": "byterover",
  "function": "query",
  "params": {
    "question": "digital ocean deployment config"
  }
}

// Returns parsed config:
{
  appName: "clienta-dashboard-prod",
  region: "nyc",
  gitRepo: "0xtsotsi/clienta-dashboard",
  branch: "main",
  buildCommand: "npm run build",
  runCommand: "npm start",
  autoDeploy: true
}
```

---

## Part 7: Implementation Roadmap

### Phase 1: Core Setup (Weeks 1-2)

**Goal**: ByteRover CLI + b0t Digital Ocean module functional

**Tasks**:
- [ ] Build ByteRover CLI (`brv init`, `curit`, `query`, `gen-rules`)
- [ ] Add Digital Ocean module to b0t
- [ ] Create `project-initialization` workflow
- [ ] Test basic flow: init project → store in ByteRover → query

**Success Criteria**:
- `brv` commands work
- Can store and query memories
- b0t can deploy to Digital Ocean

---

### Phase 2: Design OS + plannotator (Weeks 3-4)

**Goal**: Complete planning workflow with approval gate

**Tasks**:
- [ ] Integrate plannotator with Design OS output
- [ ] Create browser UI flow for plan review
- [ ] Store approvals in ByteRover
- [ ] Create `design-extraction` workflow

**Success Criteria**:
- Design OS creates plan
- plannotator opens for review
- Approved plans stored in ByteRover
- Triggers design extraction

---

### Phase 3: Figma MCP + RALPH LOOP (Weeks 5-6)

**Goal**: Automated design → code → test flow

**Tasks**:
- [ ] Create `test-and-implement` workflow
- [ ] Integrate RALPH LOOP with b0t
- [ ] Add visual verification step
- [ ] ByteRover stores test results

**Success Criteria**:
- Figma components extracted
- Code generated with correct library
- Tests run automatically
- Visual diff passes

---

### Phase 4: Deployment + Reflect (Weeks 7-8)

**Goal**: Complete E2E automation with learning

**Tasks**:
- [ ] Create `deploy-to-production` workflow
- [ ] Test Digital Ocean deployment
- [ ] Create `analyze-and-learn` workflow
- [ ] Integrate Reflect for pattern detection

**Success Criteria**:
- One-command deployment works
- Live URL stored in ByteRover
- Reflect analyzes project patterns
- Improved skills generated

---

### Phase 5: Polish + Scale (Weeks 9-10)

**Goal**: Production-ready system

**Tasks**:
- [ ] Add error handling across all workflows
- [ ] Create monitoring dashboard
- [ ] Document complete system
- [ ] Test with 3 client projects

**Success Criteria**:
- E2E flow works reliably
- All tools integrated
- Per-client isolation verified
- Documentation complete

---

## Part 8: Key Decisions & Answers

### Q: "Do we need npm packages?"
**A: YES** - Specifically for the Digital Ocean module in b0t. npm packages give b0t modules the flexibility to handle dynamic operations (deployment, error recovery, API calls) that MCPs can't handle.

### Q: "Where does b0t fit?"
**A: Execution Engine** - b0t is NOT the orchestrator. It's the muscle that executes workflows. ByteRover is the brain that decides WHAT workflows to run based on stored context.

### Q: "Where does plannotator fit?"
**A: Quality Gate** - After Design OS planning, BEFORE implementation. Ensures human approval of AI-generated plans. Stores approval/feedback in ByteRover.

### Q: "How does per-client isolation work?"
**A: Directory-based** - Each client project has own directory with own `.beads/`, `.claude/`, and `.workflows/`. ByteRover queries are scoped to current directory. b0t workflows filtered by `projectId`.

### Q: "What's the role of plane?"
**A: Portfolio Management** - Manages multiple client projects, sets priorities. Triggers b0t's `project-initialization` workflow when new project created.

### Q: "How does Reflect learn?"
**A: Event Analysis** - Reflect queries ByteRover for all project events, analyzes patterns (e.g., "shadcn/ui projects 30% faster"), generates improved skills stored in `~/.claude/skills/`. Future projects automatically benefit.

---

## Part 9: Visual System Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                         CLIENT PORTFOLIO                         │
│                           (plane)                                │
│                                                                   │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐                         │
│  │ClientA  │  │ClientB  │  │ClientC  │                         │
│  │Dashboard│  │Marketing│  │E-Comm   │                         │
│  │HIGH     │  │MEDIUM   │  │LOW      │                         │
│  └────┬────┘  └─────────┘  └─────────┘                         │
└───────┼──────────────────────────────────────────────────────────┘
        │
        ↓ Triggers b0t: project-initialization
        │
┌───────┴──────────────────────────────────────────────────────────┐
│                    PROJECT WORKSPACE                              │
│                    (designbrnd + Design OS)                       │
│                                                                   │
│  Design OS Workflow:                                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │Product Vision│→ │Product       │→ │Data Model    │          │
│  │              │  │Roadmap       │  │              │          │
│  └──────────────┘  └──────────────┘  └──────────────┘          │
│                                                                   │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │Design Tokens │→ │Design Shell  │→ │Shape Section │          │
│  │              │  │              │  │              │          │
│  └──────────────┘  └──────────────┘  └──────────────┘          │
│                                                                   │
│  ┌──────────────┐  ┌──────────────┐                             │
│  │Shape UX      │→ │Build Order   │                             │
│  │              │  │              │                             │
│  └──────────────┘  └──────────────┘                             │
│                                                                   │
│  ↓ All stored in ByteRover                                       │
└───────┬──────────────────────────────────────────────────────────┘
        │
        ↓ Plan complete, needs approval
        │
┌───────┴──────────────────────────────────────────────────────────┐
│                    QUALITY GATE                                   │
│                    (plannotator)                                  │
│                                                                   │
│  Opens browser UI:                                               │
│  ┌────────────────────────────────────────────────────┐         │
│  │  Plan Review                                        │         │
│  │  ┌──────────────────────────────────────────────┐  │         │
│  │  │ Product Vision: [text with annotations]     │  │         │
│  │  │ Roadmap: [text with markup tools]           │  │         │
│  │  │ UX Spec: [attached images with pen/arrows]  │  │         │
│  │  └──────────────────────────────────────────────┘  │         │
│  │                                                      │         │
│  │  [Request Changes] [Approve]                        │         │
│  └────────────────────────────────────────────────────┘         │
│                                                                   │
│  IF Approved: ↓                                                  │
└───────┬──────────────────────────────────────────────────────────┘
        │
        ↓ Triggers b0t: design-extraction
        │
┌───────┴──────────────────────────────────────────────────────────┐
│                    DESIGN EXTRACTION                              │
│                    (Figma MCP via b0t)                           │
│                                                                   │
│  b0t Workflow Steps:                                             │
│  1. Query ByteRover: approved plan                               │
│  2. Query ByteRover: component library                           │
│  3. Query ByteRover: design tokens                               │
│  4. Extract components from Figma                                │
│  5. Generate code (shadcn/ui + tokens)                           │
│  6. Store in ByteRover                                           │
│                                                                   │
│  ↓ Code generated                                                │
└───────┬──────────────────────────────────────────────────────────┘
        │
        ↓ Triggers b0t: test-and-implement
        │
┌───────┴──────────────────────────────────────────────────────────┐
│                    TDD IMPLEMENTATION                             │
│                    (RALPH LOOP via b0t)                          │
│                                                                   │
│  b0t Workflow Steps:                                             │
│  1. Query ByteRover: test strategy                               │
│  2. Write tests first                                            │
│  3. Implement code                                               │
│  4. Run tests                                                    │
│  5. Visual verification (screenshot vs Figma)                    │
│  6. Store results in ByteRover                                   │
│                                                                   │
│  IF Tests Pass: ↓                                                │
└───────┬──────────────────────────────────────────────────────────┘
        │
        ↓ Triggers b0t: deploy-to-production
        │
┌───────┴──────────────────────────────────────────────────────────┐
│                    DEPLOYMENT                                     │
│                    (b0t + Digital Ocean npm)                     │
│                                                                   │
│  b0t Workflow Steps:                                             │
│  1. Query ByteRover: deploy config                               │
│  2. Query ByteRover: auto-deploy setting                         │
│  3. Build: npm run build                                         │
│  4. Deploy to DO: deployApp() via npm package                    │
│  5. Wait for deployment complete                                 │
│  6. Store live URL in ByteRover                                  │
│                                                                   │
│  ✅ Live: https://clienta-dashboard.ondigitalocean.app           │
└───────┬──────────────────────────────────────────────────────────┘
        │
        ↓ After N deployments, triggers b0t: analyze-and-learn
        │
┌───────┴──────────────────────────────────────────────────────────┐
│                    META-LEARNING                                  │
│                    (Reflect via b0t)                             │
│                                                                   │
│  b0t Workflow Steps:                                             │
│  1. Query ByteRover: all project events                          │
│  2. Analyze patterns:                                            │
│     - Average time: design → deploy                              │
│     - Success rate by component library                          │
│     - Common plannotator feedback                                │
│  3. Generate improved skills                                     │
│  4. Store in ~/.claude/skills/                                   │
│                                                                   │
│  ↓ System gets smarter over time                                 │
└──────────────────────────────────────────────────────────────────┘
```

---

## Part 10: Summary & Next Steps

### What We Have Now

A **complete E2E system** that combines:
1. **plane** - Portfolio management
2. **designbrnd + Design OS** - Product planning
3. **plannotator** - Human approval gate
4. **Figma MCP** - Design extraction
5. **RALPH LOOP** - TDD implementation
6. **b0t (workflow-cluster)** - Automation execution engine (140 modules)
7. **ByteRover (Beads)** - Persistent memory across all phases
8. **Reflect** - Meta-learning for continuous improvement

### Key Innovations

1. **Memory-Driven**: ByteRover provides context at every phase
2. **Human-in-the-Loop**: plannotator approval gate ensures quality
3. **Fully Automated**: Once approved, flows to production automatically
4. **Self-Improving**: Reflect learns patterns, generates better skills
5. **Per-Client Isolated**: Each project completely independent
6. **Modular Execution**: b0t's 140 modules handle any automation need

### Immediate Next Steps

**Week 1-2**: Build ByteRover CLI + Digital Ocean module
```bash
# 1. Create ByteRover CLI
cd /home/user/Designbrnd
mkdir -p byterover/src
npm init -y
npm install typescript commander chalk ora

# 2. Add Digital Ocean to b0t
cd /path/to/workflow-cluster
# Create src/modules/devtools/digitalocean.ts
# (Code provided in Part 6)

# 3. Test integration
brv init
brv curit "Test memory" test.md
brv query "test"
```

**Week 3-4**: Integrate plannotator
```bash
# Install plannotator plugin for Claude Code
# Configure to trigger after Design OS complete
# Test approval flow
```

**Week 5-10**: Complete implementation following roadmap in Part 7

### Success Metrics

- **Time to Production**: Plan → Live URL in < 6 hours (vs 2-3 weeks manual)
- **Context Retention**: 100% (no information lost between phases)
- **Approval Rate**: > 90% (plannotator catches issues early)
- **Deployment Success**: > 95% (automated testing + ByteRover config)
- **Learning Velocity**: System improves 10% per project via Reflect

### ROI

**Investment**: 10 weeks development
**Break-Even**: After 3-5 projects
**Year 1 ROI**: $100k+ saved in manual work

---

## Conclusion

This is a **production-ready architecture** that seamlessly integrates all your tools:

✅ **plane** manages portfolio
✅ **designbrnd** plans products
✅ **plannotator** gates quality
✅ **Figma MCP** extracts designs
✅ **RALPH LOOP** implements with TDD
✅ **b0t** automates everything
✅ **ByteRover** remembers everything
✅ **Reflect** improves everything

**Result**: End-to-end automation from portfolio planning to production deployment, with human approval gates and persistent memory.

Ready to start Phase 1? 🚀
