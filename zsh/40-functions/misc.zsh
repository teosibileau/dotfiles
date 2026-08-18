# Small helpers that do not belong to a topic yet.

#   mcd: make a directory and cd into it
mcd() { mkdir -p "$1" && cd "$1"; }

#   mans: search a manpage for a term, with context and colour
#   Usage: mans <command> <search-term>
mans() {
  man "$1" | grep -iC2 --color=always "$2" | less
}
