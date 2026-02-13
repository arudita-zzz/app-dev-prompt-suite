# Investigation Loop

Execute the investigation script and monitor progress.

## Procedure

### 1. Launch Script

Run `script/run-deep-research.sh` via Bash with `run_in_background: true`:

```
bash {skill_dir}/script/run-deep-research.sh "{research_dir}" "{skill_dir}"
```

Where:
- `{research_dir}`: the output directory containing task_order.txt and tasks/
- `{skill_dir}`: path to `skills/deep-research/` (contains investigator-prompt.md, adaptation-prompt.md)

### 2. Wait for Completion

Use TaskOutput to wait for the background script to complete.

### 3. Verify Results

After completion:
1. Read `progress.log` — confirm `ALL_COMPLETE` is present
2. Count result files in `tasks/` vs expected task count
3. Read `adaptation_log.md` if it exists — note any plan changes
4. If any tasks show `WARN no result`, report to user during synthesis
