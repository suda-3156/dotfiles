#!/usr/bin/env bash

# zsh
# plugin manager: sheldon
# plugins: zsh-autosuggestions, zsh-syntax-highlighting, zsh-completions

set -eu

source "$(dirname "${BASH_SOURCE[0]}")/../utils.sh"

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
CONFIG_DIR="$SCRIPT_DIR/../../.config"

function install_with_cargo() {
    log "INFO" "Installing Rust packages..."

    if ! source "$HOME/.cargo/env"; then
        log "ERROR" "Failed to source cargo environment."
        exit 1
    fi

    packages=(
        sheldon
        starship
        zoxide
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
                exit 1
            fi
        fi
    done

    log "INFO" "Rust packages installation completed successfully."
}

check_install "zsh"

create_symlink "$CONFIG_DIR/zsh/.zshrc" "$HOME/.zshrc"

install_with_cargo

# use zsh as default shell
if ! grep -q "$(which zsh)" /etc/shells; then
    log "INFO" "Adding zsh to /etc/shells..."
    log "INFO" "$(which zsh)" | sudo tee -a /etc/shells
else
    log "INFO" "zsh is already in /etc/shells."
fi

mkdir -p "$HOME/.config/sheldon"
create_symlink "$CONFIG_DIR/zsh/plugins.toml" "$HOME/.config/sheldon/plugins.toml"
create_symlink "$CONFIG_DIR/zsh/starship.toml" "$HOME/.config/starship.toml"
