#!/usr/bin/env bash

set -eu

source "$(dirname "${BASH_SOURCE[0]}")/../utils.sh"

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
CONFIG_DIR="$SCRIPT_DIR/../../.config"

check_install "luarocks"
check_install "git"

create_symlink "${CONFIG_DIR}/nvim" "$HOME/.config/nvim"

log "WARN" "Need to install nvim manually"
