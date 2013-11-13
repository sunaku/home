alias puts='print -l'

alias grep='grep --color'

words() { grep "$@" /usr/share/dict/words ;}

# print only the given columns, numbered from 1 to N
col() { awk "{ print $(for n; do echo -n "\$$n,"; done | sed 's/,$//') }" ;}
