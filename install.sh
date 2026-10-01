#!/usr/bin/env bash
# Symlink the dotfiles into $HOME. Safe to re-run.
set -euo pipefail

src="$(dirname "$(realpath "$0")")/home"

link() {
  local target="$HOME/$1"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "skip: $target exists and is not a symlink" >&2
    return
  fi
  mkdir -p "$(dirname "$target")"
  ln -sfnv "$src/$1" "$target"
}

# Plain dotfiles go straight into ~. .config and .claude hold other state, so
# only specific entries inside them get linked.
for f in "$src"/.[!.]*; do
  name="$(basename "$f")"
  case "$name" in .config | .claude) continue ;; esac
  link "$name"
done

link .config/fish
link .config/starship.toml
link .config/Code/User/settings.json
link .config/k9s/aliases.yaml
link .config/k9s/config.yaml
link .config/gh/config.yml

link .claude/settings.json
link .claude/commands
link .claude/agents
link .claude/skills/update-openhexa-version
