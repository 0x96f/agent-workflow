---
name: docs-workflow
description: Create or substantially revise repository documentation using research, writing, and review subagents. Use for READMEs, onboarding guides, tutorials, API references, architecture docs, and runbooks grounded in the codebase.
---

Delegate documentation work to explorer, docs-maintainer, and docs-reviewer
as needed. Keep scope, integration, and the final response in the parent.
Handle small wording fixes directly. Preserve configured agent models and
reasoning settings.

## Establish scope

Identify the intended reader, the task the documentation should help them
complete, and the requested output. Infer these from the request and existing
docs where possible. Ask only when missing information changes the content.
Follow the repository's documentation structure and conventions. Prefer
updating the existing source of truth over creating duplicate guides.

For a documentation plan or outline request, return that deliverable and stop.
For a request to write docs, continue through drafting and review.

## Gather evidence

Use explorer when relevant code or behavior is unclear. Give each explorer a
bounded question about implementation, configuration, public interfaces,
tests, or existing docs. Request concise findings with file references and
unresolved questions. Parallelize independent searches when useful.

Verify findings before handing them to the writer. Distinguish implemented
behavior from proposals. Use current official documentation for external,
version-specific claims when needed. Do not invent commands, defaults,
supported behavior, or successful validation.

## Write

Give docs-maintainer the audience, deliverables, evidence, and exact file
ownership. It may create new documentation and update affected navigation
or examples within that scope. Tell it the workspace is shared and to
preserve other edits. Keep production code changes outside this task.

Include prerequisites, concrete examples, and expected results where they
help the reader complete the task. Match detail to the requested document:
explain component relationships in architecture docs, parameters and errors
in API references, and diagnosis and recovery in runbooks. Avoid sections
that add no useful information.

Split writing across agents only for independent documents with separate
file ownership. Assign shared indexes or navigation to one owner. Keep
cross-document terminology and links consistent during integration.

## Review and finish

After drafting, ask docs-reviewer to compare the documentation with the
implementation and assess whether the intended reader can follow it.
Provide the audience, scope, and changed paths. Request concrete findings
with file references, checks performed, and verification gaps.

Have docs-maintainer address actionable findings. Run existing documentation
checks and safe examples when practical. Do not execute destructive commands
or change external state merely to verify a documented procedure. Report
which examples were executed and which were only inspected.

Recheck affected content after corrections. Summarize created or updated
documents, validation results, and unresolved factual gaps.

Subagents should perform their assigned task rather than restart this
workflow. If a role is unavailable, perform its work in the parent within
the same constraints and disclose the fallback.
