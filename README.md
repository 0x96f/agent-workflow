# Agents and skills

A collection of agents and skills I use in my development and documentation workflows with Codex and Claude Code.

Agents handle specific jobs, such as finding code, planning changes, or reviewing a patch. Skills coordinate those agents through a larger task.

## Agents

Each agent has a definition for [Codex](agents/codex/) and [Claude Code](agents/claude/).

| Name | Description |
| --- | --- |
| `explorer` | Finds relevant files, symbols, and callers. Returns a summary under 200 words with code references, without changing files. |
| `planner` | Investigates a fix or feature and returns a plan with acceptance criteria, ordered changes, validation, and risks. Does not edit files. |
| `fixer` | Makes the smallest correct patch for an identified issue and runs focused checks when practical. |
| `checker` | Reviews a completed patch and its callers for regressions. Reports findings, checks performed, and verification gaps without editing source files. |
| `test-writer` | Adds and runs focused tests for changed behavior, regressions, edge cases, and failure paths. |
| `docs-maintainer` | Creates and updates documentation grounded in the code, including READMEs, guides, API references, architecture docs, and runbooks. |
| `docs-reviewer` | Checks documentation against the implementation for accuracy, missing steps, broken links, and usable examples. Reports findings without editing files. |
| `migration-planner` | Plans dependency upgrades, compatibility changes, and larger refactors, including affected files, ordered steps, validation, and rollback options. Does not edit files. |

## Skills

The same skill definitions work with both clients.

| Name | Description |
| --- | --- |
| [dev-workflow](skills/dev-workflow/SKILL.md) | Coordinates agents for substantial bugs, features, and migrations. Selects the needed roles, assigns file ownership, sequences dependent work, and arranges validation and patch review. |
| [docs-workflow](skills/docs-workflow/SKILL.md) | Coordinates research, writing, and review to create or substantially revise repository documentation. Checks the result against the implementation and the reader's task. |

## Installation

Requires Bash on macOS or Linux. Run the installer from this repository for interactive client and scope selection:

```sh
./install.sh
```

Or choose explicitly:

```sh
# Install for both clients globally
./install.sh --agent all --global

# Install for Codex in the current directory
./install.sh --agent codex --local

# Install for Claude Code in an existing project
./install.sh --agent claude --local "/path/to/my project"
```

The installer copies all agents and skills for the selected clients. With flags, the defaults are both clients and local scope. Local installs use the current directory unless a path follows `--local`.

| Client | Global destination | Local destination |
| --- | --- | --- |
| Codex | `~/.codex/agents/` and `~/.codex/skills/` | `<project>/.codex/agents/` and `<project>/.codex/skills/` |
| Claude Code | `~/.claude/agents/` and `~/.claude/skills/` | `<project>/.claude/agents/` and `<project>/.claude/skills/` |

Global installs respect `CODEX_HOME` and `CLAUDE_CONFIG_DIR`. The installer skips identical content and backs up changed files or folders as `.bak.<timestamp>.<pid>`. Restart the selected clients after installation. Run `./install.sh --help` for usage.

## Usage

Ask your client to delegate to an agent by name:

```text
Use planner to plan a fix for duplicate submissions when Save is clicked twice.
```

For a coordinated workflow, invoke a skill. In Codex:

```text
Use $dev-workflow to fix duplicate submissions when Save is clicked twice.
Use $docs-workflow to create an onboarding guide based on this repository's setup and test commands.
```

In Claude Code, use `/dev-workflow` or `/docs-workflow` followed by the task. Agents can also be used independently of the skills.

## Customization and removal

Edit agent instructions and model choices in `agents/codex/*.toml` and `agents/claude/*.md`. Choose models available to your account.

Add skills at `skills/<skill-name>/SKILL.md`, with supporting files in the same folder. The installer discovers each immediate subfolder containing `SKILL.md` and copies the entire folder. Re-run it after changing the sources to update installed copies.

To remove an installation, delete the installed agent files and skill folders. Restore adjacent `.bak.*` backups if needed. Review local configuration changes before committing them.
