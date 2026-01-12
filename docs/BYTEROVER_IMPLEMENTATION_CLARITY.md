# Building ByteRover with Beads - Implementation Strategy

## Clear Objective

**We are BUILDING our own ByteRover from scratch using Beads as the engine.**

- ✅ Use ByteRover as a **proven mental model**
- ✅ Replicate the **exact app logic**
- ✅ Copy the **exact strategy and workflows**
- ✅ Match the **exact features and UI**
- ❌ NOT integrating with the real ByteRover service
- ❌ NOT using their proprietary backend

**Why?** ByteRover is closed-source and costs money. We want the same power but:
- Open-source (we control it)
- Free (no subscription)
- Git-backed (Beads gives us this)
- Customizable for our workflow cluster

---

## What We're Replicating from ByteRover

### 1. Core Features (Must-Have)

**CLI Commands:**
```bash
# ByteRover Original    →    Our Beads Version
brv login                     (Skip - local only)
brv init                      brv init (initialize .beads/)
brv curit "desc" @files       brv curit "desc" @files
brv query "question"          brv query "question"
brv push                      brv push (git push)
brv pull                      brv pull (git pull)
brv gen-rules                 brv gen-rules
brv status                    brv status
```

**Context Tree:**
```
ByteRover: Proprietary hierarchical storage
Our Version: Beads tasks with parent/child relationships (bd dep)
```

**Agentic Search:**
```
ByteRover: AI-powered tree navigation
Our Version: Same algorithm, uses Beads task graph
```

**Team Sync:**
```
ByteRover: Cloud sync with their servers
Our Version: Git push/pull (better for teams!)
```

**Auto-Rules:**
```
ByteRover: Detects IDE, generates rules
Our Version: Exact same - detect IDE, write .claude/custom_instructions.md
```

---

### 2. App Logic to Replicate

#### Memory Creation (brv curit)

**ByteRover's Flow:**
```
1. Parse: "description @file1 @file2"
2. Read files
3. Classify into category (database, auth, api, etc.)
4. Build markdown content
5. Store in proprietary DB
6. Create relationships
7. Version with git-like system
```

**Our Beads Implementation:**
```typescript
// Exact same logic, different storage

async function curit(input: string) {
  // 1. Parse (SAME)
  const { description, files } = parseInput(input);

  // 2. Read files (SAME)
  const contents = await readFiles(files);

  // 3. Classify (SAME algorithm)
  const category = classifyContent(description, contents);

  // 4. Build markdown (SAME format)
  const markdown = buildMemoryMarkdown(description, files, contents);

  // 5. Store in Beads (DIFFERENT - use bd create)
  const taskId = execSync(`bd create "/${category}/${slug}" -p 0`);
  execSync(`bd update ${taskId} < ${tempFile}`);

  // 6. Create relationships (DIFFERENT - use bd dep)
  const parentId = getCategoryParentId(category);
  execSync(`bd dep add ${taskId} ${parentId}`);

  // 7. Version with git (SAME)
  execSync(`git add .beads/ && git commit -m "Add memory: ${description}"`);
}
```

**Result:** User experience is IDENTICAL, storage is Beads instead.

---

#### Memory Query (brv query)

**ByteRover's Flow:**
```
1. User asks: "How do we handle authentication?"
2. Extract keywords: [authentication, handle]
3. Navigate context tree intelligently (agentic search)
4. Score results by relevance
5. Return top 5 matches with context
6. Format for display
```

**Our Beads Implementation:**
```typescript
// Exact same algorithm

async function query(question: string) {
  // 1. User asks (SAME)
  // question = "How do we handle authentication?"

  // 2. Extract keywords (SAME algorithm)
  const keywords = extractKeywords(question); // [authentication, handle]

  // 3. Navigate tree (SAME - but use Beads)
  const allTasks = JSON.parse(execSync('bd list --format json'));
  const results = await agenticSearch(question, allTasks);

  // 4. Score results (SAME algorithm)
  // Match keywords in title/description, calculate relevance

  // 5. Return top 5 (SAME)
  const top5 = results.slice(0, 5);

  // 6. Format (SAME display format)
  return formatResults(top5);
}
```

