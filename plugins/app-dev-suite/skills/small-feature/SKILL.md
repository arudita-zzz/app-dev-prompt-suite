---
name: small-feature
description: Implement feature/bugfix/tech improvement with a TDD approach
argument-hint: [message]
allowed-tools: Read, Grep, Write, Edit
---

Implement the feature spec at `config.feature_spec.path` (default: `.claude/claudeRes/scripts/feature_spec.md`) using TDD.

## Steps

### 1. Read & Investigate
- Read and understand the spec
- Investigate current implementation

### 2. Clarify
- AskUserQuestion to clarify ambiguities and finalize requirements
- If spec demands something infeasible, propose alternatives
- If web research needed: delegate to web-research-expert agent, review findings
- Re-confirm requirements with user if new questions arose

### 3. Plan & Approve
- Present implementation plan to user
- AskUserQuestion: approve / request PoC / modify
  - PoC → delegate to poc-feasibility-expert agent, show results, return to plan
- Finalize implementation items

### 4. Design Subtasks & Approve
- Split into subtasks; map dependencies (precedence diagram style)
- Save to `{docs_dir}/{task_name}/solution_design.md` (default docs_dir: `.claude/claudeRes/docs`)
- AskUserQuestion: approve / request changes
- Incorporate feedback

### 5. Branch Setup
- Propose feature branch; create or wait for user's branch
- Checkout the feature branch

### 6. Implement
Delegate to tdd-implementer agent; implement subtasks in dependency order via TDD.

### 7. Report
- Save implementation report to `{docs_dir}/{task_name}/dev_final.md`
- Append PR Description: Background / Main Changes / Notes (3-10 lines each)

## Constraints

- DRY: reuse existing code
- If TDD is overkill: inform user, get approval, then use simpler approach
- For complex unknowns: delegate to poc-feasibility-expert agent
- Document language: `config.documents.language` (see [conventions](../../conventions.md))
