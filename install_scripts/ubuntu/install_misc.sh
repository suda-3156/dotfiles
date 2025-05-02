#!/usr/bin/env bash

set -eu

source "$(dirname "${BASH_SOURCE[0]}")/utils/log.sh"
source "$(dirname "${BASH_SOURCE[0]}")/utils/install.sh"
source "$(dirname "${BASH_SOURCE[0]}")/utils/check.sh"

log "INFO" "Installing misc packages on Ubuntu"

packages=(
    curl
    fzf
    tree
    build-essential
    cmake
    libssl-dev
    pkg-config
)

for package in "${packages[@]}"; do
    check_installed is_installed "$package"
    if [[ ! $is_installed -eq 0 ]]; then
        log "INFO" "$package is already installed. Skipping installation."
        continue
    fi

    apt_install "$package"
    if [[ $? -eq 0 ]]; then
        log "INFO" "$package installed successfully."
    else
        log "ERROR" "Failed to install $package."
        exit 1
    fi
done

log "INFO" "All misc packages installed successfully"
