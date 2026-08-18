# Core environment. Runs first: later fragments append to PATH, LDFLAGS and
# CPPFLAGS set here, and 20-antigen expects EDITOR to already exist.

# Prepend a directory to PATH, but only if it exists and is not already there.
# The guard is why this file is safe to load on a machine missing half of it.
_path_prepend() {
  [ -d "$1" ] || return 0
  case ":$PATH:" in
    *":$1:"*) ;;
    *) PATH="$1:$PATH" ;;
  esac
}

_path_prepend "$HOME/bin"
_path_prepend "/usr/local/bin"
_path_prepend "$HOME/.local/bin"
_path_prepend "$HOME/.opencode/bin"

export GPG_TTY=$(tty)
export EDITOR="nvim"

# ---------------------------------------------------------------------------
# Runtime version managers. mise replaces all of this; see the migration plan.
# Kept working until mise is installed and verified, then deleted wholesale.
# ---------------------------------------------------------------------------
export PYENV_ROOT="$HOME/.pyenv"
_path_prepend "$PYENV_ROOT/bin"

export BUN_INSTALL="$HOME/.bun"
_path_prepend "$BUN_INSTALL/bin"

_path_prepend "$HOME/.cargo/bin"

# Ruby exists on this machine to host Kamal. Glob the gems bindir rather than
# hardcoding a version, which used to break on every ruby minor bump.
_path_prepend "/opt/homebrew/opt/ruby/bin"
for _gemdir in /opt/homebrew/lib/ruby/gems/*/bin(N); do
  _path_prepend "$_gemdir"
done
unset _gemdir
# --------------------------------------------------------------------- end --

export PATH
