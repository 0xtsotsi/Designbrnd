# Thread-Based Engineering - Sequence Diagrams

## 1. Base Thread (P → R)

```mermaid
sequenceDiagram
    participant U as User
    participant A as Agent
    participant BR as ByteRover
    participant FS as File System

    Note over U,FS: BASE THREAD: Single task execution

    U->>A: PROMPT: "Create color palette for Italian restaurant"

    A->>BR: Query: "Any existing brand context?"
    BR-->>A: No prior context found

    A->>A: Analyze requirements
    A->>A: Generate color palette
    A->>FS: Write colors.json

    A-->>U: Present: Red (#DC2626) + Gold (#F59E0B) palette

    U->>U: REVIEW: Looks good!
    U->>A: Approve

    A->>BR: Curate: "Chose Red (appetizing) + Gold (premium)"
    BR-->>A: Saved as memory bd-a1b2

    Note over U,FS: Thread Complete: 1 task, 8 tool calls, 5 minutes
```

---

## 2. P-Thread (Parallel Execution)

```mermaid
sequenceDiagram
    participant U as User
    participant A1 as Agent 1
    participant A2 as Agent 2
    participant A3 as Agent 3
    participant BR as ByteRover
    participant FS as File System

    Note over U,FS: P-THREAD: 3 agents in parallel

    U->>A1: PROMPT: "Shape Homepage section"
    U->>A2: PROMPT: "Shape Menu section"
    U->>A3: PROMPT: "Shape Booking section"

    par Agent 1 Work
        A1->>BR: Query context
        A1->>FS: Write homepage/spec.md
        A1-->>U: Homepage ready
    and Agent 2 Work
        A2->>BR: Query context
        A2->>FS: Write menu/spec.md
        A2-->>U: Menu ready
    and Agent 3 Work
        A3->>BR: Query context
        A3->>FS: Write booking/spec.md
        A3-->>U: Booking ready
    end

    U->>U: REVIEW: All 3 sections
    U->>U: Approve all

    A1->>BR: Curate homepage context
    A2->>BR: Curate menu context
    A3->>BR: Curate booking context

    Note over U,FS: Thread Complete: 3 tasks, 42 tool calls, 15 minutes
    Note over U,FS: Time Saved: 60% (vs sequential 40 minutes)
```

---

## 3. C-Thread (Workflow Cluster - 4 Phases)

```mermaid
sequenceDiagram
    participant U as User
    participant DS as Design OS Agent
    participant FM as Figma MCP Agent
    participant RL as RALPH LOOP Agent
    participant RF as Reflect Agent
    participant BR as ByteRover

    Note over U,BR: C-THREAD: Chained workflow with checkpoints

    rect rgb(200, 220, 240)
        Note over U,BR: PHASE 1: Design OS (Planning)
        U->>DS: PROMPT: "Plan restaurant website"
        DS->>BR: Query: "Any existing context?"
        BR-->>DS: No prior project

        DS->>DS: Run discovery
        DS->>DS: Create product-overview.md
        DS->>DS: Create colors.json
        DS->>DS: Shape 3 sections

        DS->>BR: Curate: "Vision, colors, sections"
        DS-->>U: Phase 1 complete
        U->>U: CHECKPOINT: Review specs
        U->>DS: ✅ Approved
    end

    rect rgb(200, 240, 220)
        Note over U,BR: PHASE 2: Figma MCP (Design)
        U->>FM: PROMPT: "Design screens from specs"
        FM->>BR: Query: "Approved colors?"
        BR-->>FM: Red + Gold palette
        FM->>BR: Query: "Section specs?"
        BR-->>FM: 3 sections defined

        FM->>FM: Create component library
        FM->>FM: Design 3 screens

        FM->>BR: Curate: "Components, screens"
        FM-->>U: Phase 2 complete
        U->>U: CHECKPOINT: Review mockups
        U->>FM: ✅ Approved
    end

    rect rgb(240, 220, 240)
        Note over U,BR: PHASE 3: RALPH LOOP (Implementation)
        U->>RL: PROMPT: "Implement approved designs"
        RL->>BR: Query: "Design specifications?"
        BR-->>RL: Component library + screens
        RL->>BR: Query: "Color tokens?"
        BR-->>RL: colors.json values

        RL->>RL: Write E2E tests
        RL->>RL: Implement components
        RL->>RL: Run tests (all pass)
        RL->>RL: Verify screenshots

        RL->>BR: Curate: "Implementation details"
        RL-->>U: Phase 3 complete
        U->>U: CHECKPOINT: Review code
        U->>RL: ✅ Ship it
    end

    rect rgb(240, 200, 200)
        Note over U,BR: PHASE 4: Reflect (Learning)
        RF->>BR: Query: "All project memories"
        BR-->>RF: 23 memories across phases

        RF->>RF: Analyze patterns
        RF->>RF: Update SKILL.md files
        RF->>BR: Curate: "Learned patterns"
        RF-->>U: Learning complete (auto)
    end

    Note over U,BR: C-Thread Complete: 4 phases, 387 tool calls, 4 weeks
```

