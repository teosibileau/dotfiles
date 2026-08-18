# Compiler flags for building native Python extensions: psycopg2 needs libpq,
# lxml needs libxml2, pyzbar needs zbar, PyQt5 needs qt@5.
#
# These are unaffected by mise, which changes how the interpreter is installed
# rather than how wheels are built. Pairs with the commented-out library lines
# in the Brewfile: uncomment there, and this picks them up automatically.

# Rebuilt from scratch each time rather than prepended to. These used to
# accumulate: every nested shell added another copy of every flag, and one of
# the old lines joined them with ':' instead of a space, so the value drifted
# into something no compiler would parse. ~/.zshrc.local loads later and can
# still override.
LDFLAGS=""
CPPFLAGS=""

_brew_lib_flags() {
  local prefix="/opt/homebrew/opt/$1"
  [ -d "$prefix" ] || return 0
  _path_prepend "$prefix/bin"
  LDFLAGS="${LDFLAGS:+$LDFLAGS }-L$prefix/lib"
  CPPFLAGS="${CPPFLAGS:+$CPPFLAGS }-I$prefix/include"
}

for _lib in qt@5 libxml2 libpq zbar; do
  _brew_lib_flags "$_lib"
done
unset _lib

# zbar needs a runtime search path too, not just link-time flags. Guarded
# against re-adding itself in nested shells, same reason as the flags above.
if [ -d "/opt/homebrew/opt/zbar/lib" ]; then
  case ":$DYLD_LIBRARY_PATH:" in
    *":/opt/homebrew/opt/zbar/lib:"*) ;;
    *) export DYLD_LIBRARY_PATH="/opt/homebrew/opt/zbar/lib${DYLD_LIBRARY_PATH:+:$DYLD_LIBRARY_PATH}" ;;
  esac
fi

export PATH LDFLAGS CPPFLAGS
