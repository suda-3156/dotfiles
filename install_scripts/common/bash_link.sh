#!/usr/bin/env bash

set -eu

source "$(dirname "${BASH_SOURCE[0]}")/../utils/log.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../utils/symlink.sh"

PJROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

log "INFO" "Starting symlink creation ..."

# bash
create_symlink "$PJROOT_DIR/.config/bash/.profile" "$HOME/.profile"

log "INFO" "Symlink creation completed successfully."
