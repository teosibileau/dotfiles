export PATH=$HOME/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/opt/homebrew/opt/libxml2/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=/opt/homebrew/opt/qt@5/bin:$PATH
export PATH=$HOME/.bun/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/4.0.0/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

export GPG_TTY=$(tty)

export EDITOR="nvim"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

export LDFLAGS="-L/opt/homebrew/opt/qt@5/lib -L/opt/homebrew/opt/libxml2/lib"
export CPPFLAGS="-I/opt/homebrew/opt/qt@5/include -I/opt/homebrew/opt/libxml2/include"
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib:$LDFLAGS"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include:$CPPFLAGS"

export DYLD_LIBRARY_PATH="/opt/homebrew/opt/zbar/lib:$DYLD_LIBRARY_PATH"
export LDFLAGS="-L/opt/homebrew/opt/zbar/lib $LDFLAGS"
export CPPFLAGS="-I/opt/homebrew/opt/zbar/include $CPPFLAGS"

command -v pyenv >/dev/null && eval "$(pyenv init -)"

source ~/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

antigen bundle zsh-users/zsh-syntax-highlighting

# antigen theme robbyrussell  # Starship handles prompt styling

antigen apply

command -v starship >/dev/null && eval "$(starship init zsh)"

#   1.  MAKE GIT BETTER
#   -----------------------------

alias gln='git --no-pager log --pretty=format:"%C(yellow)%h %Cred%ad %Cblue%an%Cgreen%d %Creset%s" --date=short -n 10'

#   -----------------------------
#   2.  MAKE TERMINAL BETTER
#   -----------------------------
ssh_noverify() {
  # usage: ssh_noverify user@host [ssh-args...]
  ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "$@"
}

alias ducks='/usr/bin/du -cks * | sort -rn | head'                   # find big files
alias du='du -h -d 1'
alias df='df -h'
alias cp='cp -iv'                                           # Preferred 'cp' implementation
alias mv='mv -iv'                                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                                     # Preferred 'mkdir' implementation
alias cd..='cd ../'                                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                                           # Go back 1 directory level
alias ...='cd ../../'                                       # Go back 2 directory levels
alias .3='cd ../../../'                                     # Go back 3 directory levels
alias .4='cd ../../../../'                                  # Go back 4 directory levels
alias .5='cd ../../../../../'                               # Go back 5 directory levels
alias .6='cd ../../../../../../'                            # Go back 6 directory levels
alias gitroot='cd "$(git rev-parse --show-toplevel)"'       # cd into gitroot for current repo
alias edit='subl'                                           # edit:         Opens any file in sublime editor
alias ~="cd ~"                                              # ~:            Go Home
alias c='clear'                                             # c:            Clear terminal display
alias which='type -a'                                       # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'                         # path:         Echo all executable Paths
alias fix_stty='stty sane'                                  # fix_stty:     Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'                   # cic:          Make tab-completion case-insensitive
mcd () { mkdir -p "$1" && cd "$1"; }                        # mcd:          Makes new Dir and jumps inside

