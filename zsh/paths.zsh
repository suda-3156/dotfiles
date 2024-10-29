# paths
# python brewのやつは別なの?
export PATH=$PATH:/Users/kyaka3/Library/Python/3.9/bin

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# .zprofileから移行. homebrewのコマンドをシェルで正しく使えるようにする.問題があれば、.zprofileに戻す.
# eval "$(/opt/homebrew/bin/brew shellenv)"

# valta?? .zshenvに書かれていたので、コメントアウト.
# export VOLTA_HOME="$HOME/.volta"
# export PATH="$VOLTA_HOME/bin:$PATH"
