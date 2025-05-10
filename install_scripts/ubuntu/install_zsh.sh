#!/usr/bin/env bash

# zsh
# plugin manager: sheldon
# plugins: zsh-autosuggestions, zsh-syntax-highlighting, zsh-completions

set -eu

source "$(dirname "${BASH_SOURCE[0]}")/utils/log.sh"
source "$(dirname "${BASH_SOURCE[0]}")/utils/install.sh"
source "$(dirname "${BASH_SOURCE[0]}")/utils/check.sh"

PJ_ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)

# sudo で実行される場合、$HOMEは/rootになるため、$SUDO_USERを使ってユーザーのHOMEを取得する
if [[ -n "${SUDO_USER:-}" ]]; then
    USER_HOME=$(eval echo "~$SUDO_USER")
else
    USER_HOME="$HOME"
fi

function install_misc() {
    log "INFO" "Installing Rust packages required for zsh ..."

    packages=(
        sheldon
        starship
        zoxide
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

check_installed zsh_installed "zsh"
if [[ $zsh_installed -eq 1 ]]; then
    log "INFO" "zsh is already installed."
else
    log "INFO" "zsh is not installed. Installing zsh..."
    apt_install "zsh"
    if [[ $? -eq 0 ]]; then
        log "INFO" "zsh installed successfully."
    else
        log "ERROR" "Failed to install zsh."
        exit 1
    fi
fi

create_symlink "$PJ_ROOT_DIR/.config/zsh/.ubuntu.zshrc" "$USER_HOME/.zshrc"
create_symlink "$PJ_ROOT_DIR/.config/zsh/.zshenv" "$USER_HOME/.zshenv"

check_installed cargo_installed "cargo"
if [[ $cargo_installed -eq 1 ]]; then
    log "INFO" "cargo is already installed."
else
    log "ERROR" "Execute install_cargo.sh to install cargo."
    exit 1
fi

install_misc

# TODO: 
# use zsh as default shell
# if ! grep -q "$(which zsh)" /etc/shells; then
#     log "INFO" "Adding zsh to /etc/shells..."
#     log "INFO" "$(which zsh)" | sudo tee -a /etc/shells
# else
#     log "INFO" "zsh is already in /etc/shells."
# fi

mkdir -p "$HOME/.config/sheldon"
create_symlink "$PJ_ROOT_DIR/.config/zsh/plugins.toml" "$USER_HOME/.config/sheldon/plugins.toml"
create_symlink "$PJ_ROOT_DIR/.config/zsh/starship.toml" "$USER_HOME/.config/starship.toml"
