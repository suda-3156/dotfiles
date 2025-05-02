#!/usr/bin/env bash

set -eu

source "$(dirname "${BASH_SOURCE[0]}")/utils/log.sh"
source "$(dirname "${BASH_SOURCE[0]}")/utils/install.sh"
source "$(dirname "${BASH_SOURCE[0]}")/utils/check.sh"

PJ_ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)

log "INFO" "Starting Vim installation..."

log "INFO" "Setting non-interactive mode for apt-get..."
export DEBIAN_FRONTEND=noninteractive

check_installed vim_installed "vim"
if [[ $vim_installed -eq 1 ]]; then
    log "INFO" "Vim is already installed."
else
    log "INFO" "Vim is not installed. Installing Vim..."
    apt_install "vim"
    if [[ $? -eq 0 ]]; then
        log "INFO" "Vim installed successfully."
    else
        log "ERROR" "Failed to install Vim."
        exit 1
    fi
fi

create_symlink "$PJ_ROOT_DIR/.config/vim/.vimrc" "$HOME/.vimrc"

# TODO:
# update-alternatives --set editor /usr/bin/vim.basic
# if [[ $? -eq 0 ]]; then
#     log "INFO" "Successfully set Vim as the default editor."
# else
#     log "WARN" "Failed to set Vim as the default editor."
# fi
