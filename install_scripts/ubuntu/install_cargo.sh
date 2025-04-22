#!/usr/bin/env bash

set -eu

source "$(dirname "${BASH_SOURCE[0]}")/../utils/log.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../utils/install.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../utils/check.sh"

function install_cargo () {
    realtime_log "curl https://sh.rustup.rs -sSf | sh -s -- -y"
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
        check_installed is_installed "$package"
        if [[ ! $is_installed -eq 0 ]]; then
            log "INFO" "$package is already installed. Skipping installation."
            continue
        fi

        log "INFO" "$package is not installed. Installing..."
        cargo_install "$package"
        if [[ $? -eq 0 ]]; then
            log "INFO" "$package installed successfully."
        else
            log "ERROR" "Failed to install $package."
            exit 1
        fi
    done
}

log "INFO" "Starting Rust installation..."

check_installed is_installed_cargo "cargo"
if [[ $is_installed_cargo -eq 0 ]]; then
    log "INFO" "cargo is not installed. Installing..."
    install_cargo
else
    log "INFO" "cargo is already installed. Skipping installation."
fi

install_misc

log "INFO" "Rust packages installation completed successfully."
