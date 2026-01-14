# Auto-Rules Generation System - Beads ByteRover

## Overview

This document details the **auto-rules initialization system** that enables AI coding agents (Claude Code, Cursor, Windsurf, etc.) to automatically recognize, query, and update the memory system without manual prompting.

## Core Concept

After running `brv gen-rules`, the AI agent receives system instructions that teach it:
1. **Memory awareness** - The agent knows a context tree exists
2. **Autonomous querying** - When it needs info, it runs `brv query` itself
3. **Automatic curation** - After implementing features, it saves learnings via `brv curit`
4. **Self-managing** - The agent maintains its own context loop

**Result**: The agent behaves like a developer who knows how to look up documentation instead of guessing.

---

## CLI Command Structure

### Core Commands

```bash
# Installation & Setup
npm install -g beads-byterover       # Install CLI globally
brv login                            # Authenticate with ByteRover account
brv init                             # Initialize project workspace

# Rules Generation (THE KEY COMMAND)
brv gen-rules                        # Auto-detect IDE and generate rules file

# Context Management
brv curit <description> @file.md     # Curate context from files
brv query "question about context"   # Query the context tree
brv push                             # Push context to remote (team sync)
brv pull                             # Pull context from remote (team sync)

# Interactive REPL
brv                                  # Open interactive interface
  /curit <description> @file         # Curate in REPL
  /query <question>                  # Query in REPL
  /gen-rules                         # Generate rules in REPL
```

---

## Rules Generation Flow

### 1. Agent Detection

When user runs `brv gen-rules`, the CLI:

```typescript
// cli/commands/gen-rules.ts

async function detectIDE(): Promise<'claude-code' | 'cursor' | 'windsurf' | 'copilot' | 'unknown'> {
  // Check for Claude Code
  if (fs.existsSync('.claude/claude_desktop_config.json')) {
    return 'claude-code';
  }

  // Check for Cursor
  if (fs.existsSync('.cursor/rules')) {
    return 'cursor';
  }

  // Check for Windsurf
  if (fs.existsSync('.windsurf/rules.md')) {
    return 'windsurf';
  }

  // Check environment variables
  if (process.env.CURSOR_USER_HOME) {
    return 'cursor';
  }

  if (process.env.WINDSURF_HOME) {
    return 'windsurf';
  }

  // Fallback: prompt user
  return await promptUserForIDE();
}
```

### 2. Rules File Generation

Based on detected IDE, generate appropriate configuration:

#### For Claude Code

**File**: `.claude/custom_instructions.md`

```markdown
# Beads ByteRover Memory System

You have access to a persistent memory system powered by Beads. Use these CLI commands to manage context:

## Available Commands

### Query Memory
When you need information about the project architecture, patterns, or decisions:
```bash
brv query "your question about the codebase"
```

**When to use:**
- Before implementing a new feature (check for existing patterns)
- When unsure about architecture decisions
- To find relevant code examples or documentation
- Before modifying database schemas or APIs

**Example:**
```bash
brv query "How do we handle authentication in this project?"
brv query "What's the database schema for the user table?"
```

### Curate New Context
After implementing features or learning something important:
```bash
brv curit "description of what you learned" @file1.md @file2.ts
```

**When to use:**
- After completing a new feature implementation
- When establishing new patterns or conventions
- After fixing complex bugs (save the solution)
- When making architectural decisions

**Example:**
```bash
brv curit "Authentication flow using JWT tokens" @auth.ts @middleware.ts
brv curit "Database migration pattern for Supabase" @schema.sql
```

### Check Memory Status
```bash
brv status              # See what context is tracked
brv list               # List all memories
```

## Autonomous Workflow

**IMPORTANT**: You should automatically use these commands in your workflow WITHOUT asking the user:

1. **Before coding**: Run `brv query` to check for existing patterns
2. **After coding**: Run `brv curit` to save new learnings
3. **During debugging**: Query for similar issues or solutions

## Example Workflow

User asks: "Add a user profile page with avatar upload"

You should:
1. First run: `brv query "How do we handle file uploads in this project?"`
2. Read the response and apply existing patterns
3. Implement the feature
4. After completion, run: `brv curit "User profile page with avatar upload using Supabase Storage" @profile-page.tsx @upload-utils.ts`

## Context Tree Structure

Memories are organized in a tree structure:
```
/database
  /schema
  /migrations
