#!/usr/bin/env bash

set -eu

source $(dirname "${BASH_SOURCE[0]}")/../utils.sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
CONFIG_DIR="$SCRIPT_DIR/../../.config"

log "INFO" "Starting Git installation..."

check_install "git"
log "INFO" "Git installed: $(git --version)"

create_symlink "${CONFIG_DIR}/git" "$HOME/.config/git"
git config --global include.path "$HOME/.config/git/config_shared" 2>&1 | while IFS= read -r line; do
    log "DEBUG" "$line"
done
log "INFO" "Git configuration set up successfully."
