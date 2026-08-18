# Tool initialisation. Runs last, after antigen has applied, because starship
# must own the prompt once oh-my-zsh is loaded.
#
# Everything here is guarded, so this file is inert on a machine that has none
# of these tools rather than an error on every shell start.

# mise manages python, node, and ruby. `activate` installs a precmd hook that
# rewrites PATH per directory, rather than pyenv-style shims, so `which python`
# resolves to a real binary. Needs `unsetopt hashcmds` from 10-shell.zsh.
command -v mise >/dev/null && eval "$(mise activate zsh)"

command -v starship >/dev/null && eval "$(starship init zsh)"

# fzf key bindings: Ctrl-R history, Ctrl-T files, Alt-C cd.
command -v fzf >/dev/null && source <(fzf --zsh)

# ---------------------------------------------------------------------------
# Replaced by mise; see the migration plan. Deleted once mise is verified.
# ---------------------------------------------------------------------------
command -v pyenv >/dev/null && eval "$(pyenv init -)"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
# --------------------------------------------------------------------- end --
