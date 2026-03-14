# zsh config

# emacs mode
bindkey -e

# History
HISTFILE=$HOME/.zsh_history # File to save history
HISTSIZE=100000             # Number of history entries to keep in memory
SAVEHIST=1000000            # Number of history entries to save in the file

setopt inc_append_history # Incrementally append history to the file upon execution
setopt share_history      # Share history across shell sessions in real-time

setopt hist_ignore_all_dups   # Do not display duplicate commands in history
setopt hist_save_no_dups      # Delete older duplicates when saving a duplicated command
setopt extended_history       # Record timestamps of commands in HISTFILE
setopt hist_expire_dups_first # Delete duplicate entries first when HISTFILE size exceeds HISTSIZE

# Enable completion
autoload -Uz compinit
compinit
autoload -Uz colors
colors

# Enable menu selection with the Tab key
zstyle ':completion:*:default' menu select=2

# Completion matching rules: exact match -> lowercase to uppercase -> uppercase to lowercase
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

# Do not complete current directory after ../
zstyle ':completion:*' ignore-parents parent pwd ..

# Exclude current directory from completion candidates for cd
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Group completions by their types
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''

# Select completion candidates from a menu
# select=2: Start menu selection if there are 2 or more completion candidates
zstyle ':completion:*:default' menu select=2

# Colorize completion candidates
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Automatically append a trailing / to directory names to prepare for the next completion
setopt auto_param_slash

# Automatically complete parentheses/brackets
setopt auto_param_keys

# Append a trailing / to matched directories during filename expansion
setopt mark_dirs

# Automatically cycle through completion candidates by hitting the completion key repeatedly
setopt auto_menu

# Disable ctrl+s, ctrl+q
setopt no_flow_control

# Treat # and everything after it as a comment in interactive shells
setopt interactive_comments

# Enable completion after = in command line arguments (e.g., --prefix=/usr)
setopt magic_equal_subst

# Allow completion from within a word at the cursor position
setopt complete_in_word

# Allow display of 8-bit characters (e.g., Japanese file names)
setopt print_eight_bit

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

# From: https://gist.github.com/yonchu/3935922
chpwd() {
	ls_abbrev
}
ls_abbrev() {
	if [[ ! -r $PWD ]]; then
		return
	fi
	# -a : Do not ignore entries starting with ..
	# -C : Force multi-column output.
	# -F : Append indicator (one of */=>@|) to entries.
	local cmd_ls='ls'
	local -a opt_ls
	opt_ls=('-aCF' '--color=always')
	case "${OSTYPE}" in
	freebsd* | darwin*)
		if type gls >/dev/null 2>&1; then
			cmd_ls='gls'
		else
			# -G : Enable colorized output.
			opt_ls=('-aCFG')
		fi
		;;
	esac
	local ls_result
	ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

	local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

	if [ $ls_lines -gt 10 ]; then
		echo "$ls_result" | head -n 5
		echo '...'
		echo "$ls_result" | tail -n 5
		echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
	else
		echo "$ls_result"
	fi
}
