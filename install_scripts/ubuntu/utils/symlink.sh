#!/usr/bin/env bash

# Create a symbolic link to a target file or directory
# Arguments:
#   target: The target file or directory to link to
#   link_name: The name of the symbolic link to create
# Usage:
#   create_symlink target link_name
# Example:
#   source "$(dirname $0)/symlink.sh"
#   PJ_ROOT_DIR=$(cd "$(dirname $0)/../.." && pwd)
#   create_symlink "$PJ_ROOT_DIR/.config/brew" "$HOME/dots/brew"

set -eu

source "$(dirname "${BASH_SOURCE[0]}")/log.sh"

function create_symlink() {
    local target="$1"
    local link_name="$2"

    if [[ -e "$link_name" ]]; then
        log "INFO" "Backing up existing $link_name to $link_name.bak.$(date +%Y%m%d%H%M%S)"
        mv "$link_name" "$link_name.bak.$(date +%Y%m%d%H%M%S)"
        if [[ ! $? -eq 0 ]]; then
          log "ERROR" "Failed to move existing link: $link_name"
          return 1
        fi
    fi

    # Ensure the target directory exists
    if [[ ! -d "$HOME/.config" ]]; then
        mkdir -p "$HOME/.config"
        log "INFO" "Created directory: $HOME/.config"
    fi

    ln -s "$target" "$link_name"
    if [[ $? -eq 0 ]]; then
        log "INFO" "Successfully created symlink: $link_name -> $target"
    else
        log "ERROR" "Failed to create symlink: $link_name -> $target"
        return 1
    fi
}
