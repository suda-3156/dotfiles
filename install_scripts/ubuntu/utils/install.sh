#!/usr/bin/env bash

set -eu

source "$(dirname "${BASH_SOURCE[0]}")/log.sh"

function apt_install() {
    local package="$1"

    if command -v "apt-get" &> /dev/null; then
        log "DEBUG" "Using apt-get to install $package."
    else
        log "ERROR" "apt-get not found. Please install it first."
        return 1
    fi

    realtime_log "sudo DEBIAN_FRONTEND=noninteractive apt-get install -y $package"
    if [[ ! ${PIPESTATUS[0]} -eq 0 ]]; then
        log "ERROR" "Failed to install $package."
        return 1
    fi
}

function cargo_install() {
    local package="$1"

    if command -v "cargo" &> /dev/null; then
        log "DEBUG" "Using cargo to install $package."
    else
        log "ERROR" "cargo not found. Please install it first."
        return 1
    fi

    realtime_log "cargo install $package"
    if [[ !${PIPESTATUS[0]} -eq 0 ]]; then
        log "ERROR" "Failed to install $package."
        return 1
    fi
}
