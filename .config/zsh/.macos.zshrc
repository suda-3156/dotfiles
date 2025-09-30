eval $(/opt/homebrew/bin/brew shellenv)
eval "$(sheldon source)"

eval "$(mise activate zsh)"
eval "$(task --completion zsh)"
eval "$(direnv hook zsh)"

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

