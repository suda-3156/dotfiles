#!/usr/bin/env bash

set -eu

log() {
    local level="$1"
    local message="$2"
    echo "[$level] $message"
}

function create_symlink() {
    local target="$1"
    local link_name="$2"

    if [[ -L "$link_name" || -e "$link_name" ]]; then
        log "INFO" "Backing up existing symlink or file: $link_name"
        mv "$link_name" "$link_name.bak.$(date +%Y%m%d%H%M%S)"
    fi

    if [[ ! -d "$(dirname "$link_name")" ]]; then
        mkdir -p "$(dirname "$link_name")"
    fi

    ln -s "$target" "$link_name"
}

PJ_ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

if [[ "$(uname)" != "Darwin" ]] ; then
    log "ERROR" "This script is intended to be run on macOS only."
    exit 1
fi

log "INFO" "Starting symlink creation for macOS..."

# git config 
create_symlink "$PJ_ROOT_DIR/.config/git" "$HOME/.config/git"
if [[ command -v git &> /dev/null ]]; then
    git config --global include.path $HOME/.config/git/config_shared
    log "INFO" "Git config updated to include shared config."
fi

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
