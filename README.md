# dotfiles

zsh setup: antigen + oh-my-zsh bundles + starship prompt.

## New machine

```sh
git clone <repo-url> ~/dotfiles
~/dotfiles/install.sh
brew bundle --file ~/dotfiles/Brewfile
```

Antigen clones oh-my-zsh and plugins automatically on first shell start.

## Python CLI tools

`pipx-packages.txt` lists the Python CLIs wanted on every machine. `install.sh`
installs any that are missing (and skips the step entirely if pipx is absent, so
run `brew bundle` first). Add a line to that file to add a tool everywhere.

## Machine-local config

Secrets and per-machine overrides go in `~/.zshrc.local` (sourced if present,
never committed). Anything tool-specific in `zshrc` is guarded with
`command -v`, so missing tools do not break shell startup.