#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
    alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'''
#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.             Example: mans 
#   -------------------------------------------------------------------
    mans () {
        man $1 | grep -iC2 --color=always $2 | less
    }
#   showa: to remind yourself of an alias (given some part of it)
#   ------------------------------------------------------------
    showa () { /usr/bin/grep --color=always -i -a1 $@ ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc ; }

#   -------------------------------
#   3.  FILE AND FOLDER MANAGEMENT
#   -------------------------------

zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)


#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
    extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *.xz)        unxz $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }


#   -----------------
#   4.  KEY BINDINGS
#   -----------------
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

#   -------------
#   5.  SERVICES
#   -------------

# alias start_dnsmasq='sudo /opt/homebrew/opt/dnsmasq/sbin/dnsmasq --keep-in-foreground -C /opt/homebrew/etc/dnsmasq.conf -7 /opt/homebrew/etc/dnsmasq.d,\*.conf'
# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"
# End of LM Studio CLI section


# opencode
export PATH=$HOME/.opencode/bin:$PATH

# Machine-local secrets and overrides (not in the dotfiles repo)
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# fzf key bindings and completion (Ctrl-R history, Ctrl-T files, Alt-C cd)
command -v fzf >/dev/null && source <(fzf --zsh)
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

#   -----------------------------
#   6.  GIT PUSH FIRST COMMIT
#   -----------------------------
#   Push the first commit after the default branch to a new remote branch
#   named after the commit message (slugified). Auto-detects main vs master.
#   -----------------------------

push-first() {
    local base_branch ref title slug

    if git rev-parse --verify origin/develop &>/dev/null; then
        base_branch="origin/develop"
    elif git rev-parse --verify origin/main &>/dev/null; then
        base_branch="origin/main"
    elif git rev-parse --verify origin/master &>/dev/null; then
        base_branch="origin/master"
    else
        echo "Error: Could not find origin/develop, origin/main, or origin/master" >&2
        return 1
    fi

    ref=$(git rev-list --reverse "$(git merge-base "$base_branch" HEAD)..HEAD" | head -1)
    if [[ -z "$ref" ]]; then
        echo "Error: No commits found after $base_branch" >&2
        return 1
    fi

    title=$(git log -1 --format="%s" "$ref")
    slug=$(echo "$title" \
        | tr '[:upper:]' '[:lower:]' \
        | sed 's/[^a-z0-9]/-/g; s/-\+/-/g; s/^-//; s/-$//')

    echo "Pushing $ref to refs/heads/$slug"
    git push origin "${ref}:refs/heads/${slug}"
}

#   -----------------------------
#   7.  YOUTUBE TO WHATSAPP AUDIO
#   -----------------------------
#   Download a YouTube video's audio and convert it to a WhatsApp
#   voice-message-compatible OGG/OPUS file.
#   Usage: ytwa <youtube-url> [output-directory]
#   Defaults to saving in ~/Downloads.
#   -----------------------------

ytwa() {
  local url="$1"
  local outdir="${2:-$HOME/Downloads}"
  local tmpdir tmpbase infile base safe out

  if [[ -z "$url" ]]; then
    echo "❌🚨 Usage: ytwa <youtube-url> [output-directory]" >&2
    return 1
  fi

  mkdir -p "$outdir"
  tmpdir=$(mktemp -d)
  tmpbase="$tmpdir/audio"

  echo "🎵⬇️ Grabbing audio from the tubes..."
  yt-dlp --no-playlist -f bestaudio -o "$tmpbase.%(ext)s" "$url" || {
    echo "❌💥 Download failed! The tubes are clogged." >&2
    rm -rf "$tmpdir"
    return 1
  }

  infile=$(ls "$tmpbase".* 2>/dev/null | head -1)
  if [[ -z "$infile" ]]; then
    echo "❌🤷‍♂️ No downloaded file found. Ghost audio?" >&2
    rm -rf "$tmpdir"
    return 1
  fi

  base=$(yt-dlp --no-playlist --print filename -o "%(title)s" "$url" 2>/dev/null)
  safe=$(echo "$base" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/_/g; s/_\+/_/g; s/^_//; s/_$//')
  out="$outdir/${safe}.ogg"

  echo "🔄🎙️ Cooking it into a WhatsApp voice note..."
  ffmpeg -hide_banner -loglevel error -i "$infile" \
    -vn -c:a libopus -b:a 32k -ar 48000 -ac 1 \
    -af "loudnorm=I=-16:TP=-1.5:LRA=11" \
    -y "$out"

  rm -rf "$tmpdir"

  if [[ -f "$out" ]]; then
    echo "✅🎉 Boom! Your voice note is ready:"
    ls -lh "$out"
    echo "📤🎵 Drag and drop that bad boy into WhatsApp!"
  else
    echo "❌🔥 Conversion failed! The audio gods are angry." >&2
    return 1
  fi
}

# sentry
fpath=("$HOME/.local/share/zsh/site-functions" $fpath)
