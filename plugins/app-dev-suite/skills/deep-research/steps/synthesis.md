# Synthesis

Integrate all task findings into a coherent research report.

## Procedure

### 1. Load Findings
- Read `accumulated_findings.md` (all key findings)
- Read `research_context.md` (dimensions list)
- Read `adaptation_log.md` if exists (plan evolution)

### 2. Build Cross-Reference Matrix
For each research dimension:
- Identify which tasks contributed findings
- Extract consensus points (findings supported by multiple tasks)
- Flag contradictions (conflicting findings across tasks)
- Identify gaps (dimensions with insufficient coverage)

### 3. Fill Coverage Gaps
If critical gaps exist:
- Create ad-hoc task definitions for gap-filling
- Execute them via `claude -p` with the same investigator-prompt.md pattern:
  ```
  claude -p "{investigator_prompt}
  ## Research Context
  {research_context}
  ## Your Task
  {gap_task_definition}
  ## Prior Investigation Findings
  {accumulated_findings}
  ## Output
  - Full result: {result_path}
  - Key findings only: {key_findings_path}" \
    --allowedTools "Read" "Write(.claude/claudeRes/*)" "WebSearch" "WebFetch" "Grep" "Glob" \
    --max-turns 25
  ```
- Append new key findings to accumulated_findings.md

### 4. Synthesize
For deeper analysis, Read individual `{task_id}_result.md` files (the `## Detailed Findings` section) as needed. Then:
- Identify cross-cutting patterns
- Draw connections between dimensions
- Formulate actionable recommendations
- Assess overall confidence

### 5. Generate Report
Write `research_report.md` following [report format](../report-format.md).
