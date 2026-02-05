# custom scripts
export PATH="$PATH:$HOME/dotfiles/bin"

# shellcheck disable=all
case "$(uname -s)" in
  Darwin)
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

    # LLVM
    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
    export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
    ;;
  Linux)
    # nvim with appimage
    export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
    ;;
esac
