# Reflect + Beads ByteRover Integration

## Overview

**Reflect** and **Beads ByteRover** are complementary systems that work together to create a complete AI agent memory architecture:

- **Reflect**: Long-term skill learning (cross-project)
- **ByteRover**: Short-term context management (project-specific)

Think of it like human memory:
- **Reflect** = Procedural memory (how to ride a bike)
- **ByteRover** = Episodic memory (what happened yesterday)

---

## System Comparison

### Reflect Skill

**Purpose:** Learn general principles and preferences

**Storage:** `~/.claude/skills/`
```
~/.claude/skills/
├── client-discovery.md
├── brand-design.md
├── figma-design.md
├── implementation.md
└── qa-verification.md
```

**Example Content:**
```markdown
# Brand Design Skill

## Component Standards
- Button padding: 16px horizontal (NEVER 20px)
- [LEARNED: 2026-01-10 - Button sizing standards]

## Industry Color Guidelines
- Restaurants: Warm colors (red, orange, gold)
- [LEARNED: 2026-01-10 - Restaurant preferences]
```

**Lifecycle:** Permanent, grows with every project

**Sharing:** Private team repository (proprietary patterns)

---

### Beads ByteRover

**Purpose:** Manage project-specific context

**Storage:** `.beads/` + `.brv/`
```
project-root/
├── .beads/                # Beads tasks (memories)
└── .brv/                  # ByteRover config
```

**Example Content:**
```markdown
# /database/user-schema

## Users Table
- id (uuid, primary key)
- email (text, unique)
- created_at (timestamp)

## Implementation
See: auth/models/user.ts
```

**Lifecycle:** Project-scoped, archived after project ends

**Sharing:** Project git repository (team shares same context)

---

## When to Use Each

### Use Reflect When:
- ✅ Learning a **general principle** ("Always validate user input")
- ✅ Capturing **preferences** ("I prefer shadcn/ui over Material-UI")
- ✅ Recording **repeated mistakes** ("Never hardcode API keys")
- ✅ Establishing **team standards** ("Button padding: 16px")
- ✅ Industry-specific patterns ("Restaurants prefer warm colors")

### Use ByteRover When:
- ✅ Recording **project architecture** ("We use Supabase for auth")
- ✅ Storing **API specifications** ("POST /api/users endpoint")
- ✅ Documenting **database schemas** ("User table structure")
- ✅ Saving **implementation details** ("File upload uses Supabase Storage")
- ✅ Tracking **project decisions** ("Using Next.js App Router")

---

## Integrated Workflow

### Scenario: Building User Authentication

**Step 1: Agent queries BOTH systems**

```bash
# Query Reflect for general principles
(Agent reads ~/.claude/skills/implementation.md)
→ Finds: "Always use JWT tokens, never store passwords in plain text"

# Query ByteRover for project context
brv query "How do we handle authentication?"
→ Finds: "We use Supabase Auth with JWT tokens"
```

**Step 2: Agent implements using combined knowledge**
- Uses Reflect principles (JWT, secure practices)
- Applies ByteRover context (Supabase-specific implementation)

**Step 3: Agent saves to BOTH systems**

```bash
# Save to ByteRover (project-specific)
brv curit "User authentication implementation" @auth.ts @middleware.ts

# Save to Reflect (if learned something general)
(At session end) /reflect implementation
→ Learns: "Supabase Auth is faster than custom JWT implementation"
```

---

## Integration Points

### 1. Auto-Curation from Reflect

When Reflect learns something project-specific, suggest curation to ByteRover:

```
Reflect detected learning:
"Supabase Auth setup for this project"

This seems project-specific. Save to ByteRover?
[Y/n] _

→ If Y: Automatically runs brv curit
```

**Implementation:**
```typescript
// In Reflect skill
async function onLearnDetected(learning: Learning) {
  if (learning.isProjectSpecific) {
    const answer = await prompt('Save to ByteRover? [Y/n]');
    if (answer === 'Y') {
      execSync(`brv curit "${learning.title}" @${learning.files.join(' @')}`);
    }
  }
}
```

---

### 2. Query Both Systems

Add a unified query command that searches BOTH:

```bash
brv query-all "authentication"
```

**Output:**
```
=== REFLECT SKILLS ===

From: implementation.md
- Always use JWT tokens
- Never store passwords in plain text
- Use bcrypt for password hashing (min 10 rounds)

=== PROJECT MEMORIES ===

From: /auth/setup (bd-a1b2)
- Using Supabase Auth
- JWT tokens stored in httpOnly cookies
- Middleware: auth/middleware.ts
```

