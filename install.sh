#!/bin/sh
# Symlink dotfiles into place and install the tools they expect.
# Safe to re-run; backs up real files it would replace.
# Usage: ./install.sh [--no-brew]
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

RUN_BREW=1
for arg in "$@"; do
  case "$arg" in
    --no-brew) RUN_BREW=0 ;;
    *) echo "unknown option: $arg (usage: $0 [--no-brew])" >&2; exit 2 ;;
  esac
done

# Homebrew is a prerequisite, not something this script installs.
# Its bin dir comes from path_helper, which only runs for login shells,
# so look in the standard locations before giving up.
if [ "$RUN_BREW" -eq 1 ]; then
  if ! command -v brew >/dev/null 2>&1; then
    for candidate in /opt/homebrew/bin/brew /usr/local/bin/brew; do
      [ -x "$candidate" ] && eval "$("$candidate" shellenv)" && break
    done
  fi
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found." >&2
    echo "Install it first: https://brew.sh" >&2
    echo "Or re-run with --no-brew to only symlink configs." >&2
    exit 1
  fi
fi

link() {
  src="$DOTFILES/$1"
  dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "$dst.pre-dotfiles"
    echo "backed up $dst -> $dst.pre-dotfiles"
  fi
  ln -sfn "$src" "$dst"
  echo "linked $dst -> $src"
}

link zshrc "$HOME/.zshrc"
link antigen.zsh "$HOME/antigen.zsh"
link starship.toml "$HOME/.config/starship.toml"
link tmux.conf "$HOME/.tmux.conf"
link nvim "$HOME/.config/nvim"

# Brew first: later steps need the tools it provides (pipx, git, tmux, nvim).
if [ "$RUN_BREW" -eq 1 ]; then
  echo
  echo "running brew bundle"
  brew bundle --file "$DOTFILES/Brewfile"
else
  echo
  echo "skipping brew bundle (--no-brew)"
fi

# tmux plugin manager: .tmux.conf expects it at ~/.tmux/plugins/tpm
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo
  echo "cloning tpm (tmux plugin manager)"
  mkdir -p "$HOME/.tmux/plugins"
  git clone -q https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  echo "tpm installed; press prefix + I inside tmux to fetch plugins"
fi

if command -v pipx >/dev/null 2>&1; then
  echo
  installed=$(pipx list --short 2>/dev/null | cut -d' ' -f1)
  grep -v '^[[:space:]]*\(#\|$\)' "$DOTFILES/pipx-packages.txt" | while read -r pkg; do
    if echo "$installed" | grep -qix "$pkg"; then
      echo "pipx: $pkg already installed"
    else
      echo "pipx: installing $pkg"
      pipx install "$pkg"
    fi
  done
else
  echo
  echo "pipx not found; skipping Python CLI tools (see pipx-packages.txt)"
fi

echo
echo "Done. Optional next step:"
echo "  touch ~/.zshrc.local   # machine-local secrets/overrides"
