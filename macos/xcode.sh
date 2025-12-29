#!/usr/bin/env bash

set -eu

if [[ "$(uname)" != "Darwin" ]]; then
  echo "macos/xcode.sh - This script must be run on macOS."
  exit 1
fi

if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode."
  xcode-select --install
fi
