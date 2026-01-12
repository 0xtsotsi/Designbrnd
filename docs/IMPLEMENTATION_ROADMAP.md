# Implementation Roadmap - Beads ByteRover

## Priority Overview

**Phase 1 (CRITICAL)**: Auto-Rules CLI - The foundation that makes agents autonomous
**Phase 2**: Context Tree & Search - Core memory functionality
**Phase 3**: Team Collaboration - Git sync features
**Phase 4**: Web UI - Optional visual interface
**Phase 5**: MCP Server - Additional integration layer

---

## Phase 1: Auto-Rules CLI (Week 1-2) 🔥 PRIORITY

**Goal**: Deliver the core CLI that AI agents can use autonomously

### 1.1 Project Setup

**Tasks:**
- [ ] Create new npm package: `beads-byterover`
- [ ] Set up TypeScript build configuration
- [ ] Initialize Beads in project (`bd init`)
- [ ] Create CLI binary entry point
- [ ] Add commander.js for CLI parsing
- [ ] Set up Jest for testing

**Files to Create:**
```
beads-byterover/
├── package.json
├── tsconfig.json
├── src/
│   ├── index.ts           # CLI entry point
│   ├── commands/
│   │   ├── init.ts
│   │   ├── gen-rules.ts
│   │   ├── curit.ts
│   │   ├── query.ts
│   │   └── sync.ts
│   ├── services/
│   │   ├── beads.service.ts
│   │   ├── git.service.ts
│   │   └── detection.service.ts
│   └── templates/
│       ├── claude-code.ts
│       ├── cursor.ts
│       └── windsurf.ts
└── bin/
    └── brv               # Executable
```

**Commands:**
```bash
npm init -y
npm install commander chalk ora inquirer
npm install -D typescript @types/node jest ts-jest
npx tsc --init
```

**Deliverable:** Working CLI skeleton that can be installed globally

---

### 1.2 Core Commands Implementation

#### `brv init`

**Purpose:** Initialize ByteRover workspace in project

**Implementation:**
```typescript
// src/commands/init.ts

export async function init() {
  const spinner = ora('Initializing Beads ByteRover...').start();

  try {
    // 1. Check if already initialized
    if (fs.existsSync('.brv')) {
      spinner.fail('Already initialized');
      return;
    }

    // 2. Initialize Beads if not present
    if (!fs.existsSync('.beads')) {
      execSync('bd init', { stdio: 'inherit' });
    }

    // 3. Create .brv workspace
    fs.mkdirSync('.brv', { recursive: true });

    // 4. Create config
    const config = {
      version: '1.0.0',
      contextTree: {},
      tags: [],
      categories: ['database', 'auth', 'api', 'frontend', 'deployment']
    };
    fs.writeFileSync('.brv/config.json', JSON.stringify(config, null, 2));

    // 5. Create root category tasks in Beads
    await createRootCategories();

    // 6. Git ignore
    addToGitignore('.brv/activity.log');

    spinner.succeed('Initialized Beads ByteRover workspace');
    console.log('');
    console.log('Next steps:');
    console.log('  1. Run: brv gen-rules');
    console.log('  2. Start using your AI agent - it will use the memory system automatically');
  } catch (error) {
    spinner.fail('Initialization failed');
    console.error(error);
  }
}

async function createRootCategories() {
  const categories = ['database', 'auth', 'api', 'frontend', 'deployment'];

  for (const cat of categories) {
    const result = execSync(`bd create "/${cat}" -p 0`, { encoding: 'utf-8' });
    const id = extractTaskId(result);

    // Store in config
    const config = JSON.parse(fs.readFileSync('.brv/config.json', 'utf-8'));
    config.contextTree[cat] = id;
    fs.writeFileSync('.brv/config.json', JSON.stringify(config, null, 2));
  }
}
```

**Test:**
```bash
brv init
# Should create .brv/ directory and initialize Beads
```

---

#### `brv gen-rules`

**Purpose:** Auto-detect IDE and generate rules file

