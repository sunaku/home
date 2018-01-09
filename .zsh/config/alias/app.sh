export PAGER='less' LESS='-iR'
export VISUAL='vim'

alias open='xdg-open'
alias scp='rsync --archive --update --compress --verbose'
alias sloc='cloc --by-file-by-lang --exclude-dir .git'
alias diff='git diff --no-index --'
alias wdiff='git diff --no-index --word-diff=color --'
alias tree='tree -ACF'
alias grep='grep --perl-regexp --color=auto'

alias a='where'
A() { where "$@" | grep / | xargs -rn1 realpath ;}
alias E='vim -u NONE -c "set term=ansi smd"'
alias e="$VISUAL"
alias g='grep'
alias H='apropos'
alias h='man'
alias s="$PAGER"
alias t='tee /dev/tty'
