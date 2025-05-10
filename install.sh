#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/install_scripts/utils/get_distribution.sh"
INSTALLER_DIR="$(pwd)/install_scripts/"

function setup_macOS() {
    echo "Setting up macOS..."
    source "$INSTALLER_DIR/macos/init.sh"

    source "$INSTALLER_DIR/macos/links.sh"

    echo "TODO: if you want, execute ininstall_scripts/macos/settings.sh manually"
    # source "$INSTALLER_DIR/macos/settings.sh"
}

function setup_ubuntu() {
    sudo -v

    echo "Setting up Ubuntu..."
    source "$INSTALLER_DIR/ubuntu/utils/up.sh"
    upgrade

    # Install
    source "$INSTALLER_DIR/$distribution/install_git.sh"

    source "$INSTALLER_DIR/$distribution/install_misc.sh"

    source "$INSTALLER_DIR/$distribution/install_cargo.sh"

    source "$INSTALLER_DIR/$distribution/install_zsh.sh"

    source "$INSTALLER_DIR/$distribution/install_vim.sh"

    source "$INSTALLER_DIR/$distribution/install_nvim.sh"

    source "$INSTALLER_DIR/$distribution/install_tmux.sh"
}

if [[ "$(uname)" == "Darwin" ]] ; then
    OS="macOS"
    distribution="macOS"
fi

if [[ "$(uname)" == "Linux" ]] ; then
    OS="linux"
    distribution=$(get_distribution)
fi

case $distribution in
macOS)
    setup_macOS
    ;;
ubuntu)
    setup_ubuntu
    ;;
*)
    echo "Unsupported OS: $OS / $distribution"
    ;;
esac