---

## 4. F-Thread (Fusion - Best of 3)

```mermaid
sequenceDiagram
    participant U as User
    participant A1 as Agent 1 (Claude)
    participant A2 as Agent 2 (Gemini)
    participant A3 as Agent 3 (GPT-4)
    participant BR as ByteRover

    Note over U,BR: F-THREAD: 3 agents, fuse best results

    U->>A1: PROMPT: "Brand strategy for Italian restaurant"
    U->>A2: PROMPT: "Brand strategy for Italian restaurant"
    U->>A3: PROMPT: "Brand strategy for Italian restaurant"

    par Agent 1 Strategy
        A1->>A1: Analyze market
        A1-->>U: Red/Gold (appetizing)
    and Agent 2 Strategy
        A2->>A2: Analyze competitors
        A2-->>U: Blue/White (modern)
    and Agent 3 Strategy
        A3->>A3: Analyze trends
        A3-->>U: Green/Brown (organic)
    end

    U->>U: REVIEW: Compare 3 strategies

    rect rgb(255, 255, 200)
        Note over U: FUSION DECISION
        U->>U: Take Red from A1 (appetizing)
        U->>U: Take Gold from A3 (premium feel)
        U->>U: Take modern typography from A2
    end

    U->>BR: Curate: "Fused brand strategy: Red+Gold+Modern"
    BR-->>U: Saved fusion rationale

    Note over U,BR: F-Thread Complete: 3 agents, best synthesis
    Note over U,BR: Higher confidence than single agent
```

---

## 5. B-Thread (Orchestrator with Sub-Agents)

```mermaid
sequenceDiagram
    participant U as User
    participant O as Orchestrator Agent
    participant S1 as Sub-Agent: Plan
    participant S2 as Sub-Agent: Build
    participant S3 as Sub-Agent: Review
    participant BR as ByteRover

    Note over U,BR: B-THREAD: Orchestrator manages sub-agents

    U->>O: PROMPT: "Build complete booking system"

    O->>BR: Query: "Project context"
    BR-->>O: Design specs + colors + sections

    O->>O: Decompose into sub-tasks

    rect rgb(220, 220, 255)
        Note over O,BR: Orchestrator runs 3 sub-agents

        O->>S1: Spawn: "Plan booking system architecture"
        S1->>BR: Query architecture patterns
        S1->>S1: Create plan
        S1->>BR: Save plan
        S1-->>O: Plan complete

        O->>S2: Spawn: "Build booking components"
        S2->>BR: Query plan
        S2->>S2: Implement 5 components
        S2->>BR: Save implementation
        S2-->>O: Build complete

        O->>S3: Spawn: "Review and test"
        S3->>BR: Query implementation
        S3->>S3: Run tests
        S3->>BR: Save test results
        S3-->>O: Review complete
    end

    O->>BR: Curate: "Booking system complete via orchestration"
    O-->>U: All done! Ready to review.

    U->>U: REVIEW: Final result only
    U->>O: ✅ Ship it

    Note over U,BR: B-Thread Complete: 1 prompt, 3 sub-threads, 84 tool calls
    Note over U,BR: User sees: P → R (simple)
    Note over U,BR: Under hood: Complex orchestration
```

---

## 6. L-Thread (Long-Running RALPH LOOP)

