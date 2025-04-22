#!/usr/bin/env bash

# Check if a package is installed and set the result variable accordingly
# Arguments:
#   result_var: The name of the variable to set (1 for installed, 0 for not installed)
#   package_name: The name of the package to check
# Usage:
#   check_installed result_var package_name

set -eu

source "$(dirname "${BASH_SOURCE[0]}")/log.sh"

function check_installed() {
    local package="$2"
    local not_installed=0

    if command -v "$package" &> /dev/null; then
        log "DEBUG" "$package is already installed."
        eval "$1=1"
        return 0
    else
        log "DEBUG" "$package is not installed or not found in PATH."
        not_installed=1
    fi

    # for cargo
    if command -v "cargo" &> /dev/null; then
        if cargo install --list | grep -q "$package"; then
            log "DEBUG" "$package is already installed."
            eval "$1=1"
            return 0
        else
            log "DEBUG" "$package is not installed via cargo."
            not_installed=1
        fi
    fi

    # for brew
    if command -v "brew" &> /dev/null; then
        if brew list --cask | grep -q "\s[$package]\s"; then
            log "DEBUG" "$package is already installed via brew."
            eval "$1=1"
            return 0
        else
            log "DEBUG" "$package is not installed via brew."
            not_installed=1
        fi
    fi

    # for apt
    if command -v "apt" &> /dev/null; then
        if dpkg -l | awk '$2 == "$package"' | grep -q $package; then
            log "DEBUG" "$package is already installed via apt."
            eval "$1=1"
            return 0
        else
            log "DEBUG" "$package is not installed via apt."
            not_installed=1
        fi
    fi

    if [[ $not_installed -eq 1 ]]; then
        log "DEBUG" "$package is not installed."
        eval "$1=0"
    fi
}
