# emacs mode
bindkey -e

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