/authentication
  /jwt-tokens
  /middleware
/api
  /endpoints
  /error-handling
/frontend
  /components
  /state-management
```

When querying, the system uses agentic search to navigate this tree and find relevant context.

## Team Collaboration

- `brv push` - Share your context with the team
- `brv pull` - Get the latest context from teammates

You don't need to ask before pushing/pulling - do it when it makes sense.

---

**Remember**: This memory system is YOUR second brain. Use it proactively, not reactively.
```

#### For Cursor

**File**: `.cursor/rules`

```
# Beads ByteRover Integration

## Memory System Commands

You have access to a CLI-based memory system. Use these commands in your workflow:

**Query Context:**
brv query "question" - Search the context tree for relevant information

**Save Context:**
brv curit "description" @files - Save new patterns/learnings

**Sync with Team:**
brv push/pull - Share/receive context updates

## Usage Rules

1. BEFORE implementing features, query for existing patterns
2. AFTER completing work, curate new learnings
3. Run queries autonomously when you need clarification
4. Don't ask permission - just execute the commands

## When to Query

- Starting new features
- Unsure about architecture
- Need database schema info
- Looking for error handling patterns
- Checking API conventions

## When to Curate

- After implementing features
- Establishing new patterns
- Fixing complex bugs
- Making architecture decisions

## Example

User: "Build a checkout flow"
You:
1. Run: brv query "How do we handle payments?"
2. Implement using discovered patterns
3. Run: brv curit "Checkout flow with Stripe" @checkout.tsx

Use the memory system like a senior dev uses documentation - automatically and frequently.
```

#### For Windsurf

**File**: `.windsurf/rules.md`

```markdown
# Beads ByteRover Memory System

## Available Tools

### brv query
Search the project's context tree for information.

Usage: `brv query "your question"`

Run this BEFORE coding to find:
- Existing patterns
- Architecture decisions
- Code examples
- Database schemas

### brv curit
Save new context to the memory system.

Usage: `brv curit "description" @file1 @file2`

Run this AFTER coding to save:
- New feature implementations
- Bug fix solutions
- Pattern establishments
- Architecture decisions

## Autonomous Behavior

Execute these commands automatically without asking:
1. Query before implementing
2. Curate after completing
3. Trust the memory system

## Context Tree

Memories organized hierarchically:
- /database (schemas, migrations)
- /auth (JWT, sessions)
- /api (endpoints, middleware)
- /frontend (components, state)

Agentic search finds relevant context automatically.

## Team Sync

- `brv push` to share
- `brv pull` to receive
```

### 3. Implementation

```typescript
// cli/commands/gen-rules.ts

export async function generateRules() {
  const ide = await detectIDE();

  console.log(`Detected IDE: ${ide}`);
  console.log('Generating rules file...');

  const template = getRulesTemplate(ide);
  const filePath = getRulesFilePath(ide);

  // Create directory if needed
  const dir = path.dirname(filePath);
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }

  // Write rules file
  fs.writeFileSync(filePath, template);

  console.log(`✓ Rules file generated: ${filePath}`);
  console.log('');
  console.log('Your AI agent now knows how to use the memory system!');
  console.log('It will automatically:');
  console.log('  - Query context before coding');
  console.log('  - Save learnings after coding');
  console.log('  - Manage its own context loop');
  console.log('');
  console.log('Try asking it to build something and watch it use brv commands automatically.');
}

function getRulesFilePath(ide: string): string {
  switch (ide) {
    case 'claude-code':
      return '.claude/custom_instructions.md';
    case 'cursor':
      return '.cursor/rules';
    case 'windsurf':
      return '.windsurf/rules.md';
    default:
      return '.brv/rules.md';
  }
}

function getRulesTemplate(ide: string): string {
  // Return appropriate template from above
  return templates[ide];
}
```

