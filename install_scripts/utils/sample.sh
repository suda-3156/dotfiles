#!/usr/bin/env bash

source "$(dirname $0)/log.sh"

log "INFO" "Starting Rust installation..."
realtime_log "echo 'Hello, World!'"
# realtime_log "rm ./foo"

# realtime_log "ping www.google.co.jp"

source "$(dirname $0)/symlink.sh"

PJROOT_DIR=$(cd "$(dirname $0)/../.." && pwd)

# create_symlink "$PJROOT_DIR/.config/brew" "$HOME/dots/brew"

# echo "$SOURCE_DIR"
# echo "$PJROOT_DIR"

source "$(dirname $0)/check.sh"

check_installed rust_installed  "rustup"
if [[ $rust_installed -eq 0 ]]; then
    log "INFO" "Rust is not installed. Installing Rust..."
else
    log "INFO" "Rust is already installed."
fi

check_installed cargo_installed "cargo"
if [[ $cargo_installed -eq 0 ]]; then
    log "INFO" "Cargo is not installed. Installing Cargo..."
else
    log "INFO" "Cargo is already installed."
fi

check_installed brew_installed "brew"
if [[ $brew_installed -eq 0 ]]; then
    log "INFO" "Brew is not installed. Installing Brew..."
else
    log "INFO" "Brew is already installed."
fi

check_installed mactex_installed "mactex-no-gui"
if [[ $mactex_installed -eq 0 ]]; then
    log "INFO" "MacTeX is not installed. Installing MacTeX..."
else
    log "INFO" "MacTeX is already installed."
fi
