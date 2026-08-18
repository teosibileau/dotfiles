# Aliases only. Anything taking arguments or needing logic is a function, in
# 40-functions/.

#   Git
alias gln='git --no-pager log --pretty=format:"%C(yellow)%h %Cred%ad %Cblue%an%Cgreen%d %Creset%s" --date=short -n 10'
alias gitroot='cd "$(git rev-parse --show-toplevel)"'

#   Disk and files
alias ducks='/usr/bin/du -cks * | sort -rn | head'   # biggest things here
alias dus='du -h -d 1'                               # one level, human sizes
alias df='df -h'
alias numFiles='echo $(ls -1 | wc -l)'
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'''

# `dus` rather than aliasing `du` itself. Aliasing `du` to `du -h -d 1` forces
# a depth on every call, so `du -sh somedir` exits 64 instead of working.

#   Safer defaults
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'

#   Navigation
alias cd..='cd ../'
alias ..='cd ../'
alias ...='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
alias .6='cd ../../../../../../'
alias ~="cd ~"

#   Terminal
alias c='clear'
alias which='type -a'
alias path='echo -e ${PATH//:/\\n}'
alias fix_stty='stty sane'                # restore a mangled terminal
alias cic='set completion-ignore-case On'

#   Scratch files
alias make1mb='mkfile 1m ./1MB.dat'
alias make5mb='mkfile 5m ./5MB.dat'
alias make10mb='mkfile 10m ./10MB.dat'

#   Tailscale ships its CLI inside the app bundle rather than on PATH.
[ -x "/Applications/Tailscale.app/Contents/MacOS/Tailscale" ] && \
  alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
