# dotfiles

zsh setup: antigen + oh-my-zsh bundles + starship prompt.

## New machine

```sh
git clone <repo-url> ~/dotfiles
~/dotfiles/install.sh
```

Homebrew must already be installed (https://brew.sh); the script checks for it
and stops rather than installing it. `install.sh` symlinks the configs, runs
`brew bundle`, clones tpm, and installs the pipx tools. Note that `brew bundle`
also upgrades formulas in the Brewfile that are out of date. Pass `--no-brew` to
symlink configs only.

Antigen clones oh-my-zsh and plugins automatically on first shell start.

## tmux and neovim

`tmux.conf` and the `nvim/` LazyVim config are symlinked into place. `install.sh`
clones tpm if missing; press `prefix + I` inside tmux once to fetch tmux plugins.
Neovim plugins install themselves on first launch, pinned by `nvim/lazy-lock.json`.

## Python CLI tools

`pipx-packages.txt` lists the Python CLIs wanted on every machine. `install.sh`
installs any that are missing (and skips the step entirely if pipx is absent, so
run `brew bundle` first). Add a line to that file to add a tool everywhere.

## Machine-local config

Secrets and per-machine overrides go in `~/.zshrc.local` (sourced if present,
never committed). Anything tool-specific in `zshrc` is guarded with
`command -v`, so missing tools do not break shell startup.