**Result:** User gets same quality answers, powered by Beads.

---

#### Auto-Rules Generation (brv gen-rules)

**ByteRover's Flow:**
```
1. Detect IDE (check for .claude/, .cursor/, .windsurf/)
2. Choose template based on IDE
3. Write rules file to correct location
4. Rules teach agent to use brv commands
```

**Our Implementation:**
```typescript
// IDENTICAL implementation

async function genRules() {
  // 1. Detect IDE (EXACT SAME)
  const ide = await detectIDE(); // 'claude-code' | 'cursor' | 'windsurf'

  // 2. Choose template (SAME templates)
  const template = getTemplate(ide);

  // 3. Write rules file (SAME locations)
  const filePath = {
    'claude-code': '.claude/custom_instructions.md',
    'cursor': '.cursor/rules',
    'windsurf': '.windsurf/rules.md'
  }[ide];

  fs.writeFileSync(filePath, template);

  // 4. Rules content (IDENTICAL)
  // Teaches agent to use brv curit, brv query automatically
}
```

**Result:** Works EXACTLY like ByteRover. Agent learns to use memory system.

---

### 3. UI to Replicate (Optional - CLI First)

**ByteRover has a web interface. We can replicate it later:**

```
┌─────────────────────────────────────────┐
│  ByteRover UI                           │
├─────────────────────────────────────────┤
│  📁 Categories                          │
│    • Database (12)                      │
│    • Authentication (8)                 │
│    • API (23)                           │
│    • Frontend (17)                      │
│                                         │
│  🔍 Search Memories                     │
│  [________________] 🔎                  │
│                                         │
│  📝 Recent Memories                     │
│  • Auth middleware with JWT (2h ago)   │
│  • Database schema for users (5h ago)  │
│  • API endpoint POST /auth (1d ago)    │
│                                         │
│  [+ New Memory]                         │
└─────────────────────────────────────────┘
```

**Our Implementation:**
- Phase 1: CLI only (matches their functionality)
- Phase 2: React UI (same design, reads from Beads)

---

## Claude Code Instance Separation

### Understanding Claude Code Instances

**KEY POINT: Claude Code is configured PER-PROJECT, not globally.**

Each project directory has its own `.claude/` folder with independent settings.

---

### Example: Your Setup

#### Project 1: Designbrnd
```
/home/user/Designbrnd/
├── .claude/                    # ← Designbrnd-specific config
│   ├── custom_instructions.md  # Rules for this project only
│   ├── commands/               # Skills for this project only
│   └── ...
├── src/
└── package.json
```

**When you run Claude Code here:**
- Reads `.claude/custom_instructions.md` from THIS directory
- Has access to Design OS commands
- Uses rules specific to Design OS workflow

---

#### Project 2: Client Restaurant Website
```
/home/user/projects/restaurant-site/
├── .claude/                    # ← Restaurant-specific config
│   ├── custom_instructions.md  # Different rules!
│   └── ...
├── app/
└── package.json
```

**When you run Claude Code here:**
- Reads `.claude/custom_instructions.md` from THIS directory
- Has restaurant project context
- Uses rules specific to this client

---

### They Are COMPLETELY Separated

```
┌──────────────────────────────────────┐
│  Designbrnd Claude Code Instance     │
│  Working Directory: ~/Designbrnd     │
│  Config: ~/Designbrnd/.claude/       │
│  Rules: Design OS + ByteRover        │
│  Context: Design OS codebase         │
└──────────────────────────────────────┘

        ↕ SEPARATE ↕

┌──────────────────────────────────────┐
│  Restaurant Claude Code Instance     │
│  Working Directory: ~/restaurant     │
│  Config: ~/restaurant/.claude/       │
│  Rules: RALPH LOOP + ByteRover       │
│  Context: Restaurant codebase        │
└──────────────────────────────────────┘
```

**They do NOT share:**
- ❌ Instructions
- ❌ Context
- ❌ Commands/Skills
- ❌ Session history