```mermaid
sequenceDiagram
    participant U as User
    participant A as Agent
    participant BR as ByteRover
    participant Hook as Stop Hook
    participant Tests as Test Suite

    Note over U,Tests: L-THREAD: Extended autonomous execution

    U->>A: PROMPT: "Implement full booking feature with tests"

    A->>BR: Query: "Booking specifications?"
    BR-->>A: Design specs, data model, colors

    loop 3 Hour Autonomous Loop
        rect rgb(240, 255, 240)
            Note over A,Tests: Iteration 1: Hero Section
            A->>A: Write hero.spec.ts
            A->>Tests: Run test → FAIL
            A->>A: Implement Hero component
            A->>Tests: Run test → PASS
            A->>A: Take screenshot
            A->>A: Verify visually
            A->>BR: Save: "Hero complete"
        end

        A->>Hook: Trigger: Check if done
        Hook->>Tests: Validate all tests
        Tests-->>Hook: More work remaining
        Hook-->>A: CONTINUE

        rect rgb(240, 240, 255)
            Note over A,Tests: Iteration 2: Form Section
            A->>A: Write form.spec.ts
            A->>Tests: Run test → FAIL
            A->>A: Implement Form component
            A->>Tests: Run test → PASS
            A->>A: Fix validation bug
            A->>Tests: Run test → PASS
            A->>A: Take screenshot
            A->>BR: Save: "Form complete"
        end

        A->>Hook: Trigger: Check if done
        Hook->>Tests: Validate all tests
        Tests-->>Hook: More work remaining
        Hook-->>A: CONTINUE

        Note over A,Tests: ... 8 more iterations ...

        rect rgb(255, 240, 240)
            Note over A,Tests: Iteration 10: Integration
            A->>A: Write integration.spec.ts
            A->>Tests: Run all tests → FAIL (2 tests)
            A->>A: Fix date picker bug
            A->>A: Fix z-index issue
            A->>Tests: Run all tests → PASS (all 15)
            A->>A: Take final screenshots
            A->>BR: Save: "All tests passing"
        end

        A->>Hook: Trigger: Check if done
        Hook->>Tests: Validate all tests
        Tests-->>Hook: ✅ All tests pass
        Hook-->>A: COMPLETE
    end

    A->>BR: Curate: "Booking feature complete: 15 tests, 342 tool calls"
    A-->>U: 🎉 Feature complete and verified!

    U->>U: REVIEW: Final screenshots + test report
    U->>A: ✅ Deploy to production

    Note over U,Tests: L-Thread Complete: 1 prompt → 3 hours → 342 tool calls
    Note over U,Tests: Autonomous work: 98% | Human review: 2%
```

---

## 7. Complete Workflow with ByteRover Integration

```mermaid
sequenceDiagram
    participant U as User
    participant DS as Design OS
    participant FM as Figma MCP
    participant RL as RALPH LOOP
    participant RF as Reflect
    participant BR as ByteRover
    participant Git as Git Repo

    Note over U,Git: FULL WORKFLOW: All threads + ByteRover

    rect rgb(240, 240, 240)
        Note over U,Git: INITIALIZATION
        U->>BR: brv init
        BR->>Git: Initialize .beads/
        BR-->>U: ✓ Workspace ready

        U->>BR: brv gen-rules
        BR->>BR: Detect: Claude Code
        BR->>DS: Write .claude/custom_instructions.md
        BR-->>U: ✓ Agents configured
    end

    rect rgb(220, 235, 255)
        Note over U,Git: PHASE 1: Design OS
        U->>DS: "Plan restaurant website"

        DS->>BR: Query: "existing context?"
        BR-->>DS: New project

        DS->>DS: Create specs (25 tool calls)

        DS->>BR: brv curit "Vision approved"
        DS->>BR: brv curit "Red/Gold colors"
        DS->>BR: brv curit "3 sections defined"
        BR->>Git: Commit memories

        DS-->>U: ✓ Phase 1 complete
    end

    rect rgb(220, 255, 235)
        Note over U,Git: PHASE 2: Figma MCP
        U->>FM: "Design screens from specs"

        FM->>BR: brv query "approved colors?"
        BR-->>FM: Red (#DC2626) + Gold

        FM->>BR: brv query "section specs?"
        BR-->>FM: Homepage, Menu, Booking

        FM->>FM: Create designs (67 tool calls)

        FM->>BR: brv curit "Component library"
        FM->>BR: brv curit "3 screens designed"
        FM->>BR: brv curit "Client: 'More impact'"
        BR->>Git: Commit memories

        FM-->>U: ✓ Phase 2 complete
    end

    rect rgb(255, 240, 255)
        Note over U,Git: PHASE 3: RALPH LOOP (L-Thread)
        U->>RL: "Implement approved designs"

        RL->>BR: brv query "design specs?"
        BR-->>RL: Full component specs

        RL->>BR: brv query "color tokens?"
        BR-->>RL: colors.json exact values

        loop 3 Hours Autonomous
            RL->>RL: Write tests
            RL->>RL: Implement
            RL->>RL: Verify

            RL->>BR: brv curit "Hero done"
            RL->>BR: brv curit "Form done"
            RL->>BR: brv curit "Fixed bug"
            BR->>Git: Commit memories
        end

        RL-->>U: ✓ Phase 3 complete (342 tool calls)
    end

    rect rgb(255, 235, 220)
        Note over U,Git: PHASE 4: Reflect
        RF->>BR: brv query "all project memories"
        BR-->>RF: 23 memories loaded

        RF->>RF: Analyze patterns
        RF->>RF: Update SKILL.md

        RF->>BR: brv curit "Pattern: Italian → Red"
        RF->>BR: brv curit "Pattern: Overlay 50%"
        BR->>Git: Commit learnings

        RF-->>U: ✓ Learning complete
    end

    Note over U,Git: COLLABORATION
    U->>BR: brv push
    BR->>Git: Push all memories to remote
    Git-->>U: ✓ Team can pull context

    Note over U,Git: Total: 457 tool calls, 4 weeks, $2,700 saved
```

