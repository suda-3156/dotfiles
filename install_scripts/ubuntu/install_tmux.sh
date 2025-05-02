#!/usr/bin/env bash

set -eu

source "$(dirname "${BASH_SOURCE[0]}")/../utils/log.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../utils/install.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../utils/check.sh"

PJ_ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)

log "INFO" "Starting Tmux installation..."

check_installed tmux_insatlled "tmux"
if [[ $tmux_insatlled -eq 1 ]]; then
    log "INFO" "Tmux is already installed."
else
    log "INFO" "Tmux is not installed. Installing Tmux..."
    apt_install "tmux"
    if [[ $? -eq 0 ]]; then
        log "INFO" "Tmux installed successfully."
    else
        log "ERROR" "Failed to install Tmux."
        exit 1
    fi
fi

create_symlink "$PJ_ROOT_DIR/.config/tmux/.tmux.conf" "$HOME/.tmux.conf"
log "INFO" "Tmux configuration set up successfully."
