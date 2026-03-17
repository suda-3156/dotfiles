#!/usr/bin/env bash

set -eu

function print() {
  local fmt="$1"
  shift
  printf "\033[0;33mjj/after.sh: \033[0m$fmt" "$@"
}

function is_username_set() {
  [ -n "$(jj config get user.name 2>/dev/null)" ]
}

function is_email_set() {
  [ -n "$(jj config get user.email 2>/dev/null)" ]
}

function should_skip() {
  is_username_set && is_email_set
}

function confirm() {
  local message="$1"
  while :; do
    print "%s (Y/n): " "$message"
    # Add '|| true' to avoid exiting with Ctrl+D
    read -r ans || true

    case "$ans" in
    "" | [yY])
      return 0
      ;;
    [nN])
      return 1
      ;;
    *)
      print "Invalid choice: '$ans'. Please enter [y]es or [n]o."
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
    print "Skipping JJ config setup"
    return 0
  fi

  init_config_file

  if ! is_username_set; then
    local git_username=""
    while [[ -z "$git_username" ]]; do
      print "Git username (Select local.toml as the destination for writing):\n"
      read -r git_username || true
    done

    jj config set --user user.name "$git_username"
  fi

  if ! is_email_set; then
    local git_email=""
    while [[ -z "$git_email" ]]; do
      print "Git email (Select local.toml as the destination for writing):\n"
      read -r git_email || true
    done

    jj config set --user user.email "$git_email"
  fi

  print "JJ config setup completed.\n"
}

if ! command -v jj >/dev/null 2>&1; then
  print "JJ not installed. Skip configuration.\n"
  exit 0
fi

if should_skip; then
  print "Username and email are set. Skip configuration.\n"
  exit 0
fi

config
