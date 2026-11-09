---
name: dev-workflow
description: Coordinate specialized subagents for code changes that need investigation, planning, implementation, or regression review. Use for substantial bugs, features, and migrations.
---

Delegate scoped work to the available custom agents below.
Keep coordination, integration, and the final response in the parent agent.

## Choose agents

- explorer: Locate relevant code, callers, and existing tests when unclear.
- planner: Resolve substantial uncertainty about a fix or feature.
- migration-planner: Plan upgrades, compatibility changes, and migrations.
- fixer: Implement a specific, bounded change once the approach is clear.
- test-writer: Add meaningful behavior or regression coverage when needed.
- docs-maintainer: Update documentation affected by the completed change.
- checker: Review the completed patch, callers, and validation gaps.

Use only the roles needed for the task. Handle trivial changes directly.
Preserve each agent's configured model and reasoning settings.

## Coordinate work

Give each agent a concrete objective, relevant context, file ownership,
constraints, and expected result. Tell editing agents they share the
workspace and must preserve others' edits.

Parallelize independent research or edits to separate files.
Sequence work when one task depends on another's result.
Avoid simultaneous edits to the same files.

Planning agents return plans without editing. For a planning-only request,
return the plan and stop. For an implementation request, continue after
planning unless a material decision requires user input.

Keep implementation ownership in the parent when the work exceeds the
fixer's narrow role. Delegate bounded changes where useful.

After implementation, request needed tests and documentation updates.
Have checker review the completed changes. Resolve actionable findings
and rerun affected checks before reporting completion.

Subagents should follow their assigned role rather than restart this
entire workflow. If a role is unavailable, report that and perform the
work directly within the same constraints.

Report the outcome, validation results, and unresolved limitations.