**They DO share (global):**
- ✅ Reflect skills (`~/.claude/skills/`)
- ✅ Global settings (`~/.claude/settings.json`)
- ✅ MCP servers (if configured globally)

---

### How ByteRover Works Across Projects

**ByteRover memory is PER-PROJECT too!**

#### Designbrnd Project
```
/home/user/Designbrnd/
├── .beads/              # ← Designbrnd memories ONLY
│   └── tasks/
├── .brv/
│   └── config.json
└── .claude/
    └── custom_instructions.md  # "Use brv for Designbrnd context"
```

**Memories stored here:**
- Design OS decisions
- Color choices
- Section specifications
- Architecture decisions
- **Only for Designbrnd project**

---

#### Restaurant Project
```
/home/user/restaurant/
├── .beads/              # ← Restaurant memories ONLY
│   └── tasks/
├── .brv/
│   └── config.json
└── .claude/
    └── custom_instructions.md  # "Use brv for Restaurant context"
```

**Memories stored here:**
- Client feedback
- Menu items
- Booking flow specs
- Implementation notes
- **Only for Restaurant project**

---

### Workflow Cluster in Each Project

**Each client project gets the SAME workflow setup:**

```
Client Project X/
├── .beads/                  # Project X memories
├── .claude/
│   ├── custom_instructions.md
│   └── commands/
│       ├── design-os/       # Phase 1 commands
│       ├── figma-mcp/       # Phase 2 (if applicable)
│       └── ralph-loop/      # Phase 3 commands
└── e2e/                     # RALPH LOOP tests
```

**When you run Phase 1 (Design OS):**
```bash
cd /home/user/client-project-x
claude  # Starts Claude Code here
# Reads: client-project-x/.claude/custom_instructions.md
# Uses: client-project-x/.beads/ for memories
```

**When you run Phase 3 (RALPH LOOP):**
```bash
cd /home/user/client-project-x
claude  # Same Claude Code instance
# Reads SAME .claude/ config
# Queries: "brv query 'approved designs?'"
# Gets: client-project-x memories from Phase 2
```

**It's all SELF-CONTAINED per project!**

---

## Configuration Strategy

### Option 1: Template Approach (RECOMMENDED)

Create a template with workflow cluster setup:

```bash
# Create template
mkdir ~/workflow-template
cd ~/workflow-template

# Initialize
brv init
brv gen-rules

# Add workflow commands
cp -r ~/Designbrnd/.claude/commands ./claude/

# This becomes your starter template
```

**For each new client:**
```bash
# Copy template
cp -r ~/workflow-template ~/client-restaurant
cd ~/client-restaurant

# Start fresh
git init
brv init  # New .beads/ for this client
brv gen-rules  # Generates .claude/ rules

# Now run workflow
# Phase 1: Design OS
# Phase 2: Figma MCP
# Phase 3: RALPH LOOP
# Phase 4: Reflect

# All memories stored in THIS project's .beads/
```

---

### Option 2: Global Workflow Commands + Per-Project Memories

**Global skills:**
```
~/.claude/
├── skills/              # Reflect skills (shared across all projects)
│   ├── brand-design/
│   ├── implementation/
│   └── qa-verification/
└── settings.json        # Global settings
```

**Per-project:**
```
client-project/
├── .beads/              # Client-specific memories
├── .brv/                # Client-specific config
└── .claude/
    └── custom_instructions.md  # "Use brv + global skills"
```

**Benefits:**
- ✅ Reflect skills learned across ALL projects
- ✅ Each client's memories isolated
- ✅ Best of both worlds

---

## Sharing Context Between Projects (Advanced)

**What if you WANT to share some memories?**

### Scenario: You build 10 restaurant websites

**Option A: Separate memories per client**
```
client-1/.beads/  # Restaurant 1 specific
client-2/.beads/  # Restaurant 2 specific
client-3/.beads/  # Restaurant 3 specific
```
✅ Client data isolated
❌ Can't query "How did we do menus in previous restaurants?"

---

**Option B: Shared "restaurant pattern" memories**

