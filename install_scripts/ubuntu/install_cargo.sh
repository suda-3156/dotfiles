#!/usr/bin/env bash

set -eu

source "$(dirname "${BASH_SOURCE[0]}")/../utils.sh"

function _install () {
    if command -v "cargo" &> /dev/null; then
        log "INFO" "cargo is already installed. Skipping installation."
        return 0
    fi

    curl https://sh.rustup.rs -sSf | sh -s -- -y 2>&1 | while IFS= read -r line; do
        log "DEBUG" "$line"
    done
    if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
        log "INFO" "Successfully installed package: cargo"
    else
        log "ERROR" "Failed to install package: cargo"
    fi

    if ! . "$HOME/.cargo/env"; then
        log "ERROR" "Failed to source cargo environment."
        exit 1
    fi
    PS1=""  # 一時的に定義
    source ~/.bashrc

    log "INFO" "Rust installation completed successfully. $(cargo --version)"
}

function install_misc() {
    log "INFO" "Installing Misc Rust packages..."

    packages=(
        bat
        ripgrep
    )

    for package in "${packages[@]}"; do
        if command -v "$package" &> /dev/null; then
            log "INFO" "$package is already installed. Skipping installation."
        else
            cargo install "$package" 2>&1 | while IFS= read -r line; do
                log "DEBUG" "$line"
            done
            if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
                log "INFO" "Successfully installed package: $package"
            else
                log "ERROR" "Failed to install package: $package"
            fi
        fi
    done

    log "INFO" "Rust packages installation completed successfully."
}

log "INFO" "Starting Rust installation..."
update
_install
install_misc