---

## Context Tree Structure

### Hierarchical Organization

Unlike flat vector databases, we use a **tree structure** for more intelligent retrieval:

```
Project Memory Tree
├── /database
│   ├── schema.md (entities, relationships)
│   ├── migrations.md (migration patterns)
│   └── queries.md (common query patterns)
├── /authentication
│   ├── jwt.md (token handling)
│   ├── middleware.md (auth middleware)
│   └── sessions.md (session management)
├── /api
│   ├── rest-endpoints.md (API routes)
│   ├── error-handling.md (error patterns)
│   └── validation.md (input validation)
├── /frontend
│   ├── components.md (component patterns)
│   ├── state-management.md (Redux/Context)
│   └── routing.md (navigation patterns)
└── /deployment
    ├── docker.md (containerization)
    └── ci-cd.md (pipeline configs)
```

### Mapping to Beads

Each node in the tree = Beads task:

```typescript
// Context tree node = Beads task
{
  id: "bd-a1b2c3",
  title: "/database/schema",
  description: `
    # Database Schema

    ## Users Table
    - id (uuid, primary key)
    - email (text, unique)
    - name (text)
    ...
  `,
  parent: "bd-root",        // /database
  tags: ["database", "schema", "users"],
  status: "active"
}
```

### Agentic Search Algorithm

When agent runs `brv query "database schema for users"`:

1. **Parse query** - Extract keywords: [database, schema, users]
2. **Navigate tree** - Start at root, traverse to /database
3. **Score nodes** - Rank children by relevance
4. **Deep dive** - Follow most relevant branch
5. **Return context** - Pull exact information needed

**Implementation:**

```typescript
// services/agentic-search.ts

async function agenticSearch(query: string): Promise<SearchResult> {
  // 1. Extract intent and keywords
  const intent = await extractIntent(query);
  const keywords = extractKeywords(query);

  // 2. Find starting nodes in tree
  const rootNodes = await findRelevantRoots(keywords);

  // 3. Navigate tree depth-first
  const results = [];
  for (const root of rootNodes) {
    const path = await traverseTree(root, keywords, intent);
    results.push(...path);
  }

  // 4. Score and rank results
  const ranked = scoreResults(results, query);

  // 5. Return top matches with context
  return {
    matches: ranked.slice(0, 5),
    contextPath: buildContextPath(ranked[0])
  };
}

async function traverseTree(node: BeadsTask, keywords: string[], intent: string): Promise<BeadsTask[]> {
  const matches = [];

  // Score current node
  const score = scoreNode(node, keywords, intent);
  if (score > 0.3) {
    matches.push(node);
  }

  // Get children (Beads dependencies)
  const children = await beadsService.getChildTasks(node.id);

  // Recursively search children
  for (const child of children) {
    const childMatches = await traverseTree(child, keywords, intent);
    matches.push(...childMatches);
  }

  return matches;
}
```

---

## Curation Workflow

### User Command

```bash
brv curit "Authentication middleware using JWT" @auth-middleware.ts @jwt-utils.ts
```

### What Happens

1. **Parse files** - Read and analyze @mentioned files
2. **Extract key concepts** - Identify patterns, functions, exports
3. **Determine tree location** - Classify into category (e.g., /authentication)
4. **Create Beads task** - Store as task with rich metadata
5. **Link relationships** - Connect to related memories via `bd dep`
6. **Commit to git** - Version the change

