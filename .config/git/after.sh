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

CONFIG_FILE="$HOME/.config/git/config.local"

function init_config_file() {
  mkdir -p "$(dirname "$CONFIG_FILE")"
  touch "$CONFIG_FILE"
}

function config() {
  if ! confirm "Set up Git author info?"; then
    echo "Skipping Git config setup"
    return 0
  fi

  init_config_file

  local git_username=""
  while [[ -z "$git_username" ]]; do
    printf "Git username:\n"
    read -r git_username || true
  done

  local git_email=""
  while [[ -z "$git_email" ]]; do
    printf "Git email:\n"
    read -r git_email || true
  done

  git config -f "$CONFIG_FILE" user.name "$git_username"
  git config -f "$CONFIG_FILE" user.email "$git_email"

  echo "Git config setup completed."
}

function add_username_to_secrets() {
  init_config_file
  local username
  username="$(whoami)"

  git config -f "$CONFIG_FILE" --unset-all secrets.patterns >/dev/null 2>&1 || true

  git config -f "$CONFIG_FILE" --add secrets.patterns "$username"
  git config -f "$CONFIG_FILE" --add secrets.patterns "/Users/"
}

function secrets() {
  if ! confirm "Set up git-secrets?"; then
    echo "Skipping git-secrets setup"
    return 0
  fi

  local template_dir="$HOME/.config/git/templates/git-secrets"
  mkdir -p "$template_dir"
  git secrets --install "$template_dir"
  git config --global init.templatedir "$template_dir"

  add_username_to_secrets

  echo "git-secrets setup completed."
}

config

if ! command -v git-secrets >/dev/null 2>&1; then
  exit 0
fi

secrets