**Implementation:**
```typescript
// src/commands/gen-rules.ts

export async function genRules() {
  console.log('Detecting IDE...');

  const ide = await detectIDE();
  console.log(`Found: ${ide}`);

  const template = getTemplate(ide);
  const filePath = getRulesPath(ide);

  // Create directory
  const dir = path.dirname(filePath);
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }

  // Write rules
  fs.writeFileSync(filePath, template);

  console.log('');
  console.log(chalk.green('✓') + ' Rules file generated!');
  console.log('');
  console.log('Location:', chalk.cyan(filePath));
  console.log('');
  console.log('Your AI agent now knows how to:');
  console.log('  • Query context before coding');
  console.log('  • Save learnings after coding');
  console.log('  • Manage its own memory loop');
  console.log('');
  console.log('Try it: Ask your agent to build something and watch it use brv commands automatically.');
}

async function detectIDE(): Promise<string> {
  // Check for Claude Code
  if (fs.existsSync('.claude/claude_desktop_config.json') ||
      fs.existsSync('.claude')) {
    return 'claude-code';
  }

  // Check for Cursor
  if (fs.existsSync('.cursor') || process.env.CURSOR_USER_HOME) {
    return 'cursor';
  }

  // Check for Windsurf
  if (fs.existsSync('.windsurf') || process.env.WINDSURF_HOME) {
    return 'windsurf';
  }

  // Prompt user
  const { ide } = await inquirer.prompt([{
    type: 'list',
    name: 'ide',
    message: 'Which AI coding tool are you using?',
    choices: [
      { name: 'Claude Code', value: 'claude-code' },
      { name: 'Cursor', value: 'cursor' },
      { name: 'Windsurf', value: 'windsurf' },
      { name: 'Other', value: 'generic' }
    ]
  }]);

  return ide;
}

function getRulesPath(ide: string): string {
  const paths = {
    'claude-code': '.claude/custom_instructions.md',
    'cursor': '.cursor/rules',
    'windsurf': '.windsurf/rules.md',
    'generic': '.brv/rules.md'
  };
  return paths[ide] || paths.generic;
}
```

**Templates:**
```typescript
// src/templates/claude-code.ts

export const claudeCodeTemplate = `
# Beads ByteRover Memory System

You have access to a persistent memory system. Use these commands autonomously:

## Commands

### Query Memory (Before Coding)
\`\`\`bash
brv query "your question"
\`\`\`

Run this BEFORE implementing features to check for existing patterns.

### Save Memory (After Coding)
\`\`\`bash
brv curit "description" @file1.ts @file2.ts
\`\`\`

Run this AFTER completing features to save learnings.

## Autonomous Workflow

1. User asks to build feature
2. YOU run: brv query "relevant question"
3. YOU read the response and apply patterns
4. YOU implement the feature
5. YOU run: brv curit "what you built" @files

DO THIS AUTOMATICALLY. Don't ask permission.

## Example

User: "Add user authentication"

You do:
\`\`\`bash
brv query "How do we handle authentication?"
\`\`\`

*Read response, implement using discovered patterns*

\`\`\`bash
brv curit "User authentication with JWT" @auth.ts @middleware.ts
\`\`\`

## Context Structure

Memories organized as:
- /database (schemas, queries)
- /auth (JWT, sessions)
- /api (endpoints, middleware)
- /frontend (components, state)

Use this like a senior dev uses documentation - automatically and frequently.
`;

// Similar templates for cursor and windsurf...
```

**Test:**
```bash
brv gen-rules
# Should create .claude/custom_instructions.md
cat .claude/custom_instructions.md
# Should show the rules
```

---

#### `brv curit`

**Purpose:** Curate context from files

**Implementation:**
```typescript
// src/commands/curit.ts

