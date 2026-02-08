# Scaling Strategies for 20+ Subtasks

When `subtask_count` exceeds `config.quality.thresholds.solution_design.max_subtask_count` (default: 20):

## Subtask Grouping

**When:** `config.templates.scaling.enable_subtask_grouping = true`

Group related subtasks by logical unit (e.g., "Authentication", "UI Components", "Data Layer").
- Design, implement, and review per group
- Document group-level dependencies
- Common implementation approach per group

## Batch Design

**When:** `config.templates.scaling.enable_batch_design = true`

Design similar-pattern subtasks together:
- Define common approach first
- Document shared components
- Per-subtask: only variations
- Shared test strategy

## Progressive Disclosure

Always applied for large task sets:
1. Detailed design for high-priority subtasks first
2. Implement and learn
3. Design next batch incorporating learnings
4. Repeat until all subtasks complete
