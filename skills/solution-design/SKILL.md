---
name: solution-design
description: Create a clear and rational solution design for TDD implementation based on the findings written in the feasibility report.
argument-hint: [-s|--source <feasibility-report-file-path>]
allowed-tools: Read, Grep, Glob, Write(.claude/claudeRes/*)
skills:
  - quality-gate
---

Create a detailed solution design for TDD implementation based on the feasibility report.

## Steps

### 0. Initialization
- Load config: see [conventions](../../conventions.md)
- Load or create metrics tracker

### 1. Source Report
- Parse `-s|--source <path>` from arguments
- If not specified: Glob for `**/*feasibility_report*.md` in output_dir, sort by mtime, present candidates to user

### 2. Previous Task Check
- TaskList: find `Feasibility Study: <task-name>`, mark completed
- If incomplete: AskUserQuestion — continue or abort

### 3. New Task
TaskCreate: `Solution Design: <task-name>`

### 4. Read Feasibility Report
- Read summary report; load details from `feasibility_details/` as needed

### 5. Initial Design
- Organize requirements
- List major implementation items
- Define high-level test cases (details deferred to implementation)
- Outline subtask overview and dependencies

### 6. Initial Design Approval
AskUserQuestion: approve / modify

### 7. Deep Codebase Investigation (parallel)
- Task 1 (Explore): Target file detailed analysis
- Task 2 (Explore): Test target analysis
- Task 3 (Explore): Dependency component analysis

### 8. Subtask Breakdown
- Split into subtasks with Mermaid precedence diagram
- Update metrics: subtask_count, dependency_depth

### 9. Solution Design Document
Save hierarchical docs:
- `{docs_dir}/{task_name}/solution_design.md` — summary (max 100 lines), format per `design-format.md`
- `{docs_dir}/{task_name}/solution_details/`:
  - `test_cases.md` — high-level test cases
  - `subtasks.md` — subtask details (see `details-format.md`)
  - `file_changes/` — per-subtask file change details

### 10. Summary Display
Use document-summarizer agent to summarize and display to user.

### 11. Approval Loop
AskUserQuestion: approve / request changes

**Additional investigation path:**
1. AskUserQuestion for focus area
2. Run appropriate agents
3. Update design document (with document update confirmation)
4. Update metrics: review_rounds
5. Return to step 11

### 12. Quality Gate
- Create solution_design checklist (via quality-gate skill)
- Display for user approval; evaluate gate

### 13. Metrics & Completion
- Save metrics report; display summary
- TaskUpdate: mark completed
- TaskCreate: `TDD Implementation: <task-name>`

## Constraints

- Docs dir: `config.documents.output_dir` (default: `.claude/claudeRes/docs`)
