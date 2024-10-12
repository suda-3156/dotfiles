##### memo #####
# load : レポート（トラッキング）を有効にします。zinit reportで一覧表示したり、zinit unloadでプラグインを無効化することができます。
# light : レポート（トラッキング）を無効にします。


# Load the pure theme, with zsh-async library that's bundled with it.
zinit ice pick"async.zsh" src"pure.zsh"

zinit light sindresorhus/pure

# syntax highlight
zinit light zsh-users/zsh-syntax-highlighting

# 入力中のコマンドと一致するコマンドを履歴から
zinit light zsh-users/zsh-autosuggestions

# 入力補完2
zinit light zsh-users/zsh-completions

# コマンド履歴を検索
zinit light zdharma/history-search-multi-word

# pecoを使うために
zinit light mollifier/anyframe

# git open でリポジトリをブラウザで開ける
zinit light paulirish/git-open