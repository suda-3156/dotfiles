#!/usr/bin/env bash

set -eu

PJ_ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
LINK_PATH="${HOME}/Library/Application Support/Code/User"

# settings.json
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

# keybindings.json
if [[ -e "$LINK_PATH/keybindings.json" || -L "$LINK_PATH/keybindings.json" ]]; then
    echo "INFO: Backing up existing $LINK_PATH/keybindings.json to $LINK_PATH/keybindings.json.bak.$(date +%Y%m%d%H%M%S)"
    mv "$LINK_PATH/keybindings.json" "$LINK_PATH/keybindings.json.bak.$(date +%Y%m%d%H%M%S)"
    if [[ ! $? -eq 0 ]]; then
      echo "ERROR: Failed to move existing link: $LINK_PATH/keybindings.json"
      exit 1
    fi
fi

ln -s "$PJ_ROOT_DIR/.config/vscode/keybindings.json" "$LINK_PATH/keybindings.json"

if [[ $? -eq 0 ]]; then
    echo "INFO: Successfully created symlink: $PJ_ROOT_DIR/.config/vscode/keybindings.json -> $LINK_PATH/keybindings.json"
else
    echo "ERROR: Failed to create symlink: $PJ_ROOT_DIR/.config/vscode/keybindings.json -> $LINK_PATH/keybindings.json"
    exit 1
fi

# Install Extensions
if [ "$(which "code")" != "" ]; then
  echo "INFO: Installing extensions to vscode..."
  cat < "$PJ_ROOT_DIR/.config/vscode/extensions" | while read -r line
  do
    code --install-extension "$line"
  done
else
  echo "ERROR: Code command not found"
fi