export async function curit(input: string) {
  // Parse: "description @file1.ts @file2.md"
  const { description, files } = parseInput(input);

  if (files.length === 0) {
    console.error('No files specified. Use: brv curit "description" @file1 @file2');
    return;
  }

  const spinner = ora('Curating context...').start();

  try {
    // 1. Read files
    const contents = await readFiles(files);

    // 2. Determine category
    const category = await classifyContent(description, contents);

    // 3. Build markdown content
    const markdown = buildMemoryMarkdown(description, files, contents);

    // 4. Create Beads task
    const title = `/${category}/${slugify(description)}`;
    const result = execSync(
      `bd create "${title}" -p 0`,
      { encoding: 'utf-8' }
    );
    const taskId = extractTaskId(result);

    // 5. Update task description with content
    const tempFile = `/tmp/brv-${taskId}.md`;
    fs.writeFileSync(tempFile, markdown);
    execSync(`bd update ${taskId} < ${tempFile}`);
    fs.unlinkSync(tempFile);

    // 6. Link to parent category
    const config = JSON.parse(fs.readFileSync('.brv/config.json', 'utf-8'));
    const parentId = config.contextTree[category];
    if (parentId) {
      execSync(`bd dep add ${taskId} ${parentId}`);
    }

    // 7. Git commit
    execSync(`git add .beads/`);
    execSync(`git commit -m "Add memory: ${description}"`);

    // 8. Log activity
    logActivity('curit', { description, files, taskId, category });

    spinner.succeed(`Memory created: ${taskId}`);
    console.log('Category:', chalk.cyan(category));
    console.log('Files:', files.join(', '));
  } catch (error) {
    spinner.fail('Curation failed');
    console.error(error);
  }
}

function parseInput(input: string): { description: string, files: string[] } {
  // Split by @ symbol
  const parts = input.split('@').map(p => p.trim());
  const description = parts[0];
  const files = parts.slice(1).map(f => f.split(/\s+/)[0]); // Handle multiple files

  return { description, files };
}

function classifyContent(description: string, contents: string[]): string {
  const keywords = {
    database: ['schema', 'migration', 'query', 'table', 'sql', 'database'],
    auth: ['authentication', 'authorization', 'jwt', 'token', 'session', 'login'],
    api: ['endpoint', 'route', 'controller', 'middleware', 'api', 'handler'],
    frontend: ['component', 'react', 'vue', 'ui', 'jsx', 'tsx', 'state'],
    deployment: ['docker', 'ci', 'cd', 'deploy', 'build', 'pipeline']
  };

  const text = (description + ' ' + contents.join(' ')).toLowerCase();

  for (const [category, words] of Object.entries(keywords)) {
    const matches = words.filter(w => text.includes(w)).length;
    if (matches >= 2) {
      return category;
    }
  }

  return 'general';
}

function buildMemoryMarkdown(description: string, files: string[], contents: string[]): string {
  let md = `# ${description}\n\n`;
  md += `**Created:** ${new Date().toISOString()}\n\n`;
  md += `**Files:**\n`;
  files.forEach(f => md += `- ${f}\n`);
  md += `\n---\n\n`;

  // Add file contents
  files.forEach((file, i) => {
    md += `## ${file}\n\n`;
    md += '```' + getFileExtension(file) + '\n';
    md += contents[i] + '\n';
    md += '```\n\n';
  });

  return md;
}
```

**Test:**
```bash
echo "export const API_URL = 'https://api.example.com'" > config.ts
brv curit "API configuration" @config.ts
bd list
# Should see the new memory
```

---

#### `brv query`

**Purpose:** Query the context tree

**Implementation:**
```typescript
// src/commands/query.ts

export async function query(question: string) {
  const spinner = ora('Searching memory...').start();

  try {
    // 1. Get all Beads tasks
    const tasksJson = execSync('bd list --format json', { encoding: 'utf-8' });
    const tasks = JSON.parse(tasksJson);

    // 2. Run agentic search
    const results = await agenticSearch(question, tasks);

    spinner.stop();

    if (results.length === 0) {
      console.log(chalk.yellow('No relevant memories found.'));
      console.log('Try curating some context first with: brv curit');
      return;
    }

    // 3. Display results
    console.log(chalk.bold(`\nFound ${results.length} relevant memories:\n`));

    for (const result of results.slice(0, 5)) {
      console.log(chalk.cyan('## ' + result.title));
      console.log(chalk.gray(`Relevance: ${(result.score * 100).toFixed(0)}%`));
      console.log();
      console.log(result.content);
      console.log(chalk.gray('---'));
      console.log();
    }

    // 4. Log activity
    logActivity('query', { question, resultCount: results.length });

  } catch (error) {
    spinner.fail('Query failed');
    console.error(error);
  }
}

