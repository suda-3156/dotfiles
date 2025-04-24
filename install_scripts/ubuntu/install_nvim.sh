#!/usr/bin/env bash

set -eu

source "$(dirname "${BASH_SOURCE[0]}")/../utils/log.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../utils/install.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../utils/check.sh"

PJROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)

check_installed nvim_installed "luarocks"
if [[ $nvim_installed -eq 1 ]]; then
    log "INFO" "Luarocks is already installed."
else
    log "INFO" "Luarocks is not installed. Installing Luarocks..."
    apt_install "luarocks"
    if [[ $? -eq 0 ]]; then
        log "INFO" "Luarocks installed successfully."
    else
        log "ERROR" "Failed to install Luarocks."
        exit 1
    fi
fi

check_installed git_installed "git"
if [[ $git_installed -eq 1 ]]; then
    log "INFO" "Git is already installed."
else
    log "INFO" "Git is not installed. Installing Git..."
    apt_install "git"
    if [[ $? -eq 0 ]]; then
        log "INFO" "Git installed successfully."
    else
        log "ERROR" "Failed to install Git."
        exit 1
    fi
fi

create_symlink "$PJROOT_DIR/.config/nvim" "$HOME/.config/nvim"

log "WARN" "Need to install nvim manually"
