eval $(/opt/homebrew/bin/brew shellenv)
eval "$(sheldon source)"

eval "$(mise activate zsh)"
eval "$(task --completion zsh)"
eval "$(direnv hook zsh)"