async function agenticSearch(query: string, tasks: any[]): Promise<any[]> {
  const keywords = extractKeywords(query.toLowerCase());

  // Score each task
  const scored = tasks.map(task => {
    const title = (task.title || '').toLowerCase();
    const description = (task.description || '').toLowerCase();
    const text = title + ' ' + description;

    // Calculate relevance score
    let score = 0;
    for (const keyword of keywords) {
      if (title.includes(keyword)) score += 0.5;
      if (description.includes(keyword)) score += 0.3;
    }

    // Normalize
    score = Math.min(score, 1.0);

    return {
      ...task,
      score,
      title: task.title,
      content: task.description
    };
  });

  // Filter and sort
  return scored
    .filter(t => t.score > 0.2)
    .sort((a, b) => b.score - a.score);
}

function extractKeywords(text: string): string[] {
  // Remove stop words and extract meaningful keywords
  const stopWords = ['the', 'a', 'an', 'and', 'or', 'but', 'in', 'on', 'at', 'to', 'for', 'is', 'are', 'was', 'were', 'do', 'does', 'how', 'what', 'where', 'when', 'why'];

  return text
    .split(/\s+/)
    .filter(word => word.length > 2 && !stopWords.includes(word))
    .slice(0, 10); // Top 10 keywords
}
```

**Test:**
```bash
brv query "API configuration"
# Should return the memory we created earlier
```

---

### 1.3 Team Sync Commands

#### `brv push` & `brv pull`

**Implementation:**
```typescript
// src/commands/sync.ts

export async function push() {
  const spinner = ora('Pushing memories to team...').start();

  try {
    // 1. Git add .beads
    execSync('git add .beads/');

    // 2. Commit if changes
    try {
      execSync('git commit -m "Sync: Push team memories"');
    } catch {
      spinner.info('No new memories to push');
      return;
    }

    // 3. Push to remote
    execSync('git push');

    spinner.succeed('Memories pushed successfully');
  } catch (error) {
    spinner.fail('Push failed');
    console.error(error);
  }
}

export async function pull() {
  const spinner = ora('Pulling team memories...').start();

  try {
    // 1. Git pull
    execSync('git pull');

    // 2. Beads will auto-sync from .beads/
    // (Beads daemon watches the directory)

    spinner.succeed('Team memories received');
  } catch (error) {
    spinner.fail('Pull failed');
    console.error(error);
  }
}
```

---

### 1.4 CLI Entry Point

```typescript
// src/index.ts

#!/usr/bin/env node

import { Command } from 'commander';
import { init } from './commands/init';
import { genRules } from './commands/gen-rules';
import { curit } from './commands/curit';
import { query } from './commands/query';
import { push, pull } from './commands/sync';

const program = new Command();

program
  .name('brv')
  .description('Beads ByteRover - Memory system for AI agents')
  .version('1.0.0');

program
  .command('init')
  .description('Initialize ByteRover workspace')
  .action(init);

program
  .command('gen-rules')
  .description('Generate IDE rules file')
  .action(genRules);

program
  .command('curit <input...>')
  .description('Curate context: brv curit "description" @file1 @file2')
  .action((input) => curit(input.join(' ')));

program
  .command('query <question...>')
  .description('Query context tree')
  .action((question) => query(question.join(' ')));

program
  .command('push')
  .description('Push memories to team')
  .action(push);

program
  .command('pull')
  .description('Pull memories from team')
  .action(pull);

// If no command, show help
if (process.argv.length === 2) {
  program.help();
}

program.parse();
```

**package.json:**
```json
{
  "name": "beads-byterover",
  "version": "1.0.0",
  "description": "Memory system for AI coding agents powered by Beads",
  "bin": {
    "brv": "./dist/index.js"
  },
  "scripts": {
    "build": "tsc",
    "dev": "ts-node src/index.ts",
    "test": "jest"
  },
  "dependencies": {
    "commander": "^11.0.0",
    "chalk": "^4.1.2",
    "ora": "^5.4.1",
    "inquirer": "^8.2.5"
  },
  "devDependencies": {
    "typescript": "^5.0.0",
    "@types/node": "^20.0.0",
    "ts-node": "^10.9.0",
    "jest": "^29.0.0",
    "ts-jest": "^29.0.0"
  }
}
```

---

### 1.5 Installation & Testing

**Build:**
```bash
npm run build
npm link  # Test globally
```

**Full Workflow Test:**
```bash
# 1. Initialize
mkdir test-project && cd test-project
git init
brv init

