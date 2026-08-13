#!/bin/sh
# Symlink dotfiles into place. Safe to re-run; backs up real files it would replace.
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

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

echo
echo "Done. Optional next steps:"
echo "  brew bundle --file $DOTFILES/Brewfile   # install CLI tools"
echo "  touch ~/.zshrc.local                    # machine-local secrets/overrides"