```typescript
// services/curation.service.ts

async function curateContext(
  description: string,
  files: string[]
): Promise<string> {
  // 1. Read files
  const fileContents = await Promise.all(
    files.map(f => fs.readFile(f, 'utf-8'))
  );

  // 2. Analyze content
  const analysis = await analyzeCode(fileContents, description);

  // 3. Determine category
  const category = classifyContent(description, analysis);

  // 4. Build markdown content
  const content = buildMemoryContent(description, files, analysis);

  // 5. Create Beads task
  const memoryId = await beadsService.createMemory(
    `${category}/${description}`,
    content,
    analysis.tags
  );

  // 6. Link to parent category
  const parentId = await findOrCreateCategory(category);
  await beadsService.linkMemories(memoryId, parentId);

  // 7. Find related memories
  const related = await findRelatedMemories(analysis.tags, content);
  for (const relatedId of related) {
    await beadsService.linkMemories(memoryId, relatedId);
  }

  // 8. Commit to git
  await gitService.commit(`Add memory: ${description}`);

  return memoryId;
}

function classifyContent(description: string, analysis: CodeAnalysis): string {
  // Use LLM or rules to classify
  const keywords = {
    database: ['schema', 'migration', 'query', 'table', 'sql'],
    auth: ['authentication', 'authorization', 'jwt', 'token', 'session'],
    api: ['endpoint', 'route', 'controller', 'middleware', 'handler'],
    frontend: ['component', 'react', 'vue', 'ui', 'state'],
    deployment: ['docker', 'ci', 'cd', 'deploy', 'build']
  };

  for (const [category, words] of Object.entries(keywords)) {
    if (words.some(w => description.toLowerCase().includes(w))) {
      return category;
    }
  }

  return 'general';
}
```

---

## Query Workflow

### User Command

```bash
brv query "How do we handle file uploads?"
```

### What Happens

1. **Agentic search** - Navigate context tree intelligently
2. **Retrieve matches** - Get top 5 relevant memories
3. **Format output** - Present with context paths
4. **Return to agent** - Agent reads output and applies knowledge

```typescript
// services/query.service.ts

async function queryContext(question: string): Promise<QueryResult> {
  // 1. Run agentic search
  const searchResults = await agenticSearch(question);

  // 2. Format for display
  const formatted = formatQueryResults(searchResults);

  // 3. Return structured data
  return {
    question,
    matches: searchResults.matches.map(m => ({
      id: m.id,
      title: m.title,
      excerpt: extractExcerpt(m.description, question),
      relevance: m.score,
      path: m.contextPath
    })),
    summary: generateSummary(searchResults)
  };
}

function formatQueryResults(results: SearchResult): string {
  let output = `Found ${results.matches.length} relevant memories:\n\n`;

  for (const match of results.matches) {
    output += `## ${match.title}\n`;
    output += `Path: ${match.contextPath}\n`;
    output += `Relevance: ${(match.score * 100).toFixed(0)}%\n\n`;
    output += match.description + '\n\n';
    output += '---\n\n';
  }

  return output;
}
```

**Example Output:**

```
Found 2 relevant memories:

## /api/file-upload

Path: /api → /file-upload
Relevance: 95%

# File Upload Handling

We use Supabase Storage for file uploads.

## Implementation Pattern

```typescript
import { supabase } from './supabase';

async function uploadFile(file: File) {
  const { data, error } = await supabase.storage
    .from('uploads')
    .upload(`${userId}/${file.name}`, file);

  if (error) throw error;
  return data.path;
}
```

## Error Handling

Always check file size before upload (max 5MB).
Use content-type validation to prevent malicious files.

---

## /frontend/components/file-uploader

Path: /frontend → /components → /file-uploader
Relevance: 82%

# FileUploader Component

React component for drag-and-drop uploads.

```tsx
<FileUploader
  onUpload={handleUpload}
  maxSize={5 * 1024 * 1024}
  accept="image/*"
/>
```

