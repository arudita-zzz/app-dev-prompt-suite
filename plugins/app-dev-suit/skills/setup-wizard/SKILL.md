---
name: setup-wizard
description: Interactive configuration wizard to set up app-dev-suit
argument-hint: none
allowed-tools: Read, Write, Glob, Bash(mkdir)
---

Interactive wizard to generate a customized `config.yaml` based on user preferences.

## Steps

### 0. Welcome
Display welcome message. If `.claude/config.yaml` exists, AskUserQuestion: backup+overwrite / cancel.

### 1. Project Type
AskUserQuestion: Android App / Web Application / Backend Service / Multi-platform
Sets defaults for docs dir, quality thresholds.

### 2. Team Size
AskUserQuestion: Solo Developer / Small Team (2-5) / Medium Team (6-15) / Large Team (15+)
Affects quality gate strictness and documentation verbosity.

### 3. Template System
- Use subtask design templates? (Yes / No)
- If yes: select sections (Overview, Technical Approach, Dependencies, Test Strategy)
- Scaling strategy for 20+ subtasks? (Grouping / Batch Design / Disable)

### 4. Quality Thresholds
AskUserQuestion: Use defaults / Customize
If customize: walk through each phase's thresholds with preset options.

### 5. Document Management
- Output dir (default: `.claude/claudeRes/docs`)
- Naming pattern (date-based / type-based / simple)
- Hierarchical structure? (Yes / No)

### 6. Task Naming
- JIRA integration? (Enabled / Disabled); if enabled: require ID? custom pattern?
- Valid task types (defaults / add custom)

### 7. Agent Configuration
AskUserQuestion: Use specialized agents? (Yes / No)
Show agent assignments (poc-expert, tdd-implementer, web-researcher, document-summarizer, explore).

### 8. Metrics
- Enable quality metrics? (Yes / No)
- Enable checklists? (Yes / No)
- Metric scope? (All / Essential only / Custom)

### 9. Generate config.yaml
Use `config-template.md` as reference. Write to `.claude/config.yaml`.
Display summary of key settings and next steps.

### 10. Completion
Display completion message with quick-start guide.
