---
argument-hint: [message]
description: Implement feature/bugfix/tech improvement with a TDD approach
---

Based on the spec in `.claude/claudeRes/scripts/feature_spec.md`, follow the phases below to implement via TDD.

### Phase 1 — Requirements & Research

1. Analyze the spec. Launch Explore subagent(s) to investigate the current codebase. Clarify ambiguities with the user.
2. If the spec contains infeasible requirements, propose alternatives.
3. If web research is needed, delegate to `web-research-agent` with the requirements. Review the report and re-clarify with the user if new questions arise.

### Phase 2 — Solution Design

4. Present the implementation approach to the user and get approval.
   - If the user requests a PoC, invoke `poc-feasibility-expert` subagent, then present results.
5. Finalize implementation items. Break them into subtasks and map dependencies using a precedence diagram.
6. Present the subtask list with the precedence diagram to the user and get approval.

### Phase 3 — Branch & Design Document

7. Propose a feature branch name and location. Either create it or prompt the user to create it manually, then check out.
8. Save a design document (requirements, implementation items, subtask list, precedence diagram) as a Markdown file:
   - Path: `.claude/claudeRes/docs/<YY_MM_DD>_solution_design_<name>.md` (create the directory if it does not exist)
   - Submit the document to the user for review and approval. Incorporate any revisions and confirm the final plan.

### Phase 4 — TDD Implementation

9. Hand off the approved design document to `tdd-implementer` subagent. Execute subtasks in precedence-diagram order via TDD.
10. Report completion to the user. Save a final report as `.claude/claudeRes/docs/<YY_MM_DD>_dev_final_<name>.md`.
    - Append a PR description section at the end: **Background**, **Main Changes**, **Notes** — each 3-6 lines, 10 lines max.

## Rules

- Use `poc-feasibility-expert` for uncertain or complex problems where no clear solution exists.
- If TDD is overkill for the task, inform the user and propose a simpler approach with their approval.

## Appendix: Document Update Confirmation Format

When updating an existing document, output the following format and get user approval before applying changes:

```
=== Document Update Confirmation ===

File: {document_file_path}

Changes Summary:
- {one-line description of change 1}
- {one-line description of change 2}
- {one-line description of change 3}

--- Before ---
{existing content to be changed}

--- After ---
{updated content}

=== End of Update Preview ===
```

Apply the update only after approval.
