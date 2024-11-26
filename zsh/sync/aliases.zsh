# aliases
alias g='git'
alias ga='git add .'
alias gs='git status'
alias gc='(){git commit -m $1}'

alias doco='docker compose'
alias e='exit'

alias py='python3'
alias pip='pip3'

# alias v='nvim .'
alias v='sh -c "
  file=\$(ls -a -F | grep -v / | grep -v .DS_Store | sed s/\*$//g | head -n 1);
  if [ -z \"\$file\" ]; then
    nvim .;
  else
    nvim \$file;
  fi
"'
# ls -a (隠しファイルも表示) -F (ディレクトリなら末尾に/をつけるなど) 
# grep -v / (-vは一致しないもの→ / を含まないもの)
# mac os のやつ？はいじりたくないので外す
# sed s/\*$//g (テキストデータに対して、一行ずつ処理を行う。s=呪文, /A/B/=AをBに置換 g=全部置換 \*は特殊文字？)
# 一行だけの置換なら、(変数名)/(置換前)/(置換後)
# head -n 1 (表示する, -nで表示行数を指定)

alias lsa='ls -a'

alias t='tmux'

alias mc='(){mkdir $1 && cd $1}'

alias lg='lazygit'

alias c='clear'

alias mv='(){mv -i $1 $2}'

# z をcdで使う
# func_enhanced_cd() {
#     local x2 the_new_dir adir index
#     local -i cnt
#
#     if [[ $1 == "--" ]]; then
#         dirs -v
#         return 0
#     fi
#
#     the_new_dir=$1
#     [[ -z $1 ]] && the_new_dir=$HOME
#
#     if [[ ${the_new_dir:0:1} == '-' ]]; then
#         #
#         # Extract dir N from dirs
#         index=${the_new_dir:1}
#         [[ -z $index ]] && index=1
#         adir=$(dirs +$index)
#         [[ -z $adir ]] && return 1
#         the_new_dir=$adir
#     fi
#
#     #
#     # '~' has to be substituted by ${HOME}
#     [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"
#
#     #
#     # Now change to the new dir and add to the top of the stack
#     pushd "${the_new_dir}" >/dev/null 2>&1
#     if [[ $? -ne 0 ]]; then
#         local q v
#         q="$(IFS=' '; echo "$*")"
#         v="$(zoxide query $q 2>/dev/null)"
#         # なんかダサいこと書いてるけどエラー表示させるために
#         # zoxide query の検索がヒットしなければ
#         # $the_new_dir を入れて再び pushd でエラーにする
#         [ -z "$v" ] && v="${the_new_dir}"
#         pushd "$v" >/dev/null
#         [[ $? -ne 0 ]] && return 1
#     fi
#     the_new_dir="$(pwd)"
#
#     # ホームディレクトリとルートディレクトリは除外して
#     # zoxide add でディレクトリの登録とスコアをインクリメントする
#     local -a EXCLUDES=("$HOME" '/')
#     local ok=true
#     local v
#     for v in "${EXCLUDES[@]}"; do
#         [ "$the_new_dir" == "$v" ] && ok=false
#     done
#     "${ok}" && zoxide add "${the_new_dir}" >/dev/null 2>&1
#
#     #
#     # Trim down everything beyond 11th entry
#     popd -n +11 2>/dev/null 1>/dev/null
#
#     #
#     # Remove any other occurence of this dir, skipping the top of the stack
#     for ((cnt = 1; cnt <= 10; cnt++)); do
#         x2=$(dirs +${cnt} 2>/dev/null)
#         [[ $? -ne 0 ]] && return 0
#         [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
#         if [[ "${x2}" == "${the_new_dir}" ]]; then
#             popd -n +$cnt 2>/dev/null 1>/dev/null
#             cnt=cnt-1
#         fi
#     done
#     return 0
# }
# alias cd=func_enhanced_cd

# ff でfzfで検索してcd 
# ff -f だとfindコマンドで現在のディレクトリ以下を探索した結果をfzfで絞り込んでcdできる
# ff() {
#     local -a MAXDEPTH=(-maxdepth 6)
#     local -a HIDDEN=(-and ! -path '*\/\.*')
#     local -a ARGS=()
#     local FIND=false
#     while (($# > 0)); do
#         case "$1" in
#         -*)
#             [[ "$1" =~ ^-(.*[^afl0-9]+.*|)$ ]] && echo "Error: invalid option -- ‘$1‘" && return 1
#             [[ "$1" =~ ^-[^0-9]*([0-9]|[1-9][0-9]+) ]] && MAXDEPTH=(-maxdepth "${BASH_REMATCH[1]}")
#             [[ "$1" =~ ^-[^-]*a ]] && HIDDEN=()
#             [[ "$1" =~ ^-[^-]*f ]] && FIND=true
#             [[ "$1" =~ ^-[^-]*l ]] && MAXDEPTH=() 
#             shift
#             continue
#             ;;
#         esac
#         ARGS+=("$1")
#         shift
#     done
#     local v
#     if "${FIND}"; then
#         v=$(find "${ARGS[0]:-.}" "${MAXDEPTH[@]}" -type d "${HIDDEN[@]}" -and ! -regex '^\.$' -and ! -regex '.*/node_modules/.*' -print 2>/dev/null | sed -e "s/^${HOME//\//\\/}/\~/" | fzf --select-1 --no-multi)
#     else
#         # zoxide のパス一覧を fzf で検索する
#         v=$(zoxide query -l | sed -e "s/^${HOME//\//\\/}/\~/" | fzf --query="$(IFS=' '; echo "${ARGS[*]}")" --select-1 --no-multi)
#     fi
#     [ -n "$v" ] && v="${v/~\//$HOME/}"
#     [ -d "$v" ] && cd "$v" || return 0
# }
