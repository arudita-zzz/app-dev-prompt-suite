# Codebase & Research Investigation

## If `--research` was provided

A deep-research report already exists at `research_report_path`. Skip the standard parallel investigation:

1. Read the research report
2. Assess whether codebase-specific information is sufficient
3. If codebase coverage is lacking, launch **only** the codebase-investigator agent to supplement:
   - investigation_type: feasibility
   - feature_spec_path: `.claude/claudeRes/scripts/feature_spec.md` (see conventions.md)
   - docs_dir, task_name
4. Merge the research report findings with any supplemental codebase investigation

## If `--research` was NOT provided (default)

Launch 2 parallel Task agents:

1. **Task 1** (codebase-investigator agent): Codebase exploration
   - investigation_type: feasibility
   - feature_spec_path: `.claude/claudeRes/scripts/feature_spec.md` (see conventions.md)
   - docs_dir, task_name

2. **Task 2** (web-research-expert agent): Research best practices
   - Search for industry best practices, library documentation, and known solutions
   - Include version info and retrieval date in findings

Receive codebase investigation report.
Merge codebase investigation report with web research results into comprehensive analysis.
