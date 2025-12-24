eval $(/opt/homebrew/bin/brew shellenv)
eval "$(sheldon source)"

eval "$(mise activate zsh)"
eval "$(task --completion zsh)"
eval "$(direnv hook zsh)"

# go
export PATH="$PATH:$(go env GOPATH)/bin"

# Created by `pipx`
export PATH="$PATH:$HOME/.local/bin"

# GNU utils
export PATH="$PATH:$(brew --prefix coreutils)/libexec/gnubin"
export PATH="$PATH:$(brew --prefix make)/libexec/gnubin"
export PATH="$PATH:$(brew --prefix diffutils)/libexec/gnubin"
export PATH="$PATH:$(brew --prefix findutils)/libexec/gnubin"
export PATH="$PATH:$(brew --prefix gzip)/libexec/gnubin"
export PATH="$PATH:$(brew --prefix gawk)/libexec/gnubin"
