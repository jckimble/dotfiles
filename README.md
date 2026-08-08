# Dotfiles

This repository contains my personal dotfiles for an immutable workstation setup, including `yadm` + `Ansible` bootstrap configuration and devcontainer support for Chromebook and AVF environments.

## What this repo does

- Manages shell, editor, and terminal configuration with version-controlled dotfiles.
- Uses `yadm` to clone and bootstrap the repository, keeping the working tree and home directory synced.
- Runs an Ansible-based bootstrap to install essential packages, configure third-party repos, and enable automated system services.
- Includes local reusable utilities and a small service automation setup for user-level `systemd` timers.

## Included configuration

### Shell and terminal
- `.zshrc`
  - Enables `zsh` completions and command correction.
  - Uses a clean colored prompt with a cyan right prompt showing the current directory.
  - Configures history settings, `ls` alias, and `vim` as the default editor.
  - Adds helpful functions:
    - `retry` retries a command until it succeeds.
    - `funny` prints a random fortune with `cowthink` and `lolcat`.
  - Exports Wayland-friendly environment flags for Chrome/Electron applications.
  - Automatically starts `tmux` for interactive shells.

- `.tmux.conf`
  - Uses `Ctrl+a` as the tmux prefix instead of the default `Ctrl+b`.
  - Enables mouse support and `vi` copy mode.
  - Adds Vim-style pane movement and resize bindings.
  - Loads a custom `powerline-double-cyan` theme.

- `.vimrc`
  - Loads Vim plugin manager configuration from `.config/vimplug`.
  - Enables syntax highlighting, 256-color support, and a dark color theme.
  - Sets sane tab, indent, clipboard, and search settings.
  - Defines convenient mappings for window movement, NERDTree, and Vimux operations.

### Git
- `.gitconfig`
  - Sets user name and email.
  - Configures push behavior, rebase on branch setup, and color UI.
  - Uses GitHub CLI credential helper for GitHub and Gist access.

### System and application config
- `.config/ansible/site.yml` and `tasks/`
  - Bootstraps workstation packages using Ansible.
  - Installs `git`, `zsh`, `tmux`, `vim`, `yadm`, `curl`, `wget`, `gh`, `code`, Docker packages, and more.
  - Configures unattended upgrades and APT daily timers.
  - Adds the current user to the `docker` group.

- `.config/yadm/bootstrap`
  - Runs the Ansible site playbook after clone.
  - Boots Vim plugin sync when `vim` is installed.

- `.config/systemd/user/`
  - `yadm-sync.timer` / `yadm-sync.service` keeps the dotfiles repo synced hourly.
  - `git-clean.timer` / `git-clean.service` runs weekly Git cleanup.
  - `docker-clean.timer` / `docker-clean.service` runs weekly Docker cleanup.

- `.local/bin/`
  - Includes helper scripts such as `git-clean` and `docker-clean` used by the user-level timers.

## Cool repository features

- `yadm`-managed dotfiles deployment with a bootstrap hook.
- `yadm` hook support that hides `README.md` from the home directory after clone.
- Ansible automation for installing packages and configuring repos.
- GitHub Actions coverage that validates `yadm` clone, README hiding, Ansible bootstrap, and devcontainer builds.
- User-level `systemd` timers for repo sync and cleanup tasks.
- Custom `zsh`, `tmux`, and `vim` workflows built for terminal productivity.
- Wayland-friendly environment flags for Chromium and Electron apps.

## Setup instructions

Run the following commands on a Debian/Ubuntu-based machine:

```bash
sudo apt update
sudo apt install yadm ansible

yadm clone https://github.com/jckimble/dotfiles.git --bootstrap
```

After cloning, the bootstrap will execute Ansible and install the configured packages. If `vim` is present, it also syncs Vim plugins automatically.

## Notes

- The repo expects files and service definitions to be installed into the home directory via `yadm`.
- If your environment uses Wayland, the `.zshrc` exports flags to help Chrome and VS Code run in a Wayland-compatible mode.
- The `post_clone` hook rewrites `.config/weston.ini` for AVF-specific configuration and removes the repository copy of `README.md` from tracking.
