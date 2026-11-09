#!/usr/bin/env bash
set -euo pipefail

source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
agent=all
scope=local
project="$PWD"

if [[ $# == 0 ]]; then
  read -r -p 'Clients [codex/claude/all] (all): ' agent
  read -r -p 'Scope [global/local] (local): ' scope
  agent="${agent:-all}"
  scope="${scope:-local}"
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    --agent) agent="${2:?--agent requires codex, claude, or all}"; shift 2 ;;
    --global) scope=global; shift ;;
    --local)
      scope=local; shift
      if [[ $# -gt 0 && "$1" != -* ]]; then project="$1"; shift; fi ;;
    -h|--help)
      echo 'Usage: ./install.sh [--agent codex|claude|all] [--global|--local [PATH]]'
      echo 'Installs all agents and skills for the selected clients.'
      echo 'No arguments: interactive. With arguments: defaults to all clients, local scope.'
      exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

case "$agent" in codex|claude|all) ;; *) echo "Invalid agent: $agent" >&2; exit 1 ;; esac
case "$scope" in global|local) ;; *) echo "Invalid scope: $scope" >&2; exit 1 ;; esac
project="$(cd "$project" && pwd)"
cd "$project"
clients=("$agent")
[[ "$agent" != all ]] || clients=(codex claude)

for client in "${clients[@]}"; do
  if [[ "$scope" == local ]]; then
    config_dir="$project/.$client"
  elif [[ "$client" == codex ]]; then
    config_dir="${CODEX_HOME:-$HOME/.codex}"
  else
    config_dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
  fi

  mkdir -p "$config_dir/agents"
  for file in "$source_dir/agents/$client/"*; do
    target="$config_dir/agents/${file##*/}"
    if cmp -s "$file" "$target"; then continue; fi
    if [[ -e "$target" || -L "$target" ]]; then
      mv "$target" "$target.bak.$(date +%Y%m%d%H%M%S).$$"
    fi
    cp "$file" "$target"
  done
  echo "Installed $client agents in $config_dir/agents"

  mkdir -p "$config_dir/skills"
  for skill in "$source_dir/skills/"*; do
    [[ -d "$skill" && -f "$skill/SKILL.md" ]] || continue
    target="$config_dir/skills/${skill##*/}"
    if [[ -d "$target" && ! -L "$target" ]] && diff -qr "$skill" "$target" >/dev/null 2>&1; then
      continue
    fi
    if [[ -e "$target" || -L "$target" ]]; then
      mv "$target" "$target.bak.$(date +%Y%m%d%H%M%S).$$"
    fi
    cp -R "$skill" "$target"
  done
  echo "Installed $client skills in $config_dir/skills"

done

echo 'Done. Restart the selected clients.'
