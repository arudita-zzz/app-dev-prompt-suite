---
name: quality-gate
description: Manage quality checklists, metrics tracking, and phase gate decisions for the app-dev-suite workflow.
user-invocable: false
---

# Quality Gate Operations

Manage quality assurance across the three-phase workflow (feasibility → design → implementation).

For checklist template, see [quality-checklist-template.md](quality-checklist-template.md).

## Phase Checklists

### Feasibility Study
- All implementation approach candidates explored
- Risks and constraints clearly identified
- Existing codebase investigation sufficient
- Web research conducted if needed
- PoC results documented if conducted
- Recommended approach has clear justification

### Solution Design
- Subtask granularity appropriate (each 1-4 hours)
- No circular dependencies in precedence diagram
- Test cases cover all requirements
- High-level test cases defined (details deferred to implementation)
- File-level changes identified for each subtask
- Risk mitigation strategies defined

### Implementation
- All tests passing
- Code follows project conventions
- No obvious security vulnerabilities
- Documentation updated where needed
- Implementation report includes PR description

## Metrics Tracker

Initialize at start of a task, update during each phase, save at completion.

**Structure**:
```
task_name, created timestamp
phases:
  feasibility_study: files_analyzed, web_research_count, solution_candidates, poc_count, issues_found
  solution_design: subtask_count, test_case_count, dependency_depth, review_rounds, issues_found
  implementation: files_changed, tests_added, test_coverage, design_issues
```

Track metrics incrementally during each phase. Record start/completion timestamps per phase.

## Quality Gate Decision

At each phase boundary, evaluate pass/warn/block:

**Pass**: All required checklist items passed AND no threshold violations
**Warn**: Optional items failed OR metrics below recommended but above minimum
**Block**: Required items failed OR critical thresholds violated

**Thresholds** (from `config.quality.thresholds`):
- Feasibility: `min_files_analyzed` (default 10), `min_solution_candidates` (default 2)
- Design: `min_subtask_count` (default 3), `max_subtask_count` (default 20), `min_test_cases` (default 5)
- Implementation: `min_test_coverage` (default 80%), `max_files_changed` (default 30)

## Metrics Report

Save to `{docs_dir}/{task_name}/quality_metrics.md` with:
- Overall timeline (start, end, duration)
- Per-phase metrics with actual values
- Quality indicators (issue resolution rate, avg subtask size, test coverage)
