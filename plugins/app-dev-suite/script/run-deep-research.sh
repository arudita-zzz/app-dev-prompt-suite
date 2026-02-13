#!/bin/bash
# Execute investigation tasks serially with adaptive re-evaluation after each task.
# Usage: run-deep-research.sh <research_dir> <skill_dir>
set -euo pipefail

RESEARCH_DIR="$1"
SKILL_DIR="$2"

TASK_ORDER="$RESEARCH_DIR/task_order.txt"
FINDINGS="$RESEARCH_DIR/accumulated_findings.md"
TASKS_DIR="$RESEARCH_DIR/tasks"
PROGRESS="$RESEARCH_DIR/progress.log"

touch "$FINDINGS"
: > "$PROGRESS"

completed=0

# Re-read task_order.txt each iteration to pick up adaptation changes
while true; do
  next_task=""
  total=$(grep -c '[^[:space:]]' "$TASK_ORDER" || echo 0)
  while IFS= read -r tid || [ -n "$tid" ]; do
    tid=$(echo "$tid" | tr -d '[:space:]')
    [ -z "$tid" ] && continue
    if [ ! -f "$TASKS_DIR/${tid}_result.md" ]; then
      next_task="$tid"
      break
    fi
  done < "$TASK_ORDER"

  [ -z "$next_task" ] && break
  completed=$((completed + 1))
  result_file="$TASKS_DIR/${next_task}_result.md"
  key_file="$TASKS_DIR/${next_task}_key_findings.md"

  # === Investigation ===
  echo "[$completed/$total] $next_task: investigating..." | tee -a "$PROGRESS"
  claude -p "$(cat "$SKILL_DIR/investigator-prompt.md")
## Research Context
$(cat "$RESEARCH_DIR/research_context.md")
## Your Task
$(cat "$TASKS_DIR/${next_task}_definition.md")
## Prior Investigation Findings
$(cat "$FINDINGS")
## Output
- Full result: $result_file
- Key findings only: $key_file" \
    --allowedTools "Read" "Write(.claude/claudeRes/*)" "WebSearch" "WebFetch" "Grep" "Glob" \
    --max-turns 25 > /dev/null 2>&1

  if [ ! -f "$result_file" ]; then
    echo "[$completed/$total] $next_task: WARN no result" | tee -a "$PROGRESS"
    continue
  fi

  # Append key findings
  if [ -f "$key_file" ]; then
    printf '\n### %s\n' "$next_task" >> "$FINDINGS"
    cat "$key_file" >> "$FINDINGS"
  fi
  echo "[$completed/$total] $next_task: done" | tee -a "$PROGRESS"

  # === Adaptation (only if tasks remain) ===
  remaining_count=0
  while IFS= read -r rid || [ -n "$rid" ]; do
    rid=$(echo "$rid" | tr -d '[:space:]')
    [ -z "$rid" ] && continue
    [ ! -f "$TASKS_DIR/${rid}_result.md" ] && remaining_count=$((remaining_count + 1))
  done < "$TASK_ORDER"

  if [ "$remaining_count" -gt 0 ]; then
    echo "[$completed/$total] adapting remaining tasks..." | tee -a "$PROGRESS"
    remaining_defs=""
    while IFS= read -r rid || [ -n "$rid" ]; do
      rid=$(echo "$rid" | tr -d '[:space:]')
      [ -z "$rid" ] && continue
      [ -f "$TASKS_DIR/${rid}_result.md" ] && continue
      [ -f "$TASKS_DIR/${rid}_definition.md" ] && \
        remaining_defs="$remaining_defs
---
$(cat "$TASKS_DIR/${rid}_definition.md")"
    done < "$TASK_ORDER"

    claude -p "$(cat "$SKILL_DIR/adaptation-prompt.md")
## Research Context
$(cat "$RESEARCH_DIR/research_context.md")
## Accumulated Findings
$(cat "$FINDINGS")
## Remaining Tasks
$remaining_defs
## Writable Files
- Task definitions: $TASKS_DIR/
- Task order: $TASK_ORDER
- Adaptation log: $RESEARCH_DIR/adaptation_log.md" \
      --allowedTools "Read" "Write(.claude/claudeRes/*)" \
      --max-turns 10 > /dev/null 2>&1

    echo "[$completed/$total] adaptation done" | tee -a "$PROGRESS"
  fi
done

echo "ALL_COMPLETE" | tee -a "$PROGRESS"
