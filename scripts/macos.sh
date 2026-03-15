#!/usr/bin/env bash

set -eu

if [[ "$(uname)" != "Darwin" ]]; then
  echo "macos.sh - This script must be run on macOS."
  exit 1
fi

BREW_PREFIX=$(brew --prefix)
DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode."
  xcode-select --install
fi

if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

while :; do
  printf "Install binaries listed in brew/Brewfile and brew/install.sh? (y/N): "
  read -r ans
  case "$ans" in
  [yY])
    echo "Installing..."
    break
    ;;
  "" | [nN])
    echo "Skipping installation."
    return
    ;;
  *)
    echo "Invalid choice: '$ans'. Please enter [y]es or [n]o."
    ;;
  esac
done

brew update
brew upgrade

# Use latest version of bash
brew install bash
if ! grep -F -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells
fi

# Install packages in the Brewfile
brew bundle --file="$DOTFILES_ROOT/scripts/Brewfile"

# Remove outdated versions from the cellar.
brew cleanup
