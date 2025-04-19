#!/usr/bin/env bash

set -eu

source $(dirname "${BASH_SOURCE[0]}")/../utils.sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
CONFIG_DIR="$SCRIPT_DIR/../../.config"

log "INFO" "Starting Tmux installation..."

check_install "tmux"
log "INFO" "Tmux installed: $(tmux -V)"

create_symlink "${CONFIG_DIR}/tmux/.tmux.conf" "$HOME/.tmux.conf"
log "INFO" "Tmux configuration set up successfully."