**Implementation:**
```typescript
// Add to CLI
program
  .command('query-all <question>')
  .description('Query both Reflect skills and project memories')
  .action(async (question) => {
    // 1. Query Reflect skills
    const skills = await queryReflectSkills(question);

    // 2. Query ByteRover memories
    const memories = await queryByteRover(question);

    // 3. Display combined results
    displayCombinedResults(skills, memories);
  });
```

---

### 3. Reflect on ByteRover Memories

Periodically analyze ByteRover memories to extract general patterns:

```bash
brv reflect-analyze
```

**Example:**
```
Analyzing 50 project memories...

Pattern detected (3 projects):
"Always use Supabase Storage for file uploads"

Suggest adding to Reflect skill: implementation.md?
[Y/n] _
```

**Implementation:**
```typescript
async function analyzeMemoriesForPatterns() {
  // 1. Get all memories
  const memories = await beadsService.listMemories();

  // 2. Find repeated patterns across projects
  const patterns = detectRepeatedPatterns(memories);

  // 3. Suggest adding to Reflect skills
  for (const pattern of patterns) {
    if (pattern.occurrences >= 3) {
      const answer = await prompt(`Add "${pattern.rule}" to Reflect?`);
      if (answer === 'Y') {
        await updateReflectSkill(pattern.category, pattern.rule);
      }
    }
  }
}
```

---

### 4. Rules Generation Enhancement

Update `brv gen-rules` to include Reflect skills:

**Enhanced rules file:**
```markdown
# Beads ByteRover + Reflect Memory System

You have TWO memory systems:

## 1. Reflect Skills (General Principles)
Location: ~/.claude/skills/

Before coding, read relevant skills:
- implementation.md - Tech stack rules
- brand-design.md - Design standards
- qa-verification.md - Testing checklist

## 2. ByteRover Memories (Project Context)

Query with: `brv query "question"`

## Workflow

1. Read Reflect skills for general principles
2. Query ByteRover for project-specific context
3. Implement using BOTH sources
4. Save project details to ByteRover
5. At session end, update Reflect if learned something general
```

---

### 5. Unified Dashboard (Optional)

Build a combined view in the web UI:

```
┌────────────────────────────────────────────────┐
│          Memory Dashboard                      │
├────────────────────────────────────────────────┤
│                                                │
│  📚 REFLECT SKILLS (5)                        │
│  └─ implementation.md (Updated: 2 days ago)   │
│  └─ brand-design.md (Updated: 1 week ago)     │
│                                                │
│  🧠 PROJECT MEMORIES (23)                      │
│  └─ /database/schema (Updated: 2 hours ago)   │
│  └─ /auth/jwt (Updated: 1 day ago)            │
│                                                │
│  🔍 Quick Search: [________________]          │
│      ⚫ Skills  ⚫ Memories  ⚫ Both           │
└────────────────────────────────────────────────┘
```

---

## Example Sessions

### Session 1: Building Authentication (No Prior Context)

**Agent behavior:**
```
User: "Add user authentication"

Agent:
1. Reads ~/.claude/skills/implementation.md
   → Learns: Use JWT, bcrypt, secure storage

2. Runs: brv query "authentication"
   → No results (new project)

3. Implements auth using Reflect principles

4. Runs: brv curit "Auth with Supabase" @auth.ts

5. At session end: /reflect implementation
   → Updates skill with Supabase-specific learnings
```

---

### Session 2: Same User, Different Project

**Agent behavior:**
```
User: "Add user authentication"

Agent:
1. Reads ~/.claude/skills/implementation.md
   → NOW sees: "Supabase Auth is fast and reliable"

2. Runs: brv query "authentication"
   → No results (different project)

3. Implements auth FASTER (already knows Supabase pattern)

4. Runs: brv curit "Auth with Supabase" @auth.ts
```

**Result:** Agent is faster because Reflect remembers the approach!

---

### Session 3: Teammate Joins Project

**Agent behavior:**
```
Teammate's Agent:

1. Reads ~/.claude/skills/implementation.md
   → Learns general principles (if team shares skills repo)

2. Runs: brv pull
   → Gets project-specific memories from git

3. Runs: brv query "authentication"
   → Finds: "Auth with Supabase" (from Session 1)

4. Implements consistently with original developer
```

**Result:** Team consistency through BOTH memory layers!

---

## Technical Implementation

### Shared CLI Command

Add Reflect integration to ByteRover CLI:

