eval $(/opt/homebrew/bin/brew shellenv)
eval "$(sheldon source)"
eval "$(zoxide init zsh --hook prompt )"

source $HOME/dotfiles/zsh/aliases.zsh
source $HOME/dotfiles/zsh/paths.zsh
