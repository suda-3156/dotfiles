# PATH
# source "$HOME/.cargo/env" # .zshrcの中で読み込むため

# nvm
export NVM_DIR="$HOME/.nvm"
# [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
# [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# go
export PATH="$PATH:$(go env GOPATH)/bin"

