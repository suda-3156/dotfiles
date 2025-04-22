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

apt update
apt upgrade -y

# Install
## Required (many depend on below implicitly)
source "$INSTALLER_DIR/$OS/install_git.sh"

source "$INSTALLER_DIR/$OS/install_misc.sh"

source "$INSTALLER_DIR/$OS/install_cargo.sh"

# source "$INSTALLER_DIR/$OS/install_zsh.sh"

# chmod +x "$INSTALLER_DIR/$OS/install_vim.sh"
# source "$INSTALLER_DIR/$OS/install_vim.sh"

# chmod +x "$INSTALLER_DIR/$OS/install_nvim.sh"
# source "$INSTALLER_DIR/$OS/install_nvim.sh"

# # Optional
# chmod +x "$INSTALLER_DIR/$OS/install_tmux.sh"
# source "$INSTALLER_DIR/$OS/install_tmux.sh"
