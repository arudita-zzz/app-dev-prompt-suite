> Structural reference. Adapt all headings and content to `config.documents.language`.

# Marp Slide Format

## Frontmatter

```
---
marp: true
theme: {config.slides.theme}
paginate: {config.slides.paginate}
footer: "{config.slides.footer}"
---
```

## Slide Structure

Each `---` separator creates a new slide. Maximum `config.slides.content_max_lines_per_slide` content lines per slide.

### Slide 1: Title

```
# {task_name}

**Date:** {date}
**Phases:** {included_phases}
```

### Phase 1 — Feasibility Study (conditional: feasibility artifacts exist)

**Slide 2: Requirements**
- Source: `feasibility_report.md` ## Requirements
- Max 8 bullet points

**Slide 3: Codebase Analysis**
- Source: `feasibility_details/codebase_analysis.md`
- Key findings only

**Slide 4: Candidates Comparison**
- Source: `feasibility_details/alternatives.md` ## Comparison Matrix
- Preserve table structure; condense if > 8 rows

**Slide 5: Chosen Approach & Rationale**
- Source: `feasibility_report.md` ## Chosen Approach + ## Rationale

### Phase 2 — Solution Design (conditional: solution design artifacts exist)

**Slide 6: Implementation Overview**
- Source: `solution_design.md` ## Implementation Items

**Slide 7: Subtask Breakdown**
- Source: `solution_design.md` ## Subtask List
- Numbered list

**Slide 8: Dependency Diagram**
- Source: `solution_design.md` ## Precedence Diagram
- Mermaid block: preserve verbatim

**Slide 9: Test Strategy**
- Source: `solution_details/test_cases.md`
- Condensed summary

**Slide 10: Risks**
- Source: `solution_design.md` ## Risks / Concerns

### Phase 3 — Implementation (conditional: implementation artifacts exist)

**Slide 11: Implementation Results**
- Source: `implementation_report.md`
- Summary + files changed / tests added

**Slide 12: Quality Metrics**
- Source: `quality_metrics.md`
- Preserve table structure

**Slide 13: Issues & Resolutions**
- Source: `implementation_report.md` ## Issues Found During Implementation

### Closing

**Slide 14: Summary & Next Steps**
- Aggregate key decisions across included phases
- List recommended next actions
