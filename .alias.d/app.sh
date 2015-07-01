export LESS='-iLR'
export PAGER='less'
alias p=$PAGER

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
alias diff='colordiff -u'
alias tree='tree -ACF'
