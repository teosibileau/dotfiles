# Plugin manager. Clones oh-my-zsh and the bundles below on first shell start,
# so a fresh machine has a slow first prompt and fast ones after.
#
# Ordering: `antigen apply` runs compinit, so anything touching fpath belongs
# in 10-shell.zsh. starship must initialise after this file, in 50-init.zsh,
# or oh-my-zsh's prompt handling wins.

if [ -f "$HOME/antigen.zsh" ]; then
  source "$HOME/antigen.zsh"

  antigen use oh-my-zsh

  antigen bundle git
  antigen bundle command-not-found
  antigen bundle zsh-users/zsh-syntax-highlighting

  # No antigen theme: starship owns prompt styling.
  antigen apply
fi
