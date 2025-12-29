#!/usr/bin/env bash

# Reference: https://github.com/mathiasbynens/dotfiles/blob/main/brew.sh

set -eu

if [[ "$(uname)" != "Darwin" ]]; then
  echo "macos/brew.sh - This script must be run on macOS."
  exit 1
fi

BREW_PREFIX=$(brew --prefix)
DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

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

# Install GNU core utilities (those that come with macOS are outdated).
# Add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
# Add `$(brew --prefix make)/libexec/gnubin` to `$PATH`.
brew install make
# Add `$(brew --prefix diffutils)/libexec/gnubin` to `$PATH`.
brew install diffutils
# Add `$(brew --prefix findutils)/libexec/gnubin` to `$PATH`.
brew install findutils
# Add `$(brew --prefix gzip)/libexec/gnubin` to `$PATH`.
brew install gzip
# Add `$(brew --prefix gawk)/libexec/gnubin` to `$PATH`.
brew install gawk

# Use homebrew bash
brew install bash
if ! grep -F -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells
fi

# Install packages in the Brewfile
brew bundle --file="$DOTFILES_ROOT/brew/Brewfile"

# Iterm2
brew install --cask iterm2

# Docker
# `brew install docker` to install CLI only
brew install --cask docker-desktop

# Clipy
brew install --cask clipy

# Latex
brew install --cask mactex-no-gui

# Apps
brew install --cask gcloud-cli
brew install --cask firefox
brew install --cask google-chrome
brew install --cask github-copilot-for-xcode
brew install --cask obsidian
brew install --cask appcleaner
brew install --cask keyboardcleantool
brew install --cask postman

# Remove outdated versions from the cellar.
brew cleanup
