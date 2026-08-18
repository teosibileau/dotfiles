# Shell behaviour. History options are deliberately absent: oh-my-zsh sets them
# in 20-antigen, which loads after this file and would overwrite anything here.

# zsh caches the resolved path of every command it runs. mise rewrites PATH on
# each prompt, so a cached path can keep pointing at the old interpreter after
# a version switch until `hash -r`. Turning the cache off costs one lookup per
# command and removes the whole class of confusion. Omarchy does the same with
# `set +h` in bash, for the same reason.
unsetopt hashcmds
unsetopt hashdirs

# Completion functions installed by tools outside brew, currently sentry's.
# This must run before compinit, which oh-my-zsh calls during `antigen apply`.
# It used to sit at the very bottom of zshrc, which was too late to have any
# effect.
if [ -d "$HOME/.local/share/zsh/site-functions" ]; then
  fpath=("$HOME/.local/share/zsh/site-functions" $fpath)
fi

# Ctrl-Left and Ctrl-Right move by word.
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
