#!/usr/bin/env bash

# Note: Requires Bash 4 or newer, as the log function relies on associative arrays.

set -eu

echo $BASH_VERSION | grep -qE '^[4-9]\.' || {
    echo "This script requires Bash 4 or newer."
    exit 1
}

source "$(dirname "${BASH_SOURCE[0]}")/../utils/log.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../utils/symlink.sh"

PJ_ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

if [[ "$(uname)" != "Darwin" ]] ; then
    log "ERROR" "This script is intended to be run on macOS only."
    exit 1
fi

log "INFO" "Starting symlink creation for macOS..."

# git config 
create_symlink "$PJ_ROOT_DIR/.config/git" "$HOME/.config/git"
realtime_log "git config --global include.path $HOME/.config/git/config_shared"

# nvim
create_symlink "$PJ_ROOT_DIR/.config/nvim" "$HOME/.config/nvim"

# tmux
create_symlink "$PJ_ROOT_DIR/.config/tmux/.tmux.conf" "$HOME/.tmux.conf"

# vim
create_symlink "$PJ_ROOT_DIR/.config/vim/.vimrc" "$HOME/.vimrc"

# zsh
create_symlink "$PJ_ROOT_DIR/.config/zsh/.zshrc_mac" "$HOME/.zshrc"
create_symlink "$PJ_ROOT_DIR/.config/zsh/.zshenv" "$HOME/.zshenv"
mkdir -p "$HOME/.config/sheldon"
create_symlink "$PJ_ROOT_DIR/.config/zsh/plugins.toml" "$HOME/.config/sheldon/plugins.toml"
create_symlink "$PJ_ROOT_DIR/.config/zsh/starship.toml" "$HOME/.config/starship.toml"

log "INFO" "Symlink creation for macOS completed successfully."
