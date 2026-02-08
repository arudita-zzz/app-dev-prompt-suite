# app-dev-suit Conventions

## Configuration Loading

Load configuration at the start of each skill:
1. Read `.claude/config.yaml` (user config, if exists)
2. Read [default config](config.default.yaml) (bundled defaults)
3. Merge: user config overrides defaults (deep merge)
4. Resolve `output_dir` to absolute path if relative

## Document Update Confirmation

When updating existing documents, present diff format for user approval before writing:

```
=== Document Update Confirmation ===

File: {document_file_path}

Changes Summary:
- {change 1}
- {change 2}

--- Before ---
{existing content being changed}

--- After ---
{updated content}

=== End of Update Preview ===
```

Only update after user approval.

## Issue Handling

When discovering issues during any phase:
1. Add `## Issues Found During {Phase}` section to current document
2. AskUserQuestion: fix / continue / rollback
3. Record decision and rationale
