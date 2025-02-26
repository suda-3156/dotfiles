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
# alias v='sh -c "
#   file=\$(ls -a -F | grep -v / | grep -v .DS_Store | sed s/\*$//g | head -n 1);
#   if [ -z \"\$file\" ]; then
#     nvim .;
#   else
#     nvim \$file;
#   fi
# "'
# ls -a (隠しファイルも表示) -F (ディレクトリなら末尾に/をつけるなど) 
# grep -v / (-vは一致しないもの→ / を含まないもの)
# mac os のやつ？はいじりたくないので外す
# sed s/\*$//g (テキストデータに対して、一行ずつ処理を行う。s=呪文, /A/B/=AをBに置換 g=全部置換 \*は特殊文字？)
# 一行だけの置換なら、(変数名)/(置換前)/(置換後)
# head -n 1 (表示する, -nで表示行数を指定)

alias v="nvim"

alias lsa='ls -a'

alias t='tmux'

alias mc='(){mkdir $1 && cd $1}'

alias lg='lazygit'

alias c='clear'

# alias mv='(){mv -i $1 $2}'

alias ta='t a'
