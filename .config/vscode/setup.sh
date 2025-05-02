#!/usr/bin/env bash

set -eu

PJ_ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
LINK_PATH="${HOME}/Library/Application Support/Code/User"

if [[ -e "$LINK_PATH/settings.json" || -L "$LINK_PATH/settings.json" ]]; then
    echo "INFO: Backing up existing $LINK_PATH/settings.json to $LINK_PATH/settings.json.bak.$(date +%Y%m%d%H%M%S)"
    mv "$LINK_PATH/settings.json" "$LINK_PATH/settings.json.bak.$(date +%Y%m%d%H%M%S)"
    if [[ ! $? -eq 0 ]]; then
      echo "ERROR: Failed to move existing link: $LINK_PATH/settings.json"
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

ln -s "$PJ_ROOT_DIR/.config/vscode/settings.json" "$LINK_PATH/settings.json"

if [[ $? -eq 0 ]]; then
    echo "INFO: Successfully created symlink: $PJ_ROOT_DIR/.config/vscode/settings.json -> $LINK_PATH/settings.json"
else
    echo "ERROR: Failed to create symlink: $PJ_ROOT_DIR/.config/vscode/settings.json -> $LINK_PATH/settings.json"
    exit 1
fi
