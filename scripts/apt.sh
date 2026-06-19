#!/usr/bin/env bash

set -eu

if ! command -v apt > /dev/null 2>&1; then
    echo "apt.sh - This script requires apt as package manager"
    exit 1
fi

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
    direnv
    clang
    libclang-dev
    fd
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
    tree-sitter-cli
)
for package in "${packages[@]}"; do
    if ! command -v "$package" > /dev/null 2>&1; then
        cargo install "$package"
    fi
done

# jj
# https://docs.jj-vcs.dev/latest/install-and-setup/#linux
if ! command -v "jj" > /dev/null 2>&1; then
    cargo install --locked --bin jj jj-cli
fi

# use zsh as default shell
chsh -s "$(which zsh)"

# Install vim
if ! command -v vim > /dev/null 2>&1; then
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y vim
fi
# update-alternatives --set editor /usr/bin/vim.basic

# Install neovim and its dependencies
if ! command -v luarocks > /dev/null 2>&1; then
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y luarocks
fi

cargo install ripgrep

# Install tmux
if ! command -v tmux > /dev/null 2>&1; then
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y tmux
fi
mkdir -p "$HOME/.tmux/plugins.tpm"
git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

# Install mise
# Ref: https://mise.jdx.dev/getting-started.html
if ! command -v mise > /dev/null 2>&1; then
    sudo install -dm 755 /etc/apt/keyrings
    curl -fSs https://mise.jdx.dev/gpg-key.pub | sudo tee /etc/apt/keyrings/mise-archive-keyring.asc 1> /dev/null
    echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.asc] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
    sudo apt update -y
    sudo apt install -y mise
fi

# Install go-task
# Ref: https://taskfile.dev/docs/installation
if ! command -v task > /dev/null 2>&1; then
    curl -1sLf 'https://dl.cloudsmith.io/public/task/task/setup.deb.sh' | sudo -E bash
    sudo apt install task
fi

# Install docker
# Ref: https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script
if ! command -v docker > /dev/null 2>&1; then
    curl -fsSL https://get.docker.com | sudo sh
    echo "Exec \"sudo usermod -aG docker \$User\" and re-login to run docker commands without sudo"
fi

# Install terraform
# Ref: https://developer.hashicorp.com/terraform/install
if ! command -v terraform > /dev/null 2>&1; then
    wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install terraform
fi

# TODO: Install nvim
echo "Install nvim manually: https://github.com/neovim/neovim/blob/master/INSTALL.md"
