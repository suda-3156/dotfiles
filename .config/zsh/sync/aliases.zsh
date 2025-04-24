# Cursor placement for abbr
ABBR_SET_EXPANSION_CURSOR=1

# Enable abbr after pipe and so on
ABBR_REGULAR_ABBREVIATION_GLOB_PREFIXES+=(
  '*& '
  '*&& '
  '*| '
  '*|| '
  '*; '
)

abbr -S ll='ls -l' >> /dev/null
abbr -S la='ls -la' >> /dev/null
abbr -S c='clear' >> /dev/null
abbr -S t='tmux' >> /dev/null
abbr -S g='git' >> /dev/null
abbr -S gcm='git commit -m' >> /dev/null
abbr -S gst='git status' >> /dev/null
abbr -S ga='git add' >> /dev/null
abbr -S gaa='git add -A' >> /dev/null
abbr -S gac='git add -A && git commit -m "%' >> /dev/null
abbr -S e='exit' >> /dev/null
abbr -S doco='docker compose' >> /dev/null
abbr -S v='nvim' >> /dev/null
abbr -S py='python' >> /dev/null
abbr -S lg='lazygit' >> /dev/null
abbr -S h='history 16' >> /dev/null
abbr -S mkdc='mkdir % && cd $_' >> /dev/null

alias ls='ls --color=auto'

alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -ir'
