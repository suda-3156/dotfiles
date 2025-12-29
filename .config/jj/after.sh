#!/usr/bin/env bash

set -eu

cd "$(dirname "$0")/../.."
DOTFILES_ROOT=$(pwd -P)

function jj_config() {
  local skip=false

  while :; do
    printf "Set up Git author info for JJ? (Y/n): "
    read -r ans

    case "$ans" in
    "" | [yY])
      break
      ;;
    [nN])
      echo "Skipping JJ config setup"
      skip=true
      break
      ;;
    *)
      echo "Invalid choice: '$ans'. Please enter [y]es or [n]o."
      ;;
    esac
  done

  if [[ "$skip" == "true" ]]; then
    return 0
  fi

  if ! [[ -L "$HOME/.config/jj/config.toml" || -e "$HOME/.config/jj/config.toml" ]]; then
    cp "$DOTFILES_ROOT/.config/jj/config.toml.example" "$HOME/.config/jj/config.toml"
  fi

  printf "JJ username:\n"
  read -er git_username
  jj config set --user user.name "$git_username"

  printf "JJ email:\n"
  read -er git_email
  jj config set --user user.email "$git_email"
}

if ! command -v jj >/dev/null 2>&1; then
  echo "jj not installed. Skip jj configuration."
  exit 0
fi
jj_config