---
```

---

## Autonomous Agent Behavior

### Example Session

**User**: "Add a user profile page with avatar upload"

**Claude Code (autonomous)**:

```bash
# Agent automatically runs query
brv query "How do we handle file uploads?"
```

*Reads output, learns about Supabase Storage pattern*

```bash
# Agent implements feature using discovered pattern
# (writes code to files)
```

```bash
# Agent automatically saves learning
brv curit "User profile page with avatar upload using Supabase Storage" @profile.tsx @upload-utils.ts
```

**Key point**: The agent did ALL of this without user intervention. It:
1. Recognized it needed context
2. Queried the memory system
3. Applied the knowledge
4. Saved the new implementation

---

## Team Collaboration

### Push Workflow

```bash
brv push
```

**What happens:**
1. Commit all local memory changes to git
2. Push to shared remote repository
3. Teammates can now pull these memories

```typescript
// services/sync.service.ts

async function push(): Promise<void> {
  // 1. Ensure all Beads tasks are committed
  await beadsService.syncToGit();

  // 2. Git add .beads/
  await gitService.add('.beads/');

  // 3. Commit with message
  await gitService.commit('Sync memory updates');

  // 4. Push to remote
  await gitService.push();

  console.log('✓ Memories pushed to team workspace');
}
```

### Pull Workflow

```bash
brv pull
```

**What happens:**
1. Pull latest changes from remote
2. Beads daemon syncs from git
3. Local context tree updates

```typescript
async function pull(): Promise<void> {
  // 1. Git pull
  await gitService.pull();

  // 2. Beads re-syncs from .beads/
  await beadsService.resync();

  console.log('✓ Received latest team memories');
}
```

---

## Interactive REPL

### Launch

```bash
brv
```

**Opens interactive terminal interface:**

```
Beads ByteRover CLI v1.0.0

Commands:
  /curit <description> @files    Curate context
  /query <question>              Query context tree
  /list                          List all memories
  /status                        Show workspace status
  /gen-rules                     Generate IDE rules
  /push                          Push to team
  /pull                          Pull from team
  /help                          Show help
  /exit                          Exit REPL

brv>
```

### Implementation

```typescript
// cli/repl.ts

import * as readline from 'readline';

export async function startREPL() {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
    prompt: 'brv> '
  });

  rl.prompt();

  rl.on('line', async (line) => {
    const trimmed = line.trim();

    if (trimmed.startsWith('/curit ')) {
      await handleCurit(trimmed.slice(7));
    } else if (trimmed.startsWith('/query ')) {
      await handleQuery(trimmed.slice(7));
    } else if (trimmed === '/list') {
      await handleList();
    } else if (trimmed === '/status') {
      await handleStatus();
    } else if (trimmed === '/gen-rules') {
      await generateRules();
    } else if (trimmed === '/push') {
      await push();
    } else if (trimmed === '/pull') {
      await pull();
    } else if (trimmed === '/exit') {
      rl.close();
      process.exit(0);
    } else {
      console.log('Unknown command. Type /help for help.');
    }

    rl.prompt();
  });
}
```

---

## File Structure

```
project-root/
├── .beads/                      # Beads storage (managed by Beads)
│   ├── tasks/                   # JSONL task files
│   ├── cache.db                 # SQLite cache
│   └── config                   # Beads config
├── .brv/                        # ByteRover workspace
│   ├── config.json              # User config
│   ├── context-tree.json        # Tree structure cache
│   └── activity.log             # Curation/query log
├── .claude/                     # Claude Code integration
│   └── custom_instructions.md   # Auto-generated rules
├── .cursor/                     # Cursor integration
│   └── rules                    # Auto-generated rules
├── .windsurf/                   # Windsurf integration
│   └── rules.md                 # Auto-generated rules
└── .git/                        # Version control
```

---

## Summary

The auto-rules system transforms AI agents from reactive chatbots into **autonomous developers** who:

1. **Query before acting** - Check memory for patterns
2. **Apply learned knowledge** - Use project-specific context
3. **Save after completing** - Curate new learnings
4. **Collaborate seamlessly** - Sync via git push/pull

**Key Innovation**: The agent manages its own context loop without human intervention, preventing hallucinations and reducing token waste by 50%.

**Implementation Priority**: This is the HIGHEST priority feature because it's what makes the system truly autonomous and differentiates it from basic MCP servers.
