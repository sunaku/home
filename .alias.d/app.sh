export LESS='-iLR'
export PAGER='less'
alias p=$PAGER

function vim() {
  if [ $# -gt 0 ]; then
    env vim "$@"
  elif [ -f Session.vim ]; then
    env vim -S
  else
    env vim -c Obsession
  fi
}
export EDITOR='vim'
alias e=$EDITOR

alias open='xdg-open'
alias scp='rsync --archive --update --compress --verbose'
alias sloc='cloc --by-file-by-lang --exclude-dir .git'
alias diff='colordiff -u'
alias tree='tree -ACF'
