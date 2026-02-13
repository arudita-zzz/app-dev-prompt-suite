# Task Decomposition

Break down the research topic into focused investigation tasks.

## Procedure

### 1. Analyze Research Topic
- Identify the core question and its scope
- Extract **research dimensions** (distinct perspectives/concerns to investigate)
- Number each dimension: D1, D2, ...

### 2. Design Investigation Tasks
Create 3-8 tasks that collectively cover all dimensions. For each task:

```markdown
# {task_id}: {title}

- **method**: {web-research | codebase-analysis | comparative | synthesis-subtask}
- **covers_dimensions**: {comma-separated dimension numbers}

## Question
{The specific question this task must answer}

## Guidance
{Specific instructions, search terms, or focus areas}
```

Task design principles:
- Each task answers ONE specific question
- Order tasks so earlier ones inform later ones (serial execution)
- Place broad/foundational tasks first, specialized/synthesis tasks later
- Every dimension must be covered by at least one task
- Use `synthesis-subtask` for tasks that integrate findings from prior tasks

### 3. Save Files
- Save each task definition: `tasks/{task_id}_definition.md`
- Save `research_context.md`:
  ```markdown
  # Research Context
  ## Topic
  {research topic as stated by user}
  ## Dimensions
  - D1: {description}
  - D2: {description}
  ...
  ```
- Save `task_order.txt`: one task ID per line, in execution order

### 4. Present to User
- Use document-summarizer agent (max 30 lines) to summarize the task list
- Display the summary

### 5. Get Approval
- AskUserQuestion:
  - Approve and start investigation
  - Modify task scope or questions
  - Add or remove tasks
  - Type Anything
