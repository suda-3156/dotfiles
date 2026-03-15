# History
HISTFILE="$XDG_STATE_HOME"/zsh/history # File to save history
HISTSIZE=100000                        # Number of history entries to keep in memory
SAVEHIST=1000000                       # Number of history entries to save in the file

setopt inc_append_history # Incrementally append history to the file upon execution
setopt share_history      # Share history across shell sessions in real-time

setopt hist_ignore_all_dups   # Do not display duplicate commands in history
setopt hist_save_no_dups      # Delete older duplicates when saving a duplicated command
setopt extended_history       # Record timestamps of commands in HISTFILE
setopt hist_expire_dups_first # Delete duplicate entries first when HISTFILE size exceeds HISTSIZE

# Search history based on the partially entered command
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

## fzf
function fzf-select-history() {
	BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER")
	CURSOR=$#BUFFER
	zle reset-prompt
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history
