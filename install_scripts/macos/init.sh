#!/usr/bin/env bash

set -eu

PJ_ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

log() {
    local level="$1"
    local message="$2"
    echo "[$level] $message"
}

if [[ "$(uname)" != "Darwin" ]] ; then
    log "ERROR" "This script is intended to be run on macOS only."
    exit 1
fi

log "INFO" "Starting Xcode installation..."

if xcode-select -p &> /dev/null; then
    log "INFO" "Xcode is already installed."
else
    log "INFO" "Xcode is not installed. Installing Xcode..."
    xcode-select --install > /dev/null
    until xcode-select -p &> /dev/null; do
        sleep 5
    done
    log "INFO" "Xcode installed successfully."
fi

log "INFO" "Starting Brew installation..."

if command -v brew &> /dev/null; then
    log "INFO" "Brew is already installed."
else
    log "INFO" "Brew is not installed. Installing Brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
        log "ERROR" "Failed to install Brew."
        exit 1
    }
    log "INFO" "Brew installed successfully."
fi

log "INFO" "Installing Brew packages..."
brew bundle --file="$PJ_ROOT_DIR/.config/brew/Brewfile" || {
    log "ERROR" "Failed to install Brew packages."
    exit 1
}
log "INFO" "Brew package installation completed successfully."
