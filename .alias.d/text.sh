col() { # print only the given columns, numbered from 1 to N
  awk "{ print $(for n; do echo -n "\$$n,"; done | sed 's/,$//') }"
}

alias puts='print -l'
