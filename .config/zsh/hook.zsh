# From: https://gist.github.com/yonchu/3935922
function run_ls() {
	if [[ ! -r $PWD ]]; then
		return
	fi

	# -A : Show all entries except for '.' and '..'.
	# -C : Force multi-column output.
	# -F : Append indicator (one of */=>@|) to entries.
	local cmd_ls='ls'
	local -a opt_ls
	opt_ls=('-AF' '--color=always')

	case "${OSTYPE}" in
	freebsd* | darwin*)
		if command -v gls >/dev/null 2>&1; then
			cmd_ls='gls'
		else
			# -G : Enable colorized output.
			opt_ls=('-aFG')
		fi
		;;
	esac

  local num="$(command ls -1 -A | wc -l | tr -d ' ')"
  local show_all=1

  if [ "$num" -gt 20 ]; then
    opt_ls+=('-C')
    show_all=0
  fi

  # Remove lines only with color codes by sed
	local ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

	local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

	if [ $ls_lines -gt 10 -a $show_all -eq 0 ]; then
		echo "$ls_result" | head -n 3
		echo '...'
		echo "$ls_result" | tail -n 3
		echo "$(command ls -1 -A | wc -l | tr -d ' ') files"
	else
		echo "$ls_result"
	fi
}

function show_exit_code() {
  local exit_code=$?

  if [[ exit_code -ne 0 ]]; then
    print -P "%F{red}%BExit code: $exit_code%b%f"
  fi
}

# Set hooks
autoload -Uz add-zsh-hook
# add-zsh-hook zshaddhistory <function>
# add-zsh-hook preexec <function>
# Input command runs here
add-zsh-hook chpwd run_ls
add-zsh-hook precmd show_exit_code
# add-zsh-hook periodic <function>
