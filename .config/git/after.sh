#!/usr/bin/env bash

set -eu

function git_config() {
  local skip=false

  while :; do
    printf "Set up Git author info? (Y/n): "
    read -r ans

    case "$ans" in
    "" | [yY])
      break
      ;;
    [nN])
      echo "Skipping Git config setup"
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

  printf "Git username:\n"
  read -r git_username
  echo git config set --global user.name "$git_username"
  

  printf "Git email:\n"
  read -r git_email
  echo git config set --global user.email "$git_email"
}

git config --global include.path "$HOME/.config/git/config_shared"
git_config

if command -v git-secrets > /dev/null 2>&1; then
  git secrets --install ~/.git-templates/git-secrets
  git config --global init.templatedir '~/.git-templates/git-secrets'
fi
