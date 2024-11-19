##### install dotfiles #####
## usage
## 1. $ chmod +x install.sh
## 2. ./install.sh

CURRENT_DIR=$(pwd)

echo "Create dotfile links."

# neovim
ln -sfnv ${PWD}/nvim ${HOME}/.config

# zshrc
ln -sfnv ${PWD}/zsh/.zshrc ${HOME}

# sheldon
ln -sfnv ${PWD}/zsh/plugins.toml ${HOME}/.config/sheldon

# starship
ln -sfnv ${PWD}/zsh/starship.toml ${HOME}/.config

# tmux
ln -sfnv ${PWD}/tmux/.tmux.conf ${HOME}

# obsidian
# ln -sfnv ${PWD}/obsidian/.obsidian.vimrc ${HOME}/Notes/KnowledgeBase
echo "Done."
