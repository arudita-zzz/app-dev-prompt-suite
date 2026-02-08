---
name: feasibility-study
description: Read a spec document and conduct a deep feasibility study with deep codebase analysis, web research, and PoC prototyping.
argument-hint: [message]
allowed-tools: Read, Grep, Glob, Write(.claude/claudeRes/*)
skills:
  - quality-gate
---

Conduct a feasibility study based on the spec at `config.feature_spec.path` (default: `.claude/claudeRes/scripts/feature_spec.md`).

## Steps

### 0. Initialization
- Load config: see [conventions](../../conventions.md)
- Initialize metrics tracker for this task

### 1. Task Name and Output Path
- Format task name per `config.task_naming.pattern` (default: `{type}-{jira_id}-{brief_desc}`)
  - If `config.task_naming.jira.enabled`: AskUserQuestion for JIRA ID
  - If JIRA disabled: use `{type}-{brief_desc}` pattern
- Output path: `{output_dir}/{task_name}/feasibility_report.md`
- TaskCreate: `Feasibility Study: <task-name>`

### 2. Ultrathink Mode
AskUserQuestion: use ultrathink for deep analysis? (Yes / No)

### 3. Codebase & Research Investigation (parallel)
Launch parallel Task agents:
- Task 1 (Explore): Find similar implementations
- Task 2 (Explore): Investigate test patterns
- Task 3 (Explore): Identify impact scope
- Task 4 (web-research-expert): Research best practices

Merge results into comprehensive analysis. Update metrics: files_analyzed count.

### 4. Clarification
AskUserQuestion for any unclear requirements.

### 5. Solution Candidates
Build list of implementation approach candidates.

### 6. Candidate Summary
Use document-summarizer agent to create max 100-line summary of candidates.
Display to user. Update metrics: solution_candidates count.

### 7. Approach Selection
AskUserQuestion: select approach / request PoC / request additional investigation

**PoC path:**
1. AskUserQuestion: which candidates to test
2. For each: delegate to poc-feasibility-expert with hypothesis, scope, success criteria
3. Save PoC to `{docs_dir}/{task_name}/poc/poc_<N>_<name>/`
4. Update metrics: poc_count
5. Return to step 7

**Additional investigation path:**
1. AskUserQuestion for investigation focus
2. Run appropriate agents (Explore / web-research-expert / Read+Grep)
3. Save references to `{docs_dir}/{task_name}/references/`
4. Update metrics: web_research_count
5. Return to step 7

### 8. Final Report
Use document-summarizer to create max 100-line summary.
Save hierarchical docs:
- `{docs_dir}/{task_name}/feasibility_report.md` — summary (max 100 lines), format per `report-format.md`
- `{docs_dir}/{task_name}/feasibility_details/` — see `details-format.md`
  - `codebase_analysis.md`
  - `alternatives.md`
  - `poc_results.md` (if PoC conducted)

### 9. Quality Gate
- Create feasibility_study checklist (via quality-gate skill)
- Display for user approval
- Evaluate gate: pass/warn/block based on thresholds
- Block → fix issues first; Warn → confirm with user

### 10. Metrics & Completion
- Record completion timestamp and save metrics report
- Display metrics summary
- TaskUpdate: mark completed
- TaskCreate: `Solution Design: <task-name>` as next step

## Constraints

- DRY: reuse existing code
- Docs dir: `config.documents.output_dir` (default: `.claude/claudeRes/docs`)
