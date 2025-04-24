#!/usr/bin/env bash

# I don't know if it works

# 1. install brew
# 2. brew install git, bash
# 3. re login
# 4. create_symlinks.sh

set -eu

source "$(dirname "${BASH_SOURCE[0]}")/../utils/log.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../utils/install.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../utils/check.sh"

PJROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

log "INFO" "Starting Brew installation..."

check_installed brew_installed "brew"
if [[ $brew_installed -eq 1 ]]; then
    log "INFO" "Brew is already installed."
else
    log "INFO" "Brew is not installed. Installing Brew..."
    # realtime_log `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
    # if [[ $? -eq 0 ]]; then
    #     log "INFO" "Brew installed successfully."
    # else
    #     log "ERROR" "Failed to install Brew."
    #     exit 1
    # fi
fi

log "INFO" "Brew installation completed successfully."
log "INFO" "Starting Brew package installation..."

realtime_log "brew bundle --file=$PJROOT_DIR/.config/brew/Brewfile"
if [[ $? -eq 0 ]]; then
    log "INFO" "Brew packages installed successfully."
else
    log "ERROR" "Failed to install Brew packages."
    exit 1
fi

log "INFO" "Brew package installation completed successfully."
