#!/usr/bin/env bash

# Note: need to use bash varsion 4 or higher ?

set -eu

source "$(dirname "${BASH_SOURCE[0]}")/../utils/log.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../utils/symlink.sh"

PJROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

log "INFO" "Starting symlink creation for macOS..."

# git config 
create_symlink "$PJROOT_DIR/.config/git" "$HOME/.config/git"
realtime_log "git config --global include.path $HOME/.config/git/config_shared"

# nvim
create_symlink "$PJROOT_DIR/.config/nvim" "$HOME/.config/nvim"

# tmux
create_symlink "$PJROOT_DIR/.config/tmux/.tmux.conf" "$HOME/.tmux.conf"

# vim
create_symlink "$PJROOT_DIR/.config/vim/.vimrc" "$HOME/.vimrc"

# zsh
create_symlink "$PJROOT_DIR/.config/zsh/.zshrc" "$HOME/.zshrc"
create_symlink "$PJROOT_DIR/.config/zsh/.zshenv" "$HOME/.zshenv"
mkdir -p "$HOME/.config/sheldon"
create_symlink "$PJROOT_DIR/.config/zsh/plugins.toml" "$HOME/.config/sheldon/plugins.toml"
create_symlink "$PJROOT_DIR/.config/zsh/starship.toml" "$HOME/.config/starship.toml"

log "INFO" "Symlink creation for macOS completed successfully."
