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
    *) echo "❌ unknown option: $arg (usage: $0 [--no-brew])" >&2; exit 2 ;;
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
    echo "❌ Homebrew not found." >&2
    echo "   Install it first: https://brew.sh" >&2
    echo "   Or re-run with --no-brew to only symlink configs." >&2
    exit 1
  fi
fi

link() {
  src="$DOTFILES/$1"
  dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "$dst.pre-dotfiles"
    echo "   💾 backed up $dst -> $dst.pre-dotfiles"
  fi
  ln -sfn "$src" "$dst"
  echo "   🔗 $dst -> $src"
}

echo "🔗 Symlinking configs"
link zshrc "$HOME/.zshrc"
link antigen.zsh "$HOME/antigen.zsh"
link starship.toml "$HOME/.config/starship.toml"
link tmux.conf "$HOME/.tmux.conf"
link nvim "$HOME/.config/nvim"
# File, not dir: opencode also keeps plugins and node_modules in that directory.
link opencode.json "$HOME/.config/opencode/opencode.json"
# Template for new colima VMs, so `colima start` needs no flags.
link colima.yaml "$HOME/.colima/_templates/default.yaml"

# Brew first: later steps need the tools it provides (pipx, git, tmux, nvim).
if [ "$RUN_BREW" -eq 1 ]; then
  echo
  echo "🍺 Homebrew packages"
  brew bundle --file "$DOTFILES/Brewfile"
else
  echo
  echo "🍺 Homebrew packages: skipped (--no-brew)"
fi

# tmux plugin manager: .tmux.conf expects it at ~/.tmux/plugins/tpm
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo
  echo "   ⬇️  cloning tpm (tmux plugin manager)"
  mkdir -p "$HOME/.tmux/plugins"
  git clone -q https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# Fetch the plugins listed in tmux.conf. install_plugins needs a running
# server and skips anything already present, so this is safe to re-run.
if command -v tmux >/dev/null 2>&1; then
  echo
  echo "🖥️  tmux plugins"
  tmux start-server
  tmux source-file "$HOME/.tmux.conf" 2>/dev/null || true
  "$HOME/.tmux/plugins/tpm/bin/install_plugins"
else
  echo
  echo "🖥️  tmux plugins: skipped (tmux not found)"
fi

# Install neovim plugins now rather than on first interactive launch.
# lazy-lock.json is untracked, so a fresh clone has no pins to restore from:
# install what the config asks for, and restore pins only when they exist.
if command -v nvim >/dev/null 2>&1; then
  echo
  if [ -f "$DOTFILES/nvim/lazy-lock.json" ]; then
    echo "📝 neovim plugins (lazy restore)"
    nvim --headless "+Lazy! restore" +qa 2>&1 | tail -3 || true
  else
    echo "📝 neovim plugins (lazy install)"
    nvim --headless "+Lazy! install" +qa 2>&1 | tail -3 || true
  fi
else
  echo
  echo "📝 neovim plugins: skipped (nvim not found)"
fi

if command -v pipx >/dev/null 2>&1; then
  echo
  echo "🐍 Python CLI tools"
  installed=$(pipx list --short 2>/dev/null | cut -d' ' -f1)
  grep -v '^[[:space:]]*\(#\|$\)' "$DOTFILES/pipx-packages.txt" | while read -r pkg; do
    if echo "$installed" | grep -qix "$pkg"; then
      echo "   ✅ $pkg already installed"
    else
      echo "   ⬇️  installing $pkg"
      pipx install "$pkg"
    fi
  done
else
  echo
  echo "🐍 Python CLI tools: skipped (pipx not found)"
fi

# Container runtime. Docker Desktop and colima can both be installed at once,
# but Desktop owns /usr/local/bin/docker as a symlink into its app bundle, and
# /usr/local/bin precedes /opt/homebrew/bin in PATH, so while Desktop is present
# it shadows the brew docker CLI. Rather than fight that, detect Desktop and
# report the situation instead of changing it: removing Desktop is a decision
# for a human, not a side effect of running this script.
if command -v colima >/dev/null 2>&1; then
  echo
  echo "🐳 Container runtime"

  if [ -d "/Applications/Docker.app" ]; then
    echo "   ⚠️  Docker Desktop is installed; leaving colima stopped."
    echo "      Desktop's CLI shadows the brew one, so both would fight over"
    echo "      which daemon 'docker' talks to. To switch over:"
    echo "        colima start && docker context use colima"
    echo "      To go back:  docker context use desktop-linux"
    echo "      Once you are happy with colima, uninstall Desktop from its own"
    echo "      Troubleshoot panel so it removes its symlinks and helper."
  elif colima status >/dev/null 2>&1; then
    echo "   ✅ colima already running"
  elif colima list -j 2>/dev/null | grep -q '"name"'; then
    echo "   ▶️  starting existing colima VM"
    colima start
  else
    echo "   ⬇️  creating colima VM (cpu/memory/disk from colima.yaml)"
    colima start
  fi

  # Desktop's credential helper disappears with the app, taking registry logins
  # with it. Flag the stale setting rather than rewriting a file docker owns.
  if [ ! -d "/Applications/Docker.app" ] &&
     grep -q '"credsStore"[[:space:]]*:[[:space:]]*"desktop"' "$HOME/.docker/config.json" 2>/dev/null; then
    echo "   ⚠️  ~/.docker/config.json still uses the 'desktop' credential store,"
    echo "      which no longer exists. Set it to \"osxkeychain\" and re-run:"
    echo "        docker login registry.gitlab.com"
  fi
else
  echo
  echo "🐳 Container runtime: skipped (colima not found)"
fi

# Agent CLIs, each via its own official installer. Both self-update after
# this, so only install when the binary is missing.
echo
echo "🤖 Agent CLIs"
if [ -x "$HOME/.local/bin/claude" ] || command -v claude >/dev/null 2>&1; then
  echo "   ✅ claude already installed"
else
  echo "   ⬇️  installing claude code"
  curl -fsSL https://claude.ai/install.sh | bash
fi

if [ -x "$HOME/.opencode/bin/opencode" ] || command -v opencode >/dev/null 2>&1; then
  echo "   ✅ opencode already installed"
else
  echo "   ⬇️  installing opencode"
  curl -fsSL https://opencode.ai/install | bash
fi

echo
echo "🎉 Done. Optional next steps:"
echo "  touch ~/.zshrc.local   # machine-local secrets/overrides"
echo "  claude    # sign in"
echo "  opencode auth login"
