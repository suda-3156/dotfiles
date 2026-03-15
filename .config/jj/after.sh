#!/usr/bin/env bash

set -eu

function confirm() {
  local message="$1"
  while :; do
    printf "%s (Y/n): " "$message"
    # Add || true to avoid exiting with Ctrl+D
    read -r ans || true

    case "$ans" in
    "" | [yY])
      return 0
      ;;
    [nN])
      return 1
      ;;
    *)
      echo "Invalid choice: '$ans'. Please enter [y]es or [n]o."
      ;;
    esac
  done
}

CONFIG_FILE="$HOME/.config/jj/local.toml"

function init_config_file() {
  mkdir -p "$(dirname "$CONFIG_FILE")"
  touch "$CONFIG_FILE"
}

function config() {
  if ! confirm "Set up Git author info for JJ?"; then
    echo "Skipping JJ config setup"
    return 0
  fi

  init_config_file

  local git_username=""
  while [[ -z "$git_username" ]]; do
    printf "Git username (Select local.toml as the destination for writing):\n"
    read -r git_username || true
  done

  jj config set --user user.name "$git_username"

  local git_email=""
  while [[ -z "$git_email" ]]; do
    printf "Git email (Select local.toml as the destination for writing):\n"
    read -r git_email || true
  done

  jj config set --user user.email "$git_email"

  echo "JJ config setup completed."
}

if ! command -v jj >/dev/null 2>&1; then
  echo "jj not installed. Skip jj configuration."
  exit 0
fi

config
