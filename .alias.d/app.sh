export LESS='-iLR'
export PAGER='less'
export EDITOR='vim'
export VISUAL=$EDITOR
export BROWSER='w3m -v'

alias vi=vim
alias view='vim -R'
function vim() {
  if test $# -gt 0; then
    env vim "$@"
  elif test -f Session.vim; then
    env vim -S
  else
    env vim -c Obsession
  fi
}

alias e=$EDITOR
alias v=$PAGER
alias b=$BROWSER

alias open='xdg-open'
alias scp='rsync --rsh=ssh -auz'
alias sloc='cloc --by-file-by-lang --exclude-dir .git'
alias diff='colordiff -u'
