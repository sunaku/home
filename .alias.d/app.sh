export PAGER='less -LR'
export EDITOR='vim'
export BROWSER='w3m -v'

alias e=$EDITOR
alias v=$PAGER
alias b=$BROWSER
alias x='nice extract-archive'

alias open='xdg-open'
alias scp='rsync --rsh=ssh -arvP'
alias sloc='cloc --by-file-by-lang --exclude-dir .git'
alias diff='colordiff -u'
