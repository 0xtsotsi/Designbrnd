# ByteRover with Beads Engine - Architecture Specification

## Executive Summary

This document outlines the architecture for recreating ByteRover (a memory management platform for AI coding agents) using Beads (a git-backed task graph engine) as the underlying storage and organization system.

## System Overview

### What We're Building

A context engineering platform that:
- Stores AI coding memories as structured, version-controlled data
- Provides CRUD operations for memories with git-based versioning
- Enables team collaboration through git-based sharing
- Integrates with AI IDEs via MCP (Model Context Protocol)
- Offers a Context Composer for importing internal documentation

### Core Innovation

Instead of a proprietary database, we use **Beads' git-backed task system** to store memories, giving us:
- Built-in version control (git commits)
- Dependency graphing (related memories)
- Hierarchical organization (memory categories)
- Distributed collaboration (git push/pull)
- Persistent storage (JSONL + SQLite cache)

---

## Architecture Layers

### 1. Storage Layer (Beads Engine)

**Technology:** Beads CLI + `.beads/` directory

**Data Model:**
```
Memory = Beads Task
├── ID: bd-a1b2 (hash-based)
├── Title: Memory name
├── Description: Memory content (markdown)
├── Status: active/archived (open/closed)
├── Created: timestamp
├── Updated: timestamp (via git history)
├── Tags: custom metadata in description
├── Category: parent task hierarchy
└── Related: dependencies (bd dep)
```

**Storage Structure:**
```
.beads/
├── tasks/           # JSONL files (Beads manages)
├── cache.db         # SQLite cache (Beads manages)
└── config           # Beads configuration

.git/                # Version control
├── commits          # Memory version history
└── branches         # Team workspaces
```

**Beads Commands Used:**
- `bd init` - Initialize memory system
- `bd create "Memory Title" -p 0` - Create memory
- `bd show <id>` - Read memory details
- `bd update <id>` - Update memory content
- `bd close <id>` - Archive memory
- `bd dep add <child> <parent>` - Link related memories
- `bd ready` - Get active memories
- `bd list --format json` - Query all memories

---

### 2. Backend Layer (API Server)

**Technology:** Node.js + Express + TypeScript

**Purpose:** Wrap Beads CLI with RESTful API

**Endpoints:**

```typescript
// Memory CRUD
POST   /api/memories              // Create memory (bd create)
GET    /api/memories              // List all memories (bd list)
GET    /api/memories/:id          // Get memory (bd show)
PUT    /api/memories/:id          // Update memory (bd update)
DELETE /api/memories/:id          // Archive memory (bd close)

// Relationships
POST   /api/memories/:id/related  // Link memories (bd dep)
GET    /api/memories/:id/related  // Get related memories

// Categories
POST   /api/categories            // Create category (parent task)
GET    /api/categories            // List categories
POST   /api/memories/:id/category // Assign to category

// Context Composer
POST   /api/context/import        // Import doc as memory
POST   /api/context/bulk-import   // Import multiple docs

// Version Control
GET    /api/memories/:id/history  // Git log for memory
POST   /api/memories/:id/rollback // Git revert to version
GET    /api/memories/:id/diff     // Compare versions

// Search
GET    /api/search?q=...          // Full-text search memories
GET    /api/search/tags?tag=...   // Search by tag

// Team Collaboration
POST   /api/sync/pull             // Git pull (get team updates)
POST   /api/sync/push             // Git push (share memories)
GET    /api/sync/status           // Git status
```

**Core Services:**

```typescript
// services/beads.service.ts
class BeadsService {
  async createMemory(title: string, content: string, tags?: string[]): Promise<string>
  async getMemory(id: string): Promise<Memory>
  async updateMemory(id: string, content: string): Promise<void>
  async archiveMemory(id: string): Promise<void>
  async listMemories(status?: 'active' | 'archived'): Promise<Memory[]>
  async linkMemories(childId: string, parentId: string): Promise<void>
  async getRelatedMemories(id: string): Promise<Memory[]>
  async searchMemories(query: string): Promise<Memory[]>

  private execBeads(command: string): Promise<string> // Spawn bd CLI
}

// services/git.service.ts
class GitService {
  async getHistory(filePath: string): Promise<Commit[]>
  async rollbackToCommit(commitHash: string): Promise<void>
  async getDiff(commitHash1: string, commitHash2: string): Promise<string>
  async pull(): Promise<void>
  async push(): Promise<void>
  async getStatus(): Promise<GitStatus>
}

// services/context-composer.service.ts
class ContextComposerService {
  async importDocument(filePath: string, category?: string): Promise<string>
  async importMultiple(filePaths: string[]): Promise<string[]>
  async parseMarkdown(content: string): Promise<Memory>
}
```

