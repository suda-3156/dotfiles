# load .zshenv
[ -f "${HOME}/.zshenv" ] && source "${HOME}/.zshenv"

export EDITOR="nvim"

# make jj to load not only ~/.config/jj/config.toml but also ~/.config/jj/*.toml
export JJ_CONFIG="$HOME/.config/jj"

# for bin/spt
export SNIPPETS_DIR="$HOME/projects/snippets"

# custom scripts
export PATH="$PATH:$HOME/dotfiles/bin"

# os specific
case "$(uname -s)" in
Darwin)
	# go
	export PATH="$PATH:$(go env GOPATH)/bin"

	# Created by `pipx`
	export PATH="$PATH:$HOME/.local/bin"

	# GNU utils
	export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
	export PATH="$(brew --prefix make)/libexec/gnubin:$PATH"
	export PATH="$(brew --prefix diffutils)/libexec/gnubin:$PATH"
	export PATH="$(brew --prefix findutils)/libexec/gnubin:$PATH"
	export PATH="$(brew --prefix gzip)/libexec/gnubin:$PATH"
	export PATH="$(brew --prefix gawk)/libexec/gnubin:$PATH"

	# LLVM
	export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
	export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
	export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

  # move gsutils config
  export BOTO_CONFIG="${XDG_CONFIG_HOME}/gcloud/boto"

	;;
Linux)
	# nvim with appimage
	export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
	;;
esac
