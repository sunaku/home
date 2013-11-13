alias puts='print -l'

alias grep='grep --color'

words() { grep "$@" /usr/share/dict/words ;}

# this is similar to cut(1) but using awk(1) fields:
# print only the given columns, numbered from 1 to N
kut() { awk "{ print $(for n; do echo -n "\$$n,"; done | sed 's/,$//') }" ;}
