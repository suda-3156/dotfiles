#!/usr/bin/env bash

set -eu

if [[ "$(uname)" != "Darwin" ]]; then
  echo "karabiner/install.sh - This script must be run on macOS."
  exit 0
fi

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LINK_PATH="$HOME/.config/karabiner/assets"
TIMESTAMP=$(date +%Y%m%d%H%M%S)

while :; do
  printf "Install Karabiner Elements via Homebrew? (y/N): "
  read -r ans
  case "$ans" in
  [yY])
    echo "Installing..."
    brew install --cask karabiner-elements
    break
    ;;
  "" | [nN])
    echo "Skipping installation."
    echo "Creating a symlink for karabiner-elements"
    break
    ;;
  *)
    echo "Invalid choice: '$ans'. Please enter [y]es or [n]o."
    ;;
  esac
done


if [[ -L "$LINK_PATH/complex_modifications" || -e "$LINK_PATH/complex_modifications" ]]; then
  while :; do
    printf "File already exists: %s\nChoose action - [o]verwrite, [b]ackup, or [s]kip: " "$LINK_PATH/complex_modifications"
    read -r ans
    case "$ans" in
    [oO])
      rm -rf "$LINK_PATH/complex_modifications"
      break
      ;;
    [bB])
      echo "Backed up: $LINK_PATH/complex_modifications -> complex_modifications.bak.$TIMESTAMP"
      mv "$LINK_PATH/complex_modifications" "$LINK_PATH/complex_modifications.bak.$TIMESTAMP"
      break
      ;;
    [sS])
      exit 0
      ;;
    "") ;;
    *)
      echo "Invalid option: $ans"
      ;;
    esac
  done
fi

mkdir -p "$LINK_PATH"

ln -sv "$DOTFILES_ROOT/karabiner/complex_modifications" "$LINK_PATH/complex_modifications"

CONFIG_FILE="$HOME/.config/karabiner/karabiner.json"
if [[ -L "$CONFIG_FILE" || -e "$CONFIG_FILE" ]]; then
  while :; do
    printf "File already exists: %s\nChoose action - [o]verwrite, [b]ackup, or [s]kip: " "$CONFIG_FILE"
    read -r ans
    case "$ans" in
    [oO])
      rm -rf "$CONFIG_FILE"
      break
      ;;
    [bB])
      echo "Backed up: $CONFIG_FILE -> karabiner.json.bak.$TIMESTAMP"
      mv "$CONFIG_FILE" "$CONFIG_FILE.bak.$TIMESTAMP"
      break
      ;;
    [sS])
      exit 0
      ;;
    "") ;;
    *)
      echo "Invalid option: $ans"
      ;;
    esac
  done
fi

cp -v "$DOTFILES_ROOT/karabiner/karabiner.json.example" "$CONFIG_FILE"

echo "Installation complete. Open Karabiner Elements to choose the complex modifications."
