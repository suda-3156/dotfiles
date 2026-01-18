#!/usr/bin/env bash

set -eu

if [[ -e "$HOME/.tmux/plugins/tpm" ]]; then
  exit 0
fi

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

source ~/.tmux/plugins/tpm/bin/install_plugins
