---
name: setup-wizard
description: Interactive configuration wizard to set up app-dev-suite
argument-hint: none
allowed-tools: Read, Write, Glob, Bash(mkdir)
---

Interactive wizard to generate `config.yaml` with sensible defaults.
Convention over Configuration — only asks what truly varies per project.

## Steps

### 0. Welcome
Display welcome message. If `.claude/config.yaml` exists, AskUserQuestion: Backup and overwrite / Cancel.

### 1. Document Language
AskUserQuestion: Auto-detect (Recommended) / English / Japanese / Type Anything
Default "auto" detects from feature spec or user's language.

### 2. JIRA Integration
AskUserQuestion: Enabled / Disabled
If Enabled → AskUserQuestion: Require JIRA ID? Yes / No

### 3. Generate config.yaml
1. Read `config-template.md` and substitute answers from Steps 1-2.
2. Create `.claude/claudeRes/` directory if not exists.
3. Write to `.claude/config.yaml`.
4. Display summary of key settings.
5. Note: "For detailed customization, edit config.yaml directly. See comments in config.default.yaml for all options."

### 4. Completion
Display completion message with quick-start guide:
- `feasibility-study` — Analyze feasibility of your feature
- `solution-design` — Design solution and break down into subtasks
- `implementation` — Implement subtasks with TDD
