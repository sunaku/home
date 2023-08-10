export LESS='-iR'
for pager in bat less more; do
  if command -v $pager >/dev/null; then
    export PAGER=$pager
    break
  fi
done

for editor in nvim vim vi; do
  if command -v $editor >/dev/null; then
    export VISUAL=$editor
    break
  fi
done

for filter in sk fzf; do
  if command -v $filter >/dev/null; then
    break
  fi
done

export SUDO_ASKPASS=/usr/libexec/ssh-askpass
test -e $SUDO_ASKPASS || unset SUDO_ASKPASS

alias open='xdg-open'
alias scp='rsync --archive --update --compress --verbose --mkpath'
alias sloc='cloc --by-file-by-lang --exclude-dir .git'
alias tree='tree -ACF'

alias a='where'
A() { /usr/bin/which "$@" | xargs -r realpath ;}
alias E='vim -u NONE -c "set term=ansi showmode"'
alias e=$VISUAL
alias c=$PAGER
alias f=$filter
alias g='grep --perl-regexp --color=auto'
alias h='man'
alias H='apropos'
