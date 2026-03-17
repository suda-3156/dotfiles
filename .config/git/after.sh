#!/usr/bin/env bash

set -eu

function print() {
  local fmt="$1"
  shift
  printf "\033[0;33mgit/after.sh: \033[0m$fmt" "$@"
}

function is_username_set() {
  [ -n "$(git config get user.name 2>/dev/null)" ]
}

function is_email_set() {
  [ -n "$(git config get user.email 2>/dev/null)" ]
}

function should_skip() {
  is_username_set && is_email_set
}

function confirm() {
  local message="$1"
  while :; do
    print "%s (Y/n): " "$message"
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
      print "Invalid choice: '$ans'. Please enter [y]es or [n]o."
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
    print "Skipping Git config setup.\n"
    return 0
  fi

  init_config_file

  if ! is_username_set; then
    local git_username=""
    while [[ -z "$git_username" ]]; do
      print "Git username:\n"
      read -r git_username || true
    done

    git config -f "$CONFIG_FILE" user.name "$git_username"
  fi

  if ! is_email_set; then
    local git_email=""
    while [[ -z "$git_email" ]]; do
      print "Git email:\n"
      read -r git_email || true
    done

    git config -f "$CONFIG_FILE" user.email "$git_email"
  fi

  print "Git config setup completed.\n"
}

function should_skip_git_secrets() {
  [ -n "$(git config get init.templatedir 2>/dev/null)" ]
}

# If "/Users/" + username is in a program, it won't work in other environments.
# So it should not be contained.
function add_username_to_secrets() {
  init_config_file
  local username
  username="$(whoami)"

  git config -f "$CONFIG_FILE" --unset-all secrets.patterns >/dev/null 2>&1 || true

  git config -f "$CONFIG_FILE" --add secrets.patterns "/Users/$username"
}

function secrets() {
  if ! confirm "Set up git-secrets?"; then
    print "Skipping git-secrets setup.\n"
    return 0
  fi

  local template_dir="$HOME/.config/git/templates/git-secrets"
  mkdir -p "$template_dir"
  git secrets --install "$template_dir"
  git config --global init.templatedir "$template_dir"

  add_username_to_secrets

  print "git-secrets setup completed.\n"
}

if should_skip; then
  print "Username and email are set. Skip configuration.\n"
else
  config
fi

if ! command -v git-secrets >/dev/null 2>&1; then
  print "git-secrets not found. Skip setup for git-secrets.\n"
  exit 0
fi

if should_skip_git_secrets; then
  print "git-secrets seems to have been configured. Skip setup for git-secrets.\n"
  exit 0
fi

secrets
