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

abbr -S -q c='clear'
abbr -S -q e='exit 0'
abbr -S -q ll='ls -lh'
abbr -S -q la='ls -lAh'
abbr -S -q s='source'
abbr -S -q rd='rmdir'
abbr -S -q md='mkdir -p %'
abbr -S -q run-help='man %'
abbr -S -q which-command='whence %'
abbr -S -q ..='cd ../'
abbr -S -q ...='cd ../../'
abbr -S -q ....='cd ../../../'

abbr -S -q doco='docker compose'
abbr -S -q doce='docker compose exec'
abbr -S -q docr='docker compose run'

abbr -S -q v='nvim'
abbr -S -q co='code .'

abbr -S -q py='python'
abbr -S -q h='history 16'
abbr -S -q mkdc='mkdir % && cd $_'

abbr -S -q g='git'
abbr -S -q gst='git status'
abbr -S -q gcm='git commit -m "%'
abbr -S -q gc='git commit'
abbr -S -q ga='git add'
abbr -S -q gaa='git add -A'
abbr -S -q gac='git add -A && git commit -m "%'

abbr -S -q t='tmux'
abbr -S -q tt='tmux a -t'
abbr -S -q tn='tmux new -s'
abbr -S -q tl='tmux ls'
abbr -S -q ta='tmux a'

abbr -S -q ghcr='gh repo create % --private --push -s .'

abbr -S -q tf='terraform'

abbr -S -q op='open .'

abbr -S -q tc='touch % && code $_'

abbr -S -q gccl='gcloud config configurations list'
abbr -S -q gcca='gcloud config configurations activate'
abbr -S -q gcreauth='gcloud auth application-default login'

abbr -S -q quitapp="osascript -e 'quit app \"%\"'"

abbr -S -q gai="git aicommit"

