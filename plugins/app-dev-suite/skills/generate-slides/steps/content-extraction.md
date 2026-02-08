# Content Extraction

Extract content from phase artifacts for slide generation.

## Procedure

For each selected phase:

1. **Read summary document** — the primary report file for the phase
2. **Read detail documents** — referenced in [slide-format.md](../slide-format.md) per slide

## Per-Slide Extraction

For each slide defined in slide-format.md:
- Locate the source file and target section
- Extract content within that section
- If content exceeds `config.slides.content_max_lines_per_slide`: delegate to `document-summarizer` agent with the max line count as the limit

## Special Content Handling

### Mermaid Code Blocks
Preserve verbatim. Never summarize or modify Mermaid blocks.

### Tables
Preserve table structure. If table exceeds 8 rows: keep header + top 6 data rows + "... ({N} more rows)" footer row.

### Bullet Lists
If list exceeds `config.slides.content_max_lines_per_slide`: delegate to `document-summarizer` agent to condense.

## Phase-to-Artifact Mapping

| Phase | Summary | Details Directory |
|-------|---------|-------------------|
| feasibility | `feasibility_report.md` | `feasibility_details/` |
| design | `solution_design.md` | `solution_details/` |
| implementation | `implementation_report.md` | (inline) |
| quality | `quality_metrics.md` | — |