---

### 3. Frontend Layer (React UI)

**Technology:** React + TypeScript + Tailwind CSS (existing stack)

**New Pages:**

1. **Memory Workspace** (`/memories`)
   - List view with filters (all/active/archived)
   - Search bar with tag filtering
   - Category sidebar navigation
   - Create new memory button
   - Grid/list view toggle

2. **Memory Editor** (`/memories/:id`)
   - Markdown editor for content
   - Title input
   - Tag management (add/remove)
   - Category selector
   - Related memories section (link/unlink)
   - Save/cancel actions
   - Version history sidebar

3. **Context Composer** (`/context-composer`)
   - File upload area (drag & drop)
   - Directory import
   - Bulk import queue
   - Category assignment
   - Auto-tag suggestions
   - Import preview
   - Progress indicator

4. **Version Control** (`/memories/:id/versions`)
   - Timeline view of changes
   - Side-by-side diff viewer
   - Rollback buttons
   - Commit messages (git commits)
   - Author information

5. **Team Sync** (`/sync`)
   - Git status dashboard
   - Pull/push buttons
   - Conflict resolution UI
   - Team activity feed
   - Branch selector

**Key Components:**

```typescript
// components/MemoryCard.tsx
interface MemoryCardProps {
  id: string
  title: string
  content: string
  tags: string[]
  category?: string
  createdAt: Date
  updatedAt: Date
}

// components/MemoryEditor.tsx
interface MemoryEditorProps {
  memoryId?: string  // undefined = create mode
  onSave: (memory: Memory) => void
  onCancel: () => void
}

// components/ContextComporter.tsx
interface ContextComporterProps {
  onImportComplete: (memoryIds: string[]) => void
}

// components/VersionTimeline.tsx
interface VersionTimelineProps {
  memoryId: string
  versions: Version[]
  onRollback: (versionId: string) => void
}

// components/RelatedMemories.tsx
interface RelatedMemoriesProps {
  memoryId: string
  related: Memory[]
  onLink: (targetId: string) => void
  onUnlink: (targetId: string) => void
}
```

---

### 4. MCP Integration Layer

**Technology:** Model Context Protocol Server

**Purpose:** AI IDE integration (Claude Code, Cursor, Windsurf, etc.)

**MCP Server Implementation:**

```typescript
// mcp-server/index.ts
import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";

const server = new Server({
  name: "beads-byterover",
  version: "1.0.0"
}, {
  capabilities: {
    resources: {},
    tools: {}
  }
});

// Tools exposed to AI agents
server.setRequestHandler("tools/list", async () => ({
  tools: [
    {
      name: "create_memory",
      description: "Save a coding memory (pattern, decision, learning)",
      inputSchema: {
        type: "object",
        properties: {
          title: { type: "string" },
          content: { type: "string" },
          tags: { type: "array", items: { type: "string" } },
          category: { type: "string" }
        }
      }
    },
    {
      name: "search_memories",
      description: "Search for relevant memories before writing code",
      inputSchema: {
        type: "object",
        properties: {
          query: { type: "string" },
          tags: { type: "array", items: { type: "string" } }
        }
      }
    },
    {
      name: "get_memory",
      description: "Retrieve a specific memory by ID",
      inputSchema: {
        type: "object",
        properties: {
          id: { type: "string" }
        }
      }
    },
    {
      name: "list_memories",
      description: "List all active memories",
      inputSchema: {
        type: "object",
        properties: {
          category: { type: "string" },
          tags: { type: "array", items: { type: "string" } }
        }
      }
    }
  ]
}));

// Tool execution handlers
server.setRequestHandler("tools/call", async (request) => {
  const { name, arguments: args } = request.params;

  switch (name) {
    case "create_memory":
      return await beadsService.createMemory(args.title, args.content, args.tags);
    case "search_memories":
      return await beadsService.searchMemories(args.query);
    case "get_memory":
      return await beadsService.getMemory(args.id);
    case "list_memories":
      return await beadsService.listMemories();
  }
});
```

