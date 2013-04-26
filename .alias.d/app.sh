export LESS='-iLR'
export PAGER='less'
export EDITOR='vim'
export VISUAL=$EDITOR
export BROWSER='w3m -v'

alias e=$EDITOR
alias v=$PAGER
alias b=$BROWSER

alias open='xdg-open'
alias scp='rsync --rsh=ssh -CarvP'
alias sloc='cloc --by-file-by-lang --exclude-dir .git'
alias diff='colordiff -u'
