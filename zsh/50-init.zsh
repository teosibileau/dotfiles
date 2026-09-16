# Tool initialisation. Runs last, after antigen has applied, because starship
# must own the prompt once oh-my-zsh is loaded.
#
# Everything here is guarded, so this file is inert on a machine that has none
# of these tools rather than an error on every shell start.

# mise manages python, node, bun and ruby, plus the Python CLI tools and kamal.
# `activate` installs a precmd hook that rewrites PATH per directory, rather
# than pyenv-style shims, so `which python` resolves to a real binary. Relies
# on `unsetopt hashcmds` from 10-shell.zsh.
command -v mise >/dev/null && eval "$(mise activate zsh)"

command -v starship >/dev/null && eval "$(starship init zsh)"

# fzf key bindings: Ctrl-R history, Ctrl-T files, Alt-C cd.
command -v fzf >/dev/null && source <(fzf --zsh)

# bun's own completions, written by its installer.
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Railway CLI, installed by its own installer into ~/.railway.
[ -f "$HOME/.railway/env" ] && source "$HOME/.railway/env"
