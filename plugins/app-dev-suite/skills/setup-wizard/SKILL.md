---
name: setup-wizard
description: Interactive setup wizard to initialize app-dev-suite directories
argument-hint: none
allowed-tools: Read, Write, Glob, Bash(mkdir)
---

Initialize project directories and confirm language preference.

## Steps

### 1. Create Directories
- Create `.claude/claudeRes/docs` and `.claude/claudeRes/scripts` if not exist

### 2. Language Preference
AskUserQuestion: Auto-detect (Recommended) / English / Japanese / Type Anything
- If not "auto": inform user to update the `language` row in [conventions.md](../../conventions.md)

### 3. Feature Spec Check
- Check if `.claude/claudeRes/scripts/feature_spec.md` exists
- If missing: inform user to place feature spec there before running skills

### 4. Completion
Display quick-start guide:
- `feasibility-study` — Analyze feasibility of your feature
- `solution-design` — Design solution and break down into subtasks
- `implement-tdd` — Implement subtasks with TDD
- `small-feature` — Quick all-in-one implementation
