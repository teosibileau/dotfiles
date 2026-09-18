# Third-party taps for formulae declared below.
tap "scottfelder/lazymqtt"
tap "viniciussouzao/tap"
tap "basecamp/tap"

# Icon glyphs for starship, yazi and neovim status lines.
cask "font-symbols-only-nerd-font"

# Tools the zsh setup expects. Install with: brew bundle --file Brewfile
brew "starship"
brew "fzf"
brew "tmux"
brew "neovim"
brew "luarocks"         # Lua packages for neovim plugins
brew "tree-sitter-cli"  # nvim-treesitter compiles grammars with it

# Runtimes. mise manages python, node, and ruby; what it installs is declared
# in mise.toml. uv is not optional: mise's "pipx:" backend shells out to
# `uv tool install` rather than requiring pipx.
brew "mise"
brew "uv"

# Superseded by mise, kept until the migration is verified end to end.
# Remove these three once `mise ls` looks right and projects resolve correctly.
brew "pyenv"
brew "pyenv-virtualenv"
brew "pipx"

# Called by the ytwa function in zsh/40-functions/transcoding.zsh.
brew "ffmpeg"

# Basecamp CLI, used by the basecamp agent skill. Auth: basecamp login.
cask "basecamp-cli"

# Forge and CI CLIs. Authentication is per-machine: gh auth login, glab auth login.
brew "gh"
brew "glab"
brew "act"
brew "gitlab-ci-local"
brew "git-filter-repo"  # rewrite history, replaces git filter-branch

# Containers: colima runs the VM and daemon but supplies no client, so the
# docker CLI and the compose plugin come separately. docker-credential-helper
# provides docker-credential-osxkeychain, which replaces Docker Desktop's
# "desktop" credential store once Desktop is gone.
brew "colima"
brew "docker"
brew "docker-compose"
brew "docker-credential-helper"

# Libraries referenced by zsh/05-native-build.zsh, for building native Python
# extensions. Uncomment per machine as needed; the zsh fragment guards on each
# directory existing, so uncommenting here is all that is required.
brew "libpq"      # psycopg2, also provides psql
# brew "libxml2"  # lxml
brew "zbar"       # pyzbar
# brew "qt@5"     # PyQt5
# brew "ruby"     # only needed if kamal moves off mise

# Disk cleanup. Names are easy to forget, so they live here:
#   mo         mole: deep clean of caches, logs, dev leftovers (`mo` or `mole`)
#   tidymymac  interactive TUI for finding and removing large junk
#   ncdu       ncurses disk usage browser, for finding what is eating space
brew "mole"
brew "tidymymac"
brew "ncdu"

# Shell staples.
brew "jq"
brew "csvkit"  # csvlook, csvcut, csvsql
brew "tree"
brew "wget"
brew "rsync"
brew "btop"
brew "htop"
brew "ripgrep"
brew "fd"
brew "the_silver_searcher"
brew "glow"        # render Markdown in the terminal
brew "grip"        # preview Markdown as GitHub renders it
brew "hugo"        # static site generator
brew "deck"        # Markdown to Google Slides
brew "figlet"      # ASCII-art banners
brew "sevenzip"    # 7zz, archives

# TUIs: files, git, SQL, Kubernetes.
brew "yazi"
brew "lazygit"
brew "lazysql"
brew "rainfrog"
brew "k9s"

# Linters.
brew "golangci-lint"  # Go
brew "hadolint"       # Dockerfile

# Cloud. granted (`assume`) switches AWS profiles and SSO sessions.
brew "awscli"
brew "granted"
brew "doctl"       # DigitalOcean
brew "localstack"  # local AWS mock in Docker
cask "gcloud-cli"  # Google Cloud

# Infra and network.
brew "opentofu"
brew "ansible"
brew "docker-buildx"
brew "nmap"
brew "telnet"
brew "k6"      # load testing
brew "ykman"     # YubiKey manager
brew "libfido2"  # FIDO2 keys, used by ssh-keygen -t ed25519-sk

# Media. The -full variants carry every optional codec and delegate.
brew "ffmpeg-full"
brew "imagemagick-full"
brew "mediamtx"  # RTSP/RTMP/HLS/WebRTC streaming server

# PDF.
brew "poppler"  # pdftotext, pdftoppm, pdfinfo
brew "qpdf"     # merge, split, rotate, encrypt

# Per-project CLI from a .ahoy.yml: turns a YAML file of commands into a
# documented, tab-completed command runner (like make, but for arbitrary
# commands, often wrapping docker exec).
brew "ahoy"
brew "go-task"  # `task`, same idea driven by a Taskfile.yml

# MQTT. lazymqtt is a TUI broker browser (topics, messages, publish), the
# terminal replacement for MQTT Explorer. mosquitto supplies mosquitto_sub/pub.
brew "lazymqtt"
brew "mosquitto"

# GUI apps.
cask "obsidian"
cask "ghostty"
cask "google-chrome"
cask "vlc"
cask "grid"
cask "spotify"
cask "nordvpn"
cask "displaylink"  # driver for USB docking-station monitors
