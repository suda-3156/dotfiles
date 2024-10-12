##### peco hotkeys #####

# Ctrl+x -> b でディレクトリの移動履歴
bindkey '^xb' anyframe-widget-cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# Ctrl+x -> r コマンドの実行履歴
bindkey '^xr' anyframe-widget-execute-history

# Ctrl+x -> Ctrl+b gitブランチを表示して切り替え
bindkey '^x^b' anyframe-widget-checkout-git-branch