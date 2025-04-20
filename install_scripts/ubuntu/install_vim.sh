#!/usr/bin/env bash

set -eu

source "$(dirname "${BASH_SOURCE[0]}")/../utils.sh"

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
CONFIG_DIR="$SCRIPT_DIR/../../.config"

log "INFO" "Starting Vim installation..."

check_install "vim"
log "INFO" "Vim installed: $(vim --version)"

update-alternatives --set editor /usr/bin/vim.basic
if [[ $? -eq 0 ]]; then
    log "INFO" "Successfully set Vim as the default editor."
else
    log "ERROR" "Failed to set Vim as the default editor."
    exit 1
fi

create_symlink "$CONFIG_DIR/vim" "$HOME/.config/vim"
