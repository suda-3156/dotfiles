#!/usr/bin/env bash

# Installer for Ubuntu

set -eu

# Define script paths
OS="ubuntu"
INSTALLER_DIR="$(pwd)/install_scripts/"

if [[ ! -d "$INSTALLER_DIR" ]]; then
    echo "Installer directory not found: $INSTALLER_DIR"
    exit 1
fi

source "$INSTALLER_DIR/utils/up.sh"
upgrade

# Install
source "$INSTALLER_DIR/$OS/install_git.sh"

source "$INSTALLER_DIR/$OS/install_misc.sh"

source "$INSTALLER_DIR/$OS/install_cargo.sh"

source "$INSTALLER_DIR/$OS/install_zsh.sh"

source "$INSTALLER_DIR/$OS/install_vim.sh"

source "$INSTALLER_DIR/$OS/install_nvim.sh"

source "$INSTALLER_DIR/$OS/install_tmux.sh"