```typescript
// src/commands/reflect-integration.ts

export async function queryAll(question: string) {
  console.log(chalk.bold('Searching memory systems...\n'));

  // 1. Query Reflect skills
  const skillsPath = path.join(os.homedir(), '.claude/skills');
  const skills = await searchSkills(skillsPath, question);

  // 2. Query ByteRover memories
  const memories = await query(question); // Existing brv query

  // 3. Display combined
  if (skills.length > 0) {
    console.log(chalk.yellow('📚 REFLECT SKILLS\n'));
    displaySkills(skills);
    console.log();
  }

  if (memories.length > 0) {
    console.log(chalk.cyan('🧠 PROJECT MEMORIES\n'));
    displayMemories(memories);
  }
}

async function searchSkills(skillsPath: string, query: string): Promise<any[]> {
  if (!fs.existsSync(skillsPath)) return [];

  const files = fs.readdirSync(skillsPath)
    .filter(f => f.endsWith('.md'));

  const results = [];
  for (const file of files) {
    const content = fs.readFileSync(path.join(skillsPath, file), 'utf-8');
    if (content.toLowerCase().includes(query.toLowerCase())) {
      results.push({
        skill: file.replace('.md', ''),
        excerpt: extractRelevantExcerpt(content, query)
      });
    }
  }

  return results;
}
```

### Updated Rules Template

```typescript
// src/templates/claude-code-enhanced.ts

export const enhancedTemplate = `
# Beads ByteRover + Reflect Memory System

## Two Memory Layers

### Layer 1: Reflect Skills (Permanent)
General principles and preferences stored in ~/.claude/skills/

Before starting work, read relevant skills:
- implementation.md
- brand-design.md
- qa-verification.md

### Layer 2: ByteRover Memories (Project)
Project-specific context stored in .beads/

Query with: \`brv query "question"\`
Save with: \`brv curit "description" @files\`

## Autonomous Workflow

1. Read Reflect skills (general principles)
2. Query ByteRover (project context)
3. Implement feature
4. Save to ByteRover (project-specific)
5. Consider: Is this a general principle? → Update Reflect

## Example

User: "Add authentication"

You:
1. Read ~/.claude/skills/implementation.md
   → See: "Use JWT, bcrypt, Supabase is good"

2. Run: brv query "authentication"
   → See: "We use Supabase Auth" (if exists)

3. Implement using BOTH sources

4. Run: brv curit "Auth implementation" @auth.ts

DO THIS AUTOMATICALLY.
`;
```

---

## Benefits of Integration

### 1. Faster Iteration
- **Reflect**: Agent remembers patterns across projects
- **ByteRover**: Team doesn't repeat questions

### 2. Consistency
- **Reflect**: Same quality standards everywhere
- **ByteRover**: Same architecture decisions per project

### 3. Team Collaboration
- **Reflect**: Shared skills → consistent team output
- **ByteRover**: Shared memories → no knowledge silos

### 4. Continuous Improvement
- **Reflect**: Gets smarter with every correction
- **ByteRover**: Gets more complete with every feature

### 5. Zero Redundancy
- **Reflect**: Stores "how to do things"
- **ByteRover**: Stores "what we did"
- No overlap, perfect complement

---

## Migration Strategy

### If You Already Use Reflect

1. **Keep using Reflect for skills**
2. **Add ByteRover for project context**
3. **Update rules file** to reference both systems
4. **Train agent** to query both before coding

### Commands to Add

```bash
# Query both systems
brv query-all "question"

# Analyze memories for patterns
brv reflect-analyze

# Check what's stored where
brv status --verbose
  → Shows: 5 Reflect skills, 23 ByteRover memories
```

---

## Summary

**Reflect** and **ByteRover** form a complete memory architecture:

```
┌─────────────────────────────────────────┐
│            AI AGENT                     │
│                                         │
│  ┌────────────┐      ┌──────────────┐ │
│  │  REFLECT   │      │   BYTEROVER  │ │
│  │  (Skills)  │  +   │  (Memories)  │ │
│  └────────────┘      └──────────────┘ │
│       ↓                     ↓          │
│  "How to do"          "What we did"    │
│  General rules        Project context  │
│  Cross-project        Project-scoped   │
│  Permanent            Temporary        │
└─────────────────────────────────────────┘
```

**Result**: Agent with both **long-term skill** and **short-term project memory** → Human-like memory architecture!

---

## Next Steps

1. ✅ Continue building ByteRover CLI (Phase 1)
2. ✅ Add `brv query-all` command (integrates with Reflect)
3. ✅ Update rules template to reference both systems
4. ✅ Add `brv reflect-analyze` for pattern extraction
5. ✅ Test combined workflow with real project

Ready to implement?
