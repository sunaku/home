alias ls='ls -h --color=auto'
alias la='ls -lA'
alias lt='ls -ltr'
alias mv='mv -i'
alias rm='rm -i'
alias RM='rm -vrf'

duh() { # disk usage for humans
  test $# -eq 0 && set -- *
  du -sch "$@" | sort -h
}
