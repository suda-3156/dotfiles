#!/usr/bin/env bash

set -eu

source $(dirname "${BASH_SOURCE[0]}")/../utils.sh

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
    if ! check_install "$package"; then
        log "ERROR" "Failed to install $package"
        exit 1
    fi
done

log "INFO" "All misc packages installed successfully"
