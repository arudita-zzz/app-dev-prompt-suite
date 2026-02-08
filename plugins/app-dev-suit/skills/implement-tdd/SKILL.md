---
name: implement-tdd
description: Implement feature/bugfix/tech improvement based on a solution design document with a TDD approach
argument-hint: [-s|--source <solution-design-file-path>]
allowed-tools: Read, Grep, Glob, Write, Edit
skills:
  - quality-gate
---

Implement the solution design using TDD (Red-Green-Refactor).

## Steps

### 0. Initialization
- Load config: see [conventions](../../conventions.md)
- Load metrics tracker

### 1. Source Design
- Parse `-s|--source <path>` from arguments
- If not specified: Glob for `**/*solution_design*.md` in output_dir, sort by mtime, present candidates

### 2. Previous Task Check
- TaskList: find `Solution Design: <task-name>`, mark completed
- If incomplete: AskUserQuestion — continue or abort

### 3. New Task
TaskCreate: `TDD Implementation: <task-name>`

### 4. Read Solution Design
- Read summary; load subtask details and dependencies from `solution_details/`
- AskUserQuestion if information is insufficient

### 5. Branch Setup
Propose branch name and base; create or wait for user to create. Checkout.

### 6. Subtask Implementation Loop

For each subtask (in dependency order):

**a. Detailed Design**
- Read subtask overview from `solution_details/subtasks.md`
- If needed: Explore agent for deeper file investigation
- Define detailed unit/integration test cases
- Use subtask design template (read from `solution-design/subtask-design-template.md` if config enables templates)
- **Scaling (20+ subtasks):** apply grouping or batch design per `scaling-strategies.md`
- Save: `{docs_dir}/{task_name}/solution_details/file_changes/subtask_<N>.md`
- AskUserQuestion: approve detailed design

**b. TDD Implementation**
- Delegate to tdd-implementer agent with the detailed design
- TDD cycle: Red → Green → Refactor
- Update metrics: files_changed

**c. Subtask Retrospective**
- Record design↔implementation gaps
- Log issues to `## Issues Found During Implementation`
- Quality checklist: subtask-level verification

### 7. Integration Verification
- Run all tests; confirm passing
- Run integration tests
- Update metrics: tests_added

### 8. Implementation Report
Save to `{docs_dir}/{task_name}/implementation_report.md`:
- Summary of what was implemented
- Subtask completion status
- Issues encountered and resolutions
- Append PR Description: Background / Main Changes / Notes (3-10 lines each)

### 9. Quality Gate
- Create implementation checklist (via quality-gate skill)
- Display for user approval; evaluate gate

### 10. Metrics & Completion
- Save metrics report; display summary
- TaskUpdate: mark completed

## Constraints

- TDD overkill → inform user, get approval for simpler approach
- Docs dir: `config.documents.output_dir` (default: `.claude/claudeRes/docs`)