```bash
# Create shared repository
mkdir ~/patterns/restaurant
cd ~/patterns/restaurant
brv init

# Store general patterns (not client-specific)
brv curit "Restaurant menu grid: 3 columns, Card components" @pattern.md
brv curit "Booking form: Date picker + time select + party size" @pattern.md
brv curit "Hero overlay: 50% black works best for food photos" @pattern.md
git push  # Share with team
```

**In each client project:**
```markdown
# .claude/custom_instructions.md

## Memory Systems

1. Project-specific memories: `brv curit / brv query`
2. Restaurant patterns: Query ~/patterns/restaurant/.beads/

When starting new restaurant features:
- Query local .beads/ for THIS client's context
- Query ~/patterns/restaurant/ for general restaurant patterns
```

**Result:**
- ✅ Client data isolated
- ✅ Can reuse proven patterns
- ✅ Reflect learns cross-project

---

## Implementation Phases

### Phase 1: Core CLI (Weeks 1-2) - PRIORITY

**Build the exact ByteRover CLI:**

```bash
# Commands to implement (exact feature parity)
brv init          # Initialize workspace
brv gen-rules     # Auto-detect IDE, write rules
brv curit         # Curate context
brv query         # Query context
brv push          # Git push
brv pull          # Git pull
brv status        # Workspace status
brv list          # List all memories
```

**Implementation:**
```typescript
// Same logic as ByteRover, Beads as storage
// Everything we've designed in previous docs
```

**Test in Designbrnd first:**
```bash
cd ~/Designbrnd
brv init
brv gen-rules  # Detects Claude Code, writes rules
brv curit "Thread-based engineering framework" @docs/THREAD_BASED_ENGINEERING.md
brv query "thread types"  # Should return concepts
```

---

### Phase 2: Workflow Integration (Week 3)

**Add workflow-specific features:**

```bash
brv pthread <count> <prompt>     # Parallel threads
brv workflow <workflow-name>      # Run full C-Thread
brv thread start <type>           # Track threads
brv reflect-analyze               # Extract patterns for Reflect
```

**Test in client project:**
```bash
cd ~/restaurant-project
brv init
brv workflow "restaurant-website"
# Runs: Design OS → Figma MCP → RALPH → Reflect
# Each phase queries memories from prior phases
```

---

### Phase 3: Web UI (Optional, Weeks 4-5)

**Build React interface matching ByteRover:**
- Memory workspace
- Context Composer
- Version history viewer
- Team sync dashboard

**But CLI FIRST** - that's where the power is!

---

## Summary

### What We're Building

**A complete ByteRover clone powered by Beads:**

| Feature | ByteRover Original | Our Beads Version |
|---------|-------------------|-------------------|
| Storage | Proprietary DB | Beads (git-backed) |
| CLI | `brv` commands | `brv` commands (identical!) |
| Auto-rules | ✅ | ✅ (exact same) |
| Agentic search | ✅ | ✅ (same algorithm) |
| Team sync | Cloud servers | Git push/pull |
| Context tree | Proprietary | Beads task graph |
| Versioning | Git-like | Actual git |
| Cost | $$ subscription | FREE |
| Open source | ❌ | ✅ |
| Customizable | ❌ | ✅ |

---

### Claude Code Instances

**Completely separate per project:**

```
Project 1 (.claude/) ←→ [Project 1 memories] (.beads/)
Project 2 (.claude/) ←→ [Project 2 memories] (.beads/)
Project 3 (.claude/) ←→ [Project 3 memories] (.beads/)
```

**Shared across all:**
```
~/.claude/skills/ ← Reflect learns from ALL projects
```

---

### Next Steps

1. ✅ **Finalize architecture** (done!)
2. ⏳ **Build Phase 1 CLI** - Start here!
3. ⏳ **Test in Designbrnd**
4. ⏳ **Test in client project**
5. ⏳ **Add workflow features**
6. ⏳ **Build UI** (optional)

**Ready to start building the CLI?** 🚀

We're creating a **better ByteRover** that's free, open, and git-native!
