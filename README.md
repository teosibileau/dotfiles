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

`tmux.conf` and the `nvim/` LazyVim config are symlinked into place, and
`install.sh` installs their plugins too: tpm plus everything in `tmux.conf`
(resurrect, continuum), and the neovim plugins at the exact commits pinned in
`nvim/lazy-lock.json` via `Lazy! restore`. No manual `prefix + I` needed, and
nothing is left to install on first launch.

## Agent CLIs

Claude Code and opencode are installed from their official installers when
missing, and left alone otherwise since both self-update. Neither is in the
Brewfile because neither is distributed through Homebrew. Authentication is
per-machine: run `claude` and `opencode auth login` once after installing.

`opencode.json` carries the opencode settings worth having everywhere (theme:
tokyonight) and is symlinked to `~/.config/opencode/opencode.json`. Only that
one file is linked, since opencode keeps plugins and `node_modules` in the same
directory. Picking a theme from the TUI writes to
`~/.local/state/opencode/kv.json` instead, which is machine-local runtime state
and stays out of the repo; the config file is the reproducible way to set it.

## Containers

colima replaces Docker Desktop: it runs the Linux VM and the daemon, but ships
no client, so the Brewfile also installs the `docker` CLI, the `docker-compose`
plugin, and `docker-credential-helper`.

`colima.yaml` is symlinked to `~/.colima/_templates/default.yaml`, the template
colima applies to new instances, so `colima start` needs no flags. It sets 4
CPUs / 8GB / 100GB (the 2/2 defaults are too small for a Supabase-sized compose
stack), `vmType: vz` with `mountType: virtiofs` for fast boots and usable bind
mounts, and `rosetta: true` for linux/amd64 images. It is a template for VMs
that do not exist yet: editing it does not reconfigure a running VM, which needs
`colima delete && colima start`.

`install.sh` checks for Docker Desktop first. If `/Applications/Docker.app` is
present it starts nothing and explains how to switch, because Desktop owns
`/usr/local/bin/docker` as a symlink into its app bundle and `/usr/local/bin`
comes before `/opt/homebrew/bin` in PATH, so Desktop's CLI shadows the brew one.
Uninstalling Desktop is left to a human. With Desktop gone, the installer starts
colima, creating the VM on first run.

One thing to fix by hand after removing Desktop: `~/.docker/config.json` has
`"credsStore": "desktop"`, a helper that leaves with the app and takes registry
logins with it. Set it to `"osxkeychain"` and log in again. `install.sh` warns
when it sees the stale value but does not rewrite a file docker owns.

## Python CLI tools

`pipx-packages.txt` lists the Python CLIs wanted on every machine. `install.sh`
installs any that are missing (and skips the step entirely if pipx is absent, so
run `brew bundle` first). Add a line to that file to add a tool everywhere.

## Machine-local config

Secrets and per-machine overrides go in `~/.zshrc.local` (sourced if present,
never committed). Anything tool-specific in `zshrc` is guarded with
`command -v`, so missing tools do not break shell startup.
