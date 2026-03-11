# Cursor placement for abbr
ABBR_SET_EXPANSION_CURSOR=1

# Enable abbr after pipe and so on
ABBR_REGULAR_ABBREVIATION_GLOB_PREFIXES+=(
  '*& '
  '*&& '
  '*| '
  '*|| '
  '*; '
  'notify'
)

abbr -S -q cl='clear'
abbr -S -q e='exit 0'
abbr -S -q ll='ls -lh'
abbr -S -q la='ls -lAh'

abbr -S -q rd='rmdir'
abbr -S -q md='mkdir -p %'
abbr -S -q mkdc='mkdir % && cd $_'
abbr -S -q te='touch % && $EDITOR $_'

abbr -S -q help='man %'
abbr -S -q which-command='whence %'

abbr -S -q ..='cd ../'
abbr -S -q ...='cd ../../'
abbr -S -q ....='cd ../../../'
abbr -S -q .....='cd ../../../../'

abbr -S -q doco='docker compose'

abbr -S -q v='nvim'
abbr -S -q co='code .'

abbr -S -q g='git'
abbr -S -q gs='git status'
abbr -S -q ga='git add'
abbr -S -q gaa='git add -A'
abbr -S -q gac='git add -A && git commit -m "%'
abbr -S -q gc='git commit'
abbr -S -q gcm='git commit -m "%'
abbr -S -q gai="git aicommit"

abbr -S -q js='jj st'
abbr -S -q jd='jj desc'
abbr -S -q jn='jj diff --name-only'
abbr -S -q jdf='jj diff'
abbr -S -q jb='jj bookmark set'
abbr -S -q jss='jj squash'

abbr -S -q t='tmux'
abbr -S -q tl='tmux ls'
abbr -S -q ta='tmux a'
abbr -S -q tt='tmux a -t'
abbr -S -q tn='tmux new -s'

abbr -S -q ghcr='gh repo create % --private -s .'

abbr -S -q tf='terraform'

abbr -S -q op='open .'

abbr -S -q gccl='gcloud config configurations list'
abbr -S -q gcca='gcloud config configurations activate'
abbr -S -q gcal='gcloud auth application-default login'

abbr -S -q cop='copilot'

abbr -S -q quitapp="osascript -e 'quit app \"%\"'"