---

## 8. P-Thread (Boris Style - 10 Agents)

```mermaid
sequenceDiagram
    participant U as User
    participant T1 as Terminal 1
    participant T2 as Terminal 2
    participant T3 as Terminal 3
    participant T4 as Terminal 4
    participant T5 as Terminal 5
    participant W1 as Web Agent 1
    participant W2 as Web Agent 2
    participant W3 as Web Agent 3
    participant W4 as Web Agent 4
    participant W5 as Web Agent 5
    participant BR as ByteRover

    Note over U,BR: BORIS STYLE: 10 agents in parallel

    rect rgb(220, 255, 255)
        Note over U,BR: Terminal Agents (In-Loop)
        U->>T1: "Build homepage"
        U->>T2: "Build menu page"
        U->>T3: "Build booking page"
        U->>T4: "Build about page"
        U->>T5: "Review all code"
    end

    rect rgb(255, 240, 255)
        Note over U,BR: Web Agents (Out-of-Loop)
        U->>W1: "Research best practices"
        U->>W2: "Generate test data"
        U->>W3: "Optimize images"
        U->>W4: "Write documentation"
        U->>W5: "Security audit"
    end

    par Terminal 1-5 Work
        T1->>BR: Query + Build + Save
        T2->>BR: Query + Build + Save
        T3->>BR: Query + Build + Save
        T4->>BR: Query + Build + Save
        T5->>BR: Query + Build + Save
    and Web 1-5 Work
        W1->>BR: Research + Save
        W2->>BR: Generate + Save
        W3->>BR: Optimize + Save
        W4->>BR: Write + Save
        W5->>BR: Audit + Save
    end

    U->>U: REVIEW: Check terminals 1-4 (pages done)
    U->>U: REVIEW: Check terminal 5 (review)
    U->>U: REVIEW: Check web agents (background work)

    Note over U,BR: 10x Compute = 10x Output
    Note over U,BR: Same 8 hour day = 10x Features
```

---

## 9. Transcript + Image Processing

```mermaid
sequenceDiagram
    participant U as User
    participant A as Agent
    participant BR as ByteRover
    participant Img as Image Analyzer
    participant TXT as Text Processor

    Note over U,TXT: PROCESSING: Transcript + Image

    U->>A: Provide: Transcript (8000 words)
    U->>A: Provide: Image (6-panel thread diagram)

    rect rgb(255, 250, 240)
        Note over A,TXT: TRANSCRIPT PROCESSING
        A->>TXT: Parse transcript
        TXT->>TXT: Extract key concepts
        TXT-->>A: 6 thread types + definitions

        A->>BR: brv curit "Base Thread: P→R pattern"
        A->>BR: brv curit "P-Thread: Parallel execution"
        A->>BR: brv curit "C-Thread: Chained phases"
        A->>BR: brv curit "F-Thread: Fusion/best-of-N"
        A->>BR: brv curit "B-Thread: Orchestrated"
        A->>BR: brv curit "L-Thread: Long-running"
    end

    rect rgb(240, 255, 250)
        Note over A,Img: IMAGE PROCESSING
        A->>Img: Analyze diagram
        Img->>Img: Extract visual patterns
        Img-->>A: 6 panels with flow diagrams

        A->>BR: brv curit "Visual: Base shows P→R"
        A->>BR: brv curit "Visual: P-Thread shows 3 parallel"
        A->>BR: brv curit "Visual: C-Thread shows chain"
        A->>BR: brv curit "Visual: F-Thread shows fusion"
        A->>BR: brv curit "Visual: B-Thread shows nesting"
        A->>BR: brv curit "Visual: L-Thread shows long chain"
    end

    rect rgb(255, 240, 255)
        Note over A,BR: SYNTHESIS
        A->>BR: brv curit "Complete framework: 6 types"
        A->>BR: brv curit "Cross-ref: Text + Visual"
        A->>BR: brv curit "Implementation: Boris uses P+L"
        A->>BR: brv curit "ROI: 10x compute = 10x output"
    end

    A-->>U: ✓ Knowledge captured in ByteRover

    Note over U,TXT: FUTURE QUERIES WORK
    U->>A: "How do I run agents in parallel?"
    A->>BR: brv query "parallel agents"
    BR-->>A: "P-Thread: Boris runs 5-10 in parallel"
    A-->>U: Full answer with context!
```

