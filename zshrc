# Loader. The real configuration lives in zsh/, split by concern.
#
# Load order is load-bearing, which is why the fragments are numbered and
# sourced explicitly rather than globbed:
#
#   00-env           PATH, EDITOR, GPG_TTY. Everything below depends on it.
#   05-native-build  appends to LDFLAGS/CPPFLAGS set in 00.
#   10-shell         touches fpath, which must happen before compinit.
#   20-antigen       runs compinit via `antigen apply`.
#   30-aliases       plain aliases.
#   40-functions/    globbed: functions have no ordering constraint.
#   50-init          starship, which must follow `antigen apply`.

DOTFILES="${DOTFILES:-$HOME/dotfiles}"

source "$DOTFILES/zsh/00-env.zsh"
source "$DOTFILES/zsh/05-native-build.zsh"
source "$DOTFILES/zsh/10-shell.zsh"
source "$DOTFILES/zsh/20-antigen.zsh"
source "$DOTFILES/zsh/30-aliases.zsh"

for _fn in "$DOTFILES"/zsh/40-functions/*.zsh(N); do
  source "$_fn"
done
unset _fn

source "$DOTFILES/zsh/50-init.zsh"

# Machine-local secrets and overrides, never committed. Sourced last so it can
# actually override what the fragments above set.
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# Machine-specific additions go below this line. Tool installers that append to
# ~/.zshrc land here, and show up in `git status` rather than being lost.