**AI IDE Configuration:**

```json
// claude_desktop_config.json
{
  "mcpServers": {
    "beads-byterover": {
      "command": "node",
      "args": ["/path/to/mcp-server/index.js"]
    }
  }
}
```

---

## Data Flow Examples

### 1. Create Memory Flow

```
AI Agent → MCP Tool Call → Backend API → Beads CLI → Git Commit
                                ↓
                          Update UI (WebSocket)
```

**Steps:**
1. Agent calls `create_memory("Error Handling Pattern", "Always use try-catch...")`
2. MCP server forwards to backend API `POST /api/memories`
3. Backend calls `bd create "Error Handling Pattern" -p 0`
4. Beads creates task in `.beads/tasks/`
5. Backend commits to git with message "Add memory: Error Handling Pattern"
6. Backend broadcasts WebSocket event
7. Frontend updates memory list

### 2. Search Memory Flow

```
AI Agent → MCP Tool Call → Backend API → Beads Query + Full-Text Search
                                ↓
                          Return Matches
```

**Steps:**
1. Agent calls `search_memories("authentication")`
2. MCP server forwards to backend `GET /api/search?q=authentication`
3. Backend calls `bd list --format json`
4. Backend filters tasks by title/description match
5. Backend returns ranked results
6. Agent uses memory content to inform code generation

### 3. Version Rollback Flow

```
User → Frontend UI → Backend API → Git Revert → Beads Sync
                         ↓
                   Update UI
```

**Steps:**
1. User clicks "Rollback to v3" in version timeline
2. Frontend calls `POST /api/memories/:id/rollback`
3. Backend runs `git log` to find commit
4. Backend runs `git revert <commit-hash>`
5. Beads daemon syncs from git
6. Backend returns updated memory
7. Frontend updates editor view

---

## Implementation Phases

### Phase 1: Foundation (Week 1)
- [ ] Initialize Beads in repository (`bd init`)
- [ ] Set up Express backend project structure
- [ ] Create Beads service wrapper (spawn CLI commands)
- [ ] Implement basic CRUD endpoints
- [ ] Create Memory data types

### Phase 2: Core Features (Week 2)
- [ ] Build Memory Workspace UI
- [ ] Implement Memory Editor with markdown
- [ ] Add tag and category management
- [ ] Create search functionality
- [ ] Implement related memories (dependencies)

### Phase 3: Context Composer (Week 3)
- [ ] Build file upload interface
- [ ] Implement document parsing (markdown, txt)
- [ ] Add bulk import queue
- [ ] Create category assignment flow
- [ ] Add auto-tagging suggestions

### Phase 4: Version Control (Week 4)
- [ ] Build version history viewer
- [ ] Implement git diff visualization
- [ ] Add rollback functionality
- [ ] Create commit message UI
- [ ] Add timeline view

### Phase 5: Collaboration (Week 5)
- [ ] Implement git sync (pull/push)
- [ ] Build team activity feed
- [ ] Add conflict resolution UI
- [ ] Create branch management
- [ ] Add user attribution

### Phase 6: MCP Integration (Week 6)
- [ ] Set up MCP server project
- [ ] Implement tool definitions
- [ ] Add tool execution handlers
- [ ] Test with Claude Code
- [ ] Test with Cursor, Windsurf
- [ ] Write MCP configuration docs

### Phase 7: Polish & Deploy
- [ ] Add real-time updates (WebSocket)
- [ ] Implement auto-save/recall
- [ ] Optimize search performance
- [ ] Add export/import features
- [ ] Write user documentation
- [ ] Deploy to production

---

## Technical Decisions

### Why Beads Over Custom Database?