---

## 10. Improvement Metrics Over Time

```mermaid
sequenceDiagram
    participant U as User
    participant A as Agent
    participant BR as ByteRover
    participant RF as Reflect

    Note over U,RF: MEASURING IMPROVEMENT

    rect rgb(255, 240, 240)
        Note over U,RF: WEEK 1: Baseline
        U->>A: 8 hours of work
        A->>A: 1 agent, sequential
        A->>BR: 1 thread, 47 tool calls
        BR->>RF: Track: 1 thread/day
        Note over U,RF: Output: 1 feature/day
    end

    rect rgb(255, 250, 240)
        Note over U,RF: WEEK 2: Add P-Threads
        U->>A: 8 hours of work
        A->>A: 3 agents in parallel
        A->>BR: 3 threads, 124 tool calls
        BR->>RF: Track: 3 threads/day
        Note over U,RF: Output: 2.5 features/day
        Note over U,RF: Improvement: 2.5x
    end

    rect rgb(255, 255, 240)
        Note over U,RF: WEEK 3: Add L-Threads
        U->>A: 8 hours of work
        A->>A: 3 parallel + 2 overnight
        A->>BR: 5 threads, 287 tool calls
        BR->>RF: Track: 5 threads/day
        Note over U,RF: Output: 4 features/day
        Note over U,RF: Improvement: 4x
    end

    rect rgb(240, 255, 240)
        Note over U,RF: WEEK 4: Add B-Threads
        U->>A: 8 hours of work
        A->>A: Orchestrator + 10 sub-agents
        A->>BR: 1 B-thread (10 sub), 543 tool calls
        BR->>RF: Track: 11 threads/day
        Note over U,RF: Output: 7 features/day
        Note over U,RF: Improvement: 7x
    end

    rect rgb(240, 240, 255)
        Note over U,RF: WEEK 5: Optimize to Z-Threads
        U->>A: 8 hours of work
        A->>A: Maximum autonomy, minimal review
        A->>BR: 2 Z-threads (no review), 892 tool calls
        BR->>RF: Track: 15 effective threads
        Note over U,RF: Output: 10 features/day
        Note over U,RF: Improvement: 10x
    end

    RF->>U: Report: 10x improvement in 5 weeks!
    RF->>BR: brv curit "Improvement pattern documented"
```

---

## Summary

**Thread Types:**
1. **Base** - Single agent, single task (P → R)
2. **P-Thread** - Multiple agents in parallel (3-10+)
3. **C-Thread** - Chained phases with checkpoints (your workflow!)
4. **F-Thread** - Fusion of multiple agent outputs (best-of-N)
5. **B-Thread** - Orchestrated with sub-agents (nested threads)
6. **L-Thread** - Long-running autonomous (hours/days)
7. **Z-Thread** - Zero-touch, maximum trust (future state)

**ByteRover Role:**
- Stores context between ALL threads
- Enables cross-thread queries
- Provides complete audit trail
- Supports improvement tracking
- Powers Reflect learning

**Improvement Path:**
Week 1: Base threads → 1x output
Week 2: P-Threads → 2.5x output
Week 3: L-Threads → 4x output
Week 4: B-Threads → 7x output
Week 5: Z-Threads → 10x output

**Next:** Implement `brv pthread` and `brv workflow` commands! 🚀
