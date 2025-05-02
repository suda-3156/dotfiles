#!/usr/bin/env bash

set -eu

PJ_ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
LINK_PATH="$HOME/.config/karabiner/assets"

if [[ -L "$LINK_PATH/complex_modifications" ]]; then
    echo "INFO: Backing up existing $LINK_PATH/complex_modifications to $LINK_PATH/complex_modifications.bak.$(date +%Y%m%d%H%M%S)"
    mv "$LINK_PATH/complex_modifications" "$LINK_PATH/complex_modifications.bak.$(date +%Y%m%d%H%M%S)"
    if [[ ! $? -eq 0 ]]; then
      echo "ERROR: Failed to move existing link: $LINK_PATH/complex_modifications"
      exit 1
    fi
fi

if [[ ! -d "$LINK_PATH" ]]; then
    mkdir -p "$LINK_PATH"
    if [[ ! $? -eq 0 ]]; then
      echo "ERROR: Failed to create directory: $LINK_PATH"
      exit 1
    fi
fi

ln -s "$PJ_ROOT_DIR/.config/karabiner/complex_modifications" "$LINK_PATH/complex_modifications"

if [[ $? -eq 0 ]]; then
    echo "INFO: Successfully created symlink: $PJ_ROOT_DIR/.config/karabiner/complex_modifications -> $LINK_PATH/complex_modifications"
else
    echo "ERROR: Failed to create symlink: $PJ_ROOT_DIR/.config/karabiner/complex_modifications -> $LINK_PATH/complex_modifications"
    exit 1
fi