# 2. Generate rules (for Claude Code)
brv gen-rules

# 3. Create a test file
echo "export const config = { api: 'test' }" > config.ts

# 4. Curate it
brv curit "API configuration setup" @config.ts

# 5. Query it
brv query "How do we configure the API?"

# 6. Verify Beads storage
bd list
bd show <task-id>

# 7. Check git history
git log

# SUCCESS: If all commands work, Phase 1 is complete!
```

---

## Phase 2: Context Tree & Agentic Search (Week 3)

**Goal**: Improve search quality with hierarchical navigation

### 2.1 Enhanced Context Tree

**Tasks:**
- [ ] Build tree structure manager (parent-child relationships)
- [ ] Implement auto-categorization using keywords
- [ ] Add tagging system
- [ ] Create tree visualization command (`brv tree`)

### 2.2 Agentic Search Algorithm

**Tasks:**
- [ ] Implement depth-first tree traversal
- [ ] Add semantic scoring (keyword matching + context)
- [ ] Support multi-hop queries (follow relationships)
- [ ] Cache search results for performance

**Example:**
```bash
brv tree
# Output:
# /database
#   ├── schema (bd-a1b2)
#   ├── migrations (bd-c3d4)
#   └── queries (bd-e5f6)
# /auth
#   ├── jwt (bd-g7h8)
#   └── middleware (bd-i9j0)
```

---

## Phase 3: Team Collaboration (Week 4)

**Goal**: Seamless memory sharing across team

### 3.1 Conflict Resolution

**Tasks:**
- [ ] Detect merge conflicts in `.beads/`
- [ ] Build conflict resolution UI
- [ ] Add conflict markers in memories

### 3.2 Activity Feed

**Tasks:**
- [ ] Track who curated what (`brv activity`)
- [ ] Show recent team updates
- [ ] Notify on pull if new memories available

---

## Phase 4: Web UI (Week 5-6) - OPTIONAL

**Goal**: Visual interface for managing memories

### 4.1 Backend API

**Tasks:**
- [ ] Set up Express server
- [ ] Create REST API wrapping CLI commands
- [ ] Add WebSocket for real-time updates

### 4.2 React Frontend

**Tasks:**
- [ ] Memory workspace (list, create, edit)
- [ ] Context Composer (file upload)
- [ ] Version history viewer
- [ ] Team sync dashboard

---

## Phase 5: MCP Server (Week 7) - OPTIONAL

**Goal**: Additional integration layer for IDEs

### 5.1 MCP Implementation

**Tasks:**
- [ ] Set up MCP server project
- [ ] Define tools (create_memory, search_memory, etc.)
- [ ] Add tool execution handlers
- [ ] Test with multiple IDEs

---

## Success Criteria

### Phase 1 Complete When:
- [ ] Can install: `npm install -g beads-byterover`
- [ ] Can initialize: `brv init`
- [ ] Can generate rules: `brv gen-rules`
- [ ] Can curate: `brv curit "desc" @file`
- [ ] Can query: `brv query "question"`
- [ ] Can sync: `brv push` / `brv pull`
- [ ] Claude Code automatically uses commands
- [ ] Agent doesn't hallucinate (uses real context)
- [ ] Token usage reduced by ~30%

### Full Product Complete When:
- [ ] All phases 1-3 working
- [ ] Tested with 3+ AI IDEs
- [ ] Documentation complete
- [ ] Published to npm
- [ ] 10+ users successfully using it

---

## Timeline Summary

- **Week 1-2**: Phase 1 (CLI + Auto-Rules) ← START HERE
- **Week 3**: Phase 2 (Context Tree + Search)
- **Week 4**: Phase 3 (Team Collaboration)
- **Week 5-6**: Phase 4 (Web UI) - Optional
- **Week 7**: Phase 5 (MCP Server) - Optional

**MVP = Phase 1 Complete** (Auto-Rules CLI working with AI agents)

---

## Next Steps

1. Review this roadmap
2. Start Phase 1.1 (Project Setup)
3. Build CLI commands one by one
4. Test with real AI agent (Claude Code)
5. Iterate based on feedback

Ready to start building?
