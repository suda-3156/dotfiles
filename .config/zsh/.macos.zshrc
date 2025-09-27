eval $(/opt/homebrew/bin/brew shellenv)
eval "$(sheldon source)"

eval "$(mise activate zsh)"
eval "$(task --completion zsh)"
eval "$(direnv hook zsh)"

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# zsh notify
zstyle ':notify:*' error-sound "Glass"
zstyle ':notify:*' success-sound "default"
zstyle ':notify:*' error-title "Command failed (in #{time_elapsed} seconds)"
zstyle ':notify:*' success-title "Command finished (in #{time_elapsed} seconds)"

zstyle ':notify:*' enable-on-ssh yes
zstyle ':notify:*' blacklist-regex 'find|git'
zstyle ':notify:*' always-notify-on-failure no

