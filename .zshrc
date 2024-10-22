######################## Added by Zinit's installer ########################
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

######################## End of Zinit's installer chunk #####################

SCRIPT_DIR=$HOME/dotfiles

source $SCRIPT_DIR/zsh/plugins.zsh
source $SCRIPT_DIR/zsh/config.zsh

# peco 
bindkey '^xb' anyframe-widget-cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
bindkey '^xr' anyframe-widget-execute-history
bindkey '^x^b' anyframe-widget-checkout-git-branch

# python no path
export PATH=$PATH:/Users/kyaka3/Library/Python/3.9/bin

# aliases
alias g='git' 
alias doco='docker compose'
alias e='exit'
alias ga='git add .'
alias gs='git status'
alias gc='(){git commit -m $1}'

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# .zprofileから移行. homebrewのコマンドをシェルで正しく使えるようにする. 問題があれば、.zprofileに戻す.
eval "$(/opt/homebrew/bin/brew shellenv)"
