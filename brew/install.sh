#!/usr/bin/env bash

# Reference: https://github.com/mathiasbynens/dotfiles/blob/main/brew.sh

set -eu

BREW_PREFIX=$(brew --prefix)
PJ_ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

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
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells
fi

# Install packages in the Brewfile
brew bundle --file="$PJ_ROOT_DIR/brew/Brewfile"

# Iterm2
brew install --cask iterm2

# VSCode
brew install --cask visual-studio-code

# Docker
# `brew install docker` to install CLI only
brew install --cask docker-desktop

# Clipy
brew install --cask clipy

# Emacs
# tap "railwaycat/emacsmacport"
# cask "emacs-mac"
# brew "jansson"

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

# # Install some CTF tools; see https://github.com/ctfs/write-ups.
# brew install aircrack-ng
# brew install bfg
# brew install binutils
# brew install binwalk
# brew install cifer
# brew install dex2jar
# brew install dns2tcp
# brew install fcrackzip
# brew install foremost
# brew install hashpump
# brew install hydra
# brew install john
# brew install knock
# brew install netpbm
# brew install nmap
# brew install pngcheck
# brew install socat
# brew install sqlmap
# brew install tcpflow
# brew install tcpreplay
# brew install tcptrace
# brew install ucspi-tcp # `tcpserver` etc.
# brew install xpdf
# brew install xz

# Remove outdated versions from the cellar.
brew cleanup
