## Editing Guardrails

- Prefer surgical edits.
- Make the smallest possible diff to resolve the requested issue.
- Never rewrite an entire file unless explicitly requested.
- Never remove existing comments/docstrings unless they're made obsolete by your changes.
- Never change unrelated formatting/import ordering/style in touched files.
- If planned edits exceed 1 file or ~30 lines, ask for confirmation first.
- Prefer patching specific lines over refactors, unless explicitly requested.
- If a fix attempt fails, keep previous file contents intact and propose the next minimal patch.
- In final output, provide a concise per-file change summary and line count changed.

## Python Style (Project-Specific)

- Use explicit type hints for all functions, methods, and return values.
- Use Sphinx-style docstrings for non-trivial functions, using `:param ...` and `:return:`.
- Use unit suffixes for dimensioned values such as `_m`, `_s`, `_rad`, `_radps`, `_hz`, and `_mps`.
- Keep ROS callback naming consistent with `_cb` suffix.
- Prefer early returns in callbacks and helpers to avoid deep nesting.
- Keep helper methods private (`_name`) and single-purpose.
- Preserve existing comments/docstrings; only modify them when task-relevant or requested.
