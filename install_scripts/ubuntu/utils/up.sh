#!/usr/bin/env bash

set -eu

source "$(dirname "${BASH_SOURCE[0]}")/log.sh"

update() {
    log "INFO" "Starting apt update"
    apt-get update 2>&1 | while IFS= read -r line; do
        log "DEBUG" "$line"
    done
    if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
        log "INFO" "Successfully updated package list"
    else
        log "ERROR" "Failed to update package list"
    fi
}

upgrade() {
    log "INFO" "Starting apt upgrade"
    update
    apt-get upgrade -y 2>&1 | while IFS= read -r line; do
        log "DEBUG" "$line"
    done
    if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
        log "INFO" "Successfully upgraded packages"
    else
        log "ERROR" "Failed to upgrade packages"
    fi
}
