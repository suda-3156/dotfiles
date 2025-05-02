#!/usr/bin/env bash

set -eu

source "$(dirname "${BASH_SOURCE[0]}")/utils/log.sh"
source "$(dirname "${BASH_SOURCE[0]}")/utils/install.sh"
source "$(dirname "${BASH_SOURCE[0]}")/utils/check.sh"
source "$(dirname "${BASH_SOURCE[0]}")/utils/symlink.sh"

PJ_ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)

log "INFO" "Starting Git installation..."

check_installed is_installed "git"
if [[ $is_installed -eq 0 ]]; then
    log "INFO" "Git is not installed. Installing Git..."

    apt_install "git"
    if [[ $? -eq 0 ]]; then
        log "INFO" "Git installed successfully."
    else
        log "ERROR" "Failed to install Git."
        exit 1
    fi
else
    log "INFO" "Git is already installed."
fi

create_symlink "${PJ_ROOT_DIR}/.config/git" "$HOME/.config/git"

realtime_log "git config --global include.path $HOME/.config/git/config_shared"

log "INFO" "Git configuration set up successfully."
