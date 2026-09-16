# Tools the zsh setup expects. Install with: brew bundle --file Brewfile
brew "starship"
brew "fzf"
brew "tmux"
brew "neovim"

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

# Forge and CI CLIs. Authentication is per-machine: gh auth login, glab auth login.
brew "gh"
brew "glab"
brew "act"
brew "gitlab-ci-local"

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
# brew "libpq"    # psycopg2
# brew "libxml2"  # lxml
# brew "zbar"     # pyzbar
# brew "qt@5"     # PyQt5
# brew "ruby"     # only needed if kamal moves off mise

# GUI apps.
cask "obsidian"
