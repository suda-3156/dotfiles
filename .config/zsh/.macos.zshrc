eval $(/opt/homebrew/bin/brew shellenv)
eval "$(sheldon source)"

eval "$(mise activate zsh)"
eval "$(task --completion zsh)"
eval "$(direnv hook zsh)"

# go
export PATH="$PATH:$(go env GOPATH)/bin"

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# Created by `pipx`
export PATH="$PATH:$HOME/.local/bin"

