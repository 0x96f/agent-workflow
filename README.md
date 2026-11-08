# Subagents

Subagents for Codex and Claude Code.

| Agent             | Job                                                            |
| ----------------- | -------------------------------------------------------------- |
| explorer          | Find code and summarize in under 200 words                     |
| fixer             | Make the smallest correct patch and run focused validation     |
| checker           | Review the patch and callers, report checks and gaps           |
| test-writer       | Add focused behavior and regression tests                      |
| docs-maintainer   | Keep documentation and examples aligned with code              |
| migration-planner | Plan upgrades and refactors with validation and rollback steps |

## Install

Requires Bash on macOS or Linux. Run without arguments for interactive choices:

```sh
./install.sh
```

Or use flags. Defaults are all clients and local scope:

```sh
./install.sh --agent all --global
./install.sh --agent codex --local
./install.sh --agent claude --local "/path/to/my project"
```

Local installs target the current directory unless a path follows `--local`.
The project directory must exist. Run `./install.sh --help` for usage.

| Client      | Global destination  | Local destination           |
| ----------- | ------------------- | --------------------------- |
| Codex       | `~/.codex/agents/`  | `<project>/.codex/agents/`  |
| Claude Code | `~/.claude/agents/` | `<project>/.claude/agents/` |

Global paths respect `CODEX_HOME` and `CLAUDE_CONFIG_DIR`. The script copies the
agent files, skips identical files, and backs up changed files as
`.bak.<timestamp>.<pid>`. Re-run it after editing the source agents.

Restart your client after installation. Ask it to delegate to the agent that
fits the task. Use `explorer` to locate relevant code, `fixer` for an identified
issue, or `checker` to review a completed patch. These agents can be used
independently. The fixer reports validation results; the checker reports findings,
checks performed, and verification gaps without editing source files or running
autofix commands. Codex models must be
available to your account; change them in `agents/codex/*.toml` if needed.
Use `test-writer` for behavior coverage, `docs-maintainer` for documentation
updates, and `migration-planner` to plan a migration before implementation.
The migration planner returns a plan without editing files.
See the [OpenAI custom agent documentation](https://learn.chatgpt.com/docs/agent-configuration/subagents#custom-agents).

## Remove

Delete the installed agent files. Restore adjacent `.bak.*` files if needed.
Review local configuration changes before committing them.