**Advantages:**
1. **Git-native versioning** - Built-in history, rollback, branching
2. **Zero infrastructure** - No database server to manage
3. **Distributed by default** - Team sync via git push/pull
4. **Conflict-free IDs** - Hash-based IDs prevent collisions
5. **Developer-friendly** - Familiar git workflow
6. **Performance** - SQLite cache for fast queries
7. **Portable** - Entire memory system in `.beads/` directory

**Trade-offs:**
1. Beads CLI overhead (spawn processes) - Mitigated by caching
2. Limited query capabilities - Supplemented with backend indexing
3. Depends on external tool - Well-maintained, active project

### API Design Principles

1. **RESTful** - Standard HTTP methods for CRUD
2. **Idempotent** - Safe to retry operations
3. **Versioned** - `/api/v1/` prefix for future changes
4. **Typed** - TypeScript interfaces for all data
5. **Documented** - OpenAPI/Swagger spec

### Frontend Architecture

1. **Component-based** - Reusable UI components
2. **Type-safe** - Full TypeScript coverage
3. **Responsive** - Mobile-friendly design
4. **Accessible** - WCAG 2.1 AA compliance
5. **Fast** - Code splitting, lazy loading

---

## Security Considerations

1. **Input validation** - Sanitize all user input
2. **Command injection** - Escape shell arguments when calling Beads CLI
3. **Path traversal** - Validate file paths in Context Composer
4. **Authentication** - Add auth layer for team features
5. **Rate limiting** - Prevent API abuse
6. **Git credentials** - Secure storage for remote sync

---

## Monitoring & Observability

1. **Logging** - Structured logs (Winston/Pino)
2. **Metrics** - Track API latency, Beads command timing
3. **Error tracking** - Sentry integration
4. **Health checks** - `/health` endpoint
5. **Audit trail** - Git commits provide full history

---

## Testing Strategy

1. **Unit tests** - Jest for services and utilities
2. **Integration tests** - Test Beads CLI wrapper
3. **API tests** - Supertest for endpoints
4. **E2E tests** - Playwright for UI flows
5. **MCP tests** - Test tool execution with mock agents

---

## Deployment Architecture

```
┌─────────────────┐
│   AI IDEs       │ (Claude Code, Cursor, Windsurf)
└────────┬────────┘
         │ MCP Protocol
┌────────▼────────┐
│  MCP Server     │ (Node.js process)
└────────┬────────┘
         │ HTTP API
┌────────▼────────┐
│  Backend API    │ (Express server)
└────────┬────────┘
         │ CLI Spawn
┌────────▼────────┐
│  Beads Engine   │ (.beads/ + git)
└─────────────────┘

Frontend (React) → Backend API (same server)
```

**Hosting:**
- Single server deployment (Heroku, Railway, Fly.io)
- Or: Frontend (Vercel) + Backend (Railway)
- Git repository (GitHub, GitLab)

---

## Success Metrics

1. **Performance**
   - Memory creation < 200ms
   - Search response < 100ms
   - Version history load < 500ms

2. **Reliability**
   - 99.9% uptime
   - Zero data loss (git-backed)
   - Graceful failure handling

3. **User Experience**
   - < 3 clicks to create memory
   - Instant search results
   - Real-time collaboration updates

---

## Future Enhancements

1. **AI-powered features**
   - Auto-categorization of memories
   - Smart tag suggestions
   - Duplicate detection
   - Memory summarization

2. **Advanced collaboration**
   - Comments on memories
   - @mentions for team members
   - Memory sharing permissions
   - Activity notifications

3. **Integrations**
   - Slack/Discord bots
   - GitHub Actions integration
   - VS Code extension
   - JetBrains plugin

4. **Analytics**
   - Memory usage statistics
   - Most-accessed memories
   - Team contribution metrics
   - Search query analysis

---

## Resources

- **Beads Documentation**: https://github.com/steveyegge/beads
- **MCP Specification**: https://modelcontextprotocol.io
- **ByteRover Reference**: https://byterover.dev
- **Current Codebase**: /home/user/Designbrnd

---

## Next Steps

1. Review and approve this architecture
2. Set up project structure
3. Initialize Beads in repository
4. Begin Phase 1 implementation
5. Iterate based on feedback
