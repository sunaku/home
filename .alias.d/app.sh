export LESS='-iLR'
export PAGER='less'

export VISUAL='vim'
export EDITOR='vim'
function vim_() {
  if [ $# -gt 1 ]; then
    env "$@"
  elif [ -f Session.vim ]; then
    env "$1" -S
  else
    env "$1" -c Obsession
  fi
}
alias vim='vim_ vim'
alias nvim='vim_ nvim'

alias open='xdg-open'
alias scp='rsync --archive --update --compress --verbose'
alias sloc='cloc --by-file-by-lang --exclude-dir .git'
alias diff='git diff --no-index --'
alias wdiff='git diff --no-index --word-diff=color --'
alias tree='tree -ACF'
alias grep='grep --perl-regexp --color=auto'

alias a='where'
alias E='vim -u NONE -c "set term=ansi smd"'
alias e='vim'
alias g='grep'
alias H='apropos'
alias h='man'
alias s="$PAGER"
alias t='tee /dev/tty'
