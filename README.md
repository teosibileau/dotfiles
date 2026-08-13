# dotfiles

zsh setup: antigen + oh-my-zsh bundles + starship prompt.

## New machine

```sh
git clone <repo-url> ~/dotfiles
~/dotfiles/install.sh
brew bundle --file ~/dotfiles/Brewfile
```

Antigen clones oh-my-zsh and plugins automatically on first shell start.

## Machine-local config

Secrets and per-machine overrides go in `~/.zshrc.local` (sourced if present,
never committed). Anything tool-specific in `zshrc` is guarded with
`command -v`, so missing tools do not break shell startup.
