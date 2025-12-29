#!/usr/bin/env bash

set -eu

sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# Install Git
if ! command -v git > /dev/null 2>&1; then
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y git
fi

# Install basic packages via apt
packages=(
  curl
  fzf
  tree
  build-essential
  cmake
  libssl-dev
  pkg-config
)
for package in "${packages[@]}"; do
  if ! command -v "$package" > /dev/null 2>&1; then
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y "$package"
  fi
done

# Install cargo for some rust packages
if ! command -v cargo > /dev/null 2>&1; then
  curl https://sh.rustup.rs -sSf | sh -s -- -y

  PS1=
  source "$HOME/.cargo/env"
  # source "$HOME/.bashrc"
fi

# Install zsh and its dependencies
if ! command -v zsh > /dev/null 2>&1; then
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y zsh
fi

packages=(
  sheldon
  starship
  zoxide
)
for package in "${packages[@]}"; do
  if ! command -v "$package" > /dev/null 2>&1; then
    cargo install "$package"
  fi
done

# use zsh as default shell
chsh -s "$(which zsh)"

# Install vim
if ! command -v vim > /dev/null 2>&1; then
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y vim
fi
# update-alternatives --set editor /usr/bin/vim.basic

# Insatll neovim and its dependencies
if ! command -v luarocks > /dev/null 2>&1; then
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y luarocks
fi

cargo install ripgrep

# TODO
# install nvim

# Install tmux
if ! command -v tmux > /dev/null 2>&1; then
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y tmux
fi
mkdir -p "$HOME/.tmux/plugins.tpm"
git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

# Install mise
# Ref: https://mise.jdx.dev/getting-started.html
# sudo install -dm 755 /etc/apt/keyrings
# curl -fSs https://mise.jdx.dev/gpg-key.pub | sudo tee /etc/apt/keyrings/mise-archive-keyring.pub 1> /dev/null
# echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.pub arch=amd64] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
# sudo apt-get update
# sudo apt-get install -y mise
