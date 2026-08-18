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

# Rust stays on rustup rather than mise: both want to own the toolchain, and
# rustup wins on component management. Omarchy makes the same exception.
_path_prepend "$HOME/.cargo/bin"

# bun itself comes from mise, but packages installed with `bun install -g`
# land here rather than under mise's prefix, so this stays on PATH.
export BUN_INSTALL="$HOME/.bun"
_path_prepend "$BUN_INSTALL/bin"

export GPG_TTY=$(tty)
export EDITOR="nvim"

export PATH
